@echo off
mkdir terraform-virtualbox
cd terraform-virtualbox
type nul > providers.tf
type nul > variables.tf
type nul > main.tf
type nul > outputs.tf
type nul > terraform.tfvars
dir
cd ..
