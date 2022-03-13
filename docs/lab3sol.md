# Lab3: L'inventaire dynamique

## Créer un inventaire dynamique pour virtualbox
```
vi vbox.yml
```
```
plugin: virtualbox
running_only: yes
groups:
  web: "'web' in (inventory_hostname)"
  ha: "'ha' in (inventory_hostname)"
```
## Afficher l'inventaire
```
ansible-inventory -i vbox.yml --graph
```

## Tester les cibles
```
ansible all -i vbox.yml -m ping
```

## Créer les VMs

```
VBoxManage import centos7orig.ova --dry-run
```

```
VBoxManage import centos77last.ova  --vsys 0 --vmname  ha --memory 1024 --unit 4 --ignore --unit 5 --ignore --unit 8 --ignore --unit 9 --ignore --unit 10 --ignore --unit 11 --ignore --unit 12 --disk /Users/samir/virtualbox/kube/kube-disk001.vmdk
```


```
VBoxManage import centos77last.ova  --vsys 0 --vmname n1 --memory 1024 --unit 4 --ignore --unit 5 --ignore --unit 8 --ignore --unit 9 --ignore --unit 10 --ignore --unit 11 --ignore --unit 12 --disk /Users/samir/virtualbox/n1/n1-disk001.vmdk
```

```
VBoxManage import centos77last.ova  --vsys 0 --vmname n2 --memory 1024 --unit 4 --ignore --unit 5 --ignore --unit 8 --ignore --unit 9 --ignore --unit 10 --ignore --unit 11 --ignore --unit 12 --disk /Users/samir/virtualbox/n2-disk001.vmdk
```

```
VBoxManage import centos77last.ova  --vsys 0 --vmname n3 --memory 1024 --unit 4 --ignore --unit 5 --ignore --unit 8 --ignore --unit 9 --ignore --unit 10 --ignore --unit 11 --ignore --unit 12 --disk /Users/samir/virtualbox/n3-disk001.vmdk
```


