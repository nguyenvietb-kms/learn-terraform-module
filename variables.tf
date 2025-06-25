#--------------------------------------------------------------
# Common variables
#--------------------------------------------------------------
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-2"
}
variable "account_id" {
  description = "The account id"
  type        = string
  default     = "575108915615"
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
variable "database_extraction_framework_job_name" {
  type        = string
  default     = ""
  description = "Name of the glue job when not required as default format"
}
variable "snowflake_ingestion_framework_job_name" {
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
variable "database_extraction_framework_script_location" {
  description = "S3 location of the script to be executed by the Glue job"
  type        = string
  default     = "s3://test-bucket-bvn/database_extraction_framework/scripts/GLUE_DATABASE_EXTRACTION_FRAMEWORK.py"
}
variable "snowflake_ingestion_framework_script_location" {
  description = "S3 location of the script to be executed by the Glue job"
  type        = string
  default     = "s3://test-bucket-bvn/snowflake_ingestion_framework/scripts/INGESTION_SNOWFLAKE_FRAMEWORK.py"
}
variable "python_version" {
  default = "3"
}
variable "database_extraction_framework_arguments" {
  type    = map(any)
  default = {
    "--table_list" = "sqltablelist"
    "--database" = "test_glue_database"
    "--bucket" = "test-bucket-bvn"
    "--deployment" = "test"
    "--secret_name" = "test_secret"
    "--dataformat" = "parquet"
    "--s3prefix" = "DataExtraction"
    "--glue_database" = "test_glue_database"
    "--enable-continuous-cloudwatch-log" = "true"
    "--continuous-log-logGroup" = "/aws-glue/jobs/database_extraction_framework_job"
    "--extra-jars" = "s3://test-bucket-bvn/database_extraction_framework/resources/drivers/sqlserver/mssql-jdbc-8.4.1.jre8.jar"
  }
}
variable "snowflake_ingestion_framework_arguments" {
  type    = map(any)
  default = {
    "--secret_name" = "snowflake_secret"
	"--deployment" = "test"
	"--s3_bucket" = "test-bucket-bvn"
	"--s3prefix" = "DataExtraction"
	"--athena_database" = "test_glue_database"
    "--table_list" = "sqltablelist_snowflake"
    "--enable-continuous-cloudwatch-log" = "true"
    "--continuous-log-logGroup" = "/aws-glue/jobs/snowflake_ingestion_framework_job"
    "--extra-jars" = "s3://test-bucket-bvn/snowflake_ingestion_framework/resources/drivers/snowflake-jdbc-3.13.22.jar,s3://test-bucket-bvn/snowflake_ingestion_framework/resources/drivers/spark-snowflake_2.12-2.11.0-spark_3.1.jar"
  }
}
variable "description" {
  default = "Test Terraform AWS Glue"
}
variable "max_retries" {
  default = 0
}
variable "timeout" {
  default = 2880
}
variable "glue_version" { default = "3.0" }
variable "max_concurrent" {
  default = 1
}
variable "test_mode" {
  type    = bool
  default = false
}