pipeline {
    agent any
    
    environment {
        GIT_REPO = 'git@github.com:galantixa/be-dumbmerch.git'
        IMAGE_NAME = 'dumbmerch-be-production'
        DOCKER_USERNAME = 'galantixa'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'production', url: GIT_REPO
            }
        }

        stage('Build Image') {
            steps {
                script {
                    docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
                        docker.image(IMAGE_NAME).push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline selesai. Semua tahapan berhasil.'
        }
        failure {
            echo 'Pipeline gagal. Mohon periksa log untuk detail kesalahan.'
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
