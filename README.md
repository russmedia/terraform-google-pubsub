# Terraform module - Google Pub/Sub 

Terraform module which creates Pub/Sub resources on Google Cloud Platform‎.

These types of resources are supported:

* [Topic](https://www.terraform.io/docs/providers/google/r/pubsub_topic.html)
* [Subscription](https://www.terraform.io/docs/providers/google/r/pubsub_subscription.html)
* [Topic IAM member](https://www.terraform.io/docs/providers/google/r/pubsub_topic_iam.html)

# Compatibility
This module is meant for use with Terraform 0.12. If you haven't upgraded and need a Terraform 0.11.x-compatible version of this module, the last released version intended for Terraform 0.11.x is 2.0.0.

## Note

If you wish to use `retentionDuration`, `retainAcked` or `expirationTtl` you need the `google` provider `~> 2.20`

## Usage

e.g.: **pubsub.tf**
```hcl
module "pubsub_module_name" {
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
```

and see a plan with following command `terraform plan --out=.tfplan`. In case the output looks good you can apply with `terraform apply ".tfplan"`.

For more usage examples go to [Examples folder](./examples).

_Note: You don't have to use *.tfvars file. It is just easier to switch when you have different data per environment._

## Known issue

- If used with IAM (e.g.: service account), this account has to be created before terraform runs plan for Pub/Sub.

## Authors

Module managed by [erento GmbH.](https://github.com/erento)

- [Konrad Cerny](https://github.com/rokerkony)
