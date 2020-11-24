# Assessment Script

## Usage:

### For Openstack

Este comando puede poner carga media a las controladoras de Openstack, no afecta servicios
```
time nice -n 19 ./osp-sizing.sh
```


### For Openshift

Este comando genera una carga pequeña en las controladoras de Openshift, no afecta servicios
```
time ./ocp-assessment.sh
```

Este comando puede poner carga media a las controladoras de Openshift, no afecta servicios:
```
oc cluster-info dump > cluster.dump
```

## Resultados

Se generan tres archivos, se pueden comprimir considerablemente ya que sólo son salidas de texto.
* output="rhosp-assessment.out"
* output="rs-ocp-assessment.out"
* y la salida de cluster-info: cluster.dump

## Autor
Fabián Salamanca <fabian.salamanca@rackspace.com>
