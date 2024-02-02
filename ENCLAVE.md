## Accessing Enclave Kubectl cluster
Login to NGC laptop
RDP into first machine 
RDP into the Raptor Environment
Access Enclave by going into the WinMOBA client on the raptor desktop 
Click "Start SSH session"
ssh into IP: 10.150.2.112 
Should be a passwordless SSH session 

--- 
Once you are logged into the machine, all files are located in `/data01/` 

### kubectl / k8s 
The Kubectl is located in `/data01/k8s/rke2.yaml` and can be exported with `export KUBECONFIG=/data01/k8s/rke2.yaml` and run `kubectl get pods -A to test`

### ansible-rke2 playbook
The playbook is located in `/data01/unicorn/uds-raptor-bundle/` you can run the following command inside of that directory `sh run_ansible.sh` which will kick us into an ansible container with all of the necessary ansible features needed to deploy rke2-ansible. For the time being this does not need to be redeployed as we have a functioning cluster. 

To deploy the cluster you can run `ansible-playbook -i infra/ansible/inventory-working/hosts rke2-ansible/site.yml`

### UDS bundle / rook-ceph-init 
The UDS bundle is located in `/data01/raptor-bundle` and has already been created, this however may need to be updated (which means we need to create a bundle within the EDN and then transfer the files over from the correct (This is mounted already within 10.163.30.91 EDN)/cifs_new/RaptorDrop/ directory, you can also create a directory and transfer the file in there and have Justin from NGC transfer it over to the enclave.

You can run `uds deploy uds-raptor-bundle-...` to begin the deployment process but currently it is failing somewhere. 

Changes needed: the current nodes may need a kernel build to enable a module named "RDB" for rook-ceph to function properly. 

