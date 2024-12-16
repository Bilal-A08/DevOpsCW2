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
				sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
			}
		}

		stage('DockerHub Image Push') {
			steps {
				sh 'docker push basgha300/cw2-server:1.0'
			}
		}

		stage('Deploy') {
			steps {
				sshagent(['jenkins-k8s-ssh-key']) {
					sh '''
						ssh -T basgha300@35.171.158.206 << 'EOF'
						kubectl set image deployment/cw2-server cw2-server=basgha300/cw2-server:latest
						kubectl rollout status deployment/cw2-server
						curl $(minikube service cw2-server-service --url)
					'''
				}
			}
		}
	}
}
