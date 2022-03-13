# Lab5: Jinja2

## Créer un user admin sur le serveur haproxy avec un fichier bashrc spécifique pour modifier le prompt = user@hostname
```
vi bashrc.j2
```
```
export PS1="{{ inventory_hostname }}:{{ user_name }} $ "
```
## Utiliser un template pour créer un fichier index.html 'echo hostname'
```
vi host.html.j2
```
```
<html>
<head> <title>{{inventory_hostname}}</title> </head>
<body>
<p>Nom du hôte : {{inventory_hostname}}</p>
<p>Ci-dessous la liste de ces adresses :</p>
<ul>
{% for ip in ansible_all_ipv4_addresses %}
<li>{{ip}}</li>
{% endfor %}
</ul>
</body>
</html>
```

## Afficher pour les serveurs la taille RAM et calculer un seuil de saturation de 70% RAM
```
vi playbook.yml
```
```
---
- name: "Generate html file for each host"
  hosts: web
  gather_facts: yes
  become: yes
  tasks:
    - name: "html file generation"
      template:
        src: "host.html.j2"
        dest: "/var/www/html/index.html"
    - name: Checking Memory
      debug:
        msg: "{% if ansible_memfree_mb < (ansible_memtotal_mb * 0.7)  %} mémoire suffisante {% else %} Rmémoire insuffisante {% endif %}"
- name: "Create User and profile"
  hosts: ha
  gather_facts: yes
  become: yes
  vars:
    user_name: admin
    user_state: present
  tasks:
    - name: Create user on remote host
      user:
        name: '{{user_name}}'
        state: '{{user_state}}'
        remove: yes
        shell: /bin/bash
    - name: Add bashrc to include host and user
      template:
        dest: '~{{user_name}}/.bashrc'
        src: bashrc.j2
```
