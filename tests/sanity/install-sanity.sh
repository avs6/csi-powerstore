#!/bin/sh
IMAGE=$1

kubectl create ns sanity
# Create controller and noce driver instances
helm_command="helm install --values ./myvalues.yaml --name-template csi-sanity-pstore --namespace sanity ./helm/sanity-csi-powerstore --wait --timeout 180s"
echo "Helm install command:"
echo "  ${helm_command}"
${helm_command}

# Run tests from using csi-sanity container 
./test.sh $1

# Delete sanity test chart
helm delete --namespace sanity csi-sanity-pstore
kubectl delete ns sanity
