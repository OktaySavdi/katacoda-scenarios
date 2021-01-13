#### Launch Cluster

This will create a two node Kubernetes cluster using WeaveNet for networking.

Check Kuberetes Node
`kubectl get nodes`{{execute}}

#### Health Check
Check istioctl version
get version `istioctl version`{{execute}}

Check istio pod status
`kubectl get po -n istio-system`{{execute}}

Check istio proxy status
`istioctl proxy-status`{{execute}}

or

`istioctl analyze`{{execute}}
