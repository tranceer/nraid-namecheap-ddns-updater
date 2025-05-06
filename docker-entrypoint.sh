#!/bin/bash

# Default interval if not provided
interval="${INTERVAL:-600}"

# Creează scriptul entrypoint
cat << 'EOF' > /app/entrypoint.sh
#!/bin/bash

IFS=',' read -ra hosts <<< "${HOSTS}"

while true; do
    local_ip=$(curl -s http://checkip.amazonaws.com)
    echo "🔍 Local IP: $local_ip"

    for host in "${hosts[@]}"; do
        echo "🔄 Checking $host.$DOMAIN"

        response=$(curl -s "https://dynamicdns.park-your-domain.com/update?host=$host&domain=$DOMAIN&password=$API_KEY")
        err_count=$(echo "$response" | grep -oP "<ErrCount>\\K.*(?=</ErrCount>)")
        err=$(echo "$response" | grep -oP "<Err1>\\K.*(?=</Err1>)")

        if [ "$err_count" = "0" ]; then
            echo "✅ $host.$DOMAIN updated to $local_ip"
        else
            echo "❌ Failed to update $host.$DOMAIN - Reason: $err"
        fi
    done

    echo "⏳ Sleeping $INTERVAL seconds..."
    sleep "$INTERVAL"
done
EOF

chmod +x /app/entrypoint.sh

# Rulează scriptul generat
exec /app/entrypoint.sh
