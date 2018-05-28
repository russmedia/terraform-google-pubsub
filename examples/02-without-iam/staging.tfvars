pubsub-order-definition = {
  "name" = ["my-topic-name"]

  "pull" = []

  "push" = [
    {
      "name"     = "other-subscription-name"
      "url"      = "https://www.domain.tld/endpoint-2"
      "deadline" = "120"
    },
  ]
}
