pipeline {
  agent {
    node {
        label 'AGENT-1'
    }
  } 
  options{
        timeout(time: 1,unit:'HOURS')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {

          string(name: 'version', defaultValue: '', description: ' Pick up artifact version ?')
          string(name: 'environment', defaultValue: 'dev', description: ' Pick up deploy environment ?')

        }
    // Build //
    stages {
        stage('get_version') {
            steps {
                sh """
                      echo "version : ${params.version}"
                      echo "environment : ${params.environment}"

                """
            }
          }
          stage('Init') {
            steps {
                sh """
                    cd terraform 
                    terraform init 
                """ 
                // --backend-config=${params.environment}/backend.tf -reconfigure

            }
          }
          stage('plan') {
            steps {
                sh """
                      cd terraform 
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}"

                """
            }
          }
          stage('apply') {
            steps {
                sh """
                      cd terraform 
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -auto-approve

                """
            }
          }
        
        }
    // post build 
     post { 
        always { 

            echo 'I will always run'
            deleteDir()
        }
        failure{
            echo 'job is failed , creating an alarm'
        }
        success{
            echo 'job completed successfully'
        }
    }
}
