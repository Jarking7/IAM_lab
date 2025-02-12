# Proyecto Terraform para Gestión de IAM en AWS

Este proyecto contiene la infraestructura necesaria para gestionar usuarios, grupos, roles y políticas de IAM en AWS mediante **Terraform**.

## 1. Infraestructura creada

En este proyecto se utilizó Terraform para automatizar la creación de los siguientes recursos en AWS:

- **Creación de un Usuario IAM**: Se creó un usuario IAM con permisos controlados.
- **Creación de un Grupo IAM**: Se creó un grupo IAM al cual se asignó el usuario.
- **Creación de un Rol IAM para Lambda**: Se creó un rol IAM con permisos adecuados para ejecutar funciones Lambda.  
```json

{
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect"    : "Allow"
        "Principal" : {
        "Service" : "lambda.amazonaws.com"
        }
        "Action"   : "sts:AssumeRole"
      },
    ]
}

```
Creación de una Política IAM: Se creó una política IAM que permite invocar, listar y obtener funciones Lambda.
Aquí se encuentra el JSON de la política:

```json
{
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect"   : "Allow"
        "Action"   : [
          "lambda:InvokeFunction",
          "lambda:ListFunctions",
          "lambda:GetFunction"
        ]
        "Resource" : "*"
      },
    ]
}
```

- **Adjuntar Políticas al Grupo IAM: Se adjuntaron las políticas necesarias al grupo de IAM que incluye permisos para trabajar con Lambda.

- **Creación de Política para Asumir el Rol de Lambda: Se creó una política IAM que permite que el usuario asuma el rol de Lambda.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "aws_iam_role.lambda_role.arn"
    }
  ]
}

```
## 2. Comandos utilizados

Para crear los recursos en AWS, se ejecutaron los siguientes comandos de Terraform:

1. **Inicializar el entorno de Terraform**:
   Este comando descarga los proveedores necesarios y configura el entorno de trabajo.

```bash
terraform init    # Inicializa el entorno de Terraform
terraform plan    # Muestra el plan de ejecución antes de aplicar cambios
terraform apply   # Aplica los cambios en AWS
```
## 3. Verificación en la Consola de AWS

Una vez aplicada la infraestructura con Terraform, accedí a la consola de **IAM** en AWS para confirmar la creación exitosa de los siguientes recursos:

- **Usuario IAM**: Se verificó que el usuario fue creado correctamente en el servicio IAM.
- **Grupo IAM**: Se verificó que el grupo IAM fue creado y que el usuario fue añadido a dicho grupo.
- **Roles IAM**: Se verificó que el rol para Lambda fue creado correctamente con los permisos adecuados.
- **Políticas IAM**: Se verificó que las políticas necesarias fueron creadas y adjuntadas al grupo IAM.



## 4. Acceso del Usuario a la Consola

Después de crear los recursos, se configuró el acceso del usuario a la consola de AWS. Para ello, realicé los siguientes pasos:

1. **Configuración de Contraseña de Un Solo Uso**: Se configuró una **contraseña de un solo uso** para el usuario. Esto permite que el usuario inicie sesión por primera vez en la consola.
2. **Acceso Limitado a Funciones Lambda**: El usuario fue configurado con permisos específicos para acceder únicamente a las funciones de Lambda, permitiéndole:
   - Listar las funciones Lambda existentes.
   - Invocar funciones Lambda.
   - Obtener información detallada sobre las funciones Lambda.

El usuario ahora tiene acceso solo a las funciones de Lambda, con permisos de lectura e invocación, lo que garantiza un acceso controlado y seguro a los recursos de AWS.
![user3-jafet](https://github.com/user-attachments/assets/344a2bdc-1d84-4279-8be7-e26caa3ac6e6)
![user3-jafet_lambda](https://github.com/user-attachments/assets/129fab60-f45e-4ada-b2a8-5c730ea9299d)


# Terraform Project for IAM Management on AWS

This project contains the infrastructure needed to manage IAM users, groups, roles, and policies on AWS using **Terraform**.

## 1. Infrastructure Created

In this project, Terraform was used to automate the creation of the following resources on AWS:

- **Creation of an IAM User**: An IAM user was created with controlled permissions.
- **Creation of an IAM Group**: An IAM group was created and the user was assigned to it.
- **Creation of an IAM Role for Lambda**: An IAM role was created with appropriate permissions to execute Lambda functions.  
```json
{
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect"    : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action"   : "sts:AssumeRole"
      }
    ]
}
```
- **Creation of an IAM Policy**: An IAM policy was created that allows invoking, listing, and getting Lambda functions.  
Here is the JSON for the policy:
```json
{
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect"   : "Allow"
        "Action"   : [
          "lambda:InvokeFunction",
          "lambda:ListFunctions",
          "lambda:GetFunction"
        ]
        "Resource" : "*"
      },
    ]
}
```
- **Attaching Policies to the IAM Group**: The necessary policies were attached to the IAM group, including permissions to work with Lambda.

- **Creation of a Policy to Assume the Lambda Role**: An IAM policy was created that allows the user to assume the Lambda role.
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "aws_iam_role.lambda_role.arn"
    }
  ]
}

```
## 2. Commands Used

To create the resources on AWS, the following Terraform commands were executed:

1. **Initialize the Terraform Environment**:
   This command downloads the necessary providers and configures the working environment.

```bash
terraform init    # Initializes the Terraform environment
terraform plan    # Shows the execution plan before applying changes
terraform apply   # Applies the changes to AWS

```

## 3. Verification in the AWS Console

Once the infrastructure was applied with Terraform, I accessed the **IAM** console in AWS to confirm the successful creation of the following resources:

- **IAM User**: It was verified that the user was created correctly in the IAM service.
- **IAM Group**: It was verified that the IAM group was created and that the user was added to that group.
- **IAM Roles**: It was verified that the Lambda role was created correctly with the appropriate permissions.
- **IAM Policies**: It was verified that the necessary policies were created and attached to the IAM group.

## 4. User Access to the Console

After creating the resources, the user access to the AWS console was configured. To do this, the following steps were performed:

1. **One-Time Password Setup**: A **one-time password** was configured for the user. This allows the user to log in for the first time to the console.
2. **Limited Access to Lambda Functions**: The user was configured with specific permissions to access only Lambda functions, allowing them to:
   - List existing Lambda functions.
   - Invoke Lambda functions.
   - Get detailed information about Lambda functions.
The user now has access only to Lambda functions, with read and invoke permissions, ensuring controlled and secure access to AWS resources.
![user3-jafet](https://github.com/user-attachments/assets/344a2bdc-1d84-4279-8be7-e26caa3ac6e6)
![user3-jafet_lambda](https://github.com/user-attachments/assets/129fab60-f45e-4ada-b2a8-5c730ea9299d)

