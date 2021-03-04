library identifier: 'master', retriever: modernSCM(
 [$class: 'GitSCMSource',
  remote: 'https://github.com/harshdevl/test_1.git',
 ])

pipeline {
 environment {
  appName = "test_1"
  registry = "harshdevl/test_1"
  registryCredential = "dockerpwdharshdevl"
  projectPath = "/jenkins/data/workspace/test_1"
 }

 agent any

 parameters {
  gitParameter name: 'RELEASE_TAG',
   type: 'PT_TAG',
   defaultValue: 'master'
 }

 stages {

  stage('Basic Information') {
   steps {
    sh "echo tag: ${params.RELEASE_TAG}"
   }
  }

  stage('Build Image') {
   steps {
    script {
     if (isMaster()) {
      dockerImage = docker.build "$registry:latest"
     } else {
      dockerImage = docker.build "$registry:${params.RELEASE_TAG}"
     }
    }
   }
  }
 }


  
  stage('Deploy Image') {
   steps {
    script {
      docker.withRegistry("$registryURL", registryCredential) {
      dockerImage.push()
      }
    }
   }
  }

}


def getBuildName() {
 "${BUILD_NUMBER}_$appName:${params.RELEASE_TAG}"
}

def isMaster() {
 "${params.RELEASE_TAG}" == "master"
}
}
