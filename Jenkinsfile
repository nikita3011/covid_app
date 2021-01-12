pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'yarn install'
            }
        }
        stage('Test') {
            steps {
                sh 'yarn test'
            }
        }
        stage('build & SonarQube analysis') {
            agent any
            steps {
                script {
                    scannerHome = tool 'SonarScanner'
                    // scannerHome = tool 'sonar_scanner'
                }
                // withSonarQubeEnv('SonarQube')
                withSonarQubeEnv('Sonarqube')  {
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
                            //sh './jenkins/scripts/deliver.sh'
                            sh 'yarn build'
                            sh  'aws s3 ls'
                            echo pwd
                            sh  'aws s3 sync build/ s3://nikita-assignment'
                        }
                    }
                }
            }
        }
    }
}
