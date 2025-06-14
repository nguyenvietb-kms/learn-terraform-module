#--------------------------------------------------------------
# Common variables
#--------------------------------------------------------------
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-2"
}

variable "tag_environment" {
  description = "The Application environment (labs, dev, uat, sit, prod, etc)"
  type        = string
  default     = "test"

  validation {
    condition     = contains(["test", "labs", "dev", "nonprod", "uat", "prod"], var.tag_environment)
    error_message = "Valid values for var: tag_environment are (test, labs, nonprod, dev, uat, prod)."
  }
}

#--------------------------------------------------------------
# Other variables
#--------------------------------------------------------------
variable "command_name" {
  description = "The name of the job command. Defaults to glueetl which can create Spark job for you. Use pythonshell for Python Shell Job Type, max_capacity needs to be set if pythonshell is chosen."
  default     = "glueetl"
  validation {
    condition     = var.command_name != "glueetl" || var.command_name != "pythonshell"
    error_message = "Values other than \"glueetl\" or \"pythonshell\" are not acceptable."
  }
}

variable "gluejob_name" {
  type        = string
  default     = ""
  description = "Name of the glue job when not required as default format"
}
variable "project" {
  default = "bvn"
}
variable "job_source" {
  default = "js1"
}
variable "created_by" {
  default = "bn"
}
variable "schema" {
  default = "s1"
}
variable "env" {
  default = "test"
}
variable "glue_iam_role" {
  default = ""
}
variable "connections" {
  type    = list(any)
  default = []
}
variable "worker_type" {
  description = "What is the type of worker node "
  default     = "Standard"
}
variable "number_of_workers" {
  description = "Number of worker nodes"
  default     = 2
}
variable "script_location" {
  description = "S3 location of the script to be executed by the Glue job"
  type        = string
  default     = "s3://test-bucket-bvn/Python/GLUE_DATABASE_EXTRACTION_FRAMEWORK.py"
}
variable "python_version" {
  default = "3"
}
variable "arguments" {
  type    = map(any)
  default = {}
}
variable "description" {
  default = "Test Terraform AWS Glue"
}
variable "max_retries" {
  default = 2
}
variable "timeout" {
  default = 2880
}
variable "glue_version" { default = "2.0" }
variable "max_concurrent" {
  default = 1
}
variable "test_mode" {
  type    = bool
  default = false
}