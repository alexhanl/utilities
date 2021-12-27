mv ~/.kube/config ~/.kube/config-backup-`date "+%Y-%m-%d-%H-%M-%S"`
vagrant scp kmaster:~/.kube/config ~/.kube/config
