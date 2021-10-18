variable "project_id" {
  description = "Google Project ID"
}

variable "pokenav" {
  type        = string
  description = "VPC name or self-link"
  default = "pokenav"
}

variable "hoenn" {
  description = "hoenn region"
  default     = "us-east1"
}

variable "oldale" {
  description = "oldale zone"
  default = "us-east1-b"
}

variable "hoenn_sub"{
  type = string
  default = "jishnn-hoenn"
}

variable "hoenn_id_cidr"{
  description="ip_cidr_range for hoenn nw"
  default = "10.0.1.0/24"
}

variable "machine_type" {
  type        = string
  description = "GCP machine type"
  default     = "n1-standard-1"
}

variable "rom" {
  description = "OS Image"
  default     = "rocky-linux-cloud/rocky-linux-8"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "~/.ssh/id_dsa"
  
}
