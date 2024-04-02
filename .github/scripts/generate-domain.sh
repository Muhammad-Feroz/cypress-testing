# Check if the local server is running
# if curl --output /dev/null --silent --head --fail http://localhost:3000; then
#   echo "Local server is running, starting ngrok..."
#   ngrok http 3000 > /dev/null &
  
#   # Wait for ngrok to initialize
#   sleep 2

#   # Use curl to retrieve the ngrok URL from the ngrok API and store it in a variable
#   NGROK_URL=$(curl --silent --max-time 10 --connect-timeout 5 -H "Authorization: Bearer 2eGD7ozjA2pR1HUMdwy2gX3LLRM_2T5fiwDLVHEwFVBDRWZLt" -H "Ngrok-Version: 2" https://api.ngrok.com/tunnels | jq --raw-output .tunnels[0].public_url)

#   # Check if NGROK_URL is empty and, if it is, set it to the fallback URL
#   if [ -z "$NGROK_URL" ]; then
#     NGROK_URL="set-lemming-primarily.ngrok-free.app"
#   fi

#   # Print the ngrok URL
#   echo $NGROK_URL
# else
#   RAILS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mailmunch-rails-1)
#   if curl --output /dev/null --silent --head --fail http://$RAILS_IP:3000; then
#     echo "Local server is running, starting ngrok..."
#     echo $RAILS_IP
#     ngrok http 3000 > /dev/null &
    
#     # Wait for ngrok to initialize
#     sleep 2

#     # Use curl to retrieve the ngrok URL from the ngrok API and store it in a variable
#     NGROK_URL=$(curl --silent --max-time 10 --connect-timeout 5 -H "Authorization: Bearer 2eGD7ozjA2pR1HUMdwy2gX3LLRM_2T5fiwDLVHEwFVBDRWZLt" -H "Ngrok-Version: 2" https://api.ngrok.com/tunnels | jq --raw-output .tunnels[0].public_url)

#     # Check if NGROK_URL is empty and, if it is, set it to the fallback URL
#     if [ -z "$NGROK_URL" ]; then
#       NGROK_URL="set-lemming-primarily.ngrok-free.app"
#     fi

#     # Print the ngrok URL
#     echo $NGROK_URL
#   else
#     NGROK_URL="http://local.mailmunch.co:3000"
#     echo "Local server is not running, cannot start ngrok"
#   fi
# fi


RAILS_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mailmunch_rails_1)
if curl --output /dev/null --silent --head --fail http://$RAILS_IP:3000; then
  echo "Local server is running, starting ngrok..."
  echo $RAILS_IP
  ngrok http 3000 > /dev/null &
  
  # Wait for ngrok to initialize
  sleep 2

  # Use curl to retrieve the ngrok URL from the ngrok API and store it in a variable
  NGROK_URL=$(curl --silent --max-time 10 --connect-timeout 5 -H "Authorization: Bearer 2eGD7ozjA2pR1HUMdwy2gX3LLRM_2T5fiwDLVHEwFVBDRWZLt" -H "Ngrok-Version: 2" https://api.ngrok.com/tunnels | jq --raw-output .tunnels[0].public_url)

  # Check if NGROK_URL is empty and, if it is, set it to the fallback URL
  if [ -z "$NGROK_URL" ]; then
    NGROK_URL="set-lemming-primarily.ngrok-free.app"
  fi

  # Print the ngrok URL
  echo $NGROK_URL
else
  NGROK_URL="http://local.mailmunch.co:3000"
  echo "Local server is not running, cannot start ngrok"
fi