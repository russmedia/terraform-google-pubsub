variable "pubsub-order-definition" {
  type = "map"
}

locals {
  iAmAccount = {
    "role" = "roles/pubsub.editor"

    // Here we take a suspicion that resource of IAM account has an email provided in `email` property.
    "email" = "serviceAccount:${module.service-account-pubsub-editor.email}"
  }

  // `module.service-account-pubsub-editor` is your resource for service account created by TF.
  // Service account module has to be run separately before Pub/Sub module.
  module_depends_on = ["module.service-account-pubsub-editor"]
}

module "pubsub_order" {
  source     = "github.com/russmedia/terraform-google-pubsub"
  project    = "workspace-name"
  definition = "${var.pubsub-order-definition}"
  iAm        = "${local.iAmAccount}"
}
