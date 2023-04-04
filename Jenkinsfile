pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('GIt Pull'){
            steps{
                git branch: 'main', credentialsId: 'git', url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Day-Team--06-Feb.git'
            }
        }
        stage('code analysis'){
            steps{
                withSonarQubeEnv('sonar'){
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('build code'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -t daicon001/pipeline:1.0.11 .'
            }
        }
        stage('login to docker'){
            steps{
                sh 'docker login -u daicon001 -p Ibrahim24.'
            }
        }
        stage('push image'){
            steps{
                sh 'docker push daicon001/pipeline:1.0.11'
            }
        }
        stage('deloy to stage'){
            steps{
                sshagent(['Jenkins-key']){
                    sh 'ssh -t -t ec2-user@52.215.4.10 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/Stagecontainer.yml"'
                }
            }
          
        }
        stage('slack notification'){
            steps{
                slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to stage sever need approval to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
            }
        }
        stage('approval'){
            steps{
                timeout(activity: true, time: 5) {
                  input message: 'need approval to deploy to production ', submitter: 'admin'
                }
            }
        }
        stage('deploy to PROD'){
            steps{
                sshagent(['Jenkins-key']){
                    sh 'ssh -t -t ec2-user@52.215.4.10 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/PRODcontainer.yml"'
                }
            }
        }
    }
    post{
        success{
            slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
        }
        failure{
            slackSend channel: 'jenkins-pipeline', message: 'failed to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
        }
    }
}