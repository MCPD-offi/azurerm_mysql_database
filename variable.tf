variable "rg_name" {
  description = "Name of storage account, if it contains illegal characters (,-_ etc) those will be truncated."
  default = "rg1"
}
variable "mysql_db" {
  description = "Specifies the name of the mysql_db. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  default = "tf102042021"
}
variable "db_login" {
  description = "Specifies the login of the mysql_db. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  default = "tf102042021"
}
variable "db_password" {
  description = "Specifies the password of the mysql_db. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  default = "tf102042021"
}
variable "tags" {
  description = "map of tags assign to ressource"
  type= map(string)
}