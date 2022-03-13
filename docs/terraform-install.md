## Installer
Télécharger le binaire **terraform** à partir de [https://terraform.io/downloads.html](https://www.terraform.io/downloads.html)
??? Solution
    ``` 
    curl -O https://releases.hashicorp.com/terraform/1.0.9/terraform_1.0.9_linux_amd64.zip
    ``` 
Extraitre le binaire et l'installer sur **/usr/local/bin**
??? Solution
    ``` 
    unzip terraform_1.0.9_linux_amd64.zip
    sudo install terraform /usr/local/bin
    ``` 
## Verifier
Vérifier la version de terraform
??? Solution
    ``` 
    terraform --version
    ``` 
