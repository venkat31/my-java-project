pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        // Checkout your source code from version control
        git branch: 'main', url: 'https://github.com/venkat31/my-java-project.git'
      }
    }

    stage('Build') {
      steps {
        // Run Maven build
        sh 'mvn clean package'
      }
    }

    stage('Test') {
      steps {
        // Run tests using Maven
        sh 'mvn test'
      }
    }

    stage('Package') {
      steps {
        // Archive the built artifact (e.g., WAR file)
        sh 'mvn package'
       
      }
    }
    
    stage('Build Docker Image') {
      steps {
        script {
          def imageName = 'abhi0412/my-java-project'
          def tag = 'latest'
          
          docker.image('maven:3.8.1-adoptopenjdk-11').inside {
            sh 'mvn --version'
            sh 'mvn compile'
            sh 'cp target/*.jar app.war'
            sh "docker build -t ${imageName}:${tag} ."
          }
        }
      }
    }
    
  
    
    // stage('Build Docker Image') {
    //   steps {
    //     script {
    //       docker.withRegistry('docker-creds') {
    //         def dockerImage = docker.build('my-java-project:latest')
    //         dockerImage.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
    //           // Copy the .war file into the Docker image
    //           sh 'cp target/*.jar app.war'
    //         }
    //       }
    //     }
    //   }
    // }
    
  }
}
