def branch = "production"
def repo = "git@github.com:galantixa/be-dumbmerch.git"
def cred = "monitor"
def dir = "~/be-dumbmerch"
def server = "appserver@103.139.193.35"
def imagename = "dumbmerch-be"
def dockerusername = "galantixa"
def dockerpass = "dckr_pat_-uWxmibjWrkcl0syj8SQG2hOOJM"

pipeline {
    agent any
    stages {
        stage('Repo pull') {
            steps {
                script {
                    sshagent(credentials: [cred]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no -T ${server} << EOF
                                rm -rf ${dir}
                                git clone ${repo}
                                cd ${dir}
                                git checkout ${branch}
                                git pull origin ${branch}
                                exit
                            EOF
                        """
                    }
                }
            }
        }

        stage('Image build') {
            steps {
                script {
                    sshagent(credentials: [cred]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no -T ${server} << EOF
                                cd ${dir}
                                docker build -t ${imagename}:latest .
                                exit
                            EOF
                        """
                    }
                }
            }
        }

        stage('Running the image') {
            steps {
                script {
                    sshagent(credentials: [cred]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no -T ${server} << EOF
                                cd ${dir}
                                docker container stop ${imagename} || true
                                docker container rm ${imagename} || true
                                docker run -d -p 5000:5000 --name="${imagename}" ${imagename}:latest
                                exit
                            EOF
                        """
                    }
                }
            }
        }
        
        stage('Image push') {
            steps {
                script {
                    sshagent(credentials: [cred]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no -T ${server} << EOF
                                docker login -u ${dockerusername} -p ${dockerpass}
                                docker image tag ${imagename}:latest ${dockerusername}/${imagename}:latest
                                docker image push ${dockerusername}/${imagename}:latest
                                docker image rm ${dockerusername}/${imagename}:latest
                                exit
                            EOF
                        """
                    }
                }
            }
        }
    }
}
