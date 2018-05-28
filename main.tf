resource "google_pubsub_topic" "pubsub_topic" {
  name    = "${element(var.definition["name"], 0)}"
  project = "${var.project}"
}

module "subscription" {
  source            = "./subscription"
  project           = "${google_pubsub_topic.pubsub_topic.project}"
  topicName         = "${google_pubsub_topic.pubsub_topic.name}"
  pullSubscriptions = "${var.definition["pull"]}"
  pushSubscriptions = "${var.definition["push"]}"
}

data "google_iam_policy" "role" {
  binding {
    role    = "${lookup(var.iAm, "role")}"
    members = ["${lookup(var.iAm, "email")}"]
  }
}

resource "google_pubsub_topic_iam_policy" "role" {
  count = "${length(lookup(var.iAm, "email")) > 0 ? 1 : 0}"

  topic       = "${google_pubsub_topic.pubsub_topic.name}"
  policy_data = "${data.google_iam_policy.role.policy_data}"
}
