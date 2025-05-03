# Path to your key file
$keyPath = "C:\Users\User\Downloads\Devops-key.pem"

# EC2 login info
$ec2User = "ubuntu"
$ec2Host = "ec2-3-95-244-151.compute-1.amazonaws.com"

# Run SSH
ssh -i $keyPath "$ec2User@$ec2Host"
