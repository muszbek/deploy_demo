# DeployDemo

A demo repository for deployment examples of a Phoenix project.

## Prerequisites
- aws cli
- open-ssh
- docker, docker-compose
- terraform
- ansible
- kubectl
- helm, helmfile

### 1. Register to Amazon Web Services

### 2. Create an AWS IAM USER
We are not going to develop in the root user.
The user should have administrator privileges.
Create an access key pair for cloud development.

`aws configure` with the access credentials of the IAM user.

### 3. Register a domain name in AWS
Use the AWS Route53 service.
Here my domain name is *tamasweb.com*.

### 4. Create an RSA key pair
```
cd ./keys
ssh-keygen
```

## Single server deployment

### 5. Build the cloud environment with Terraform

```
cd ./terraform/ec2_deploy
terraform apply
```

### 6. Fix the host records in Route53
Make sure that the nameserver addresses of the NS record are referenced correctly in the domain name registry.

### 7. Source AWS variables
```
source ./source_env.sh
```
This logs in to Docker with AWS credentials, exports AWS related variables.
Make sure that the domain name at the beginning of the script is correct.

### 8. Build and push the server image to the AWS ECR

```
docker-compose build phx-server
docker push ${AWS_ECR_REPO}:deploy_demo_0.1
```

### 9. Fix Ansible target info
- Check public IP address of the EC2 instance:

```
aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress"
```
Replace this IP address with the address in `./ansible/aws_inventory`

- Fix RSA key for Ansible:

Make sure your private RSA key path is referenced correctly in `./ansible/group_vars/webservers.yml`

### 10. Configure EC2 instance with Ansible

```
cd ./ansible
ansible-playbook -i aws_inventory provision_playbook.yml
```

### 11. Launch application

```
ssh -i keys/id_rsa ubuntu@15.188.75.62
docker-compose up -d
```

The IP address of the SSH target has to be the public IP address of the EC2 instance.

Now the server should be available on the domain name in your browser.

## Kubernetes deployment

### 5. Build the cloud environment with Terraform

```
cd ./terraform/eks_deploy
terraform apply
```

### 6. Fix the host records in Route53
Make sure that the nameserver addresses of the NS record are referenced correctly in the domain name registry.

### 7. Source AWS variables
```
source ./source_env.sh
```
This logs in to Docker with AWS credentials, exports AWS related variables.
Make sure that the domain name at the beginning of the script is correct.

### 8. Build and push the server image to the AWS ECR

```
docker-compose build phx-server
docker push ${AWS_ECR_REPO}:deploy_demo_0.1
```

### 9. Deploy Kubernetes

```
helmfile apply
```
Now the server should be available on the domain name in your browser.
