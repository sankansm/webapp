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
        
        
        stage ('Release to Nexus')  {
            steps{
        nexusArtifactUploader(
        nexusVersion: 'nexus3',
        protocol: 'http',
        nexusUrl: '3.231.3.95:8081/',
        groupId: 'com.example.maven-project',
        version: '1.0-SNAPSHOT',
        repository: 'maven-snapshots',
        credentialsId: 'nexus',
        artifacts: [
            [artifactId: 'webapp',
             classifier: '',
             file: 'webapp/target/webapp-$BUILD_NUMBER.war',
             type: 'war']
        ]
     )
            }
    }
    stage('Bake Image'){
                steps{
                sh "/usr/local/bin/packer build -var 'job=$JOB_NAME' -var 'build_number=$BUILD_NUMBER' -var 'component=$JOB_NAME-$BUILD_NUMBER' packer.json"

                }
            }
            stage('Deploy'){
                steps{
                    input message: "Approve the Deploy?"
                    sh '/usr/local/bin/terraform init'

                    sh '/usr/local/bin/terraform apply -var component=${JOB_NAME}-${BUILD_NUMBER} -auto-approve'
                }
            }
    }
}

