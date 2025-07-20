resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.bigquery_dataset_id
  project                     = var.gcp_project_id
  location                    = var.gcp_region
  description                 = "Soilflo BigQuery dataset"
  delete_contents_on_destroy  = var.delete_contents_on_destroy
}
