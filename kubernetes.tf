

data "google_client_config" "default" {}
data "google_container_cluster" "gke-cluster" {
    name = var.gke_cluster_name
    location = var.zone
    depends_on = [
        var.network-module.vpc_main,
        var.network-module.subnet,
        google_container_cluster.gke-cluster
    ]
}

data "google_compute_network" "vpc_main" {
    name = var.network-module.vpc_main
}

data "google_compute_subnetwork" "subnet" {
    name = var.network-module.subnet
    network = "${data.google_compute_network.vpc_main.id}"
    depends_on = [
        google_compute_network.yantra-network.id
    ]
}



provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
}

# gke cluster
resource "google_container_cluster" "gke-cluster" {
  name     = var.gke_cluster_name
  location = var.zone
  remove_default_node_pool = false
  initial_node_count       = 1
  node_version             = var.node_version
  min_master_version       = var.min_master_version
  network                  = var.network-module.vpc_main
  subnetwork               = var.network-module.subnet
  default_snat_status {
       disabled = false
  }
  workload_identity_config {
    workload_pool = "${var.project-id}.svc.id.goog"
  }
  master_authorized_networks_config {
    dynamic "cidr_blocks"{
      for_each = var.master-authorized-network-config
      content {
        cidr_block = cidr_blocks.value["cidr_block"]
        display_name = cidr_blocks.value["display_name"]
      }

    }
  }

  
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  
   

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "${var.master_ipv4_cidr_block}"
  }
  
  ip_allocation_policy {
  
   cluster_secondary_range_name = "private-pods"
    services_secondary_range_name = "private-services"

  }
	
  release_channel {
	
		channel		   = "UNSPECIFIED"

  }
	
  
    depends_on = [
	google_compute_network.yantra-network.id,
	google_compute_subnetwork.yantra-subnet.id
	
  ]  
  
}


