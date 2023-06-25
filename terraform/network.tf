data "vkcs_networking_network" "extnet" {
   name = "ext-net"
}

data "vkcs_networking_network" "network" {
   name = "main"
}

data "vkcs_networking_subnet" "subnetwork" {
   name = "subnet_9728"
}

