Sample useful commands to manage etcd clusters

**list etcd members**

ETCDCTL_API=3 /usr/bin/etcd-v3.4.3-linux-amd64/etcdctl member list   --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt   --cert=/etc/kubernetes/pki/etcd/server.crt   --key=/etc/kubernetes/pki/etcd/server.key

**display crypted infos for test**

ETCDCTL_API=3 /usr/bin/etcd-v3.4.3-linux-amd64/etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key get /registry/secrets/default/default-token-rx7rv | hexdump -C

**Take a snapshot**

ETCDCTL_API=3 /usr/bin/etcd-v3.4.3-linux-amd64/etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save snapshotdb2
