status=0
i=0
while [[ $status != 2 ]]
       do
        status=$(kubectl get nodes --no-headers 2>&1 | wc -l )
        echo "Waiting for cluster status ready..."
        sleep 10
        i=$((i+1))
        if [[ $i -eq 20 ]]; then
          echo "cluster could not be opened"
          status=2
          exit 10
        fi        
done
