data "google_project" "current" {
  project_id = "my-existing-project-id-or-name" # Replace with your Project Name or ID
}

output "project_number" {
  value = data.google_project.current.number
}

output "project_id" {
  value = data.google_project.current.project_id
}