#!/bin/bash
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

status=0
i=0
while [[ $status != 2 ]]
       do
        status=$(kubectl get nodes --no-headers 2>&1 | wc -l )
        echo "${Yellow}Waiting for cluster status ready...${Color_Off}"
        sleep 10
        i=$((i+1))
        if [[ $i -eq 20 ]]; then
          echo "${Red}Cluster could not be opened${Color_Off}"
          status=2
          exit 10
        fi        
done

echo "${Green}✓ Cluster Running${Color_Off}"
sleep 7
echo "${Yellow}Install istioctl${Color_Off}"
curl -sL https://istio.io/downloadIstioctl | sh -
export PATH=$PATH:$HOME/.istioctl/bin
source ~/istioctl.bash
echo "${Yellow}Install istio${Color_Off}"
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.8.1
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
