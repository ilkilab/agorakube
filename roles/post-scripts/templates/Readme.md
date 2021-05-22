# Notes

## Metrics-Server
We use official Metrics-Server yaml file.

We **will** add **{{ agorakube_features.metrics_server.release }}** variable to chose the correct Metrics-Server release to install

## CoreDNS

We use official CoreDNS yaml file.
We added **{{ agorakube_features.coredns.replicas }}** variable to chose the correct coredns release to install
We added **{{ agorakube_features.coredns.release }}** variable to chose the number of CoreDNS replicas that will be deployed.

## Nginx

We use official Ningix-controller yaml file.

We added **{{ agorakube_features.ingress.release }}** variable to chose the correct nginx release to install.

This is useful when installing, and updateting Nginx with IKE

## Calico

Calico is configured in VxLAN-Cross-Subnet mode.

When updateing calico.yaml.j2, make sure that YAML file contains:

In **"calico-config"** ConfigMap:
* calico_backend: "vxlan"
* veth_mtu: "{{ calico_mtu }}"

In *"calico-node"* DaemonSet:
* Env CALICO_IPV4POOL_IPIP : "Never"
* Env: CALICO_IPV4POOL_VXLAN : "CrossSubnet"
* Env: CALICO_IPV4POOL_CIDR: "{{ cluster_cidr }}"
* Comment or delete : "-bird-live" and "-bird-ready" in livenessProbe and readynessProbe

## OpenEBS

OpenEBS is configured with 2 files:
* openebs.yaml.j2: Deploy control plane
If updateting, make sure that the following params are set:
```
MAYA API

        - name: OPENEBS_IO_BASE_DIR
          value: "{{ openebs_io_base_dir }}"
        - name: OPENEBS_IO_CSTOR_TARGET_DIR
          value: "{{ openebs_io_base_dir }}/sparse"
        - name: OPENEBS_IO_CSTOR_POOL_SPARSE_DIR
          value: "{{ openebs_io_base_dir }}/sparse"
        - name: OPENEBS_IO_JIVA_POOL_DIR
          value: "{{ openebs_io_base_dir }}"
        - name: OPENEBS_IO_LOCALPV_HOSTPATH_DIR
          value: "{{ openebs_io_base_dir }}/local"
        - name: OPENEBS_IO_JIVA_REPLICA_COUNT
          value: "{{ replicas_openebs }}"
        - name: OPENEBS_IO_ENABLE_ANALYTICS
          value: "false"
        - name: OPENEBS_IO_CREATE_DEFAULT_STORAGE_CONFIG
          value: "false"



NDM

        - name: SPARSE_FILE_DIR
          value: "{{ openebs_io_base_dir }}/sparse"

```
Add to all Deployments, DaemonSet

```
tolerations:
      - effect: NoSchedule
        operator: Exists
      nodeSelector:
        "node-role.kubernetes.io/storage": "true"
```

* configure_storage_openebs.yaml.j2: Configure Data Plane (StoragePools and StorageClass)

## Traefik

We add {{ agorakube_features.ingress.release }} variable to select Traefik release to install.


## HA-PROXY

We add {{ agorakube_features.ingress.release }} variable to select HA-PROXY release to install.

{{ agorakube_features.ingress.release }} sample:   "1.5.O"   Releases are according Docker Hub Tags !
