K8S ansible
============

This project naively setup kubernetes_ on ubuntu cluster

How to use
----------

1. Install ansible_
2. Properly config variables in `hosts` and `group/all`
3. Run `$ ansible-playbook -i hosts setup-kube-cluster.yaml`
4. Check your kubernetes_ cluster with `$ kubectl cluster-info` or `$ kubectl get nodes`

.. note::
    * https://smalltowntechblog.com/2016/09/22/kubernetes-純手作部署在-ubuntu-16-04/
    * http://www.cnblogs.com/LinuxGo/p/5729788.html

.. _ansible: https://www.ansible.com
.. _kubernetes: http://kubernetes.io
