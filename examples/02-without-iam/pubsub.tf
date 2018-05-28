variable "pubsub-order-definition" {
  type = "map"
}

module "pubsub_order" {
  source     = "github.com/russmedia/terraform-google-pubsub"
  project    = "workspace-name"
  definition = "${var.pubsub-order-definition}"
}
