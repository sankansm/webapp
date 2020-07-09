pipeline {
    agent {
        label "master"
    }
    tools {
        maven "maven"
    }
    environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "3.231.3.95:8081"
        NEXUS_REPOSITORY = "maven-snapshots"
        NEXUS_CREDENTIAL_ID = "nexus"
    }
    stages {
        stage("checkout") {
            steps {
                script {
                    git 'https://github.com/sankansm/webapp.git';
                }
            }
        }
        stage("Build") {
            steps {
                script {
                    sh "mvn package -DskipTests=true"
                }
            } 
        }
        stage("Test") {
            steps {
                script {
                    sh "mvn test"
                }
        }
        }
        
        
        
    stage('Bake Image'){
                
                 packer build -var job=${JOB_NAME} -var build_number=${BUILD_NUMBER} -var component=${JOB_NAME}-${BUILD_NUMBER} packer.json

                
            }
            stage('Deploy'){
                steps{
                    input message: "Approve the Deploy?"
                    sh '/usr/bin/terraform init'

                    sh '/usr/bin/terraform apply -var component=${JOB_NAME}-${BUILD_NUMBER} -auto-approve'
                }
            }
    }
}

