pipeline {
    agent any
    // agent {
    //     docker {
    //         image 'node:12-alpine'
    //         args '-p 3000:3000'
    //     }
    // }
    // environment {
    //     CI = 'true'
    // }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Clone sources') {
            steps {
                git url: 'https://github.com/nikita3011/covid_app.git'
            }
        }
        stage('build & SonarQube analysis') {
            agent any
            steps {
                script {
                    scannerHome = tool 'SonarScanner'
                }
                withSonarQubeEnv('SonarQube') {
                    echo "${scannerHome}"
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
        stage('Quality gate') {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
        stage('Deployment') {
            
            parallel {
                stage('Production') {
                    steps {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-access', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                            sh  'aws s3 ls'
                            sh  'aws s3 sync build/ s3://nikita-deployment-assignment'
                        }
                    }
                }
            }
        }
    }
}
