# Configuration de Ansible

## Mise en place de ssh

### Générer les clés ssh sur le poste de travail avec la commande ssh-keygen
```
ssh-keygen
```
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/centos/.ssh/id_rsa): Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/centos/.ssh/id_rsa. Your public key has been saved in /home/centos/.ssh/id_rsa.pub. The key fingerprint is: SHA256:nSzbcedztAFuuh83IyyAgHmjE+2U+9AbXX73izyuObg centos@poste1 The key's randomart image is:
+---[RSA 2048]----+
||
| +. |
| +B .. |
| * = ooo.. . |
| o + +So=..+.o.|
| . o o+.o=o..+|
```
### Pousser les clés ssh sur les 3 hosts avec la commande ssh-copy-id
```bash
for host in host11 host12 host13
do
ssh-copy-id $host
done
```

### Vérifier que les connexions sur les 3 hosts s'effectuent sans mot de passe
```
ssh host11
```

### Vérifier sur les 3 hosts que le compte centos fait partie des sudoers 
```
sudo cat /etc/sudoers.d/centos
```
```
centos ALL=(ALL)NOPASSWD: ALL
```

## Configuration Ansible

### Créer un fichier inventaire avec les 3 hosts
```
vi inventory
```
```
[servers]
host11
host12
host13
```

### Vérifier si Ansible fonctionne en utilisant le module ping 
```
ansible all -m ping -i inventory
```
```
host11 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
host12 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
host13 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```
