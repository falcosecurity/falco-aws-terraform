resource "aws_resourcegroups_group" "falcosecurity_for_cloud" {

  name = var.name
  tags = var.tags

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "product",
      "Values": ["${var.tags["product"]}"]
    }
  ]
}
JSON
  }
}
