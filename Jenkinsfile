pipeline {
        agent any
        stages{
            stage('Build'){
                steps{
                sh 'mvn clean package'

                }
                post {
                success {
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/**/*.war'
                }
            }
            }
            stage ('Unit Test') {
        rtMaven.tool = 'Maven-3.6.1' // Tool name from Jenkins configuration
        rtMaven.run pom: 'pom.xml', goals: 'clean compile test'
    }
    
    stage('SonarQube Analysis') {
        //rtMaven.run pom: 'maven-example/pom.xml', goals: 'clean org.jacoco:jacoco-maven-plugin:prepare-agent package sonar:sonar -Dsonar.host.url=https://sonarcloud.io -Dsonar.organization=pattabhi -Dsonar.login=df5bb81bae9ba310d6a38135b957227ba6ecd32c '
     
         
      } 
        
        
            stage('Bake Image'){
                steps{
                sh "/usr/bin/packer build -var 'build_number=${BUILD_NUMBER}' -var 'component=${JOB_NAME}-${BUILD_NUMBER}' packer.json"

                }
            }
            stage('Deploy'){
                steps{
                    input message: "Approve the Deploy?"
                    sh 'terraform init'

                    sh 'terraform apply -var component=${JOB_NAME}-${BUILD_NUMBER} -auto-approve'
                }
            }




        }

}
