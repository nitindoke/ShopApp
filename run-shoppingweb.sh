#!/bin/bash

# ==== CONFIG ====
CERT_PASSWORD="Hash#123"   # Change to your cert password
IMAGE_NAME="shoppingweb:latest"
CONTAINER_NAME="shoppingweb-container"

# ==== RUN ====
docker run --rm --name "$CONTAINER_NAME" \
  -p 9005:8080 -p 9050:8081 \
  -v /c/Users/HP/Microsoft/UserSecrets:/home/app/.microsoft/usersecrets:ro \
  -v /c/Users/HP/.aspnet/https:/home/app/.aspnet/https:ro \
  -e ASPNETCORE_ENVIRONMENT=Development \
  -e ASPNETCORE_HTTP_PORTS=8080 \
  -e ASPNETCORE_HTTPS_PORTS=8081 \
  -e ASPNETCORE_Kestrel__Certificates__Default__Password="$CERT_PASSWORD" \
  -e ASPNETCORE_Kestrel__Certificates__Default__Path=/home/app/.aspnet/https/aspnetapp.pfx \
  -e ApiSettings__GatewayAddress=http://yarpapigateway:8080 \
  "$IMAGE_NAME"