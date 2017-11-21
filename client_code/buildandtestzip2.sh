echo "Removing Old files.zip file" 
rm files.zip

echo "START Zipping files into files.zip" 
cd lambda_trigger_virtualenv/lib/python2.7/site-packages
zip -r9 ../../../../files.zip *

cd ../../../../
zip -g files.zip lambda_function.py

echo "Files for AWS Lambda have been Zipped up" 

echo "Removing Old testdir directory" 
rm -r testdir
mkdir testdir

echo "creating testdir to test newly Zipped archive" 
cp files.zip testdir/files.zip
cd testdir
unzip files.zip
rm files.zip
pip freeze > requirements.txt
cd ..

echo "buildandtestzip2.sh  script is complete. " 
echo "Please inspect files in testdir before usage" 



aws lambda update-function-code --function-name write_speedtest_analytics_to_S3 --zip-file fileb://files.zip