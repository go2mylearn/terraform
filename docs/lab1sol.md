# Lab1 

## Installer le serveur web apache httpd sur le premier host 

```
ansible host11 -b -i inventory -m yum -a "name=httpd state=present"
```
```
state=present"
host11 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "changes": {
        "installed": [
            "httpd"
] },
    "msg": "",
    "rc": 0,
    "results": [
        "Loaded plugins: fastestmirror\nLoading mirror speeds from
cached hostfile\n * base: mirroir.wptheme.fr\n * extras:
centos.mirror.ate.info\n * updates: ftp.pasteur.fr\nResolving
Dependencies\n--> Running transaction check\n---> Package httpd.x86_64
0:2.4.6-97.el7.centos will be installed\n--> Finished Dependency
Resolution\n\nDependencies
Resolved\n\n============================================================
====================\n Package       Arch           Version
Repository
Size\n==================================================================
==============\nInstalling:\n httpd         x86_64         2.4.6-
97.el7.centos         updates         2.7 M\n\nTransaction
Summary\n===============================================================
=================\nInstall  1 Package\n\nTotal download size: 2.7
M\nInstalled size: 9.4 M\nDownloading packages:\nRunning transaction
check\nRunning transaction test\nTransaction test succeeded\nRunning
transaction\n  Installing : httpd-2.4.6-97.el7.centos.x86_64
1/1 \n  Verifying  : httpd-2.4.6-97.el7.centos.x86_64
1/1 \n\nInstalled:\n  httpd.x86_64 0:2.4.6-97.el7.centos
\n\nComplete!\n"
] }
```

## Démarrer le service httpd

```
ansible host11 -b -i inventory -m service -a "name=httpd enabled=yes state=started"
```
```
host11 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
},
"changed": true,
"enabled": true,
"name": "httpd",
"state": "started",
"status": {
    "ActiveEnterTimestampMonotonic": "0",
    "ActiveExitTimestampMonotonic": "0",
```

## Ouvrir le port 80 du firewall

```
ansible host11 -b -i inventory -m firewalld -a "port=80/tcp permanent=true immediate=yes state=enabled"
```
```
host11 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "msg": "Permanent and Non-Permanent(immediate) operation, Changed
port 80/tcp to enabled"
}

```
## Copier un fichier index.html du dossier personnel vers le serveur web
```
ansible host11 -b -i inventory -m copy -a "src=index.html dest=/var/www/html owner=apache group=apache"
```
```
host11 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "checksum": "dc1ddb42e496eea0a5ea1033f0ac355baf0d6050",
    "dest": "/var/www/html/index.html",
    "gid": 48,
    "group": "apache",
    "md5sum": "0ec84076c244fe6b72b57b0cad5897a9",
    "mode": "0644",
    "owner": "apache",
    "secontext": "system_u:object_r:httpd_sys_content_t:s0",
    "size": 11,
    "src": "/home/centos/.ansible/tmp/ansible-tmp-1605769494.1441858-
8650-74363351770366/source",
    "state": "file",
"uid": 48 }
```
