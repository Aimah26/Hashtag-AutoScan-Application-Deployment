pipeline{
    agent any
    tools{
        maven 'maven'
    }
    environment {
        dockerusername = credentials('dockerhub-username')
        dockerpassword = credentials('dockerhub-password')
    }
    stages{
        stage('Git pull'){
            steps{
                git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/Daicon001/Application.git'
            }
        }
        stage('code analysis'){
            steps{
                withSonarQubeEnv('sonar') {
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
                sh 'docker build -t $dockerusername/pipeline:1.0.11 .'
            }
        }
        stage('login to dockerhub'){
            steps{
                sh 'docker login -u $dockerusername -p $dockerpassword'
            }
        }
        stage('push image'){
            steps{
                sh 'docker push $dockerusername/pipeline:1.0.11'
            }
        }
        stage('deploy to QA'){
            steps{
                sshagent(['jenkins-key']) {
                    sh 'ssh -t -t ec2-user@10.0.1.82 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/QAcontainer.yml"'
               }
            }
        }
        stage('slack notification'){
            steps{
                slackSend channel: 'jenkinsbuild', message: 'successfully deployed to QA sever need approval to deploy PROD Env', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
            }
        }
        stage('Approval'){
            steps{
                timeout(activity: true, time: 5) {
                  input message: 'need approval to deploy to production ', submitter: 'admin'
               }
            }
        }
        stage('deploy to PROD'){
            steps{
               sshagent(['jenkins-key']) {
                    sh 'ssh -t -t ec2-user@10.0.1.82 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/auto_discovery.yml"'
               }  
            }
        }
    }
    post {
     success {
       slackSend channel: 'jenkinsbuild', message: 'successfully deployed to PROD Env ', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
     }
     failure {
       slackSend channel: 'jenkinsbuild', message: 'failed to deploy to PROD Env', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
     }
  }

}