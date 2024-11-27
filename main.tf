resource "newrelic_nrql_alert_condition" "approximated_age_of_messages" {
  policy_id = newrelic_alert_policy.this.id
  type      = "static"
  name      = "approximated-age-of-oldest-message-${var.env}"

  enabled                      = true
  violation_time_limit_seconds = 86400

  nrql {
    query = "SELECT max(aws.sqs.ApproximateAgeOfOldestMessage) FROM Metric WHERE aws.sqs.queueArn = '${var.queue_arn}'"
  }

  warning {
    operator              = "above"
    threshold             = 250000
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  critical {
    operator              = "above"
    threshold             = 500000
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

resource "newrelic_nrql_alert_condition" "messages_in_dlq" {
  count = var.create_dlq_alert ? 1 : 0

  policy_id = newrelic_alert_policy.this.id
  type      = "static"
  name      = "message-in-dlq-${var.env}"

  enabled                      = true
  violation_time_limit_seconds = 86400

  fill_option = "static"
  fill_value  = 0

  nrql {
    query = "SELECT max(aws.sqs.NumberOfMessagesReceived) FROM Metric WHERE aws.sqs.queueArn = '${var.queue_arn_dead_letter}'"
  }

  warning {
    operator              = "above_or_equals"
    threshold             = 1
    threshold_duration    = 300
    threshold_occurrences = "all"
  }

  critical {
    operator              = "above_or_equals"
    threshold             = 5
    threshold_duration    = 300
    threshold_occurrences = "all"
  }
}

# policy
resource "newrelic_alert_policy" "this" {
  name                = "${var.app_name}-${var.env}"
  incident_preference = "PER_CONDITION"
}


# workflow
resource "newrelic_workflow" "this" {
  name                  = "workflow-${var.app_name}-${var.env}"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "${var.app_name}-${var.env}-filter-policy"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = [newrelic_alert_policy.this.id]
    }
  }

  destination {
    channel_id            = newrelic_notification_channel.google_chat.id
    notification_triggers = var.google_chat_notification_triggers
  }
}

resource "newrelic_notification_channel" "google_chat" {
  name           = "${var.app_name}-${var.env}-google-chat-notification-channel"
  type           = "WEBHOOK"
  destination_id = newrelic_notification_destination.google_chat.id
  product        = "IINT" // (Workflows)

  property {
    key   = "payload"
    value = local.google_chat_template
    label = "Payload Template"
  }
}

resource "newrelic_notification_destination" "google_chat" {
  name = "${var.app_name}-${var.env}-google-chat-destination"
  type = "WEBHOOK"

  property {
    key   = "url"
    value = var.google_chat_url
  }
}
