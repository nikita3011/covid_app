pipeline {
    agent any
       stages {
        stage('Install') {
            steps {
                echo 'Installation...'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'npm test'
            }
        }
        stage('Sonarqube') {
            environment {
                 scannerHome = tool 'sonar_scanner'
            }
            steps {
                echo 'Scanning....'
                withSonarQubeEnv('Sonarqube') {
                sh "${scannerHome}/bin/sonar-scanner"
             }
                timeout(time: 10, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
            }
        }
    }
     stage('Build') {
            steps {
                echo 'Production build...'
                sh 'npm run build'
            }
        }
    stage('Upload') {
        steps{
        echo 'Uploading...'
        dir('/home/user/.jenkins/workspace/samplejenkins'){
            pwd(); //Log current directory
            withAWS(region:'us-east-2',credentials:'aws-credentials') {
                //  def identity=awsIdentity();//Log AWS credentials
                // Upload files from working directory 'dist' in your project workspace
                s3Upload(bucket:"nikita-deployment-assignment", workingDir:'build', includePathPattern:'**/*');
            }
        }
    }
    }
}
}