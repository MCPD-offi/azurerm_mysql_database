provider "azurerm" {
 # version = "=2.1.0"
  features {}
}

module "tag-ressource" {
  source  = "app.terraform.io/PersoPierre/tag-ressource/azurerm"
  version = "0.0.1"

  namespace = {
    ent_code  =lookup(var.tags, "ent","")
    dept_code =lookup(var.tags, "dept","")
    env_code  =lookup(var.tags, "env","")
    type_code =lookup(var.tags, "type","")
  }
  free_name = var.mysql_db
}

data "azurerm_resource_group" "RG1" {
  name     = var.rg_name
}
resource "azurerm_mysql_server" "mysql_serv" {
  name                = "${module.tag-ressource.generated_values.name}serv"
  location            = data.azurerm_resource_group.RG1.location
  resource_group_name = data.azurerm_resource_group.RG1.name

  administrator_login          = var.db_login
  administrator_login_password = var.db_password

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysql_db" {
  name                = module.tag-ressource.generated_values.name
  location            = data.azurerm_resource_group.RG1.location
  resource_group_name = data.azurerm_resource_group.RG1.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}