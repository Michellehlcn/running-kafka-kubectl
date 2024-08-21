if [ -d /Users/michelle/.kube ]
then
echo "/root.kube directory exists"
else
mkdir /Users/michelle/.kube && touch /Users/michelle/.kube/config
fi