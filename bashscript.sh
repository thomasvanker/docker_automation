IP_HOST=10.0.2.15 # Check the IP address used in your environment
ping -c 5 $IP_HOST 
INTERFACE=GigabitEthernet1
USERNAME=cisco
PASSWORD=cisco123!
status_code=$(curl -ks \
-w "%{http_code}" \
-o /dev/null \
-u "$USERNAME:$PASSWORD" \
-H "Accept: application/yang-data+json" \
"https://$IP_HOST/restconf/data/ietf-interfaces:interfaces/interface=$INTERFACE")

echo $status_code

if [ $status_code -eq 200 ]
then 
   echo "Yes - interface is up - Returning status code: 200"
else
   echo "No - interface is down - Returning status code: $status_code"
fi