# credrails-task

1. Set up an EKS cluster using terraform.
2. Set up an RDS database as well.
3. Host an application on the cluster written in any language. The application should be a
simple bookstore application. One should be able to store a book and it should list the
books available. The data will be stored in RDS.
4. Design the application keeping in mind the need for scalability, security and cost
optimization.
5. Updates to the application should be deployed using github actions and ArgoCD.
6. Include alarms to monitor application/infrastructure health
7. Include instructions for any steps necessary to bring up the infrastructure as well as tear
it down. Include any other documentation needed to run the application.
8. Share the repository with your code.

### The application is a Flask-based web application that uses SQLAlchemy for database operations. It has a single model Book and two routes /books for POST and GET requests. The application is containerized using Docker.  Here's a brief description of the files: 

1. **app.py: This is the main application file. It sets up the Flask application, defines the Book model, and the routes for the application.  
2. **config.py: This file contains the configuration for the application. It reads environment variables for the PostgreSQL database connection and sets up the SQLAlchemy database URI.  
3. **Dockerfile: This file defines the Docker image for the application. It starts from a Python 3.11 base image, installs necessary packages, copies the application code into the image, installs Python dependencies from requirements.txt, and finally runs the application.  
4. **requirements.txt: This file lists the Python packages that the application depends on. These packages are installed inside the Docker image.  
To run, build, and deploy the application locally, follow these steps:
Build the Docker image:
In the terminal, navigate to the root directory of your project and run the command 
```docker build -t bookstore-app .```

# `pr-run.yaml` GitHub Actions Workflow

The `pr-run.yaml` file is a GitHub Actions workflow that automates the Continuous Integration and Continuous Deployment (CI/CD) pipeline for the project. This file is located in the `.github/workflows` directory of the project.

## Workflow Triggers

The workflow is triggered on two events:

- **Push**: Any push to any branch in the repository triggers the workflow.
- **Pull Request**: The workflow is triggered when a pull request is closed. The pull request must be against the `main` branch.

## Jobs

The workflow consists of two jobs: `lint` and `build`.

### Lint Job

The `lint` job is responsible for checking the code quality. It runs on the latest version of Ubuntu and performs the following steps:

- **Checkout**: Checks out the repository code using the `actions/checkout@v3` action.
- **Set up Python**: Sets up the specified Python version (3.10.13) using the `actions/setup-python@v3` action.
- **Install dependencies**: Installs the necessary dependencies for linting. It upgrades `pip` and installs `flake8`.
- **Lint with flake8**: Runs `flake8` to lint the code. It first checks for errors (E9, F63, F7, F82) and then checks for complexity and line length.

### Build Job

The `build` job is responsible for building and pushing the Docker image. It depends on the `lint` job, meaning it will only run if the `lint` job succeeds. It also runs on the latest version of Ubuntu and performs the following steps:

- **Checkout**: Checks out the repository code using the `actions/checkout@v3` action.
- **Login to DockerHub**: Logs in to DockerHub using the `docker/login-action@v1` action. It uses the `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets for authentication.
- **Build and push Docker image**: Builds the Docker image and pushes it to DockerHub. It uses the `POSTGRES_USER`, `POSTGRES_PASSWORD`, and `POSTGRES_DB` secrets for the


The `gitops` folder in the project is typically used to store the Kubernetes manifest files that describe the desired state of the bookstore application on the Kubernetes cluster. These manifest files are used by ArgoCD to ensure that the actual state of your application on the cluster matches the desired state described in the manifest files.

The `manifest.yaml` file inside the `gitops/credrails` directory  contains the configuration for various Kubernetes resources that make up the flask bookstore application. Here's a brief explanation of the resources defined in this file:

- **Namespace**: This section creates a namespace called `task` in your Kubernetes cluster. 

- **Secret**: This section creates a Kubernetes secret called `postgres-credentials` in the `task` namespace. This secret stores the PostgreSQL database credentials and host in base64 encoded form.

- **Deployment**: This section creates a Kubernetes deployment called `credrails-app-deployment` in the `task` namespace. The deployment manages a set of identical pods (two, in this case), ensuring that they are running and available. The pods run the Docker image specified (`ayobuba/credrails-task-web:latest`), and they use the PostgreSQL credentials from the `postgres-credentials` secret.

- **Service**: This section creates a Kubernetes service called `credrails-app-service` in the `task` namespace. The service provides a stable network endpoint for the pods managed by the `credrails-app-deployment`. It exposes the application on port 80 and routes traffic to the `credrails-app-container` on port 5001.

ArgoCD continuously monitors this `manifest.yaml` file in your Git repository. Any changes you push to this file will be detected by ArgoCD, which will then update your application on the Kubernetes cluster to match the desired state described in the updated `manifest.yaml` file.

- # Terraform Configuration Files
The terraform directory contains the following Terraform configuration files:  

## `00-meta.tf` 

This file sets up the AWS provider and other providers like Helm, Kubernetes, and Local. It also sets up the backend for storing the Terraform state in an S3 bucket.  

## `10-inputs.tf`

This file defines the input variables and local values that are used across other Terraform files. It includes variables like AWS region, profile, application name, and database credentials.  

## `20-vpc.tf`

This file creates a Virtual Private Cloud (VPC) in AWS and sets up the necessary subnets and security groups. It also tags the VPC and subnets for use with Kubernetes.


## `30-eks.tf`

This file is responsible for setting up the EKS (Elastic Kubernetes Service) cluster on AWS. It uses the `terraform-aws-modules/eks/aws` module to create the EKS cluster. The cluster is configured with two node groups, `spot-1` and `spot-2`, which use spot instances for cost efficiency. The `null_resource` "kubectl" updates the kubeconfig file with the EKS cluster details.

## `40-rds.tf`

This file creates an AWS RDS (Relational Database Service) instance for the PostgreSQL database. The RDS instance is configured with various parameters like allocated storage, engine version, instance class, and more. The database credentials and other sensitive information are fetched from the input variables.

## `50-argocd.tf`

This file sets up ArgoCD on the Kubernetes cluster. ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes. It uses the `aigisuk/argocd/kubernetes` module to install ArgoCD on the cluster.

## `90-output.tf`

This file defines the output variables for the Terraform configuration. These output variables can be used to get useful information about the resources created by Terraform, such as the EKS cluster ID, cluster endpoint, VPC ID, subnets, and RDS endpoint.

These Terraform files together set up a complete environment on AWS, including a VPC, an EKS cluster, an RDS instance, and ArgoCD for continuous delivery.

## How to Add a Book

You can add a book to the bookstore application by making a POST request to the `/books` endpoint. Here's an example using `curl`:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"title":"The Secret Lives of Baba Segis Wives.", "author":"Lola Shobowale"}' http://credails.plsg.io/books

## How to List All Books

You can retrieve all the books from the bookstore application by making a GET request to the `/books` endpoint. Here's an example using `curl`:

```bash
curl -X GET http://credails.plsg.io/books