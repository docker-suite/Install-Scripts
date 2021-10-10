pipeline {
    
    agent { label 'docker-agent' }

    stages {
        stage('Build base') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh 'make build-base'
                    }
                }
            }

            post {
                always {
                    script {
                        sh 'make remove-base'
                    }
                }
            }
        }

        stage('Build runit') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        sh 'make build-runit'
                    }
                }
            }

            post {
                always {
                    script {
                        sh 'make remove-runit'
                    }
                }
            }
        }
    }
}
