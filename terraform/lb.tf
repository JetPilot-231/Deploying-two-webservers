resource "vkcs_lb_loadbalancer" "loadbalancer" {
  name = "weblb"
  vip_subnet_id  = data.vkcs_networking_subnet.subnetwork.id
  tags = ["tag1"]
}

resource "vkcs_networking_floatingip" "balancer_fip" {
  pool = data.vkcs_networking_network.extnet.name
}

resource "vkcs_networking_floatingip_associate" "balancer_fip" {
  floating_ip = vkcs_networking_floatingip.balancer_fip.address
  port_id     = vkcs_lb_loadbalancer.loadbalancer.vip_port_id
}

resource "vkcs_lb_listener" "listener" {
  name = "listener"
  protocol = "HTTP"
  protocol_port = 80
  loadbalancer_id = "${vkcs_lb_loadbalancer.loadbalancer.id}"
}

resource "vkcs_lb_pool" "pool" {
  name = "pool"
  protocol = "HTTP"
  lb_method = "ROUND_ROBIN"
  listener_id = "${vkcs_lb_listener.listener.id}"
}

resource "vkcs_lb_member" "member_1" {
  name = "WebSrv1"
  address = vkcs_compute_instance.compute.access_ip_v4
  protocol_port = 80
  pool_id = "${vkcs_lb_pool.pool.id}"
  subnet_id = data.vkcs_networking_subnet.subnetwork.id
  weight = 10
}

resource "vkcs_lb_member" "member_2" {
  name = "WebSrv2"
  address = vkcs_compute_instance.compute2.access_ip_v4
  protocol_port = 80
  pool_id = "${vkcs_lb_pool.pool.id}"
  subnet_id = data.vkcs_networking_subnet.subnetwork.id
  weight = 10
}
