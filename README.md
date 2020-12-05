# Assessment Script

## Usage:

### For Openstack

Hacer sesión en Openstack con rol de admin sobre el tenant admin, típicamente con :

```
$ source admin-rc.sh 
```

Este comando puede poner carga media a las controladoras de Openstack, no afecta servicios
```
time nice -n 19 ./ostack-assessment.sh
```


### For Kubernetes

Se requiere un kubeconfig con permisos de cluster-admin.

Este comando genera una carga pequeña en las controladoras de Kubernetes, no afecta servicios
```
time ./k8s-assessment.sh
```

Este comando puede poner carga media a las controladoras de Kubernetes, no afecta servicios:
```
kubectl cluster-info dump > cluster.dump
```

## Resultados

Se generan tres archivos, se pueden comprimir considerablemente ya que sólo son salidas de texto.
* output="rs-ostack-assessment.out"
* output="rs-kubectl-assessment.out"
* y la salida de cluster-info: cluster.dump

## Autor
Fabián Salamanca <fabian.salamanca@rackspace.com>
