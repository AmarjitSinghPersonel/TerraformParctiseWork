# variable "prefix" {
    
# }
# variable "location" {
    
# }
# variable "subnet" {
    
# }
# variable "publicip" {
    
# }

# variable "privateipaddress"{
    
# }
# variable "os_profile_computer_name"{
    
# }
# variable "os_profile_admin_name"{
    
# }
# variable "os_profile_password"{
    
# }
# variable "storage_disk"{
    
# }
# variable "security_group"{
    
# }
# variable "security_rule"{
    
# }
# variable "vm_extension"{
    
# }
variable "confignode_count" {
    default= 1
}
variable "prefix" {
    default = "tfvmex-Amar"
}
variable "location" {
    default = "eastus"
}
variable "subnet"{
    default = "tfvmex-subnet"    
}
variable "publicip"{
    default="tfvmex-publicip"
}
variable "ipconfig"{
    default ="tfipconfig"
}
variable "privateipaddress"{
    default="10.0.2.5"
}
variable "os_profile_computer_name"{
    default="tfvmexadmin"
}
variable "os_profile_admin_name"{
    default="tfvmexadmin"
}
variable "os_profile_password"{
    default = "Password@1234"
}
variable "storage_disk"{
    default="tfvmexdisk"
}
variable "security_group"{
    default="tfvmex-securitygrp"
}
variable "security_rule"{
    default="tfvmex-securityrule"
}
variable "vm_extension"{
    default="tfvmex-extension"
}
