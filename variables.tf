variable "env" {
  type = string
}

variable "app_name" {
  type = string
}

variable "queue_arn" {
  type        = string
  description = "Arn of the queue to be monitored"
}

variable "queue_arn_dead_letter" {
  type        = string
  description = "Arn of the dead-letter-queue to be monitored"
  default     = ""
}

variable "google_chat_notification_triggers" {
  description = "The issue events to notify on for google chat notifications. Valid values are ACTIVATED, ACKNOWLEDGED, PRIORITY_CHANGED, CLOSED or OTHER_UPDATES"
  type        = list(string)
  default     = ["ACTIVATED", "ACKNOWLEDGED", "PRIORITY_CHANGED", "CLOSED", "OTHER_UPDATES"]
}

variable "google_chat_url" {
  type        = string
  description = "URL of your google chat space"
}
