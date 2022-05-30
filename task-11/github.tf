resource "github_repository" "terraform_3" {
  name        = "terraform_3"
  description = "My hometasks"
  visibility = "public"
}

resource "github_repository_file" "terraform_3" {
  repository          = github_repository.terraform_3.name
  branch              = "main"
  file                = ".gitignore"
  content             = "**/*.tfstate"
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "yurynaumovich@icloud.com"
  overwrite_on_create = true
}
