resource "aws_api_gateway_rest_api" "rest_api" {
  name = var.name

  endpoint_configuration {
      types = [var.endpoint_type]
  }
}

# configure on what endpoint we will listen for requests
# path_part will containa string that represents theendpoint path
resource "aws_api_gateway_resource" "rest_api_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
  path_part   = "{proxy+}" # ??
}

resource "aws_api_gateway_method" "rest_api_method" {
  rest_api_id      = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id      = "${aws_api_gateway_resource.rest_api_resource.id}"
  http_method      = var.http_method #??  (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY) etc  - the http method  that will be used when the API is called
  authorization    = "CUSTOM" # ?? Lambda authorizer?  - (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)
  api_key_required = true # ??  - need to ask tenant if they watnt this?
}


# need to find out more about this vvvvvvv
resource "aws_api_gateway_integration" "rest_api_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id = "${aws_api_gateway_resource.rest_api_resource.id}"
  http_method = "${aws_api_gateway_method.rest_api_method.http_method}"

  integration_http_method = "POST" #??
  type                    = "AWS_PROXY" #??  
  uri                     = "${module.acp_alert_handler_lambda.function_invoke_arn}" #?? not needed , for lambda integration!!
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration
https://docs.aws.amazon.com/apigateway/latest/developerguide/setup-http-integrations.html  < - look at 2nd part of api integration

# integration http_method iwll be the same as method http_method




# DEPLOYMENTS - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment
# Manages an API Gateway REST Deployment. A deployment is a snapshot of the REST API configuration. 
# The deployment can then be published to callable endpoints via the aws_api_gateway_stage resource and optionally managed further with the aws_api_gateway_base_path_mapping resource, aws_api_gateway_domain_name resource, and aws_api_method_settings resource. 
# For more information, see the API Gateway Developer Guide.

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage   < - STAGES
# a main stage? for each account with a var.environment appeneded to the stage name?

# method response? integration response? 