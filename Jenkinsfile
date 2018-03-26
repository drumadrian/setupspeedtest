pipeline {
    agent any

    stages {
        stage('Show directory contents') {
            steps {
                ls -lah
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Create AMI') {
            steps {
                packer build packer-config.json
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


