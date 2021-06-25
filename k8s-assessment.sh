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
	outlabel "*Failed Pods on $1*"
	spacedel
	outlabel "\`\`\`"
	for i in $crashed
	do
		echo "Pod $i"
		kubectl logs $i >> $output
	done		
	outlabel "\`\`\`"
}

function ingresses {
	namespaces=$(kubectl get ns -o jsonpath="{.items[*].metadata.name}")
	spacedel
	outlabel "\`\`\`"
	for i in $namespaces
	do
		echo "**Namespace ${i}**" >> $output
		kubectl get ingress -n $i >> $output
	done		
	outlabel "\`\`\`"
}

function desnodes {
	nodes=$(kubectl get nodes -o jsonpath="{.items[*].metadata.name}")
	spacedel
	outlabel "\`\`\`"
	for i in $nodes
	do
		echo >> $output
		echo "**Node ${i}**" >> $output
		echo >> $output
		kubectl describe node $i >> $output
	done		
	outlabel "\`\`\`"
}

function caliendp {
	namespaces=$(kubectl get ns -o jsonpath="{.items[*].metadata.name}")
	spacedel
	outlabel "\`\`\`"
	for i in $namespaces
	do
		echo "**Namespace ${i}**" >> $output
		calicoctl get workloadEndpoint -n $i >> $output
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

outlabel "### Kubernetes Nodes"
spacedel
desnodes
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

outlabel "### Kubernetes Ingress"
spacedel
ingresses
spacedel

outlabel "### Checking logs from failed pods"
spacedel
projects=$(kubectl get namespaces | awk '/NAME/ {next;} {print $1}')
for i in $projects
do
	crashedpods $i	
done

outlabel "### Calico nodes"
spacedel
outlabel "\`\`\`"
calicoctl get node  >> $output
outlabel "\`\`\`"
spacedel

outlabel "### Calico workload Endpoints"
spacedel
caliendp
spacedel

