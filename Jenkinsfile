node{
      def dockerImageName= 'harshdevl/test_task:latest'
      stage('SCM Checkout'){
         git 'https://github.com/harshdevl/test_1'
      }
      
      
      stage('Build Docker Image'){         
           sh "docker build -t ${dockerImageName} ."
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'dockerpwd', variable: 'dockerPWD')]) {
              sh "docker login -u harshdevl -p ${dockerPWD}"
         }
        sh "docker push ${dockerImageName}"
      }
      
    stage('Run Docker Image'){
            def dockerContainerName = 'test_task:latest'
                    
            def dockerRun= "sudo docker run -p 8000:8000 -d --name ${dockerContainerName} ${dockerImageName}" 
        }
      
         
  }
