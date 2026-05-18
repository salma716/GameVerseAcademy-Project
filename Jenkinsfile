pipeline {
    agent any
    tools {
        maven 'Maven'
        jdk 'jdk25'
    }
    stages {

        stage('Build') {
            steps {
                bat 'mvn compile'
            }
        }

        stage('Tests') {
            parallel {

                stage('Tests Unitaires') {
                    steps {
                        bat 'mvn test'
                    }
                    post {
                        always {
                            junit 'target/surefire-reports/**/*.xml'
                        }
                    }
                }

                stage('Couverture de Code') {
                    steps {
                        bat 'mvn cobertura:cobertura'
                    }
                }

                stage('Documentation') {
                    steps {
                        bat 'mvn javadoc:javadoc'
                    }
                }
            }
        }

        stage('Site') {
            steps {
                bat 'mvn site'
            }
        }

        stage('Package') {
            steps {
                bat 'mvn package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.jar,target/*.war', fingerprint: true
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                bat 'mvn deploy -DskipTests'
            }
        }
    }

    post {
        failure {
            mail to: 'salma.jamai.sj1234@gmail.com',
                 subject: "ECHEC Pipeline - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Build echoue : ${env.BUILD_URL}"
        }
        success {
            echo 'Pipeline termine avec succes!'
        }
    }
}
