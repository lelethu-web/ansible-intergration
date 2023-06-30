# ansible-intergration

Pre-requisites



Create your IAM user and give it appropriate permissions in AWS
Create bucket, this is to store the state file
Download the IAM creds to your local machine and ensure to state it’s path in the main file in the Provider block




In your terminal run :
         Terraform init

         Terraform plan

         Terraform apply



ec2 should be created and the public IP should be output on your terminal
Go to browser and browser to the IP:80 for nginx
 IP:81 for virtual host
