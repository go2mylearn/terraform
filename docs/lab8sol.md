# Lab8  Network

## Créer une interface supplémentaire
1. utiliser le module nmcli
2. Ajouter une interface avec une ip +3 par rapport à la première IP
```
---
- name: config ip
  hosts: host111
  become: yes
  handlers:
  - name: Restart Network
    service:
      name: network
      state: restarted
 
  tasks:
    - set_fact: ip="{{ ansible_default_ipv4.address }}"
    - set_fact: hostint="{{ ip|ipaddr('int')|int()+3 }}"
    - debug:
        msg: hostip "{{ hostint }}"
    - set_fact: hostip="{{ hostint|ipv4('address') }}" 
    - debug:
        msg: hostip "{{ hostip }}"
    - name: config ip
      nmcli:
        conn_name: ens224
        ifname: ens224
        type: ethernet
        ip4: "{{ hostip }}/24"
        state: present
        autoconnect: yes
      notify: Restart Network
```
