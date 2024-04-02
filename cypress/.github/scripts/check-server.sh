# #!/bin/bash

# # Initialize counter
# counter=0

# # Start loop
# while [ $counter -lt 100 ]
# do
#   # Check if server is running
#   if curl --output /dev/null --silent --head --fail http://localhost:3000; then
#     echo "Server is up"
#     exit 0
#   else
#     echo "Server is down, retrying in 1 minute..."
#     counter=$((counter+1))
#     # sleep 60
#   fi
# done

# # If the loop finishes, the server is still down
# echo "Server is still down after 10 attempts, exiting..."
# exit 1


#!/bin/bash

# Start loop
while true
do
  # Check if server is running
  if curl --output /dev/null --silent --head --fail http://localhost:3000; then
    echo "Server is up"
    exit 0
  else
    echo "Server is down, retrying in 1 minute..."
    sleep 10
  fi
done