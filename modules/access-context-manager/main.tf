# #We can follow the following access level types
# #1. Corp IP and selected region - office employee
# #2. Selected region and corp owned device - remote employee 
# a) mobile devices (android ios restrictions, screen lock and stuff)
# b) macos and windows latops
# #3. Selected regions and OS restrictions for external contractors
# more restricted access level will be required to access more sensitive data

#Document that this policy can only be created once in a project regardless of what name u use. ACM does not have data sources so cant even read the policy name if it already exists. 
# Use gcloud command to get the policy details: 
# resource "google_access_context_manager_access_policy" "access_policy" {
#   parent = "organizations/${var.organization.id}"
#   title  = "test policy"
# }

#1st access level is office employee: Region and Corp IP (no device restrictions coz maybe using office equipment)
resource "google_access_context_manager_access_level" "office_employees_access_level" {
  parent = "accessPolicies/${var.test_acm_policy_name}"
  name   = "accessPolicies/${var.test_acm_policy_name}/accessLevels/office_employees_access_level"
  title  = "office_employees_access_level"
  basic {
    conditions {
        ip_subnetworks = ["104.133.10.0/24"] #TODO: Google CORP private IPs needs to be taken from: https://ipdb.corp.google.com/ipdb/?a=INTERNET&a=RFC1918_GOOGLE
        regions = ["IN", "US", "CA"]
    }
  }
}

#2nd access level is remote employee contractor: Region, Corp owned and OS restrictions for windows, mac, ios and android
resource "google_access_context_manager_access_level" "remote_employees_access_level" {
  parent = "accessPolicies/${var.test_acm_policy_name}"
  name   = "accessPolicies/${var.test_acm_policy_name}/accessLevels/remote_employees_access_level"
  title  = "remote_employees_access_level"
  basic {
    combining_function = "OR"
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_corp_owned = true
            os_constraints {
                minimum_version = "12.6.1"
                os_type = "DESKTOP_MAC"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_corp_owned = true
            os_constraints {
                minimum_version = "10"
                os_type = "DESKTOP_WINDOWS"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_screen_lock = true
            require_corp_owned = true
            os_constraints {
                minimum_version = "10"
                os_type = "ANDROID"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_screen_lock = true
            require_corp_owned = true
            os_constraints {
                minimum_version = "16"
                os_type = "IOS"
            }
        }
    }
  }
}

#3rd access level is extenal contractor: Region, Encrypted and OS version restrictions for windows, mac, ios and android
resource "google_access_context_manager_access_level" "ext_contractors_access_level" {
  parent = "accessPolicies/${var.test_acm_policy_name}"
  name   = "accessPolicies/${var.test_acm_policy_name}/accessLevels/ext_contractors_access_level"
  title  = "ext_contractors_access_level"
  basic {
    combining_function = "OR"
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            allowed_encryption_statuses = ["ENCRYPTED"]
            os_constraints {
                minimum_version = "12.6.1"
                os_type = "DESKTOP_MAC"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            allowed_encryption_statuses = ["ENCRYPTED"]
            os_constraints {
                minimum_version = "10"
                os_type = "DESKTOP_WINDOWS"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_screen_lock = true
            allowed_encryption_statuses = ["ENCRYPTED"]
            os_constraints {
                minimum_version = "10"
                os_type = "ANDROID"
            }
        }
    }
    conditions {
        regions = ["IN", "US", "CA"]
        device_policy {
            require_screen_lock = true
            allowed_encryption_statuses = ["ENCRYPTED"]
            os_constraints {
                minimum_version = "16"
                os_type = "IOS"
            }
        }
    }
  }
}

#IAP IAM bindings for users on which above access levels need to be enforced
resource "google_iap_web_iam_member" "member" {
  for_each = var.google_groups
  project = var.project_id
  role = "roles/iap.httpsResourceAccessor"
  member = "group:${each.value.id}"
  condition {
      title       = "${each.value.access_level_title}"
      description = "Access for Encrypted android"
      expression = "\"accessPolicies/${var.test_acm_policy_name}/accessLevels/${each.value.access_level_title}\" in request.auth.access_levels"
    }
  depends_on = [
    module.group
  ]
}
