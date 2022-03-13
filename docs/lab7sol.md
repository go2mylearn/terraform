# Lab7  Vault

##  Créer un Vault Password dans group_vars
```
vi group_vars/all/vault
```
```
vault_password: thisIsnotAgoodPassword
```

##  Créer une variable passwd dans group_vars
```
vi group_vars/all/vars
```
```
password: '{{vault_password}}'
```

##  Créer le mot de passe encrypté
```
ansible-vault encrypt group_vars/all/vault
```
```
New Vault password:
Confirm New Vault password:
```

##  Créer un template Jinja2 qui utilise le VaultPasswd

```
vi password.j2
```
```
The password is {{password}}
```

##  Créer un playbook qui utilise le template Jinja2
```
vi pass.yml
```
```
---
- hosts: all
  tasks:
  - name: embed the secure password in a file
    template:
      src: password.j2
      dest: /tmp/password
      mode: 0600
```

##  Créer un playbook qui utilise le template Jinja2
```
ansible-playbook  pass.yml --ask-vault
```

