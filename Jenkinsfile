pipeline {
    agent any
    stages {
        stage('Dependencies installation') {
            agent {
                docker {
                    image 'node:22'
                    reuseNode true
                    //args '-v /var/jenkins_home/cache:/root/.npm'
                }
            }
            stages {
                stage('Install commands') {
                    steps {
                        sh 'npm install'
                    }
                }
                stage('Testing app') {
                    steps {
                        sh 'npm run test:cov'
                    }
                }
                stage('Building') {
                    steps {
                        sh 'npm run build'
                    }
                }
            }
        }
        stage('Quality Assurance'){
            agent{
                docker {
                    image 'sonarsource/sonar-scanner-cli'
                    reuseNode true
                }
            }
            stages{
                stage('Uploading code to sonarqube'){
                    steps{
                        withSonarQubeEnv('SonarQube'){
                            sh 'sonar-scanner'
                        }
                    }
                }
            }
        }
        stage('Image building and delivery stage'){
            steps{
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        sh 'docker build -t backend-node-devops:cmd .'
                        sh 'docker tag backend-node-devops:cmd palomapuch/backend-node-devops:cmd'
                        sh 'docker push palomapuch/backend-node-devops:cmd'
                    }
                    docker.withRegistry('http://localhost:8082', 'nexus-credentials') {
                        sh 'docker tag backend-node-devops:cmd localhost:8082/backend-node-devops:cmd'
                        sh 'docker push localhost:8082/backend-node-devops:cmd'
                    }
                }

                    
            }
        }
        //stage('Building'){
        //    steps {
        //        echo 'Another building...'
        //    }
        //}
    }
}