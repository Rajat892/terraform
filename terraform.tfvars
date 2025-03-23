project-name = "yantra1"
regions      = "us-central1"
network-module = {
  environment_name            = "dev"
  vpc_main                    = "yantra-network"
  subnet                      = "yantra-subnet"
  subnet_ip_cidr_range        = "10.0.0.0/28"
  secondary_pods_ip_range     = "10.0.1.0/24"
  secondary_services_ip_range = "10.0.2.0/24"
  router                      = "yantra-router"
  nat-name                    = "yantra-nat"
}

gcp_credentials_json   = "credentials.json"
master_ipv4_cidr_block = "10.0.3.0/28"
gke_cluster_name       = "yantra-cluster"
zone                   = "us-central1-a"
node_version           = "1.31.6-gke.1020000"
min_master_version     = "1.31.6-gke.1020000"
master-authorized-network-config = [{
  cidr_block   = "103.109.73.26/32"
  display_name = "yantra-authorized-network"
}]
project-id       = "yantra1"
gke-cluster-name = "yantra-cluster"
