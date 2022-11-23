# Instâncias Linux
module "network-linux" {
  source = "./tf-modules/gcp-networks"

  name        = "network-linux"
  description = "Rede para o grupo de máquinas linux"
}

module "subnetwork-linux" {
  source = "./tf-modules/gcp-subnetworks"

  name          = "subnetwork-linux"
  ip_cidr_range = "10.10.1.0/24"
  network       = module.network-linux.self_link
}

module "instances" {
  source = "./tf-modules/gcp-instances"

  amount     = 1
  name       = "bastion"
  image      = "rocky-linux-cloud/rocky-linux-9"
  network    = module.network-linux.self_link
  subnetwork = module.subnetwork-linux.self_link
}

# Instância Ansible
module "network-ansible" {
  source = "./tf-modules/gcp-networks"

  name        = "network-ansible"
  description = "Rede para o grupo de máquinas ansible"
}

module "subnetwork-ansible" {
  source = "./tf-modules/gcp-subnetworks"

  name          = "subnetwork-ansible"
  ip_cidr_range = "10.10.2.0/24"
  network       = module.network-ansible.self_link
}

module "group-ansible" {
  source = "./tf-modules/gcp-instances"

  amount     = 1
  name       = "ansible-aluno"
  image      = "rocky-linux-cloud/rocky-linux-9"
  network    = module.network-ansible.self_link
  subnetwork = module.subnetwork-ansible.self_link
}

# Instâncias mysql
module "network-mysql" {
  source = "./tf-modules/gcp-networks"

  name        = "network-mysql"
  description = "Rede para o grupo de máquinas gitlab"
}

module "subnetwork-mysql" {
  source = "./tf-modules/gcp-subnetworks"

  name          = "subnetwork-mysql"
  ip_cidr_range = "10.10.3.0/24"
  network       = module.network-mysql.self_link
}

module "group-mysql" {
  source = "./tf-modules/gcp-instances"

  amount     = 5
  name       = "mysql-aluno"
  image      = "rocky-linux-cloud/rocky-linux-9"
  network    = module.network-mysql.self_link
  subnetwork = module.subnetwork-mysql.self_link
}
