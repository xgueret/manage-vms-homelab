terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.5.0"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
  base_url = "https://gitlab.com"
}