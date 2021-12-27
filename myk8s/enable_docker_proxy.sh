for TARGET_HOST in kworker1 kworker2 kworker3; do
    vagrant scp docker-proxy.conf $TARGET_HOST:/tmp/docker-proxy.conf
    vagrant ssh $TARGET_HOST -c 'sudo mv /tmp/docker-proxy.conf /etc/systemd/system/docker.service.d/proxy.conf  && sudo systemctl daemon-reload && sudo systemctl restart docker'
done



