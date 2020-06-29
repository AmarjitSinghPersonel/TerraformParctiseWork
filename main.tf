
provider "azurerm" {
    features{}
      subscription_id = "39a939fd-de7a-45d8-91a6-a9e868096197"
      
}
# data "azurerm_client_config" "current" {
# }
# resource "azurerm_resource_group" "main" {
#     name = "${var.prefix}-resource"
#     location = "${var.location}"
# }


# # data "azurerm_key_vault" "main" {
# #   name                = "tfvmexkeyvault"
# #   resource_group_name = "amar-rg-eastus-terraform"
  
    
# # }
# # data "azurerm_key_vault_secret" "main" {
# #   name         = "password"
# #   key_vault_id = data.azurerm_key_vault.main.id
  
# # }
# # output "secret_value" {
# #   value = data.azurerm_key_vault_secret.main.value
# # }

# resource "azurerm_virtual_network" "main" {
#     name = "${var.prefix}-network${format("%02d", count.index+1)}"
#     address_space = ["10.0.0.0/16"]
#     location = azurerm_resource_group.main.location
#     resource_group_name = azurerm_resource_group.main.name
#      count = "${var.confignode_count}"
# }



# resource "azurerm_subnet" "internal" {
#     name = "${var.subnet}${format("%02d", count.index+1)}"
#     resource_group_name = azurerm_resource_group.main.name
#     virtual_network_name = azurerm_virtual_network.main[count.index].name
#     address_prefix = "10.0.2.0/24"
#     count = "${var.confignode_count}"
# }



# resource "azurerm_public_ip" "main" {
#   name                    = "${var.publicip}${format("%02d", count.index+1)}"
#   location                = azurerm_resource_group.main.location
#   resource_group_name     = azurerm_resource_group.main.name
#   allocation_method       = "Static"
#   idle_timeout_in_minutes = 30

#   tags = {
#     environment = "Test"
#   }
#    count = "${var.confignode_count}"
# }

# resource "azurerm_network_interface" "main" {
#     name = "${var.prefix}-nic${format("%02d", count.index+1)}"
#     location = azurerm_resource_group.main.location
#     resource_group_name = azurerm_resource_group.main.name

#     ip_configuration {
#         name = "testconfig"
#         subnet_id = azurerm_subnet.internal[count.index].id
#         private_ip_address_allocation = "Dynamic"
#         private_ip_address            = "${var.privateipaddress}"
#         public_ip_address_id = azurerm_public_ip.main[count.index].id
        
#     }
#     count = "${var.confignode_count}"
# }

# data "azurerm_public_ip" "main" {
#    name                = azurerm_public_ip.main[count.index].name
#    resource_group_name = azurerm_resource_group.main.name
#    count = "${var.confignode_count}"
#  }



#  output "public_ip_address" {
   
#    value="${azurerm_public_ip.main.*.ip_address}"
#    #value = data.azurerm_public_ip.main[count.index].ip_address
   
#  }

# resource "azurerm_virtual_machine" "main" {
#     name = "${var.prefix}vm${format("%02d", count.index+1)}"
#     location = azurerm_resource_group.main.location
#     resource_group_name = azurerm_resource_group.main.name
#     network_interface_ids = [azurerm_network_interface.main[count.index].id]
#     vm_size = "Standard_DS1_v2"
#     delete_os_disk_on_termination = true
#     delete_data_disks_on_termination  = true

#     storage_image_reference {
#         publisher = "MicrosoftWindowsServer"
#         offer = "WindowsServer"
#         sku = "2012-Datacenter"
#         version = "latest"
#     }

#     storage_os_disk {
#         name = "${var.storage_disk}-${format("%02d", count.index+1)}"
#         caching = "ReadWrite"
#         create_option = "FromImage"
#         managed_disk_type = "Standard_LRS"
#     }
#     os_profile {
#     computer_name  = "${var.os_profile_computer_name}${format("%02d", count.index+1)}"
#     admin_username = "${var.os_profile_admin_name}"
#     admin_password = "${var.os_profile_password}"
    
#     }
#     os_profile_windows_config {
#         provision_vm_agent = true
#     }
#     tags = {
#         environment = "Test-${format("%02d", count.index+1)}"
#     }
#     count = "${var.confignode_count}"
# }

# data "azurerm_virtual_machine" "main" {
#    name                = azurerm_virtual_machine.main[count.index].name
#    resource_group_name = azurerm_resource_group.main.name
#    count = "${var.confignode_count}"
# }



# resource "azurerm_network_security_group" "main" {
#   name                = "${var.security_group}"
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name
# }


# resource "azurerm_network_security_rule" "main" {
#   name                        = "${var.security_rule}"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   //destination_port_range      = "5986" -- winRM  RDP = 3389 ssh=22
#   destination_port_range      = "5986" 
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.main.name
#   network_security_group_name = azurerm_network_security_group.main.name
# }


# resource "azurerm_network_interface_security_group_association" "main" {
#   network_interface_id      = azurerm_network_interface.main[count.index].id
#   network_security_group_id = azurerm_network_security_group.main.id
#    count = "${var.confignode_count}"
# }




  resource "azurerm_virtual_machine_extension" "main" {
      name                 = "${var.vm_extension}"
      #virtual_machine_id   = azurerm_virtual_machine.main[count.index].id
      virtual_machine_id  = "/subscriptions/39a939fd-de7a-45d8-91a6-a9e868096197/resourceGroups/tfvmex-Amar-resource/providers/Microsoft.Compute/virtualMachines/tfvmex-Amarvm01"
      publisher = "Microsoft.Compute"
      type = "CustomScriptExtension"
      type_handler_version = "1.8"
      settings = <<SETTINGS
      {
          "fileUris": [             
             "https://raw.githubusercontent.com/AmarjitSinghPersonel/Sentinel/master/sentinelsetup.exe",
             "https://raw.githubusercontent.com/AmarjitSinghPersonel/Sentinel/master/sentinel.ps1",
             "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
              ],
          "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File sentinel.ps1 -Force;",
          "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ConfigureRemotingForAnsible.ps1"

      }
    SETTINGS
     count = "${var.confignode_count}"
  }
  
   # resource "azurerm_virtual_machine_extension" "main2" {
#        name                 = "SelfCertificate"
#        virtual_machine_id   = "/subscriptions/39a939fd-de7a-45d8-91a6-a9e868096197/resourceGroups/tfvmex-Amar-resource/providers/Microsoft.Compute/virtualMachines/tfvmex-Amarvm01"
#        publisher = "Microsoft.Compute"
#        type = "CustomScriptExtension"
#        type_handler_version = "1.1"
      
#       settings = <<SETTINGS
#       {
#           "fileUris": [             
#              "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
#               ],
#           "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ConfigureRemotingForAnsible.ps1 exit 0;"
#       }
#     SETTINGS
#    }
  # "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"



