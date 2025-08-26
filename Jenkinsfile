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
        //stage('Building'){
        //    steps {
        //        echo 'Another building...'
        //    }
        //}
    }
}