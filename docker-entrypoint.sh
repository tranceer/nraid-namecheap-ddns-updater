#!/bin/bash

# Prepare environment variables
domain="${DOMAIN}"
api_key="${API_KEY}"
interval="${INTERVAL:-600}" # Default to 600 seconds if not set
IFS=',' read -ra hosts <<< "${HOSTS}"

# Create entrypoint script dynamically
cat <<EOF > /app/entrypoint.sh
#!/bin/bash

while true; do
    local_ip=\$(curl -s http://checkip.amazonaws.com)
    echo "🔍 Local IP: \$local_ip"

EOF

for host in "${hosts[@]}"; do
    cat <<EOF >> /app/entrypoint.sh
    echo "🔄 Checking ${host}.\${domain}"

    response=\$(curl -s "https://dynamicdns.park-your-domain.com/update?host=${host}&domain=\${domain}&password=\${api_key}")
    err_count=\$(echo \$response | grep -oP "<ErrCount>\\K.*(?=</ErrCount>)")
    err=\$(echo \$response | grep -oP "<Err1>\\K.*(?=</Err1>)")

    if [ "\$err_count" = "0" ]; then
        echo "✅ ${host}.\${domain} updated to \$local_ip"
    else
        echo "❌ Failed to update ${host}.\${domain} - Reason: \$err"
    fi

EOF
done

cat <<EOF >> /app/entrypoint.sh
    echo "⏳ Sleeping ${interval} seconds..."
    sleep ${interval}
done
EOF

chmod +x /app/entrypoint.sh

# Start the generated script
exec /app/entrypoint.sh
