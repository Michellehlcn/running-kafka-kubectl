if [ -d /root/.kube ]
then
echo "/root.kube directory exists"
else
mkdir /root/.kube && touch /root/.kube/config
fi