# https://www.linode.com/docs/tools-reference/tools/use-the-date-command-in-linux
# https://stackoverflow.com/questions/4651437/how-to-set-a-variable-to-the-output-from-a-command-in-bash
# http://docs.aws.amazon.com/cli/latest/reference/dynamodb/put-item.html
# http://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html
# https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools	
# https://stackoverflow.com/questions/13356628/is-there-a-way-to-redirect-time-output-to-file-in-linux
# https://unix.stackexchange.com/questions/141211/removing-blank-spaces-and-tabs-from-line-without-messing-with-line-endings
# http://www.download-time.com/





######################################################################################################
##################################    Adrian's Custom SpeedTest     ##################################
######################################################################################################


# # aws sts assume-role --role-arn $role-arn --role-session-name $role-session-name

# role-arn='arn:aws:iam::101845606311:role/speedtest.adrianws.com_user_role'
# role-session-name='CLI-user-of-speedtest.adrianws.com'

# aws sts assume-role --role-arn $role-arn --role-session-name $role-session-name > assume-role-output.json

# #get the dynamoDB key which represents when the test was run
# speedtestdbkey="$(date +%s)"

# export PYTHONIOENCODING=utf8
# cat assume-role-output.json | python -c "import sys, json; print json.load(sys.stdin)['Credentials']['AccessKeyId']"










#get the dynamoDB key which represents when the test was run
speedtestdbkey="$(date +%s)"
echo $speedtestdbkey

testdate="$(date)"
echo $testdate

currentuser="$(whoami)"
echo $currentuser




###Run the 1GB file download tests and save the times
{ time curl http://speedtest.adrianws.com/file.txt ; } 2> download_time_output.txt
{ time curl https://speedtest.adrianws.com/file.txt ; } 2> download_time_output_HTTPS.txt


#Format HTTP test time
cat download_time_output.txt | grep real > download_time_output_real_line.txt
sed 's/real/ /g' download_time_output_real_line.txt > only_time_output_real.txt
tr -d " \t" < only_time_output_real.txt > only_time_output_real_no_tab.txt
speedOf1GBfiledownload=$(<only_time_output_real_no_tab.txt)
echo $speedOf1GBfiledownload

#Format HTTPS test time
cat download_time_output_HTTPS.txt | grep real > download_time_output_real_line2.txt
sed 's/real/ /g' download_time_output_real_line2.txt > only_time_output_real2.txt
tr -d " \t" < only_time_output_real2.txt > only_time_output_real_no_tab2.txt
speedOf1GBfiledownloadHTTPS=$(<only_time_output_real_no_tab2.txt)
echo $speedOf1GBfiledownloadHTTPS


 
# Crete item for DynamoDB storage
echo "{\"time_since_epoch\": {\"S\": \"$speedtestdbkey\"}," > item.json
echo "\"1GBfiledownload\": {\"S\": \"$speedOf1GBfiledownload\"}", >> item.json
echo "\"1GBfiledownload_HTTPS\": {\"S\": \"$speedOf1GBfiledownloadHTTPS\"}", >> item.json
echo "\"date\": {\"S\": \"$testdate\"}", >> item.json
echo "\"maxdownload\": {\"S\": \"??\"}", >> item.json
echo "\"maxupload\": {\"S\": \"??\"}", >> item.json
echo "\"user\": {\"S\": \"$currentuser\"}}" >> item.json



#Insert the item into DynamoDB
# aws dynamodb put-item --table-name speedtest.adrianws.com_analytics --item file://item.json
aws dynamodb put-item --table-name speedtest.adrianws.com_analytics --item file://item.json --return-consumed-capacity TOTAL --profile speedtest.adrianws.com_profile


######################################################################################################
##################################     Adrian's Ookla SpeedTest     ##################################
######################################################################################################
















