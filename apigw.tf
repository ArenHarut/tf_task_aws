resource "aws_api_gateway_rest_api" "weather" {
  description                  = var.apigw_rest_api_description
  disable_execute_api_endpoint = "false"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  name                     = var.apigw_rest_api_name
}

resource "aws_api_gateway_deployment" "weather" {
  rest_api_id = aws_api_gateway_rest_api.weather.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.weather.body))
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_method.getmethod,
    aws_api_gateway_integration.lambda
  ]
}

resource "aws_api_gateway_stage" "weather" {
  deployment_id         = aws_api_gateway_deployment.weather.id
  rest_api_id           = aws_api_gateway_rest_api.weather.id
  stage_name            = var.apigw_rest_api_stage_name
  xray_tracing_enabled  = var.xray_tracing_enabled
}

resource "aws_api_gateway_method" "getmethod" {
  authorization    = var.method_authorization
  http_method      = var.http_method
  resource_id      = aws_api_gateway_rest_api.weather.root_resource_id
  rest_api_id      = aws_api_gateway_rest_api.weather.id
}

resource "aws_api_gateway_method_response" "getresponse" {
  http_method = aws_api_gateway_method.getmethod.http_method
  resource_id = aws_api_gateway_rest_api.weather.root_resource_id

  response_models = {
    "application/json" = "Empty"
  }

  rest_api_id = aws_api_gateway_rest_api.weather.id
  status_code = var.method_response_status_code
}

resource "aws_api_gateway_integration" "lambda" {
  connection_type         = var.integration_connection_type
  content_handling        = var.integration_connection_handling
  http_method             = aws_api_gateway_method.getmethod.http_method
  integration_http_method = var.integration_http_method
  passthrough_behavior    = var.integration_passthrough_behavior
  resource_id             = aws_api_gateway_rest_api.weather.root_resource_id
  rest_api_id             = aws_api_gateway_rest_api.weather.id
  type                    = var.integration_type
  uri                     = aws_lambda_function.test_lambda.invoke_arn
}
