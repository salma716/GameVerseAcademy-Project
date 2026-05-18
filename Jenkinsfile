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
        stage('Tests Unitaires') {
            steps {
                bat 'mvn test -Dmaven.test.failure.ignore=true'
            }
        }
        stage('Couverture de Code') {
            steps {
                bat 'mvn cobertura:cobertura -Dmaven.test.failure.ignore=true'
            }
        }
        stage('Documentation') {
            steps {
                bat 'mvn javadoc:javadoc'
            }
        }
        stage('Site') {
            steps {
                bat 'mvn site -Dmaven.test.failure.ignore=true'
            }
        }
        stage('Package') {
            steps {
                bat 'mvn package -DskipTests'
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
                 subject: "ECHEC - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Build echoue : ${env.BUILD_URL}"
        }
        success {
            mail to: 'salma.jamai.sj1234@gmail.com',
                 subject: "SUCCES - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Build reussi : ${env.BUILD_URL}"
        }
    }
}
