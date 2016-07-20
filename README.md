# Kubernetes Resource

Check, Get, and Put Kubernetes Resources

## Installing

```
resource_types:
- name: kubernetes
  type: docker-image
  source:
    repository: jcderr/concourse-kubernetes-resource
resources:
- name: kubernetes
  type: kubernetes
  source:
    cluster_url: https://hostname:port
    cluster_ca: _base64 encoded CA pem_
    admin_key: _base64 encoded key pem_
    admin_cert: _base64 encoded certificate_
```

## Source Configuration

* `cluster_url`: *Required.* URL to Kubernetes Master API service
* `cluster_ca`: *Optional.* Base64 encoded PEM. Required if `cluster-url` is https.
* `admin_key`: *Optional.* Base64 encoded PEM. Required if `cluster-url` is https.
* `admin_cert`: *Optional.* Base64 encoded PEM. Required if `cluster-url` is https.

#### `out`: Begins Packer Build Process

Applies a kubectl action.

#### Parameters
* `namespace`: *Required.* Kubernetes namespace to operate upon.
* `image_name`: *Required.* Path to file containing docker image name.
* `image_tag`: *Required.* Path to file container docker image tag.
* `resource_type`: *Optional.* Resource type to operate upon (valid values: `deployment`, `replicationcontroller`).
* `resource_name`: *Optional.* Resource name to operate upon.

## Example

### Out
```
---
resources:
- name: k8s
  type: kubernetes
  source:
    cluster_url: https://kube-master.domain.example
    cluster_ca: _base64 encoded CA pem_
    admin_key: _base64 encoded key pem_
    admin_cert: _base64 encoded certificate pem_
```

```
---
- put: k8s
  params:
    namespace: alpha
    image_name: docker/repository
    image_tag: docker/tag
    resource_type: deployment
    resource_name: myapp
```