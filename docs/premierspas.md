## Initialisation
Créer un répertoire **www**
Créer le fichier **main.tf** pour initialiser l'environnement **terraform** avec le provider **aws**
??? Solution
    ``` 
    mkdir www && cd www
    vi main.tf
    ``` 
    ``` 
    terraform {
        required_version = ">= 0.12"
    }   
    provider "aws" {
        region = "eu-central-1"
    }   
    ``` 
Initialiser l’environnement de travail en utilisant la commande **terraform init**
??? Solution
    ``` 
    terraform init
    ``` 
- La commande init a pour conséquence de télécharger les providers et les modules nécessaires au fonctionnement de votre configuration (seul le provider AWS sera téléchargé dans notre cas).

## Création d'une infrastructure
Créer une instance ec2 avec les caractéristiques suivantes :

- ami : ami-0f7cd40eac2214b37
- instance_type : t2.micro 
??? Solution
    ``` 
    vi main.tf
    ``` 
    ``` 
    resource "aws_instance" "www" {
      ami           = "ami-0f7cd40eac2214b37"
      instance_type = "t2.micro"
    }
    ``` 
Utilisez la commande **terraform plan** pour analyser le plan d’exécution de votre configuration. Cette commande ne provoque aucune modification dans AWS

??? Solution
    ```   
    terraform plan
    ```

Une fois que le résultat de la commande précédente vous convient, vous pouvez créer votre infrastructure avec la commande **terraform apply** 

??? Solution
    ```   
    terraform apply
    ```

- Vous pourrez vérifier la création de l’infrastructure en utilisant la console AWS (un lien est sur le bureau de votre VM)

## Modification d'une infrastructure
### Ajout d'un tag
Proposez une solution vous permettant de nommer votre instance afin de la différencier de celles des autres participants à la formation
Ajouter l'attribut **tags** à votre instance ec2  :

- tags : { Name = Votre-Nom }

??? Solution
    ```
    vi main.tf
    ```
    ```
    resource "aws_instance" "www" {
      ami           = "ami-0f7cd40eac2214b37"
      instance_type = "t2.micro"
      tags = {
          Name = "Samir"
      }
    }
    ```

### Ajout d'une clé ssh
Proposez et mettez en place une solution pour permettre la connexion à vote instance via SSH en utilisant la ressource [aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) mise à disposition par le provider AWS.

??? Solution
    ```
    ssh-keygen 
    ```
    ```
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/retengr/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/retengr/.ssh/id_rsa
    Your public key has been saved in /home/retengr/.ssh/id_rsa.pub
    The key fingerprint is:
    SHA256:NplnvBx4xSalwYr4uNN6DZulHo/9MCXQEzPH8Yv9WgI retengr@ip-10-0-9-110
    The key's randomart image is:
    +---[RSA 3072]----+
    |        +o+..    |
    |       . =o*     |
    |     ...o.o =    |
    |    . ...* * .   |
    |     o  S E o    |
    |    . o..O + .   |
    |     o.Bo o . o  |
    |    o *=.o   +   |
    |    .=o o.. .    |
    +----[SHA256]-----+
    ```

Une fois les clés générées, il faut créer la ressource de type aws_key_pair. La création de cette ressource nécessite de copier votre clé publique. Il ne reste ensuite plus qu’à associer cette ressource à l’instance à créer. Attention, la clé que vous allez déclarer dans AWS doit avoir un nom unique, vous prendrez soin de mettre votre prénom dans le nom de cette dernière afin d’éviter les conflits avec les clés créées par les autres participants.
??? Solution
    ```
    resource "aws_key_pair" "rtg-connect-samir" {
      key_name = "rtg-key-samir"
      public_key= "AAAAB3NzaC1yc2EAAAADAQABAAABAQC1hm3hwsrmSpRcLqfndGtdafMWZCxK0Jf9QJ6FNXIojtDCH9jW2bRSd94YHyYzN+L58kcENhicv8pDZdBesYvTO/atj6VBkKWuw1YdXw3kyTZq+2Lj56/Dhds/J6gRWRmkzQJpGkGgdlPeK94ql+2/wwZKzJzV6DAdmaOWzTcBoJu1srVMdRnrMekFbWEiLn98XEF6Y6oBtolkJ6p5EId8MadIksh/zu/CzvZWbuaUIPQHvpbIAl0bgal1xz46nZdFNc7pxXAbxYp5pVkvB7K6oqosBy25PCZwfq7q/TToT4HMFMNbegNYFFN8fH4X9YUdmeF18ax/eSxrNP+HNRNx"
    }
    ```

### Mise en place de Security Group
Un security Group (SG) est une ressource AWS qui permet de contrôler les flux réseau qui pourront entrer dans une instance EC2 (INGRESS) ou sortir de cette même instance (EGRESS). Il s’agit d’un mécanisme de sécurité important qu’il convient de mettre en place pour chacun des composants déployés.
Utilisez la ressource [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) afin de définir les règles de filtrages suivantes :

- Ingress : Port 22 ouvert (ssh)
- Egress : Totalement ouvert
??? Solution
    ```
    vi main.tf
    ```
    ```
    resource "aws_security_group" "only-ssh" {
      name        = "onlyssh"
      description = "Only ssh"
        ingress {
          description = "ssh"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
      tags = {
        Name = "Only ssh"
      }
    }
    ```

Ajouter la clé **ssh** et la clé de sécurité dans la description de l'instance **ec2** 
??? Solution
    ```
    vi main.tf
    ```
    ```
    resource "aws_instance" "www" {
      ami           = "ami-0f7cd40eac2214b37"
      instance_type = "t2.micro"
      security_groups = [ aws_security_group.only-ssh.name ]
      key_name = "rtg-key"
      tags = {
          Name = "Samir"
      }
    }
    ```
