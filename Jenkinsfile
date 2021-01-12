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
        stage('Install') {
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
        // stage('Build') {
        //     steps {
        //         sh 'npm run build'
        //     }
        // }
        stage('Deployment') {
            parallel {
                stage('Production') {
                    steps {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-access', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                            // sh './jenkins/scripts/deliver.sh'
                            sh 'npm run build'
                            sh  'aws s3 ls'
                            sh 'pwd'
                            sh  'aws s3 sync build/ s3://nikita-deployment-assignment'
                        }
                    }
                }
            }
            
        }

    // stage('Upload') {
    //     steps {
    //         echo 'Uploading...'
    //         dir('/home/nineleaps/.jenkins/workspace/covid-app/') {
    //             pwd() //Log current directory
    //             //credentials is the id name under aws s3 credentials
    //             withAWS(region:'us-east-2', credentials:'aws-access') {
    //                 //  def identity=awsIdentity();//Log AWS credentials
    //                 // Upload files from working directory 'build' in your project workspace
    //                 s3Upload(bucket:'nikita-deployment-assignment', workingDir:'build', includePathPattern:'**/*')
    //             }
    //         }
    //     }
    // }
    }
}
