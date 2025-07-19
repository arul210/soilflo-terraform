resource "google_project_iam_custom_role" "platform_deployer" {
  role_id     = "platformCustomDeployer"
  title       = "Platform Deployer"
  description = "Custom role for deployments"
  permissions = [
    # Core permissions
    "resourcemanager.projects.get",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",

    # VPC permissions
    "compute.networks.create",
    "compute.networks.get",
    "compute.networks.update",
    "compute.networks.delete",

    # Storage permissions
    "storage.buckets.create",
    "storage.buckets.get",
    "storage.buckets.update",
    "storage.buckets.delete",

    # Cloud SQL permissions
    "cloudsql.instances.create",
    "cloudsql.instances.delete",
    "cloudsql.instances.get",
    "cloudsql.instances.update",
    "cloudsql.instances.connect",

    # Cloud Run permissions
    "run.services.create",
    "run.services.delete",
    "run.services.get",
    "run.services.update",
    "run.services.invoke",

    # Cloud Functions permissions
    "cloudfunctions.functions.create",
    "cloudfunctions.functions.delete",
    "cloudfunctions.functions.get",
    "cloudfunctions.functions.update",
    "cloudfunctions.functions.call",

    # BigQuery permissions
    "bigquery.datasets.create",
    "bigquery.datasets.delete",
    "bigquery.datasets.get",
    "bigquery.datasets.update",
    "bigquery.jobs.create",
    "bigquery.tables.create",
    "bigquery.tables.delete",
    "bigquery.tables.get",
    "bigquery.tables.update",
    "bigquery.tables.getData",
    "bigquery.tables.list",

    # Artifact Registry permissions
    "artifactregistry.repositories.create",
    "artifactregistry.repositories.delete",
    "artifactregistry.repositories.get",
    "artifactregistry.repositories.update",
    "artifactregistry.repositories.list",
    "artifactregistry.repositories.downloadArtifacts",
    "artifactregistry.repositories.uploadArtifacts",

    # GKE permissions
    "container.clusters.create",
    "container.clusters.delete",
    "container.clusters.get",
    "container.clusters.update",
    "container.deployments.create",
    "container.deployments.update",
    "container.deployments.get"
  ]
}

resource "google_project_iam_binding" "platform_sa_binding" {
  project = var.gcp_project_id
  role    = google_project_iam_custom_role.platform_deployer.id
  members = [
    "serviceAccount:${var.platform_sa_email}"
  ]
}