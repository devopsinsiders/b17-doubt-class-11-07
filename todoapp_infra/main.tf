module "resource_group" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-todoapp"
  resource_group_location = "centralindia"
}

module "resource_group4" {
  source                  = "../modules/azurerm_resource_group"
  resource_group_name     = "rg-todoapp3"
  resource_group_location = "centralindia"
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_virtual_network"

  virtual_network_name     = "vnet-todoapp"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_virtual_network"

  virtual_network_name     = "vnet-tondu"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}

  module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_virtual_network"

  virtual_network_name     = "vnet-dhondhu"
  virtual_network_location = "centralindia"
  resource_group_name      = "rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}
    
module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  subnet_name          = "frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "birju_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-birju"
  virtual_network_name = "vnet-birju"
  subnet_name          = "birju-subnet"
  address_prefixes     = ["10.0.60.0/24"]
}
module "tirju_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-tirju"
  virtual_network_name = "vnet-ttirju"
  subnet_name          = "tirju-subnet"
  address_prefixes     = ["10.0.7.0/24"]
}

module "backend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"

  resource_group_name  = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  subnet_name          = "backend-subnet"
  address_prefixes     = ["10.0.2.0/24"]
}

module "public_ip_frontend" {
  depends_on          = [module.resource_group]
  source              = "../modules/azurerm_public_ip"
  public_ip_name      = "pip-todoapp-frontend"
  resource_group_name = "rg-todoapp"
  location            = "centralindia"
  allocation_method   = "Static"
}

module "frontend_vm" {
  depends_on = [module.frontend_subnet, module.key_vault, module.vm_username, module.vm_password, module.public_ip_frontend]
  source     = "../modules/azurerm_virtual_machine"

  resource_group_name  = "rg-todoapp"
  location             = "centralindia"
  vm_name              = "vm-frontend2"
  vm_size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-vm-frontend2"
  frontend_ip_name     = "pip-todoapp-frontend"
  vnet_name            = "vnet-todoapp"
  frontend_subnet_name = "frontend-subnet"
  key_vault_name       = "sonamkitijori"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
}

# module "public_ip_backend" {
#   source              = "../modules/azurerm_public_ip"
#   public_ip_name      = "pip-todoapp-backend"
#   resource_group_name = "rg-todoapp"
#   location            = "centralindia"
#   allocation_method   = "Static"
# }

# module "backend_vm" {
#   depends_on = [module.backend_subnet]
#   source     = "../modules/azurerm_virtual_machine"

#   resource_group_name  = "rg-todoapp"
#   location             = "centralindia"
#   vm_name              = "vm-backend"
#   vm_size              = "Standard_B1s"
#   admin_username       = "devopsadmin"
#   admin_password       = "P@ssw0rd1234!"
#   image_publisher      = "Canonical"
#   image_offer          = "0001-com-ubuntu-server-focal"
#   image_sku            = "20_04-lts"
#   image_version        = "latest"
#   nic_name             = "nic-vm-backend"
#   virtual_network_name = "vnet-todoapp"
#   subnet_name          = "backend-subnet"
#   pip_name             = "pip-todoapp-backend"
# }

# module "sql_server" {
#   source              = "../modules/azurerm_sql_server"
#   sql_server_name     = "todosqlserver008"
#   resource_group_name = "rg-todoapp"
#   location            = "centralindia"
#   # secret ko rakhne ka sudhar - Azure Key Vault
#   administrator_login          = "sqladmin"
#   administrator_login_password = "P@ssw0rd1234!"
# }

# module "sql_database" {
#   depends_on          = [module.sql_server]
#   source              = "../modules/azurerm_sql_database"
#   sql_server_name     = "todosqlserver008"
#   resource_group_name = "rg-todoapp"
#   sql_database_name   = "tododb"
# }

module "key_vault" {
  source              = "../modules/azurerm_key_vault"
  key_vault_name      = "sonamkitijori"
  location            = "centralindia"
  resource_group_name = "rg-todoapp"
}

module "vm_password" {
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "sonamkitijori"
  resource_group_name = "rg-todoapp"
  secret_name         = "vm-password"
  secret_value        = "P@ssw01rd@123"
}

module "vm_username" {
  source              = "../modules/azurerm_key_vault_secret"
  depends_on          = [module.key_vault]
  key_vault_name      = "sonamkitijori"
  resource_group_name = "rg-todoapp"
  secret_name         = "vm-username"
  secret_value        = "devopsadmin"
}

