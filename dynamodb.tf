resource "aws_dynamodb_table" "selfserve-dynamodb-table" {
  name           = "DS_RenewalSelfServe"
  billing_mode   = var.billing_mode
  # read_capacity  = 20
  # write_capacity = 20
  hash_key       = "PK"
  range_key      = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "N"
  }

  # attribute {
  #   name = "recommend"
  #   type = "S"
  # }

  # attribute {
  #   name = "reasons"
  #   type = "S"
  # }

  # attribute {
  #   name = "usedLastYear"
  #   type = "S"
  # }

  # attribute {
  #   name = "currentPackage"
  #   type = "S"
  # }


  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  # global_secondary_index {
  #   name               = "GameTitleIndex"
  #   hash_key           = "GameTitle"
  #   range_key          = "TopScore"
  #   write_capacity     = 10
  #   read_capacity      = 10
  #   projection_type    = "INCLUDE"
  #   non_key_attributes = ["UserId"]
  # }

  tags = {
    Environment = var.environ
    Team = "data-engineering"
    app = "Renewal Self-Serve Agent Package"
    BusinessUnit = "Shared"
    Contact = "data.services@rea-group.com"
    Costcode = "451"
  }
}