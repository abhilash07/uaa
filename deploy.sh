bosh -d cfcr deploy /home/ubuntu/workspace/v0.23.0/kubo-deployment/manifests/cfcr.yml \
   -o /home/ubuntu/workspace/v0.23.0/kubo-deployment/manifests/ops-files/iaas/openstack/cloud-provider.yml \
   -o /home/ubuntu/workspace/v0.23.0/kubo-deployment/manifests/ops-files/allow-privileged-containers.yml \
   -v auth_url=http://182.252.135.131:5000/v3 \
   -v openstack_domain=default \
   -v openstack_username=crossent \
   -v openstack_password=crossent \
   -v region=RegionOne \
   -v openstack_project_id=7cd22e31952b478a8788f3f9a74c7a68 \

