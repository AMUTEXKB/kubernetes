# Docker
Docker is a popular platform for packaging and distributing containerized applications. We use Docker to build and package our Temporal application as a Docker image.

# Prerequisites
To follow the steps in this section, you'll need to have Docker installed on your local machine. You can download Docker from the Docker website.

Building the Docker image
To build the Docker image for our Temporal application, run the following command in the root directory of the project:

```
docker build -t docker.io/amutex/my-temporal-app:v1 .
```
This command builds a Docker image with the tag docker.io/amutex/my-temporal-app:v1 using the Dockerfile in the root directory of the project. The . at the end of the command specifies the build context, which is the current directory.

Running the Docker image
To run the Docker image for our Temporal application, you can use the docker run command:

```
docker run -p 8080:8080 docker.io/amutex/my-temporal-app:v1
```
This command runs the Docker image with the tag docker.io/amutex/my-temporal-app:v1 and maps port 8080 from the container to port 8080 on your local machine.

# Pushing the Docker image to a registry
To push the Docker image to a registry, you'll need to have credentials for the registry. In this example, we're using Docker Hub, but you can use any registry that you have credentials for.

To log in to Docker Hub, run the following command:

```
docker login --username=<DOCKER_HUB_USERNAME>

```
Replace <DOCKER_HUB_USERNAME> with your Docker Hub username, and enter your Docker Hub password when prompted.

Once you're logged in, you can push the Docker image to Docker Hub using the docker push command:
```
docker push docker.io/amutex/my-temporal-app:v1
```
This command pushes the Docker image with the tag docker.io/amutex/my-temporal-app:v1 to Docker Hub.

# Kubernetes Deployment for My Temporal App
This repository contains the configuration files and deployment scripts to run the My Temporal App on a Kubernetes cluster. The application consists of two services, the Worker and the Starter, which are built with Go and deployed as Docker containers.

# Prerequisites
Before deploying the application, you'll need the following:

An AWS account and an IAM user with permissions to create EKS clusters and manage Kubernetes resources.
The AWS CLI installed on your machine and configured with your AWS credentials.
The kubectl command-line tool installed on your machine to interact with the Kubernetes API server.
Docker installed on your machine to build and push the Docker images.
The Go programming language installed on your machine to build the application.
## Deployment
To deploy the application, follow these steps:

Fork this repository to your GitHub account and clone it to your local machine.
Open the kubernetes directory and update the deployment.yaml file with your Docker image name and tag.
Update the service.yaml file with your service ports and type.
Commit and push your changes to the main branch of your repository.
Create an EKS cluster by running the following command in your terminal:
```
aws eks create-cluster --name my-temporal-app --region us-east-1 --kubernetes-version 1.25 --role-arn arn:aws:iam::YOUR_AWS_ACCOUNT_ID:role/eksClusterRole --resources-vpc-config '{"subnetIds":["subnet-0e8554fddf40bed60","subnet-046f3384461efc0ed"],"securityGroupIds":["sg-0cafe62a98a8f4ff0"]}'
```
Note that you need to replace YOUR_AWS_ACCOUNT_ID with your AWS account ID.

Wait for the EKS cluster to become active by running the following command:
```
aws eks wait cluster-active --name my-temporal-app --region us-east-1
```
Update your kubectl config with the following command:
```
aws eks update-kubeconfig --name my-temporal-app --region us-east-1
```
Deploy the Kubernetes resources by running the following command:
```
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

```
After a few minutes, the application should be up and running on your Kubernetes cluster.