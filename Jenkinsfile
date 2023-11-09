def branch = "production"
def repo = "https://github.com/galantixa/be-dumbmerch.git"
def dir = "be-dumbmerch" 
def imagename = "dumbmerch-be-production"
def dockerusername = "galantixa"
def cred = "docker"
def app

pipeline {
    agent any
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
                    sh "docker build -t ${imagename} ."
                }
            }
        }
        
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        def imageTag = "${dockerusername}/${dockerimage}:${env.BUILD_NUMBER}"
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin ${https://registry.hub.docker.com}"
                        // Tag the image
                        sh "docker tag ${dockerimage}:${env.BUILD_NUMBER} ${imageTag}"

                        // Push the image
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
