pipeline {
    agent any

    tools {
        jdk 'jdk17'
        terraform 'terraform'
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Darsh1199/TERRAFORM-JENKINS-CICD.git'
            }
        }

        stage('Terraform Version Check') {
            steps {
                sh 'terraform --version'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=Terraform \
                        -Dsonar.projectName=Terraform
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 2, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }

        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs . -o trivyfs.txt'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -reconfigure'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                sh 'terraform ${action} -auto-approve'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'trivyfs.txt', allowEmptyArchive: true
        }
    }
}
