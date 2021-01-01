#/bin/bash
sleep 7
echo "########### install istioctl ###########"
curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$PATH:$HOME/.istioctl/bin
source ~/istioctl.bash

echo "########### install istio ###########"
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.8.1
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
