resource "google_compute_network" "yantra-network" {
    name = var.network-module.vpc_main
    project = var.project-name
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "yantra-subnetwork" {
    name = var.network-module.subnet
    ip_cidr_range = var.network-module.subnet_ip_cidr_range
    network = google_compute_network.yantra-network.name
    region = var.regions
    project = var.project-name

  private_ip_google_access = true
  depends_on = [
    google_compute_network.yantra-network
  ]

}

resource "google_compute_address" "yantra-address" {
    count=1
    name = "${var.network-module.vpc_main}-nat-ip-${count.index}"
    region = var.regions
    project = var.project-name
    depends_on = [
        google_compute_network.yantra-network
    ]
}

resource "google_compute_router" "yantra-router" {
    name = "${var.network-module.vpc_main}-router"
    region = var.regions
    project = var.project-name
    network = google_compute_network.yantra-network.name
    bgp {
        asn = 64514
    }
    depends_on = [
        google_compute_network.yantra-network
    ]
}

resource "google_compute_router_nat" "yantra-nat" {
    name = "${var.network-module.vpc_main}-nat"
    router = google_compute_router.yantra-router.name
    region = google_compute_router.yantra-router.region
    project = var.project-name
    nat_ip_allocate_option = "MANUAL_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    nat_ips = [google_compute_address.yantra-address[0].name]
    log_config {
        enable = true
        filter = "ERRORS_ONLY"
    }
    depends_on = [
        google_compute_network.yantra-network
    ]
}

resource "google_compute_firewall" "ssh" {
  name                  = "${var.network-module.vpc_main}-allow-ssh"
  network               = google_compute_network.yantra-network.name
  allow {
    protocol = "tcp"
    ports    = ["22","2812","7000","7199","7000",9042]
  }

#   target_tags   = ["by-vpn"]
  source_ranges = ["103.109.73.26"]
  depends_on    = [
    google_compute_subnetwork.yantra-subnetwork,
    google_compute_network.yantra-network
  ]
}