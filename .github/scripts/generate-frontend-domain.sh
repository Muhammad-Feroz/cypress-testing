# Start ngrok in the background
ngrok http --host-header=local.mailmunch.co 3001 > /dev/null &

# Wait for ngrok to initialize
sleep 2

# Use curl to retrieve the ngrok URL from the ngrok API and store it in a variable
NGROK_NETLIFY_URL=$(curl --silent --max-time 10 --connect-timeout 5 -H "Authorization: Bearer 2eGD7ozjA2pR1HUMdwy2gX3LLRM_2T5fiwDLVHEwFVBDRWZLt" -H "Ngrok-Version: 2" https://api.ngrok.com/tunnels | jq --raw-output .tunnels[0].public_url)

# Check if NGROK_NETLIFY_URL is empty and, if it is, set it to the fallback URL
if [ -z "$NGROK_NETLIFY_URL" ]; then
  NGROK_NETLIFY_URL="set-lemming-primarily.ngrok-free.app"
fi

# Print the ngrok URL
echo $NGROK_NETLIFY_URL