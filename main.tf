provider "google" {
project = var.project_id
region = var.hoenn
}
 
#Networks
resource "google_compute_network" "pokenav" {
   name = var.pokenav
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
 source_tags =["oakspc-ssh"]
 source_ranges = ["0.0.0.0/0"]
  allow {
   protocol ="icmp"
 }
 allow {
   protocol = "tcp"
   ports    = ["80","8080","22"]
   }
}
 
#Compute Engine
resource "google_compute_instance" "oakpc" {
   name = "oakspc"
   machine_type = var.machine_type
   zone = var.oldale
 
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
  metadata {
    name     = "Terraform Ansible Integration"
    ssh-keys = "${var.user}:${file("${var.public_key_path}")}"
  }
  provisioner "local-exec" {
    command = "sleep 60; ansible-playbook -i '${google_compute_instance.oakpc.network_interface.0.access_config.0.nat_ip},' --private-key ${var.private_key_path} ansible_script.yml"
  }
 
}
 
#Bucket
resource "google_storage_bucket" "billpc" {
   name = "pokedex-storage-system"
   location = var.hoenn 
}
