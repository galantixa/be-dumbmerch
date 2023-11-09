def branch = "production"
def repo = "https://github.com/galantixa/be-dumbmerch.git"
def dir = "be-dumbmerch"
def imagename = "dumbmerch-be-production"
def dockerusername = "galantixa"
def cred = "docker"
def app

pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'dumbmerch-be-production'
        DOCKER_REGISTRY = 'https://hub.docker.com/' 
    }

    stages {
        stage('Clone') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        def imageTag = "${dockerusername}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
                        sh "echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin ${DOCKER_REGISTRY}"
                        sh "docker tag ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ${imageTag}"
                        sh "docker push ${imageTag}"
                    }
                }
            }
        }

        stage('Update Manifest') {
            steps {
                script {
                    build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
                }
            }
        }
    }
}







// def branch = "production"
// def repo = "git@github.com:galantixa/be-dumbmerch.git"
// def cred = "adminuser"
// def dir = "~/be-dumbmerch"
// def server = "adminuser@"
// def imagename = "dumbmerch-be-production"
// def dockerusername = "galantixa"
// def dockerpass = "dckr_pat_-uWxmibjWrkcl0syj8SQG2hOOJM"

// pipeline {
//     agent any
    
//     stages {
//         stage('Repo pull') {
//             steps {
//                 script {
//                     sshagent(credentials: [cred]) {
//                         sh """
//                             ssh -o StrictHostKeyChecking=no -T ${server} << EOF
//                                 git clone ${repo}
//                                 cd ${dir}
//                                 git checkout ${branch}
//                                 git pull origin ${branch}
//                                 exit
//                             EOF
//                         """
//                     }
//                 }
//             }
//         }

//         stage('Image build') {
//             steps {
//                 script {
//                     sshagent(credentials: [cred]) {
//                         sh """
//                             ssh -o StrictHostKeyChecking=no -T ${server} << EOF
//                                 cd ${dir}
//                                 docker build -t ${imagename}:latest .
//                                 exit
//                             EOF
//                         """
//                     }
//                 }
//             }
//         }

//         stage('Image push') {
//             steps {
//                 script {
//                     sshagent(credentials: [cred]) {
//                         sh """
//                             ssh -o StrictHostKeyChecking=no -T ${server} << EOF
//                                 docker login -u ${dockerusername} -p ${dockerpass}
//                                 docker image tag ${imagename}:latest ${dockerusername}/${imagename}:latest
//                                 docker image push ${dockerusername}/${imagename}:latest
//                                 docker image rm ${dockerusername}/${imagename}:latest
//                                 docker image rm ${imagename}:latest || true
//                                 cd && rm -rf ${dir}
//                                 exit
//                             EOF
//                         """
//                     }
//                 }
//             }
//         }
//     }
// }
