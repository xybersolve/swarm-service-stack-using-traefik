declare ip=${1:?Expects IP as argument}

# check for provided ip address pointing to swarm.io
# egrep -q "${ip}\s*swarm.io" /etc/hosts \
#   || echo "${ip}  swarm.io" >> /etc/hosts

# check for any ipv4 address pointing to swarm.io
egrep -q "\d{1,3}\.\d{1,3}\.\d{1,3}\s*swarm.io" /etc/hosts \
  || echo "${ip}  swarm.io" >> /etc/hosts
