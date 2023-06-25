data "vkcs_compute_flavor" "compute" {
  name = var.compute_flavor
}

data "vkcs_images_image" "compute" {
  name = var.image_flavor
}

resource "vkcs_compute_instance" "compute" {
  name                    = "WebSrv1"
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh+www","terra"]
  availability_zone       = var.availability_zone_name

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 8
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = data.vkcs_networking_network.network.id
    fixed_ip_v4 = "10.0.0.101"
  }

  depends_on = [
    data.vkcs_networking_network.network,
    data.vkcs_networking_subnet.subnetwork
  ]
}



resource "vkcs_compute_instance" "compute2" {
  name                    = "WebSrv2"
  flavor_id               = data.vkcs_compute_flavor.compute.id
  key_pair                = var.key_pair_name
  security_groups         = ["default","ssh+www","terra"]
  availability_zone       = var.availability_zone_name

  block_device {
    uuid                  = data.vkcs_images_image.compute.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 8
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = data.vkcs_networking_network.network.id
    fixed_ip_v4 = "10.0.0.102"
  }

  depends_on = [
    data.vkcs_networking_network.network,
    data.vkcs_networking_subnet.subnetwork
  ]
}
