variable "gitlab_token" {
  description = "The GitLab personal access token"
  type        = string
}

variable "gitlab_project_name" {
  description = "name of the project"
  type = string
  default = "proxmox-vm-neutron"
}

variable "gitlab_project_description" {
  description = "description of the project"
  type = string
  default = "Managed by Terraform: HomeLab - vm neutron"
}

variable "gitlab_project_visibility_level" {
  description = "The visibility of the Gitlab repository (public or private)."
  type        = string
  default     = "private"
}