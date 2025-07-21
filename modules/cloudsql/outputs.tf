output "postgres_instance_connection_name" {
  description = "The connection name of the instance to be used in connection strings"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "db_name" {
  description = "Name of the user-created database"
  value       = google_sql_database.postgres_db.name
}

output "db_user" {
  description = "The name of the PostgreSQL user"
  value       = google_sql_user.postgres_user.name
}

