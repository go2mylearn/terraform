# Lab4: L'Inventaire

## Installer les deux serveurs web
```
vi web.yml
```
```
---
- name: "Installation de http sur les serveurs WEB"
  hosts: web
  become: yes
  tasks:
  - name: Install http
    yum:
      name: httpd
      state: present
```
## Copier des fichiers distincts
```
vi web.yml
```
```
- name: "copie index host112"
  hosts: host112
  become: yes
  tasks:
  - name: Copie du fichier index.html
    copy:
      src: index1.html
      dest: /var/www/html/index.html
      owner: apache
      group: apache
      mode: 0644
- name: "copie index host113"
  hosts: host113
  become: yes
  tasks:
  - name: Copie du fichier index.html
    copy:
      src: index2.html
      dest: /var/www/html/index.html
      owner: apache
      group: apache
      mode: 0644
```
## Démarrer les services web
```
vi web.yml
```
```
- name: "Start des serveurs WEB"
  hosts: web
  become: yes
  tasks:
  - name: Ensure the http service is running
    service:
      name: httpd
      enabled: yes
      state: started
```
## Installer le haproxy
```
vi web.yml
```
```
---
- name: installation haproxy
  hosts: host111
  become: yes
  tasks:
  - name: Install haproxy
    yum:
      name: haproxy
      state: present
```
## Copier le fichier de config haproxy.cfg
```
vi web.yml
```
```
---
- name: installation haproxy
  hosts: host111
  become: yes
  tasks:
  - name: Copie du fichier de configuration
    copy:
      src: "{{ config }}"
      dest: /etc/haproxy/haproxy.cfg
      owner: haproxy
      group: haproxy
      mode: 0644
```
## Ajouter un handler de restart du service haproxy lors de la copie d'un nouveau fichier de config
```
vi web.yml
```
```
---
- name: installation haproxy
  hosts: host111
  become: yes
  handlers:
  - name: Restart haproxy
    service:
      name: haproxy
      state: restarted
  tasks:
  - name: Copie du fichier de configuration
    copy:
      src: "{{ config }}"
      dest: /etc/haproxy/haproxy.cfg
      owner: haproxy
      group: haproxy
      mode: 0644
    notify: Restart haproxy
```

## Le fichier complet
```
vi web.yml
```
```
---
- name: installation haproxy
  hosts: host111
  become: yes
  handlers:
  - name: Restart haproxy
    service:
      name: haproxy
      state: restarted
  tasks:
  - name: Install haproxy
    yum:
      name: haproxy
      state: present
  - name: Copie du fichier de configuration
    copy:
      src: "{{ config }}"
      dest: /etc/haproxy/haproxy.cfg
      owner: haproxy
      group: haproxy
      mode: 0644
    notify: Restart haproxy
  - name: Ensure the http service is running
    service:
      name: haproxy
      enabled: yes
      state: restarted
- name: "Installation de http sur les serveurs WEB"
  hosts: web
  become: yes
  tasks:
  - name: Install http
    yum:
      name: httpd
      state: present
  - name: Ensure the http service is running
    service:
      name: httpd
      enabled: yes
      state: started
- name: "firewall port 80"
  hosts: all
  become: yes
  tasks:
  - firewalld:
      port: 80/tcp
      permanent: true
      immediate: true
      zone: public
      state: enabled
- name: "copie index host112"
  hosts: host112
  become: yes
  tasks:
  - name: Copie du fichier index.html
    copy:
      src: index1.html
      dest: /var/www/html/index.html
      owner: apache
      group: apache
      mode: 0644
- name: "copie index host113"
  hosts: host113
  become: yes
  tasks:
  - name: Copie du fichier index.html
    copy:
      src: index2.html
      dest: /var/www/html/index.html
      owner: apache
      group: apache
      mode: 0644
```


## Le fichier de config HAproxy

```
vi haproxy.cfg
```
```
frontend http_frontend
bind *:80
        default_backend http_backend
backend http_backend
        mode http
        balance roundrobin
        server server1 host112:80 check
        server server2 host113:80 check
```

## Le fichier inventaire

```
vi inventory
```
```
[ha]
host111 config=haproxy.cfg [web]
host112
host113
[web:vars]
index=index.html
```

