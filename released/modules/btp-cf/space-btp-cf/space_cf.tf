# ------------------------------------------------------------------------------------------------------
# Define the required providers for this module
# ------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    cloudfoundry = {
      source  = "SAP/cloudfoundry"
      version = "1.0.0-rc1"
    }
  }
}

# ------------------------------------------------------------------------------------------------------
# Create the Cloud Foundry space
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_space" "space" {
  name = var.name
  org  = var.cf_org_id
}

# ------------------------------------------------------------------------------------------------------
# Create the CF users
# ------------------------------------------------------------------------------------------------------
resource "cloudfoundry_space_role" "manager" {
  for_each = var.cf_space_managers
  username = each.value
  type     = "space_manager"
  space    = cloudfoundry_space.space.id
}

resource "cloudfoundry_space_role" "developer" {
  for_each = var.cf_space_developers
  username = each.value
  type     = "space_developer"
  space    = cloudfoundry_space.space.id
}

resource "cloudfoundry_space_role" "auditor" {
  for_each = var.cf_space_auditors
  username = each.value
  type     = "space_auditor"
  space    = cloudfoundry_space.space.id
}
