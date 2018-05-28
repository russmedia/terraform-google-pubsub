pubsub-order-definition = {
  "name" = ["my-topic-name"]

  "pull" = [
    {
      "name" = "some-pull-subscription-name"
    },
  ]

  "push" = [
    {
      "name" = "my-subscription-name"
      "url"  = "https://www.domain.tld/endpoint"
    },
    {
      "name"     = "other-subscription-name"
      "url"      = "https://www.domain.tld/endpoint-2"
      "deadline" = "120"
    },
  ]
}
