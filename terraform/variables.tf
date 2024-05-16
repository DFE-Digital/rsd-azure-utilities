variable "registry_server" {
  description = "Hostname of the Container Registry"
  type        = string
}
variable "registry_username" {
  description = "Username for authenticating to the Container Registry"
  type        = string
}
variable "registry_password" {
  description = "Password for authenticating to the Container Registry"
  type        = string
}
variable "tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
  default     = {}
}
