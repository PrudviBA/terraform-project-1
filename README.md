# 🚀☁️ Automated Web Server Deployment on AWS with Terraform & Remote State Management

---
## 📘 Project Overview

This project shows :
- Creating and managing AWS resources using Terraform
- Granting proper IAM permissions for secure access
- Using Terraform CLI to apply infrastructure changes
- Managing Terraform state files
- Setting up backend with S3 and DynamoDB (for locking and state storage)

---
## 🛠️ Tools Used

- **Terraform v1.12.2**
- **AWS CLI**
- **AWS IAM, EC2, S3, DynamoDB**
- **Git & GitHub**

---
## ✅ Step-by-Step Setup
### 📌 Step 1: Install Terraform (Ubuntu/Debian)

Run the following commands in your terminal to install Terraform:
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

- Verify installation:
 ```bash
  terraform -version
 ```
---

  ### 🔐 Step 2: IAM User Creation and Permissions
1. Go to [AWS Console](https://console.aws.amazon.com/)
2. Navigate to **IAM > Users**
3. Create a user (or select existing Terraform user)
4. Attach these policies:
   - `AmazonEC2FullAccess`
   - `AmazonS3FullAccess`
   - `AmazonDynamoDBFullAccess`
   
     <img width="1481" height="583" alt="Screenshot 2025-07-20 053619" src="https://github.com/user-attachments/assets/898162d5-96b9-4fd5-89a3-564b6b57b45e" />


---
### ⚙️ Step 3: Configure AWS CLI

```bash
aws configure
# Enter access key, secret, region, and output format
```
---

### 📁 Step 4: Create Project Directory and Configuration Files
```bash
mkdir terraform-webserver 
cd terraform-aws-webserver
```
->> Create main Terraform configuration files:  
- **`main.tf`** – Contains the infrastructure definitions like:
  - ✅ EC2 instance configuration
  - ✅ S3 bucket creation (for future backend)
  - ✅ DynamoDB table (for backend locking)

- **`variables.tf`** – Stores input variables (like AMI ID, instance type, region) to keep code reusable and clean.

- **`outputs.tf`** – *(Optional)* Prints output values such as:
  - 🌐 EC2 public IP
  - 📦 S3 bucket name, etc.

- **`user_data.sh`** – A shell script used to:
  - 🛠️ Automatically install and configure software (like Apache)
  - 🚀 Run on EC2 instance launch using the `user_data` block in `main.tf`

> ⚠️ **Note:** Do **not** include `backend.tf` during the initial run.  
> First, apply the infrastructure using the above files to create S3 and DynamoDB.  
> Then add `backend.tf` and re-run `terraform init` to enable remote state management.

 ---
 ### ✅ Step 5: Initialize Terraform (Locally First)
Before setting up remote backend, initialize Terraform with the local backend:
```bash
terraform init
```
<img width="1919" height="604" alt="Screenshot 2025-07-20 092555" src="https://github.com/user-attachments/assets/f618a82c-100b-43f5-86cc-a2129f09ad92" />

---
### ✅ Step 6: Apply Infrastructure to Create Remote Backend (S3 + DynamoDB)
Run the following:
```bash
terraform plan
terraform apply
```
This will:
- Launch EC2 instance with Apache (via user_data.sh)
- Create S3 bucket
- Create DynamoDB table for state locking
<img width="1902" height="296" alt="Screenshot 2025-07-20 104451" src="https://github.com/user-attachments/assets/057fb8c2-58d9-4d8f-8c12-2f9286d3125b" />

---
### ✅ Step 7: Configure Remote Backend
- Now that S3 & DynamoDB exist, you can add the backend.tf file.
- After that, reinitialize:
```bash
terraform init
```
- It’ll ask if you want to copy state from local to remote — type yes.
---
## 🧹 Cleanup Resources

To destroy all resources created by Terraform and avoid unnecessary AWS charges, run:

```bash
terraform destroy
```
---
## ✅ Outcomes

- ✅ Successfully launched an EC2 instance with Apache installed automatically via `user_data.sh`.
- ✅ Created an S3 bucket for storing remote Terraform state.
- ✅ Created a DynamoDB table to enable state locking and avoid conflicts.
- ✅ Configured Terraform remote backend using the created S3 and DynamoDB.
- ✅ Gained hands-on experience with deploying cloud infrastructure as code using Terraform.

---
## 📘 Key Learnings

- 📦 How to structure a reusable and modular Terraform project.
- ☁️ Practical understanding of provisioning AWS resources like EC2, S3, and DynamoDB.
- 🔒 Setting up **remote state management** with **state locking** using S3 + DynamoDB.
- 🐧 How to use `user_data` for automating EC2 instance setup tasks (e.g., installing Apache).
- 🔄 Importance of `terraform init`, `plan`, `apply`, and `destroy` lifecycle.

---








