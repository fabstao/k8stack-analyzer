#!/bin/bash
# ******************************************************
#
# (C) Rackspace 2020, fabian.salamanca@rackspace.com
#
# ******************************************************


output="rhosp-assessment.md"
echo > $output

function spacedel {
    echo >> $output
}

function outlabel {
    echo $1 >> $output
}


outlabel "# Red Hat Openstack Assessment" 
spacedel
outlabel "## Openstack projects/tenants"
outlabel "\`\`\`"
nice -n 19 openstack project list >> $output
outlabel "\`\`\`"
outlabel "\`\`\`"
nice -n 19 openstack usage list >> $output
outlabel "\`\`\`"
outlabel "## Cloud Instances" 
outlabel "\`\`\`"
nice -n 19 openstack server list --all-projects >> $output
outlabel "\`\`\`"
outlabel "## Cinder volumes"
outlabel "\`\`\`"
nice -n 19 openstack volume list --all-projects >> $output
outlabel "\`\`\`"
outlabel "## Redes (Neutron)"
outlabel "\`\`\`"
tenants=$(nice -n 19 openstack project list -f value | awk '/services/ {next} {print $2}')
for i in $tenants
do
	outlabel "### Redes en proyecto: $i"
	nice -n 19 openstack network list --project $i >> $output
done
outlabel "\`\`\`"
outlabel "\`\`\`"
spacedel
nice -n 19 openstack subnet list  >> $output
outlabel "\`\`\`"
outlabel "\`\`\`"
nice -n 19 openstack subnet pool list  >> $output
outlabel "\`\`\`"
outlabel "## Hosts"
outlabel "\`\`\`"
nice -n 19 openstack host list >> $output
nice -n 19 openstack hypervisor stats show >> $output
outlabel "\`\`\`"
outlabel "\`\`\`"
hosts=$(nice -n 19 openstack hypervisor list -f value | awk '{print $2}')
for i in $hosts
do
	nice -n 19 openstack hypervisor show $i -f json >> $output
done
outlabel "\`\`\`"
vms=$(nice -n 19 openstack server list --all-projects -f value | awk '{print $2}')
outlabel "## Detalle de VMs"
outlabel "\`\`\`"
for i in $vms
do
	nice -n 19 openstack server show $i >> $output
	nice -n 19 nova diagnostics $i >> $output
done
outlabel "\`\`\`"
