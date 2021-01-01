curl -L https://istio.io/downloadIstio | sh -
export PATH=$PWD/bin:$PATH
tar -xvf istio-1.8.1-linux-amd64.tar.gz
cd istio-1.8.1
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
