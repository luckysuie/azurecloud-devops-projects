## Deploying a dotnet application to Azure App Service using Terraform, Azure CLI, ACR, Docker and Azure app service.

### ARCHITECTURE DIAGRAM
![architecture.png]

### Phase 1: pre-requisites and Requirements of the project
- valid Azure cloud Account with subscription
- Azure CLI installed and configured
- Terraform installed and configured
1. Requirements:
- Ubuntu 20.04 LTS
- Azure container registry
- Azure webapp with dotnet runtime

### Phase2: Infrastructure deployment using Terraform
- Creat a resource group
- Create a virtual network and subnet
- Create a network security group and rules
- Create a public IP address
- Create a network interface card
- Associate the network interface card with the subnet and public IP address
- Create a virtual machine
- create an Azure container registry
- Create an Azure App Service plan
- Create an Azure web app with dotnet runtime

#### Instructions to deploy the infrastructure using Terraform
- please use the current repository for the terraform code and run the below commands to deploy the infrastructure in Azure cloud.

- Note: Before running the below commands, please make sure you have updated the dev.tfvars file with your own values for the variables.
- In the ubuntu.tf please change the size of the VM according to your subscription
- In the webapp.tf change the plan name and sku_name as per your requirement and supported plan
- commands
```bash
terraform init
terraform fmt --recursive
terraform validate
terraform plan -var-file="dev.tfvars" -out="devtf.plan"
terraform apply "devtf.plan"
```

### Phase 3: 
- connect to the VM using SSH and publicip address
- Install docker with rootless access using below
```bash
sudo apt-get update
wget -qO- https://get.docker.com/ | sh ### Install Docker using the convenience script provided by Docker
sudo groupadd -f docker ## Create the docker group if it doesn't exist
sudo usermod -aG docker $USER ## Add the current user to the docker group
sudo systemctl restart docker
newgrp docker
docker --version  ## Verify that Docker is installed and running
```

- Install Azure cli and Login to your account
```bash
sudo apt update
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az --version

## Login to your Azure account using device code authentication(after above commands run the below)
az login --use-device-code
az account show
```

- Clone the repo to the VM using Git command and navigate to the project directory
```bash
git clone https://github.com/dotnet/dotnet-docker
cd dotnet-docker/samples/AspNetCoreRazorApp
```
- Now run docker commands one by one  in the above directory
```bash
docker build -t dotnetwebapp . ## Build the docker image
docker images ## Verify the docker image is created
docker run -d --name dotnetwebapp -p 8080:8080 -e ASPNETCORE_HTTP_PORTS=8080 dotnetwebapp:latest ## Run the docker image in a container. This is for testing purpose only. In the next step we will push the image to Azure container registry and deploy it to Azure webapp.
docker tag dotnetwebapp:latest luckydevacr123456.azurecr.io/dotnetwebapp:latest 
docker login luckydevacr123456.azurecr.io ## Login to your Azure container registry
## you will get the username and password from Azure portal for your container registry
docker push luckydevacr123456.azurecr.io/dotnetwebapp:latest ## Push the docker image to Azure container registry
```

### Phase 4: Azure webapp configuration to pull the image and deploy it
 - Set your resource names
```bash
RG_NAME="lucky-dev-rg"
APP_NAME="lucky-dev-webapp-123456"
ACR_NAME="luckydevacr123456"
```
 - Retrieve the ACR credentials into variables
```bash
ACR_USERNAME=$(az acr credential show \
  --name "$ACR_NAME" \
  --query username -o tsv)

ACR_PASSWORD=$(az acr credential show \
  --name "$ACR_NAME" \
  --query "passwords[0].value" -o tsv)
```

 - Configure the Web App to pull your image and deploy it
 ```bash
 az webapp config container set \
  --resource-group "$RG_NAME" \
  --name "$APP_NAME" \
  --container-image-name "$ACR_NAME.azurecr.io/dotnetwebapp:latest" \
  --container-registry-url "https://$ACR_NAME.azurecr.io" \
  --container-registry-user "$ACR_USERNAME" \
  --container-registry-password "$ACR_PASSWORD" \
  --output none
```
 - Configure port 8080
 ```bash
 az webapp config appsettings set \
  --resource-group "$RG_NAME" \
  --name "$APP_NAME" \
  --settings WEBSITES_PORT=8080 ASPNETCORE_HTTP_PORTS=8080 \
  --output none
```
 - Enable logs and restart
```bash
 az webapp log config \
  --resource-group "$RG_NAME" \
  --name "$APP_NAME" \
  --docker-container-logging filesystem

az webapp restart \
  --resource-group "$RG_NAME" \
  --name "$APP_NAME"
```

- Browse the webapp using the URL https://<your-webapp-name>.azurewebsites.net and you should see the dotnet application running.


- output image
![webapp.png]
- once all the project is done delete the whole resource group