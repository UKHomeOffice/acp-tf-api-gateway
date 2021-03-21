variable "name" {
    type = string
    description = "The name of the API Gateway."
}

# CAN HAVE EDGE, REGIONAL OR PRIVATE  (defualts to edge if unspecified)
variable "endpoint_type" {
    type = string
    description = "The type of endpoint for the REST API (GET BETTER DEFINITION!!)"
}

variable "auth_name" {
    type = string
    description = "The name of the API Gateway Authorizer."
}