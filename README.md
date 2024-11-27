<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | >= 3.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | >= 3.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [newrelic_alert_policy.this](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_notification_channel.google_chat](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_channel) | resource |
| [newrelic_notification_destination.google_chat](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/notification_destination) | resource |
| [newrelic_nrql_alert_condition.approximated_age_of_messages](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.messages_in_dlq](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_workflow.this](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/workflow) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_google_chat_url"></a> [google\_chat\_url](#input\_google\_chat\_url) | URL of your google chat space | `string` | n/a | yes |
| <a name="input_queue_arn"></a> [queue\_arn](#input\_queue\_arn) | Arn of the queue to be monitored | `string` | n/a | yes |
| <a name="input_create_dlq_alert"></a> [create\_dlq\_alert](#input\_create\_dlq\_alert) | Create an alert for the dead-letter-queue | `bool` | `false` | no |
| <a name="input_google_chat_notification_triggers"></a> [google\_chat\_notification\_triggers](#input\_google\_chat\_notification\_triggers) | The issue events to notify on for google chat notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY\_CHANGED, CLOSED or OTHER\_UPDATES | `list(string)` | <pre>[<br/>  "ACTIVATED",<br/>  "ACKNOWLEDGED",<br/>  "PRIORITY_CHANGED",<br/>  "CLOSED",<br/>  "OTHER_UPDATES"<br/>]</pre> | no |
| <a name="input_queue_arn_dead_letter"></a> [queue\_arn\_dead\_letter](#input\_queue\_arn\_dead\_letter) | Arn of the dead-letter-queue to be monitored | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->