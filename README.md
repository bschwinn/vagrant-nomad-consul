# Vagrant environment for testing consul/nomad and prometheus

## Getting Going

1) install virtual box: brew cask install virtualbox
1) install vagrant: brew cask install vagrant
1) launch all the things: vagrant up


### Setting up the cluster
Create the cluster with the three servers; nom1, nom2, nom3 and then join the clients (clients can join ANY node already in the cluster).

```
./clusterup.sh
```

### Testing the cluster
You can test the cluster health from any node by running the following command:

```
consul info | grep -e num_peers -e state -e leader -e latest_config
```

You should see that the there are three servers in the cluster.  You can also see who is
the leader.


### Starting prometheus
1) prom > prometheus -config.file=prometheus.yml

