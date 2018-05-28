locals {
  subscriptionPullLength = "${length(var.pullSubscriptions)}"
  subscriptionPushLength = "${length(var.pushSubscriptions)}"
}

resource "google_pubsub_subscription" "pubsub_subscription_pull" {
  count   = "${local.subscriptionPullLength}"
  topic   = "${var.topicName}"
  project = "${var.project}"

  name                 = "${lookup(var.pullSubscriptions[count.index], "name")}"
  ack_deadline_seconds = "${lookup(var.pullSubscriptions[count.index], "deadline", 10)}"
}

resource "google_pubsub_subscription" "pubsub_subscription_push" {
  count   = "${local.subscriptionPushLength}"
  topic   = "${var.topicName}"
  project = "${var.project}"

  name                 = "${lookup(var.pushSubscriptions[count.index], "name")}"
  ack_deadline_seconds = "${lookup(var.pushSubscriptions[count.index], "deadline", 10)}"

  push_config {
    push_endpoint = "${lookup(var.pushSubscriptions[count.index], "url")}"
  }
}
