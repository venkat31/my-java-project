// pipeline {
//   agent any

//   stages {
//     stage('Checkout') {
//       steps {
//         // Checkout your source code from version control
//         git branch: 'main', url: 'https://github.com/venkat31/my-java-project.git'
//       }
//     }

//     stage('Build') {
//       steps {
//         // Run Maven build
//         sh 'mvn clean package'
//       }
//     }

//     stage('Test') {
//       steps {
//         // Run tests using Maven
//         sh 'mvn test'
//       }
//     }

//     stage('Package') {
//       steps {
//         // Archive the built artifact (e.g., WAR file)
//         sh 'mvn package'
       
//       }
//     }
    
//     stage('Build Docker Image') {
//       steps {
//         script {
//           def imageName = 'abhi0412/my-java-project'
//           def tag = 'latest'
          
//           docker.image('maven:3.8.1-adoptopenjdk-11').inside {
//             sh 'mvn --version'
//             sh 'mvn compile'
//             sh 'cp target/*.jar app.war'
//             sh "docker build -t ${imageName}:${tag} ."
//           }
//         }
//       }
//     }
    
  
    
//     // stage('Build Docker Image') {
//     //   steps {
//     //     script {
//     //       docker.withRegistry('docker-creds') {
//     //         def dockerImage = docker.build('my-java-project:latest')
//     //         dockerImage.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
//     //           // Copy the .war file into the Docker image
//     //           sh 'cp target/*.jar app.war'
//     //         }
//     //       }
//     //     }
//     //   }
//     // }
    
//   }
// }

pipeline {
  agent {
    docker {
      image 'abhishekf5/maven-abhishek-docker-agent:v1'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/venkat31/my-java-project.git'
      }
    }

    stage('Build Docker Image') {
        environment {
        DOCKER_IMAGE = "abhi0412/ultimate-cicd:${BUILD_NUMBER}"
        // DOCKERFILE_LOCATION = "java-maven-sonar-argocd-helm-k8s/spring-boot-app/Dockerfile"
        REGISTRY_CREDENTIALS = credentials('docker-creds')
      }
      steps {
        script {
            sh 'docker build -t ${DOCKER_IMAGE} .'
            def dockerImage = docker.image("${DOCKER_IMAGE}")
            docker.withRegistry('https://index.docker.io/v1/', "docker-creds") {
                dockerImage.push()
            }
        }
      }
    }
  }
}

