#!/bin/bash
# ******************************************************
#
# (C) Rackspace 2020, fabian.salamanca@rackspace.com   
#
# ******************************************************


output="rs-kubectl-assessment.out"
echo > $output

function spacedel {
	echo >> $output
}

function outlabel {
	echo $1 >> $output
}

function crashedpods {
	crashed=$(kubectl get pods -n $1 | egrep -i "(loop|error|pending|waiting)")
	spacedel
	outlabel "*Pods con fallas on $1*"
	spacedel
	outlabel "\`\`\`"
	for i in $crashed
	do
		echo "Pod $i"
		kubectl logs $i >> $output
	done		
	outlabel "\`\`\`"
}

echo "Iniciando..."

outlabel "# Kubernetes Assessment - RACKSPACE"
spacedel
outlabel "## Kubernetes get nodes"
spacedel
outlabel "### NODOS"
spacedel
outlabel "\`\`\`"
kubectl get nodes -o wide >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes config view"
spacedel
outlabel "\`\`\`"
kubectl config view >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes get pods"
spacedel
outlabel "\`\`\`"
kubectl get pods -o wide --all-namespaces >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes get deployments"
spacedel
outlabel "\`\`\`"
kubectl get deployments -o wide  --all-namespaces >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes services"
spacedel
outlabel "\`\`\`"
kubectl get svc -o wide --all-namespaces >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes metrics"
spacedel
outlabel "\`\`\`"
kubectl top nodes  >> $output
outlabel "\`\`\`"
outlabel "\`\`\`"
kubectl top pods --all-namespaces  >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Kubernetes enabled APIs"
spacedel
outlabel "\`\`\`"
kubectl api-resources -o wide  >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Checking logs from failed pods"
spacedel
projects=$(kubectl get namespaces | awk '/NAME/ {next;} {print $1}')
for i in $projects
do
	crashedpods $i	
done
