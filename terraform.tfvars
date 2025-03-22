project-name="yantra1"
regions="us-central1"
network-module= {
    environment_name= "dev"
    vpc_main = "yantra-network"
    subnet = "yantra-subnet"
    subnet_ip_cidr_range = "10.0.0.0/16"
    secondary_pods_ip_range = "10.4.0.0/14"
    secondary_services_ip_range = "10.8.0.0/14"
    router = "yantra-router"
    nat-name = "yantra-nat"
}

gcp_credentials_json = "credentials.json"