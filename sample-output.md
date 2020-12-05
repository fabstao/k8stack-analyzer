
# Kubernetes Assessment - RACKSPACE

## Kubernetes get nodes

### NODOS

NAME    STATUS   ROLES                      AGE     VERSION    INTERNAL-IP      EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION          CONTAINER-RUNTIME
rkem1   Ready    controlplane,etcd,worker   3h48m   v1.17.14   192.168.16.133   <none>        Debian GNU/Linux 10 (buster)   4.19.0-12-cloud-amd64   docker://18.9.1
rkew1   Ready    worker                     3h42m   v1.17.14   192.168.16.132   <none>        Debian GNU/Linux 10 (buster)   4.19.0-12-cloud-amd64   docker://18.9.1

### Kubernetes config view

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://rkem1:6443
  name: local
contexts:
- context:
    cluster: local
    user: kube-admin-local
  name: local
current-context: local
kind: Config
preferences: {}
users:
- name: kube-admin-local
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```

### Kubernetes get pods

```
NAMESPACE       NAME                                      READY   STATUS      RESTARTS   AGE     IP               NODE    NOMINATED NODE   READINESS GATES
ingress-nginx   default-http-backend-67cf578fc4-wczwc     1/1     Running     0          3h47m   172.18.0.2       rkem1   <none>           <none>
ingress-nginx   nginx-ingress-controller-cf8q8            1/1     Running     0          3h47m   192.168.16.133   rkem1   <none>           <none>
ingress-nginx   nginx-ingress-controller-j5brd            1/1     Running     0          3h41m   192.168.16.132   rkew1   <none>           <none>
kube-system     canal-qnqm9                               2/2     Running     0          3h48m   192.168.16.133   rkem1   <none>           <none>
kube-system     canal-xzdqw                               2/2     Running     0          3h42m   192.168.16.132   rkew1   <none>           <none>
kube-system     coredns-7c5566588d-5bnn8                  0/1     Running     0          3h41m   172.18.1.2       rkew1   <none>           <none>
kube-system     coredns-7c5566588d-ctzdv                  1/1     Running     0          3h48m   172.18.0.3       rkem1   <none>           <none>
kube-system     coredns-autoscaler-65bfc8d47d-rgl62       1/1     Running     0          3h48m   172.18.0.4       rkem1   <none>           <none>
kube-system     metrics-server-6b55c64f86-dfgls           1/1     Running     0          3h47m   172.18.0.5       rkem1   <none>           <none>
kube-system     rke-coredns-addon-deploy-job-h8m6x        0/1     Completed   0          3h48m   192.168.16.133   rkem1   <none>           <none>
kube-system     rke-ingress-controller-deploy-job-7wwtz   0/1     Completed   0          3h47m   192.168.16.133   rkem1   <none>           <none>
kube-system     rke-metrics-addon-deploy-job-qbktl        0/1     Completed   0          3h47m   192.168.16.133   rkem1   <none>           <none>
kube-system     rke-network-plugin-deploy-job-mczr2       0/1     Completed   0          3h48m   192.168.16.133   rkem1   <none>           <none>
```

### Kubernetes get deployments

```
NAMESPACE       NAME                   READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS             IMAGES                                                         SELECTOR
ingress-nginx   default-http-backend   1/1     1            1           3h47m   default-http-backend   rancher/nginx-ingress-controller-defaultbackend:1.5-rancher1   app=default-http-backend
kube-system     coredns                1/2     2            1           3h48m   coredns                rancher/coredns-coredns:1.6.5                                  k8s-app=kube-dns
kube-system     coredns-autoscaler     1/1     1            1           3h48m   autoscaler             rancher/cluster-proportional-autoscaler:1.7.1                  k8s-app=coredns-autoscaler
kube-system     metrics-server         1/1     1            1           3h47m   metrics-server         rancher/metrics-server:v0.3.6                                  k8s-app=metrics-server
```

### Kubernetes services

```
NAMESPACE       NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default         kubernetes             ClusterIP   172.19.0.1       <none>        443/TCP                  3h49m   <none>
ingress-nginx   default-http-backend   ClusterIP   172.19.182.46    <none>        80/TCP                   3h47m   app=default-http-backend
kube-system     kube-dns               ClusterIP   172.19.0.10      <none>        53/UDP,53/TCP,9153/TCP   3h48m   k8s-app=kube-dns
kube-system     metrics-server         ClusterIP   172.19.108.245   <none>        443/TCP                  3h47m   k8s-app=metrics-server
```

### Kubernetes metrics

```
NAME    CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%     
rkem1   245m         6%     1687Mi          21%         
rkew1   <unknown>                           <unknown>               <unknown>               <unknown>               
```
```
NAMESPACE       NAME                                    CPU(cores)   MEMORY(bytes)   
ingress-nginx   default-http-backend-67cf578fc4-wczwc   1m           4Mi             
ingress-nginx   nginx-ingress-controller-cf8q8          3m           91Mi            
kube-system     canal-qnqm9                             30m          31Mi            
kube-system     coredns-7c5566588d-ctzdv                6m           11Mi            
kube-system     coredns-autoscaler-65bfc8d47d-rgl62     1m           7Mi             
kube-system     metrics-server-6b55c64f86-dfgls         1m           12Mi            
```

### Kubernetes enabled APIs

```
NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND                             VERBS
bindings                                                                      true         Binding                          [create]
componentstatuses                 cs                                          false        ComponentStatus                  [get list]
configmaps                        cm                                          true         ConfigMap                        [create delete deletecollection get list patch update watch]
endpoints                         ep                                          true         Endpoints                        [create delete deletecollection get list patch update watch]
events                            ev                                          true         Event                            [create delete deletecollection get list patch update watch]
limitranges                       limits                                      true         LimitRange                       [create delete deletecollection get list patch update watch]
namespaces                        ns                                          false        Namespace                        [create delete get list patch update watch]
nodes                             no                                          false        Node                             [create delete deletecollection get list patch update watch]
persistentvolumeclaims            pvc                                         true         PersistentVolumeClaim            [create delete deletecollection get list patch update watch]
persistentvolumes                 pv                                          false        PersistentVolume                 [create delete deletecollection get list patch update watch]
pods                              po                                          true         Pod                              [create delete deletecollection get list patch update watch]
podtemplates                                                                  true         PodTemplate                      [create delete deletecollection get list patch update watch]
replicationcontrollers            rc                                          true         ReplicationController            [create delete deletecollection get list patch update watch]
resourcequotas                    quota                                       true         ResourceQuota                    [create delete deletecollection get list patch update watch]
secrets                                                                       true         Secret                           [create delete deletecollection get list patch update watch]
serviceaccounts                   sa                                          true         ServiceAccount                   [create delete deletecollection get list patch update watch]
services                          svc                                         true         Service                          [create delete get list patch update watch]
mutatingwebhookconfigurations                  admissionregistration.k8s.io   false        MutatingWebhookConfiguration     [create delete deletecollection get list patch update watch]
validatingwebhookconfigurations                admissionregistration.k8s.io   false        ValidatingWebhookConfiguration   [create delete deletecollection get list patch update watch]
customresourcedefinitions         crd,crds     apiextensions.k8s.io           false        CustomResourceDefinition         [create delete deletecollection get list patch update watch]
apiservices                                    apiregistration.k8s.io         false        APIService                       [create delete deletecollection get list patch update watch]
controllerrevisions                            apps                           true         ControllerRevision               [create delete deletecollection get list patch update watch]
daemonsets                        ds           apps                           true         DaemonSet                        [create delete deletecollection get list patch update watch]
deployments                       deploy       apps                           true         Deployment                       [create delete deletecollection get list patch update watch]
replicasets                       rs           apps                           true         ReplicaSet                       [create delete deletecollection get list patch update watch]
statefulsets                      sts          apps                           true         StatefulSet                      [create delete deletecollection get list patch update watch]
tokenreviews                                   authentication.k8s.io          false        TokenReview                      [create]
localsubjectaccessreviews                      authorization.k8s.io           true         LocalSubjectAccessReview         [create]
selfsubjectaccessreviews                       authorization.k8s.io           false        SelfSubjectAccessReview          [create]
selfsubjectrulesreviews                        authorization.k8s.io           false        SelfSubjectRulesReview           [create]
subjectaccessreviews                           authorization.k8s.io           false        SubjectAccessReview              [create]
horizontalpodautoscalers          hpa          autoscaling                    true         HorizontalPodAutoscaler          [create delete deletecollection get list patch update watch]
cronjobs                          cj           batch                          true         CronJob                          [create delete deletecollection get list patch update watch]
jobs                                           batch                          true         Job                              [create delete deletecollection get list patch update watch]
certificatesigningrequests        csr          certificates.k8s.io            false        CertificateSigningRequest        [create delete deletecollection get list patch update watch]
leases                                         coordination.k8s.io            true         Lease                            [create delete deletecollection get list patch update watch]
bgpconfigurations                              crd.projectcalico.org          false        BGPConfiguration                 [delete deletecollection get list patch create update watch]
bgppeers                                       crd.projectcalico.org          false        BGPPeer                          [delete deletecollection get list patch create update watch]
blockaffinities                                crd.projectcalico.org          false        BlockAffinity                    [delete deletecollection get list patch create update watch]
clusterinformations                            crd.projectcalico.org          false        ClusterInformation               [delete deletecollection get list patch create update watch]
felixconfigurations                            crd.projectcalico.org          false        FelixConfiguration               [delete deletecollection get list patch create update watch]
globalnetworkpolicies                          crd.projectcalico.org          false        GlobalNetworkPolicy              [delete deletecollection get list patch create update watch]
globalnetworksets                              crd.projectcalico.org          false        GlobalNetworkSet                 [delete deletecollection get list patch create update watch]
hostendpoints                                  crd.projectcalico.org          false        HostEndpoint                     [delete deletecollection get list patch create update watch]
ipamblocks                                     crd.projectcalico.org          false        IPAMBlock                        [delete deletecollection get list patch create update watch]
ipamconfigs                                    crd.projectcalico.org          false        IPAMConfig                       [delete deletecollection get list patch create update watch]
ipamhandles                                    crd.projectcalico.org          false        IPAMHandle                       [delete deletecollection get list patch create update watch]
ippools                                        crd.projectcalico.org          false        IPPool                           [delete deletecollection get list patch create update watch]
networkpolicies                                crd.projectcalico.org          true         NetworkPolicy                    [delete deletecollection get list patch create update watch]
networksets                                    crd.projectcalico.org          true         NetworkSet                       [delete deletecollection get list patch create update watch]
endpointslices                                 discovery.k8s.io               true         EndpointSlice                    [create delete deletecollection get list patch update watch]
events                            ev           events.k8s.io                  true         Event                            [create delete deletecollection get list patch update watch]
ingresses                         ing          extensions                     true         Ingress                          [create delete deletecollection get list patch update watch]
nodes                                          metrics.k8s.io                 false        NodeMetrics                      [get list]
pods                                           metrics.k8s.io                 true         PodMetrics                       [get list]
ingresses                         ing          networking.k8s.io              true         Ingress                          [create delete deletecollection get list patch update watch]
networkpolicies                   netpol       networking.k8s.io              true         NetworkPolicy                    [create delete deletecollection get list patch update watch]
runtimeclasses                                 node.k8s.io                    false        RuntimeClass                     [create delete deletecollection get list patch update watch]
poddisruptionbudgets              pdb          policy                         true         PodDisruptionBudget              [create delete deletecollection get list patch update watch]
podsecuritypolicies               psp          policy                         false        PodSecurityPolicy                [create delete deletecollection get list patch update watch]
clusterrolebindings                            rbac.authorization.k8s.io      false        ClusterRoleBinding               [create delete deletecollection get list patch update watch]
clusterroles                                   rbac.authorization.k8s.io      false        ClusterRole                      [create delete deletecollection get list patch update watch]
rolebindings                                   rbac.authorization.k8s.io      true         RoleBinding                      [create delete deletecollection get list patch update watch]
roles                                          rbac.authorization.k8s.io      true         Role                             [create delete deletecollection get list patch update watch]
priorityclasses                   pc           scheduling.k8s.io              false        PriorityClass                    [create delete deletecollection get list patch update watch]
csidrivers                                     storage.k8s.io                 false        CSIDriver                        [create delete deletecollection get list patch update watch]
csinodes                                       storage.k8s.io                 false        CSINode                          [create delete deletecollection get list patch update watch]
storageclasses                    sc           storage.k8s.io                 false        StorageClass                     [create delete deletecollection get list patch update watch]
volumeattachments                              storage.k8s.io                 false        VolumeAttachment                 [create delete deletecollection get list patch update watch]
```

### Checking logs from failed pods


*Pods con fallas on default*

```
```

*Pods con fallas on ingress-nginx*

```
```

*Pods con fallas on kube-node-lease*

```
```

*Pods con fallas on kube-public*

```
```

*Pods con fallas on kube-system*

```
```
