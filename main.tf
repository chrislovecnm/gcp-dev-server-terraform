/**
 * Copyright 2020 chrislovecnm
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {

  project = var.project_id
  region  = var.region
  version = "~> 3.0"
  zone        = var.zone
}

resource "google_compute_instance" "my_dev_server" {
  name         = "my-gcp-dev-box"
  machine_type = "n1-standard-8"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      size  = 100
    }
  }

  metadata_startup_script = <<-EOF
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository -y \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable"
    sudo apt-get update
    sudo apt-get install -y kubectl apt-transport-https ca-certificates curl \
      gnupg-agent software-properties-common git zsh \
      docker-ce docker-ce-cli containerd.io powerline fonts-powerline htop
    curl https://raw.githubusercontent.com/chrislovecnm/golang-tools-install-script/master/goinstall.sh | sudo bash
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
    sudo mv kustomize /usr/local/bin/
    EOF

  // Necessary scopes for administering kubernetes.
  service_account {
    email  = google_service_account.admin.email
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform"]
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}
