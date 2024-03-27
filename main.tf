# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Define project ID and region variables
variable "project_id" {
  type = string
  default = "nginx-demo-418509"
}

variable "region" {
  type = string
  default = "us-west1"  # Matches my Jenkins instance region
}

# Create a static external IP address for Nginx instance
resource "google_compute_address" "nginx_external_ip" {
  name = "nginx-external-ip"
}

# Create a Compute Engine instance for Nginx
resource "google_compute_instance" "nginx_instance" {
  name         = "my-nginx-instance"
  machine_type = "e2-micro"
  zone         = "us-west1-a"  # Matches my Jenkins instance zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.nginx_external_ip.address  # Use the address from the static IP resource
    }
  }

  # Allow incoming traffic on port 80 (HTTP) for Nginx
}

resource "google_compute_firewall" "nginx_instance_firewall" {
  name        = "allow-http-and-ssh-nginx"
  description = "Allows incoming HTTP traffic to Nginx instance"

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

    allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]  # Adjust for production. This is just example. Not secure :D
}

