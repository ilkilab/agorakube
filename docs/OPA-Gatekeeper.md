# Open Policy Agent
![opa](../images/logo-opa.png)

The Open Policy Agent (OPA) is an open source, general-purpose policy engine that enables unified, context-aware policy enforcement across the entire stack.
OPA is hosted by the Cloud Native Computing Foundation (CNCF) as a graduated project.

OPA gives you a high-level declarative language to author and enforce policies across your stack.

With OPA, you define rules that govern how your system should behave. These rules exist to answer questions like:

- Can user X call operation Y on resource Z?
- What clusters should workload W be deployed to?
- What tags must be set on resource R before it's created?

# Gatekeeper

Compared to using OPA with its sidecar kube-mgmt (aka Gatekeeper v1.0), Gatekeeper introduces the following functionality:

- An extensible, parameterized policy library
- Native Kubernetes CRDs for instantiating the policy library ("constraints")
- Native Kubernetes CRDs for extending the policy library ("constraint templates")
- Audit functionality

## Install opa/gatekeeper on Agorakube

To install opa/Gatekeeper on Agorakube use this command :

```
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.4/deploy/gatekeeper.yaml

```

# Example

we’ll take a look at the policy deny unauthorized host paths.

We need two yaml files to implement an OPA policy. One is the ConstraintTemplate file and the other one is the constraint file.

## template.yaml
```
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8spsphostfilesystem
  annotations:
    description: Controls usage of the host filesystem.
spec:
  crd:
    spec:
      names:
        kind: K8sPSPHostFilesystem
      validation:
        # Schema for the `parameters` field
        openAPIV3Schema:
          properties:
            allowedHostPaths:
              type: array
              items:
                type: object
                properties:
                  readOnly:
                    type: boolean
                  pathPrefix:
                    type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8spsphostfilesystem
        violation[{"msg": msg, "details": {}}] {
            volume := input_hostpath_volumes[_]
            allowedPaths := get_allowed_paths(input)
            input_hostpath_violation(allowedPaths, volume)
            msg := sprintf("HostPath volume %v is not allowed, pod: %v. Allowed path: %v", [volume, input.review.object.metadata.name, allowedPaths])
        }
        input_hostpath_violation(allowedPaths, volume) {
            # An empty list means all host paths are blocked
            allowedPaths == []
        }
        input_hostpath_violation(allowedPaths, volume) {
            not input_hostpath_allowed(allowedPaths, volume)
        }
        get_allowed_paths(arg) = out {
            not arg.parameters
            out = []
        }
        get_allowed_paths(arg) = out {
            not arg.parameters.allowedHostPaths
            out = []
        }
        get_allowed_paths(arg) = out {
            out = arg.parameters.allowedHostPaths
        }
        input_hostpath_allowed(allowedPaths, volume) {
            allowedHostPath := allowedPaths[_]
            path_matches(allowedHostPath.pathPrefix, volume.hostPath.path)
            not allowedHostPath.readOnly == true
        }
        input_hostpath_allowed(allowedPaths, volume) {
            allowedHostPath := allowedPaths[_]
            path_matches(allowedHostPath.pathPrefix, volume.hostPath.path)
            allowedHostPath.readOnly
            not writeable_input_volume_mounts(volume.name)
        }
        writeable_input_volume_mounts(volume_name) {
            container := input_containers[_]
            mount := container.volumeMounts[_]
            mount.name == volume_name
            not mount.readOnly
        }
        # This allows "/foo", "/foo/", "/foo/bar" etc., but
        # disallows "/fool", "/etc/foo" etc.
        path_matches(prefix, path) {
            a := split(trim(prefix, "/"), "/")
            b := split(trim(path, "/"), "/")
            prefix_matches(a, b)
        }
        prefix_matches(a, b) {
            count(a) <= count(b)
            not any_not_equal_upto(a, b, count(a))
        }
        any_not_equal_upto(a, b, n) {
            a[i] != b[i]
            i < n
        }
        input_hostpath_volumes[v] {
            v := input.review.object.spec.volumes[_]
            has_field(v, "hostPath")
        }
        # has_field returns whether an object has a field
        has_field(object, field) = true {
            object[field]
        }
        input_containers[c] {
            c := input.review.object.spec.containers[_]
        }
        input_containers[c] {
            c := input.review.object.spec.initContainers[_]
        }
```

We can apply the ConstraintTemplate 

```
kubectl apply -f template.yaml
```
```
package k8spsphostfilesystem
violation[{"msg": msg, "details": {}}] {
    volume := input_hostpath_volumes[_]
    allowedPaths := get_allowed_paths(input)
    input_hostpath_violation(allowedPaths, volume)
    msg := sprintf("HostPath volume %v is not allowed, pod: %v. Allowed path: %v", [volume, input.review.object.metadata.name, allowedPaths])
        }
 ```
The first line of this policy defines a namespace or package for the policy. Each policy must reside in a package.

Next, we define a violation block which “returns” two objects, “msg” and “details” .



## constraint.yaml

```
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sPSPHostFilesystem
metadata:
  name: psp-host-filesystem
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    allowedHostPaths:
    - readOnly: true
      pathPrefix: "/foo"
```

We can apply the constraint after we have applied the template.

```
kubectl apply -f constraint.yaml
```
the constraint contains the values for the parameter. In our case, it’s the allowed path that the pod is authorized to access which has pathPrefix: "/foo"
Once the template and the constraint have been applied, our policy is in place.

## example-disallowed.yaml
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-host-filesystem
  labels:
    app: nginx-host-filesystem-disallowed
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
      readOnly: true
  volumes:
  - name: cache-volume
    hostPath:
      path: /tmp # directory location on host
```

This will get denied as the pod is trying to access “/tmp” which is not allowed.

## example-allowed.yaml

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-host-filesystem
  labels:
    app: nginx-host-filesystem-allowed
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
      readOnly: true
  volumes:
  - name: cache-volume
    hostPath:
      path: /foo # directory location on host
```

This will get created without any issues as the hostPath is allowed to be accessed by the pod.

