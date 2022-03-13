# Lab2: Inventaire

## Créer un groupe ha contenant le premier host
```
vi hosts
```
```
[ha]
host111
```
## Créer un groupe web contenant les hosts 2 et 3
```
vi hosts
```
```
[web]
host112
host113
```
## Créer une variable config pour le host 1 égale à ha.cf
```
vi hosts
```
host111 config=ha.cfg
```
```
## Créer une variable index pour le groupe web égale à index.html
```
vi hosts
```
```
[web:vars]
index=index.html
```
## Fichier complet
```
vi hosts
```
```
[ha]
host111 config=ha.cfg [web]
host112
host113
[web:vars]
index=index.html
```
## Créer un default inventory
```
vi ~/.ansible.cfg
```
```
[defaults]
inventory = /home/centos/hosts
```

