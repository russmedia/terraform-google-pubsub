# Terraform module - Google Pub/Sub 

Terraform module which creates Pub/Sub resources on Google Cloud Platform‎.

These types of resources are supported:

* [Topic](https://www.terraform.io/docs/providers/google/r/pubsub_topic.html)
* [Subscription](https://www.terraform.io/docs/providers/google/r/pubsub_subscription.html)
* [Topic IAM member](https://www.terraform.io/docs/providers/google/r/pubsub_topic_iam.html)

## Usage

e.g.: **pubsub.tf**
```hcl
// Create an IAM reference and depends_on as a local variable - only for the reusablity purpouse.
locals {
  iAmAccount = {
    "role"  = "roles/pubsub.editor"
    "email" = "serviceAccount:${module.service-account-pubsub-editor.serviceaccount_email}"
  }

  module_depends_on = ["module.service-account-pubsub-editor"]
}

module "pubsub_all" {
  source            = "github.com/russmedia/terraform-gcp-module-pubsub"
  project           = "workspace-name"
  definition        = "${var.pubsub-x-definition}"
  iAm               = "${local.iAmAccount}"
  module_depends_on = "${local.module_depends_on}"
}
```

e.g.: **data.tfvars**
```hcl
pubsub-x-definition = {
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
    {
      "name"     = "other-subscription-name"
      "url"      = "https://www.domain.tld/endpoint-2"
      "deadline" = "120"
    },
  ]
}
```

and call it as `terraform plan -var-file=data.tfvars`.

_Note: You don't have to use *.tfvars file. It is just easier to switch when you have different data per environment._

## Known issue

- If used with IAM (e.g.: service account), this account has to be created before terraform runs plan for Pub/Sub.

## Authors

Module managed by [erento GmbH.](https://github.com/erento)

- [Konrad Cerny](https://github.com/rokerkony)
