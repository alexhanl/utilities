for TARGET_HOST in kworker1 kworker2; do
    vagrant ssh $TARGET_HOST -c 'sudo rm -rf /etc/systemd/system/docker.service.d/proxy.conf  && sudo systemctl daemon-reload && sudo systemctl restart docker'
done