variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "stage" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "alarm_actions" {
  type = list(string)
}

variable "ok_actions" {
  type = list(string)
}
