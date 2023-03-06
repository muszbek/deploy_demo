DOMAIN=tamasweb.com
CLUSTER_NAME=demo-cluster
DOCKER_REPO_NAME=demo-repository

AWS_REGION=$(aws configure get region)
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_ACM_ARN=$(aws acm list-certificates --region $AWS_REGION --query "CertificateSummaryList[?DomainName=='${DOMAIN}'].CertificateArn" --output text)

DOCKER_PW=$(aws ecr get-login-password --region $AWS_REGION)
AWS_ECR_REPO=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${DOCKER_REPO_NAME}
docker login --username AWS --password $DOCKER_PW $AWS_ECR_REPO
DOCKER_CREDS=$(cat ~/.docker/config.json)

export DOMAIN=$DOMAIN
export CLUSTER_NAME=$CLUSTER_NAME
export AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID
export AWS_ACM_ARN=$AWS_ACM_ARN
export AWS_ECR_REPO=$AWS_ECR_REPO
export DOCKER_CREDS=$DOCKER_CREDS
