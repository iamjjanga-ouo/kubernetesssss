# Pre-requirement(for MacOS)
# Installing Multipass
brew install --cask multipass
# Installing k3sup
brew install k3sup


# Generating Keys (public/private keys)
ssh-keygen
cat ~/.ssh/id_rsa.pub

# Creating config file
echo -e 'ssh_authorized_keys:\n  - ' > multipass.yaml
cat ~/.ssh/id_rsa.pub >> multipass.yaml

# Create VMs with proper names (master/worker)
multipass launch --cpus 1 --mem 1G --disk 2G --name master-node --cloud-init multipass.yaml
multipass launch --cpus 1 --mem 1G --disk 2G --name agent-master --cloud-init multipass.yaml
multipass launch --cpus 1 --mem 1G --disk 2G --name agent-worker --cloud-init multipass.yaml
multipass ls

## K8s sauce with k3sup
# Adding a master node
k3sup install --ip $MASTER_IP --user ubuntu --k3s-extra-args "--cluster-init"
# mac / linux
export KUBECONFIG=<path-to-kubeconfig>
# now you can `kubectl get nodes` to view the nodes on your cluster

# Adding a second master node (HA)
k3sup join --ip $MASTER_AGENT_IP --user ubuntu --server-ip $MASTER_IP --server-user ubuntu --server

# Adding worker node
k3sup join --ip $WORKER_IP --user ubuntu --server-ip $MASTER_IP --server-user ubuntu

# => now `kubectl get nodes`, you will find two master nodes and a single worker node composing multi node cluster setup.

# ref
# (https://medium.com/@yankee.exe/setting-up-multi-node-kubernetes-cluster-with-k3s-and-multipass-d4efed47fed5)
