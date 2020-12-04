#!/bin/bash
# ******************************************************
#
# (C) Rackspace 2020, fabian.salamanca@rackspace.com   
#
# ******************************************************


output="rs-kubectlp-assessment.out"
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
outlabel "\`\`\` "
kubectl whoami -c >> $output
outlabel "\`\`\` "
spacedel
outlabel "## OCP get nodes"
spacedel
outlabel "### NODOS"
spacedel
kubectl get nodes -o wide >> $output
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

#outlabel "### Kubernetes ImageStreams"
#spacedel
#outlabel "\`\`\`"
#kubectl get is --all-namespaces >> $output
#outlabel "\`\`\`"
#spacedel

#outlabel "### Kubernetes BuildConfigs"
#spacedel
#outlabel "\`\`\`"
#kubectl get bc --all-namespaces >> $output
#outlabel "\`\`\`"
#spacedel

outlabel "### Buscando fallas en pods"
spacedel
projects=$(kubectl get namespaces | awk '/NAME/ {next;} {print $1}')
for i in $projects
do
	crashedpods $i	
done
