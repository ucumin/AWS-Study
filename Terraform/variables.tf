variable "my_ip" {
  description = "Your IP address for SSH"
  type        = string
}

variable "db_user" {
  description = "RDS username"
  type        = string
}

variable "db_password" {
  description = "RDS password"
  type        = string
}

variable "alarm_email" {
  description = "Alarm notification email"
  type        = string
}