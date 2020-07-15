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

// Service accounts are used to provide credentials to software running in GCP
// You set what privileges a service account has by defining custom roles
// and binding those roles to a service account in the IAM tab
resource "google_service_account" "admin" {
  account_id   = "gke-tutorial-admin-${var.execution_id}"
  display_name = "GKE Tutorial Admin"
}

resource "google_project_iam_member" "kube-api-admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.admin.email}"
}

resource "google_project_iam_member" "kube-cluster-admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${google_service_account.admin.email}"
}

resource "google_project_iam_member" "compute-admin" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.admin.email}"
}

resource "google_project_iam_member" "storage-admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.admin.email}"
}

resource "google_project_iam_member" "service-account" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.admin.email}"
}
