# https://www.linode.com/docs/tools-reference/tools/use-the-date-command-in-linux
# https://stackoverflow.com/questions/4651437/how-to-set-a-variable-to-the-output-from-a-command-in-bash
# http://docs.aws.amazon.com/cli/latest/reference/dynamodb/put-item.html
# http://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html
# https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools	
# https://stackoverflow.com/questions/13356628/is-there-a-way-to-redirect-time-output-to-file-in-linux







######################################################################################################
##################################    Adrian's Custom SpeedTest     ##################################
######################################################################################################


# aws sts assume-role --role-arn $role-arn --role-session-name $role-session-name

role-arn='arn:aws:iam::101845606311:role/speedtest.adrianws.com_user_role'
role-session-name='CLI-user-of-speedtest.adrianws.com'


aws sts assume-role --role-arn $role-arn --role-session-name $role-session-name > assume-role-output.json


#get the dynamoDB key which represents when the test was run
speedtestdbkey="$(date +%s)"


export PYTHONIOENCODING=utf8
cat assume-role-output.json | python -c "import sys, json; print json.load(sys.stdin)['Credentials']['AccessKeyId']"




#get the dynamoDB key which represents when the test was run
speedtestdbkey="$(date +%s)"



###Run the download test and save the time
time curl http://speedtest.adrianws.com/file.txt > download_result.txt

# { time curl http://speedtest.adrianws.com/file.txt ; } 2> time.txt
# { time curl http://google.com ; } 2> time.txt


# aws dynamodb put-item --table-name MusicCollection --item file://item.json --return-consumed-capacity TOTAL










######################################################################################################
##################################     Adrian's Ookla SpeedTest     ##################################
######################################################################################################
















