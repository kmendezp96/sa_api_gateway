./rancher-compose --project-name sa-api-gateway \
--url http://192.168.99.100:8080/v1/projects/1a5 \
--access-key 70EE95E3F0704CB1BC85 \
--secret-key UbkJvYrYRBub9fsXxmzAP8GF2QVtmE4MsyeuFEBw \
-f docker-compose.yml \
--verbose up \
-d --force-upgrade \
--confirm-upgrade
