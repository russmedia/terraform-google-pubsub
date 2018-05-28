variable "pubsub-order-definition" {
  type = "map"
}

locals {
  iAmAccount = {
    "role"  = "roles/pubsub.editor"
    "email" = "serviceAccount:service-account@gmail.com"
  }
}

module "pubsub_order" {
  source     = "github.com/russmedia/terraform-google-pubsub"
  project    = "workspace-name"
  definition = "${var.pubsub-order-definition}"
  iAm        = "${local.iAmAccount}"
}
