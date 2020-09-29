variable "service_name" {
  default = "riflessione"
}

variable "db_storage_size" {
  default = 20
}

variable "db_instance_class" {
  description = "The size/type of the RDS instance"
  default     = "db.t3.micro"
}

variable "db_admin" {
  description = "The dbadmin username"
  default     = "root"
}

variable "db_admin_pass" {
  description = "The dbadmin password"
  default     = "SuperSecret"
}

variable "db_user" {
  description = "The db username"
  default     = "riflessione"
}

variable "db_pass" {
  description = "The db password"
  default     = "riflessione"
}

variable "db_name" {
  description = "The database name"
  default     = "riflessione"
}

variable "domain_name" {
  description = "Domain name"
  default     = "daisaku-portfolio.com"
}
