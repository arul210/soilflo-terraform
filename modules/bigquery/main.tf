resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.bigquery_dataset_id
  project                     = var.gcp_project_id
  location                    = var.gcp_region
  description                 = "Soilflo BigQuery dataset"
  delete_contents_on_destroy  = var.delete_contents_on_destroy
}

resource "google_bigquery_dataset_iam_member" "cloudrun_bq_access" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "serviceAccount:${var.cloudrun_sa}"
}
