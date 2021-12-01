pipeline {
    
   agent {
        docker { 
            image 'slave-final' 
            args '-u root:sudo'
        }
    }
    
    stages {
        stage('Terraform') {
            steps {
                git branch: 'dev', url: 'https://github.com/Chervique/devops-hw.git'
            //    sh 'rm -f -- ./"!HW7_ansible/AWS atym.pem"'
                sh 'terraform -chdir="./!HW6_terraform_rebuild" init '
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: "AWS_a-tim",
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                        sh 'TF_VAR_awsid=$AWS_ACCESS_KEY_ID TF_VAR_awskey=$AWS_SECRET_ACCESS_KEY terraform -chdir="./!HW6_terraform_rebuild" ${action} -auto-approve '
                    }
                
            }
               
            }
        
     
        stage('Ansible') {
            steps {
                sh 'ls -la ./!HW7_ansible/'    
                sh 'openssl req -subj "/CN=devpro/O=ATym/C=UA" -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout !HW7_ansible/roles/nginx/tasks/files/atym.key -out !HW7_ansible/roles/nginx/tasks/files/atym.pem'
                withAWS(credentials: 'AWS_a-tim', region: 'eu-central-1') {
    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ./!HW7_ansible/playbook -i ./!HW7_ansible/aws_ec2.yaml --private-key ./!HW7_ansible/AWS_atym.pem -e "ansible_ssh_user=ec2-user" '
}
                
            }
        }
    }

}