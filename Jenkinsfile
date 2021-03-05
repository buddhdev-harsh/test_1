node{
      def dockerImageName= 'harshdevl/test_task:latest'
      stage('SCM Checkout'){
         git 'https://github.com/harshdevl/test_1'
      }
   
     
    
      
     stage('Build Docker Image'){         
           sh "pwd"
           
           sh "docker build -t ${dockerImageName} ."
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'dockerpwdharshdevl', variable: 'dockerpwdharshdevl')]) {
              sh "docker login -u harshdevl -p ${dockerpwdharshdevl}"
         }
        sh "docker push ${dockerImageName}"
      }
      
    stage('Run Docker Image'){
            def dockerContainerName = 'harshdevl/test_task:latest'
            def changingPermission='sudo chmod +x script.sh'
            def scriptRunner='sudo ./script.sh'           
            def dockerRun= "sudo docker run -d -p 8000:8000 ${dockerImageName}" 
            sh "${changePermission}"
            sh "${dockerRun}"
            
      
      }
      
         
  }
