pipeline{
    agent any
    tools{
        maven 'maven'
    }
    environment{
        dockerusername = credentials('Username')
        dockerpassword = credentials('password')
    }
    stages{
        stage('Git Pull'){
            steps{
                git branch: 'main', credentialsId: 'git', url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Day-Team--06-Feb.git'
            }
        }
        stage('Code Anaiysis'){
            steps{
                withSonarQubeEnv('sonar'){
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Build Code'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('Build Image'){
            steps{
                sh 'docker build -t daicon001/pipeline:1.0.11 .'
            }
        }
        stage('Login to Docker'){
            steps{
                sh 'docker login -u $dockerusername -p $dockerpassword'
            }
        }
        stage('Push Image'){
            steps{
                sh 'docker push daicon001/pipeline:1.0.11'
            }
        }
        stage('Deloy to Stage'){
            steps{
                sshagent(['Jenkins-key']){
                    sh 'ssh -t -t ec2-user@184.72.199.33 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/STAGEcontainer.yml"'
                }
            }
        }
        stage('Slack Notification'){
            steps{
                emailext body: 'successfully deployed to stage sever need approval to deploy PROD', subject: 'Hash - build ', to: 'fidelisaimah@gmail.com'
                slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to stage sever need approval to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
            }
        }
        stage('Approval'){
            steps{
                timeout(activity: true, time: 5){
                    input message: 'need approval to deploy to production ', submitter: 'admin'
                }
            }
        }
        stage('Deploy to PROD'){
            steps{
                sshagent(['Jenkins-key']){
                    sh 'ssh -t -t ec2-user@184.72.199.33 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/PRODcontainer.yml"'
                }
            }
        }
    }
    post{
        success{
            emailext body: 'successfully deployed to deploy PROD', subject: 'Hash - build ', to: 'fidelisaimah@gmail.com'
            slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
        }
        failure{
            emailext body: 'successfully deployed to deploy PROD', subject: 'Hash - build ', to: 'fidelisaimah@gmail.com'
            slackSend channel: 'jenkins-pipeline', message: 'failed to deploy PROD', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
        }
    }
}