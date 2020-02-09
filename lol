apiVersion: v1
kind: Pod
metadata:
  name: busy-1
spec:
  containers:
    - name: busy-1
      image: busybox
      command: ["sleep", "inf" ]
