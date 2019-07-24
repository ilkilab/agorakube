Commande à executer sur un des etcd pour vérifier le bon fonctionnement du cluster etcd :

ETCDCTL_API=3 /usr/bin/etcd-v3.3.13-linux-amd64/etcdctl member list   --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt   --cert=/etc/kubernetes/pki/etcd/server.crt   --key=/etc/kubernetes/pki/etcd/server.key
ETCDCTL_API=3 /usr/bin/etcd-v3.3.13-linux-amd64/etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key get /registry/secrets/default/default-token-rx7rv | hexdump -C
