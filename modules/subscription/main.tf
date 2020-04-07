locals {
  subscriptionPullLength = length(var.pullSubscriptions)
  subscriptionPushLength = length(var.pushSubscriptions)
}

resource "google_pubsub_subscription" "pubsub_subscription_pull" {
  count   = local.subscriptionPullLength
  topic   = var.topicName
  project = var.project

  name                 = var.pullSubscriptions[count.index]["name"]
  ack_deadline_seconds = lookup(var.pullSubscriptions[count.index], "deadline", 10)
  message_retention_duration = "${lookup(
    var.pullSubscriptions[count.index],
    "retentionDuration",
    "604800",
  )}s"
  retain_acked_messages = lookup(var.pullSubscriptions[count.index], "retainAcked", false)
  expiration_policy {
    ttl = "${lookup(
      var.pullSubscriptions[count.index],
      "expirationPolicy",
      "2678400",
    )}s"
  }
}

resource "google_pubsub_subscription" "pubsub_subscription_push" {
  count   = local.subscriptionPushLength
  topic   = var.topicName
  project = var.project

  name                 = var.pushSubscriptions[count.index]["name"]
  ack_deadline_seconds = lookup(var.pushSubscriptions[count.index], "deadline", 10)
  message_retention_duration = "${lookup(
    var.pushSubscriptions[count.index],
    "retentionDuration",
    "604800",
  )}s"
  retain_acked_messages = lookup(var.pushSubscriptions[count.index], "retainAcked", false)
  expiration_policy {
    ttl = "${lookup(
      var.pushSubscriptions[count.index],
      "expirationPolicy",
      "2678400",
    )}s"
  }

  push_config {
    push_endpoint = var.pushSubscriptions[count.index]["url"]
  }
}

