provider "aws" {
  region = "us-east-1"
}

# Crear un usuario IAM con el nuevo nombre
resource "aws_iam_user" "user" {
  name = "user3-jafet"
}

# Crear un grupo IAM
resource "aws_iam_group" "group" {
  name = "lambda_readers"
}

# Añadir el usuario al grupo
resource "aws_iam_user_group_membership" "user_membership" {
  user    = aws_iam_user.user.name
  groups  = [aws_iam_group.group.name]
}

# Crear un rol IAM para Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role-jafet"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action   = "sts:AssumeRole"
      },
    ]
  })
}

# Crear una política IAM que permita el uso de Lambdas
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-execution-policy"
  description = "Permisos para ejecutar Lambdas"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "lambda:InvokeFunction",
          "lambda:ListFunctions",
          "lambda:GetFunction"
        ]
        Resource = "*"
      },
    ]
  })
}

# Adjuntar la política al grupo IAM
resource "aws_iam_group_policy_attachment" "group_lambda_policy_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Crear una política para permitir asumir el rol Lambda
resource "aws_iam_policy" "assume_lambda_role_policy" {
  name        = "assume-lambda-role-policy"
  description = "Permite a los miembros del grupo asumir el rol Lambda."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Resource  = aws_iam_role.lambda_role.arn
      },
    ]
  })
}

# Adjuntar la política para asumir el rol al grupo IAM
resource "aws_iam_group_policy_attachment" "group_assume_lambda_role_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.assume_lambda_role_policy.arn
}
