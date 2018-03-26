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
                sh '/packer build packer-config.json'
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


