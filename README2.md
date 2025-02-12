# Proyecto Terraform para Gestión de IAM en AWS

Este proyecto contiene la infraestructura necesaria para gestionar usuarios, grupos, roles y políticas de IAM en AWS mediante **Terraform**.

## 1. Infraestructura creada

En este proyecto se utilizó Terraform para automatizar la creación de los siguientes recursos en AWS:

- **Creación de un Usuario IAM**: Se creó un usuario IAM con permisos controlados.
- **Creación de un Grupo IAM**: Se creó un grupo IAM al cual se asignó el usuario.
- **Creación de un Rol IAM para Lambda**: Se creó un rol IAM con permisos adecuados para ejecutar funciones Lambda.  
```json

 {
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
  }

```
Creación de una Política IAM: Se creó una política IAM que permite invocar, listar y obtener funciones Lambda.
Aquí se encuentra el JSON de la política:

```json
{
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


