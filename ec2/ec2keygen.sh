# Create EC2 keypair
aws ec2 create-key-pair --key-name ec2keypair --query 'KeyMaterial' --output text > ec2keypair.pem

# Set permissions for only-user-read
chmod 400 ec2keypair.pem

# Delete EC2 keypair
aws ec2 delete-key-pair --key-name ec2keypair
