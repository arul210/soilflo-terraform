# soilflo-terraform

# SoilFLO GCP Infrastructure

This repository manages the Terraform-based infrastructure provisioning for SoilFLO's cloud environment on Google Cloud Platform (GCP). It is modular, supports multiple environments, and integrates key GCP services along with AWS Cognito, Cloudfront and Cloudflare.

---

### Key Features

- **Multi-Cloud Support**: Deploy infrastructure resources on GCP and AWS with integrated providers.
- **Environment Isolation**: Separate environment configurations for `au`, `uk`, and `v2` with reusable modules.
- **Modular Infrastructure**: Encapsulated Terraform modules for networking, compute, storage, databases, and serverless functions.
- **Cloud Run & Cloud Functions**: Serverless compute setup with custom containers and event-driven architecture.
- **Secure Authentication**: AWS Cognito integration for user authentication and authorization.
- **Automated Backups & Sync**: Scheduled DB backups and data synchronization from PostgreSQL to BigQuery.
- **Networking Setup**: Custom VPC, subnetting, firewall rules, and private service access configurations.
- **Multi-region Ready**

---

## 📁 Project Structure

```
soilflo-testing/
├── env/
│   ├── au/
│   │   ├── au.tfvars
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── uk/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── uk.tfvars
│   │   └── variables.tf
│   └── v2/
│       ├── main.tf
│       ├── outputs.tf
│       ├── v2.tfvars
│       └── variables.tf
├── modules/
│   ├── apis/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── artifact_registry/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── aws/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── bigquery/
│   ├── cloud_scheduler/
│   ├── cloudfunction/
│   ├── cloudrun/
│   ├── cloudsql/
│   ├── cognito/
│   ├── gcs_bucket/
│   ├── gke/
│   ├── iam/
│   ├── private_service_access/
│   ├── pubsub/
│   ├── service_account/
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── src/
│   ├── check_hauling_summary/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── v2-check-hauling-cloudfunction.zip
│   ├── db_backup/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── v2-db-backup-cloudfunction.zip
│   ├── html_to_pdf/
│   │   ├── Dockerfile
│   │   ├── main.py
│   │   └── requirements.txt
│   ├── pgtobq_sync/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── v2-pgtobq-sync-cloudfunction.zip
│   └── placeholder_image/
│       ├── app.py
│       └── Dockerfile
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── README.md
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf

```

---

## 🔧 Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/soilflo/terraform-gcp-infra.git
cd terraform-gcp-infra
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the plan

```bash
terraform plan -var-file="v2.tfvars"
```

### 4. Apply the infrastructure

```bash
terraform apply -var-file="v2.tfvars"
```

--- 

Secrets and credentials are managed securely via **Secret Manager** and **GitHub Secrets**.

---

## 👩‍💻 Maintainer

**Arul Kiruthika Raghupathi**  
Cloud Engineering Lead  
[LinkedIn](https://linkedin.com/in/arul210)