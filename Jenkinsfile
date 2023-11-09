def branch = "production"
def repo = "https://github.com/galantixa/be-dumbmerch.git"
def dir = "be-dumbmerch" 
def imagename = "dumbmerch-be-production"
def dockerusername = "galantixa"
def cred = "docker"


pipeline {
    agent any 
    
    environment {
        GIT_CREDENTIALS = credentials('github') // Sesuaikan dengan ID kredensial yang telah Anda buat
        REPO_URL = 'https://github.com/galantixa/be-dumbmerch.git'
    }

    stages {
        stage('Install Git') {
            steps {
                script {
                    sh 'apt-get update && apt-get install -y git'
                }
            }
        }
        stage('Clone') {
            steps {
                withCredentials([usernamePassword(credentialsId: GIT_CREDENTIALS, passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        
                        sh "git clone ${GIT_USERNAME}:${GIT_PASSWORD}@${REPO_URL}"
                    }
            }
        }

        stage('Build') {
            steps {
                    sh "docker build -t ${imagename}:v1 ${dir}"
                    sh "cd ${dir} && rm -rf *"
            }
        }
        
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        sh "docker tag ${imagename}:v1 ${dockerusername}/${imagename}:${env.BUILD_NUMBER}"
                        sh "docker push ${dockerusername}/${imagename}:${env.BUILD_NUMBER}"
                        sh "docker rmi ${dockerusername}/${imagename}:${env.BUILD_NUMBER}"
                        sh "docker rmi ${imagename} || true"
                    }
                }
            }
        }
        
        stage('Update Manifest') {
            steps {
                    build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
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
