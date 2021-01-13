#!/bin/bash
status=0
i=0
while [[ $status != 2 ]]
       do
        status=$(kubectl get nodes --no-headers 2>&1 | wc -l )
        echo "Waiting for cluster status ready..."
        sleep 10
        i=$((i+1))
        if [[ $i -eq 20 ]]; then
          echo "${Red}Cluster could not be opened"
          status=2
          exit 10
        fi        
done

echo "✓ Cluster Running"
sleep 7
echo "Install istioctl"
curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$PATH:$HOME/.istioctl/bin
source ~/istioctl.bash
echo "Install istio"
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.8.1
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
