variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "zone_id" {
  default = "Z082192717Y56TLJLLOXS"
}

variable "domain_name" {
  default = "aitechapp.fun"
}

variable "sonar" {
  default = false # If SonarQube server configuration required for Practice then should be true else false
}

variable "jenkins" {
  default = true # If Jenkins server configuration required for Practice then should be true else false
}

variable "runner" {
  default = false # If Git Runner server configuration required for Practice then should be true else false
}
