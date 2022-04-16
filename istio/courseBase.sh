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

echo "Cluster Running"
sleep 7
echo "Install istioctl"
curl -sL https://istio.io/downloadIstioctl | sh -
cp -rf .istioctl/bin/istioctl {/usr/bin/,/usr/local/sbin,/usr/local/bin}
echo "Install istio"
curl -L https://istio.io/downloadIstio | sh -
dir=$(ls | tail -n 1)
cd $dir
istioctl install --set profile=default -y
kubectl apply -f samples/addons
kubectl -n istio-system patch svc istio-ingressgateway -p '{"spec":{"type":"NodePort"}}'
kubectl -n istio-system patch svc kiali -p '{"spec":{"type":"NodePort"}}'
kubectl -n istio-system patch svc grafana -p '{"spec":{"type":"NodePort"}}'
kubectl -n istio-system patch svc prometheus -p '{"spec":{"type":"NodePort"}}'
kubectl -n istio-system patch svc tracing -p '{"spec":{"type":"NodePort"}}'
