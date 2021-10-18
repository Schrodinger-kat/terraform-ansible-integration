provider "google" {
 project     = var.project_id
 region = "us-east1"
}

#Networks
resource "google_compute_network" "pokenav" {
    name = var.vpc
    auto_create_subnetworks = false
}

#Subnet
resource "google_compute_subnetwork" "hoenn" {
    name = var.hoenn_sub
    region = var.hoenn
    ip_cidr_range = var.hoenn_id_cidr
    network = google_compute_network.pokenav.self_link
    private_ip_google_access = true
}

#Firewall
resource "google_compute_firewall" "charizard" {
    name = "charizard"
    network       = google_compute_network.pokenav.self_link
  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8"]
  
  allow {
    protocol = "all"
    ports    = []
    }
}

#Compute Engine
resource "google_compute_instance" "oakpc" {
    name = "Oak's PC"
    machine_type = var.machine_type
    zone = var.hoenn
   
    boot_disk {
    initialize_params {
      image = var.rom
    }
  }
  network_interface {
    network    = google_compute_network.pokenav.self_link
    subnetwork = google_compute_subnetwork.hoenn.self_link
    access_config {
      
    }
  }
}

#Bucket
resource "google_storage_bucket" "billpc" {
    name = "Item Storage System"
    location = var.hoenn  
}