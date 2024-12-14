pipeline {
        agent any
        environment {
                DOCKERHUB_CREDS = credentials('docker')
        }

	stages {

		stage('Docker Image Build') {
			steps {
				echo 'Building Docker Image...'
	                        sh 'docker build --tag basgha300/cw2-server:1.0 .'
				echo 'Docker Image Build Complete'
			}
		}

		stage('Test Docker Image') {
			steps {
				echo 'Testing Docker Image...'
				sh '''
					docker image inspect basgha300/cw2-server:1.0
					docker run --name test-container -p 8081:8080 -d basgha300/cw2-server:1.0
					docker ps
					docker stop test-container
					docker rm test-container
				'''
			}
		}

		stage('DockerHub Login') {
			steps {
				sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
			}
		}

		stage('DockerHub Image Push') {
			steps {
				sh 'docker push basgha300/cw2-server:1.0'
			}
		}

//		stage('Deploy') {
//			steps {
//				sshagent(['jenkins-k8s-ssh-key']) {
//					sh 'scp /Users/basgha300/home/aws/listDProcessesNativeStacks.sh ubuntu@ip-172-31-69-105.ec2.internal:/home/ubuntu'
//				}
//			}
//		}
	}
}
