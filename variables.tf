variable "project" {}

variable "iAm" {
  type = object({
    role  = string
    email = string
  })

  description = <<EOF
    Map of service account used to set permissions for a topic."

    Attributes:
      - role  [string]
      - email [string]
  EOF

  default = {
    "role"  = ""
    "email" = ""
  }
}

variable "definition" {
  type = object({
    name = list(string)
    pull = list(map(string))
    push = list(map(string))
  })

  description = <<EOF
    Attributes:
      - name [list]

      - pull [list]
        The list of PULL subscriptions should be defined by those attributes:
          - name
          - deadline (optional) (default: 10)
          - retentionDuration (optional) (default: 604800)
          - retainAcked (optional) (default: false)
          - expirationTtl (optional) (default: 2678400})

      - push [list]
        The list of PUSH subscriptions should be defined by those attributes:
          - name
          - url
          - deadline (optional) (default: 10)
          - retentionDuration (optional) (default: 604800)
          - retainAcked (optional) (default: false)
          - expirationTtl (optional) (default: 2678400)
  EOF
}

variable "module_depends_on" {
  type        = list(string)
  description = "The module which should be created before Pub/Sub, required if iAm is used."
  default     = []
}
