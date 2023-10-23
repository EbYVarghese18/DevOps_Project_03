pipeline {
    agent any

    environment {
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    
    stages {

        stage('SCM checkout') {
            steps {
                echo 'checkout starts'
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/EbYVarghese18/DevOps_Project_03']])
                echo 'checkout ends'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Build Dockerimage starts'
                script{
                    sh 'docker build -t ebinvarghese/myapp-blue:${TAG} .'
                }
                echo 'Build Dockerimage ends'
            }
        }
        
        stage('Push Docker image to Dockerhub') {
            steps {
                script{
                    withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerpwd')]) {
                    sh 'docker login -u ebinvarghese -p ${dockerpwd}'
                    }
                    sh 'docker tag ebinvarghese/myapp-blue:${TAG} ebinvarghese/myapp-blue:latest'
                    sh 'docker push ebinvarghese/myapp-blue:${TAG}'
                    sh 'docker push ebinvarghese/myapp-blue:latest'
                    sh 'docker logout'
                }
            }
        }
        stage('Deploying App With Argocd') {
            steps {
                script {
                    sh "kubectl apply -f application-blue.yaml"
                }
            }
        }
    }
}
