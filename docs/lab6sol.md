# Lab6  Les rôles 

## Créer un rôle user_create et créer un user avec ce rôle sur le serveur haproxy avec un fichier bashrc spécifique pour modifier le prompt
### Initialiser le Rôle
```
mkdir ~/roles
cd roles
ansible-galaxy init user_create

```
```
- Role user_create was created successfully
```
### Modifier les fichiers du Rôle
```
vi roles/user_create/vars/main.yml
```
```
---
# vars file for user_create
user_name: admin
user_state: present
```
```
vi roles/user_create/templates/bashrc.j2
```
```
export PS1='{{inventory_hostname}}:{{user_name}} $ '
```

Modifier le fichier tsk du rôle
```
vi roles/user_create/tasks/main.yml 
```
```
---
# tasks file for user_create
- name: Create user on remote host
  become: yes
  user:
    name: '{{user_name}}'
    state: '{{user_state}}'
    shell: /bin/bash
    password: '{{user_password}}'
    append: yes
- name: Add bashrc to include host and user
  become: yes
  template:
    dest: '~{{user_name}}/.bashrc'
    src: templates/bashrc.j2  
```

### Créer le playbook qui utilise le Rôle
```
vi playbook.yml
```
```
---
- hosts: web
  vars:
    user_password: "{{ 'my_passwd' |password_hash('sha512') }}"
  roles:
    - { role: user_create , become: yes }
```
## Créer la variable "user" à différents niveau d'initialisation 
1/ inventaire 
```
```
```
```
2/ playbook 
```
```
```
```
3/ répertoire 
```
```
```
```
4/ rôle
```
```
```
```
## Installer un rôle docker avec Ansible-Galaxy
```
ansible-galaxy install geerlingguy.docker 
```
```
- downloading role 'docker', owned by geerlingguy
- downloading role from https://github.com/geerlingguy/ansible-role-docker/archive/3.1.2.tar.gz
- extracting geerlingguy.docker to /home/centos/.ansible/roles/geerlingguy.docker
- geerlingguy.docker (3.1.2) was installed successfully
```
## Intaller docker sur le serveur ha avec le rôle docker
```
vi playbook.yml 
```
```
---
- hosts: web
  vars:
    user_name: user_play
  roles:
    - { role: user_create , become: yes }
- hosts: ha
  roles:
    - { role: geerlingguy.docker , become: yes }
```
