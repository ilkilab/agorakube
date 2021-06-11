# Manage ETCD Clusters

This file explain how to **backup** and **restore** ETCD Cluster for Disaster Recovery.

## How to backup etcd cluster ?

You can backup ETCD cluster from Agorakube racine directory by following the next steps:

```
# Run the following command:

sudo ansible-playbook tools/etcd/backup-etcd-cluster.yaml

```

Backup file will be saved on the **deploy** machine located in the following path: ```{{data_path}}/backups_etcd/```



---
If you wish to customize the backup path, set the following variable in ```group_vars/all.yaml``` file:

```
custom_etcd_backup_dir: /path/to/store/backups/on/deploy/machine

```

## How to restore etcd cluster ?

You can restore ETCD cluster from Agorakube racine directory by following the next steps:

```
# Edit group_vars/all.yaml file and add the following variable:

restoration_snapshot_file: /path/to/the/backups/file/on/deploy/machine

# Then, from Agorakube racine directory, run the following command:

sudo ansible-playbook tools/etcd/restore-etcd-cluster.yaml
```

## how to check the state of the etcd ?

We can check the state of the etcd by typing the command below without forgetting to mention the ansible tag: ```check-etcd``` , which will 
allow to play only the tasks dedicated to the check-etcd:

```ansible-playbook agorakube.yaml --tags check-etcd```

## how to Upgrade/downgrade the etcd cluster?

Just edit file "group_vars/all.yaml" with:

```
agorakube_base_components:
  etcd:
    release: v3.4.14  (Desired ETCD release)
    upgrade: True
```
Then apply agorakube with command `ansible-playbook agorakube.yaml`
