pipeline {
    agent any

    stages {
        stage('Show directory contents') {
            steps {
                sh 'ls -lah'
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Create AMI') {
            steps {
                sh '/home/ec2-user/packer build packer-config.json'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}


