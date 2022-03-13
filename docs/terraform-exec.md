<p style="font-family: times, serif; font-size:18pt; font-style:normam">
Installation de Ansible
</p>
<p style="font-family: times, serif; font-size:14pt; font-style:normam">
Nous allons installer Ansible sur un poste de travail Linux (centos 7)
</p>
<p style="font-family: times, serif; font-size:10pt; font-style:italic">
    Why did we use these specific parameters during the calculation of the fingerprints?
</p>
## Install Packages Centos 
Mettre à jour Centos
```
sudo yum update -y
```
Installer les Extra-Packages
```
sudo yum install -y epel-release
```
Installer ansible
```
sudo yum install -y ansible
```
Vérifier la version de ansible
```
ansible --version
```

## Installation em mode User avec PIP
Installer Python version 3
```
sudo yum install -y epel-release 
sudo yum install -y python3 
sudo pip3 install virtualenv 
virtualenv -p /bin/python3.6 Vpy36 
source Vpy36/bin/activate
python -V
```
Installer Ansible avec PIP
```
pip3 install ansible
pip3 install netaddr
pip3 list
```
