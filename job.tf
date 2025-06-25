
resource "aws_glue_job" "database_extraction_framework_job" {
  count             = var.command_name == "glueetl" ? 1 : 0
  name              = var.database_extraction_framework_job_name == "" ? "${var.project}_${var.job_source}_${var.created_by}_${var.schema}_${var.env}_job" : var.database_extraction_framework_job_name
  role_arn          = var.glue_iam_role == "" ? aws_iam_role.bvn_role.arn : var.glue_iam_role
  connections       = var.connections
  worker_type       = var.worker_type
  number_of_workers = var.number_of_workers

  command {
    name            = var.command_name
    script_location = var.database_extraction_framework_script_location
    python_version  = var.python_version
  }

  # https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html
  default_arguments = var.database_extraction_framework_arguments
  description       = var.description
  max_retries       = var.max_retries
  timeout           = var.timeout
  glue_version      = var.glue_version

  execution_property {
    max_concurrent_runs = var.max_concurrent
  }

  tags = merge({ Name = "${var.project}_${var.job_source}_${var.created_by}_${var.schema}_${var.env}_job" }, local.common_tags)
}

resource "aws_glue_job" "snowflake_ingestion_framework_job" {
  count             = var.command_name == "glueetl" ? 1 : 0
  name              = var.snowflake_ingestion_framework_job_name == "" ? "${var.project}_${var.job_source}_${var.created_by}_${var.schema}_${var.env}_job" : var.snowflake_ingestion_framework_job_name
  role_arn          = var.glue_iam_role == "" ? aws_iam_role.bvn_role.arn : var.glue_iam_role
  connections       = var.connections
  worker_type       = var.worker_type
  number_of_workers = var.number_of_workers

  command {
    name            = var.command_name
    script_location = var.snowflake_ingestion_framework_script_location
    python_version  = var.python_version
  }

  # https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html
  default_arguments = var.snowflake_ingestion_framework_arguments
  description       = var.description
  max_retries       = var.max_retries
  timeout           = var.timeout
  glue_version      = var.glue_version

  execution_property {
    max_concurrent_runs = var.max_concurrent
  }

  tags = merge({ Name = "${var.project}_${var.job_source}_${var.created_by}_${var.schema}_${var.env}_job" }, local.common_tags)
}
