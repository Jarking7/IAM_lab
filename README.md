# IAM_lab

# Laboratorio de IAM y S3 - Seguridad y Control de Accesos

Este repositorio documenta los pasos realizados para configurar un bucket S3, políticas de IAM, grupos de usuarios y roles en AWS, con el objetivo de practicar y entender cómo se pueden manejar los permisos y la seguridad de los datos en AWS S3.

## 1. Creación del Bucket S3 y Estructura de Carpetas

- Se creó el bucket **`bucket-lab-iam-jafet`** en AWS S3.
- Dentro de este bucket, se crearon **dos carpetas**:
  - `public`
  - `private`
  
- Se subió un archivo a cada carpeta:
  - Un archivo de ejemplo a la carpeta `public`.
  - Un archivo diferente a la carpeta `private`.
  
- Se habilitó el **cifrado SSE-S3** en el bucket, lo que asegura que los archivos se cifren automáticamente al ser almacenados.
- Se **bloqueó el acceso público** al bucket para garantizar la seguridad y evitar que los datos sean accesibles sin autenticación.

## 2. Creación de la Política para Lectores de S3

- Se creó una política personalizada para **lectores de S3**. Esta política permite el acceso solo a los archivos dentro de la carpeta **`public`**, restringiendo el acceso a la carpeta **`private`**.
  
  Aquí está el ejemplo de la política que se creó:
  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet/public/*"
        },
        {
            "Effect": "Deny",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet/private/*"
        }
    ]
}
## 3. Configuración de IAM - Usuarios y Grupos

- Se creó un **grupo de IAM** llamado **`lectores-s3`**.
- Se crearon **dos usuarios**:
  - **`usuario1jafet`**
  - **`usuario2jafet`**
  
- Ambos usuarios fueron añadidos al grupo **`lectores-s3`**, y a este grupo se le asignó la política de acceso a la carpeta `public` que se creó en el paso anterior.

## 4. Creación de Usuario Administrador

- Se creó un usuario administrador llamado **`admin-s3-jafet`**.
- A este usuario se le asignó la política administrada **`AmazonS3FullAccess`**, lo que le otorga permisos completos sobre S3, permitiéndole realizar cualquier operación sobre los recursos de S3.
```json
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
```
## 5. Creación de Rol y Asignación a EC2

- Se creó un **rol de IAM** con la política administrada **`AmazonS3ReadOnlyAccess`**.
```json

    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Describe*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": "*"
        }
    ]
```
- Este rol fue asignado a la instancia **`test-ec2-jafet`** para otorgar acceso de solo lectura a los recursos de S3 desde la instancia EC2.

## 6. Pruebas con Usuarios y AWS CLI

- Se asignaron **keys temporales** a los usuarios **`usuario1jafet`** y **`usuario2jafet`** para permitirles acceder a AWS CLI desde PowerShell con sus credenciales.
  
  A continuación se muestran los resultados de las pruebas realizadas, donde se verifica que los usuarios pueden acceder correctamente a los archivos en la carpeta `public`, pero no tienen acceso a la carpeta `private`:
![logs_usuario1](https://github.com/user-attachments/assets/1b87b909-de19-4c64-9dd5-0bfa31b5f85d)
![logs_usuario2](https://github.com/user-attachments/assets/705dc56b-0925-4b2a-bf95-a3f9e1b46fcf)
![logs_admin](https://github.com/user-attachments/assets/5603f0b7-a926-4495-8be4-c83e978e4931)


## 7. Pruebas en la Instancia EC2

- Se realizó una prueba similar en la instancia **`test-ec2-jafet`** para verificar el acceso de solo lectura a S3.
  
  Se asignaron las credenciales temporales al rol y se ejecutaron pruebas de acceso, obteniendo los siguientes resultados:

  ![logs_ec2](https://github.com/user-attachments/assets/ffe9df63-2f82-4c91-aa40-b0721a775f3e)


## 8. Conclusión

Con este laboratorio, pudimos practicar y observar cómo se pueden usar **roles** y **políticas de IAM** para proteger los archivos y datos dentro de un bucket S3. A través de la correcta configuración de permisos, podemos restringir el acceso a los objetos según el tipo de usuario o instancia.

Este ejercicio demuestra la importancia de **gestionar adecuadamente los permisos** en AWS, ya que la seguridad de nuestros datos es crucial. Un mal manejo de las políticas puede resultar en la exposición de datos sensibles que, en manos equivocadas, podrían tener un impacto negativo en el negocio.

---
## 1. Creating the S3 Bucket and Folder Structure

- The bucket **`bucket-lab-iam-jafet`** was created in AWS S3.
- Inside this bucket, **two folders** were created:
  - `public`
  - `private`
  
- One file was uploaded to each folder:
  - A sample file was uploaded to the `public` folder.
  - A different file was uploaded to the `private` folder.
  
- **SSE-S3 encryption** was enabled on the bucket, ensuring that files are automatically encrypted when stored.
- **Public access** to the bucket was **blocked** to ensure security and prevent unauthorized access.

## 2. Creating the Policy for S3 Readers

- A **custom policy** for **S3 readers** was created. This policy allows access only to the files inside the **`public`** folder and denies access to the **`private`** folder.
  
  Here is an example of the policy that was created:
  ```json
  
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet/public/*"
        },
        {
            "Effect": "Deny",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::bucket-lab-iam-jafet/private/*"
        }
    ]

## 3. IAM Configuration - Users and Groups

- An **IAM group** called **`lectores-s3`** was created.
- **Two users** were created:
  - **`usuario1jafet`**
  - **`usuario2jafet`**
  
- Both users were added to the **`lectores-s3`** group, and this group was assigned the policy for access to the `public` folder created in the previous step.

## 4. Creation of Administrator User

- An administrator user called **`admin-s3-jafet`** was created.
- This user was assigned the managed policy **`AmazonS3FullAccess`**, which grants full permissions on S3, allowing them to perform any operation on S3 resources.

```json
 
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]

```
## 5. Creation of Role and Assignment to EC2

- An **IAM role** was created with the managed policy **`AmazonS3ReadOnlyAccess`**.

```json

    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3:Describe*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ],
            "Resource": "*"
        }
    ]
```
- This role was assigned to the **`test-ec2-jafet`** EC2 instance to grant read-only access to S3 resources from the EC2 instance.

## 6. Testing with Users and AWS CLI

- **Temporary keys** were assigned to users **`usuario1jafet`** and **`usuario2jafet`** to allow them to access AWS CLI from PowerShell using their credentials.
  
  Below are the results of the tests, where it is verified that the users can correctly access the files in the `public` folder but do not have access to the `private` folder:

  ![logs_usuario1](https://github.com/user-attachments/assets/1b87b909-de19-4c64-9dd5-0bfa31b5f85d)
  ![logs_usuario2](https://github.com/user-attachments/assets/705dc56b-0925-4b2a-bf95-a3f9e1b46fcf)
  ![logs_admin](https://github.com/user-attachments/assets/5603f0b7-a926-4495-8be4-c83e978e4931)

## 7. Testing on the EC2 Instance

- A similar test was performed on the **`test-ec2-jafet`** instance to verify read-only access to S3.
  
  Temporary credentials were assigned to the role, and access tests were run, resulting in the following:

   ![logs_ec2](https://github.com/user-attachments/assets/ffe9df63-2f82-4c91-aa40-b0721a775f3e)

## 8. Conclusion

With this lab, we were able to practice and observe how **roles** and **IAM policies** can be used to protect files and data inside an S3 bucket. By properly configuring permissions, we can restrict access to objects based on the type of user or instance.

This exercise highlights the importance of **properly managing permissions** in AWS, as data security is critical. Improper handling of policies can lead to the exposure of sensitive data that, in the wrong hands, could have a negative impact on the business.

---



