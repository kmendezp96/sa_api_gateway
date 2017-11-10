./rancher-compose --project-name sa-api-gateway \
--url http://192.168.99.100:8080/v1/projects/1a5 \
--access-key 72D1E5117338928BCE87 \
--secret-key 7tuAwA6YjKVNqPWi2JUoGivUzabXM3fvXn6ZLxmY \
-f docker-compose.yml \
--verbose up \
-d --force-upgrade \
--confirm-upgrade
