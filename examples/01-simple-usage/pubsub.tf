module "pubsub_order" {
  source     = "github.com/russmedia/terraform-google-pubsub"
  project    = "workspace-name"
  definition = {
    "name" = ["my-topic-name"]
    "pull" = [
      {
        "name" = "some-pull-subscription-name"
      }
    ]
    "push" = [
      {
        "name" = "my-subscription-name"
        "url"  = "https://www.domain.tld/endpoint"
      },
    ]
  }
}
