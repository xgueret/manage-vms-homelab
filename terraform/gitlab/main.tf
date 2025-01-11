resource "gitlab_project" "startheroes" {
  name        = var.gitlab_project_name
  description = var.gitlab_project_description
  visibility_level = var.gitlab_project_visibility_level
}