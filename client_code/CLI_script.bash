# https://www.linode.com/docs/tools-reference/tools/use-the-date-command-in-linux
# https://stackoverflow.com/questions/4651437/how-to-set-a-variable-to-the-output-from-a-command-in-bash
# http://docs.aws.amazon.com/cli/latest/reference/dynamodb/put-item.html
# http://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html
# https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools	
# https://stackoverflow.com/questions/13356628/is-there-a-way-to-redirect-time-output-to-file-in-linux
# https://unix.stackexchange.com/questions/141211/removing-blank-spaces-and-tabs-from-line-without-messing-with-line-endings
# http://www.download-time.com/
# https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.upload_file
# https://github.com/sivel/speedtest-cli
# https://blogs.technet.microsoft.com/rmilne/2015/09/11/how-to-use-nslookup-to-check-dns-txt-record/
# https://stackoverflow.com/questions/18611903/how-to-pass-payload-via-json-file-for-curl
# nslookup -q=A shard.adrianws.com
# https://stackoverflow.com/questions/42813926/passing-bash-variable-to-curl
# https://stackoverflow.com/questions/21440569/bash-script-use-string-variable-in-curl-json-post-data
# https://askubuntu.com/questions/82616/how-to-execute-command-every-10-seconds-without-cron









######################################################################################################
##################################    Adrian's Custom SpeedTest     ##################################
######################################################################################################



echo ""
echo ""
echo "BEGIN"

echo "######################################################################################################"
echo "##################################    Adrian's Custom SpeedTest     ##################################"
echo "######################################################################################################"
echo ""


# Variables/data structure for dynamoDB data table
speedtestdbkey="?"
speedOf1GBfiledownload="?"
speedOf1GBfiledownloadHTTPS="?"
ookla_host="?"
testdate="?"
maxdownload="?"
maxupload="?"
currentuser="?"


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


 
# Create item for DynamoDB storage
echo "{\"time_since_epoch\": {\"S\": \"$speedtestdbkey\"}," > item.json
echo "\"1GBfiledownload\": {\"S\": \"$speedOf1GBfiledownload\"}", >> item.json
echo "\"1GBfiledownload_HTTPS\": {\"S\": \"$speedOf1GBfiledownloadHTTPS\"}", >> item.json
echo "\"ookla_host\": {\"S\": \"$ookla_host\"}", >> item.json
echo "\"date\": {\"S\": \"$testdate\"}", >> item.json
echo "\"maxdownload\": {\"S\": \"$maxdownload\"}", >> item.json
echo "\"maxupload\": {\"S\": \"$maxupload\"}", >> item.json
echo "\"user\": {\"S\": \"$currentuser\"}}" >> item.json


cat item.json

#Insert the item into DynamoDB
# aws dynamodb put-item --table-name speedtest.adrianws.com_analytics --item file://item.json
## aws dynamodb put-item --table-name speedtest.adrianws.com_analytics --item file://item.json --return-consumed-capacity TOTAL --profile speedtest.adrianws.com_profile








######################################################################################################
##################################     Adrian's Ookla SpeedTest     ##################################
######################################################################################################


# RESET Variables/data structure for dynamoDB data table (just in case)
speedtestdbkey="??"
speedOf1GBfiledownload="??"
speedOf1GBfiledownloadHTTPS="??"
ookla_host="??"
testdate="??"
maxdownload="??"
maxupload="??"
currentuser="??"
speedtestdbkey2="?"
testdate2="?"
ookla_download="??"
ookla_upload="??"
currentuser2="??"


# Download the cli tool
curl -Lo speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x speedtest-cli


#get the NEW dynamoDB key which represents when the test was run
speedtestdbkey2="$(date +%s)"
echo $speedtestdbkey2

testdate2="$(date)"
echo $testdate2

currentuser2="$(whoami)"
echo $currentuser2

./speedtest-cli --server 15133 | tee ookla.output.txt

# Sample Output
# Retrieving speedtest.net configuration...
# Testing from Cox Communications (174.65.116.21)...
# Retrieving speedtest.net server list...
# Selecting best server based on ping...
# Hosted by 83 Plus Productions (Portland, OR) [1500.20 km]: 58.563 ms
# Testing download speed................................................................................
# Download: 144.94 Mbit/s
# Testing upload speed................................................................................................
# Upload: 25.33 Mbit/s

cat ookla.output.txt | grep 'Download:' > ookla.output.txt_Download_line.txt
ookla_download=$(<ookla.output.txt_Download_line.txt)
echo $ookla_download

cat ookla.output.txt | grep 'Upload:' > ookla.output.txt_Upload_line.txt
ookla_upload=$(<ookla.output.txt_Upload_line.txt)
echo $ookla_upload

cat ookla.output.txt | grep Hosted > ookla.output.txt_Hosted_line.txt
ookla_host=$(<ookla.output.txt_Hosted_line.txt)
echo $ookla_host



# Create Ookla item for DynamoDB storage
echo "{\"time_since_epoch\": {\"S\": \"$speedtestdbkey2\"}," > item2.json
echo "\"1GBfiledownload\": {\"S\": \"$speedOf1GBfiledownload\"}", >> item2.json
echo "\"1GBfiledownload_HTTPS\": {\"S\": \"$speedOf1GBfiledownloadHTTPS\"}", >> item2.json
echo "\"ookla_host\": {\"S\": \"$ookla_host\"}", >> item2.json
echo "\"date\": {\"S\": \"$testdate2\"}", >> item2.json
echo "\"maxdownload\": {\"S\": \"$ookla_download\"}", >> item2.json
echo "\"maxupload\": {\"S\": \"$ookla_upload\"}", >> item2.json
echo "\"user\": {\"S\": \"$currentuser2\"}}" >> item2.json


cat item2.json

#Insert the Adrian SpeedTest and Ookla item into DynamoDB
## aws dynamodb put-item --table-name speedtest.adrianws.com_analytics --item file://item2.json --return-consumed-capacity TOTAL --profile speedtest.adrianws.com_profile


#Send Ookla speedtest data to clientapi.speedtest.adrianws.com for entry into DynamoDB
api_url="https://f80v3eoklk.execute-api.us-west-2.amazonaws.com/prod/uploaddata"
header1="Content-Type:application/json"
header2="x-api-key:123"


curl -v POST \
--header $header1 \
--header $header2 \
-d @item.json \
$api_url 


curl -v POST \
--header $header1 \
--header $header2 \
-d @item2.json \
$api_url 


echo ""
echo ""
echo "COMPLETE"



