#  create an s3 bucket to store code
# need to make sure s3_key is there? 
# get tenants to upload code to bucket therefore they have to provide the object key? 


#  figure out how to parameterize vvvv

resource "aws_api_gateway_authorizer" "rest_api_authorizer" {
  name                   = var.auth_name
  rest_api_id            = "${aws_api_gateway_rest_api.rest_api.id}"
  authorizer_uri         = aws_lambda_function.authorizer.invoke_arn # lambda function below 
  authorizer_credentials = aws_iam_role.invocation_role.arn
}

resource "aws_lambda_function" "authorizer" {
  filename      = "lambda-function.zip"
  function_name = "api_gateway_authorizer"
  role          = aws_iam_role.lambda.arn
  handler       = "exports.example"  # how to define this (parameterise)?
  s3_bucket     = # create bucket from module and reference it here?  have a single bucket for all? 
  s3_key        = # key of an object 


  source_code_hash = filebase64sha256("lambda-function.zip") # explore options on where to store lambda code
}