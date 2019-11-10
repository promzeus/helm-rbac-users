# helm-rbac-users
edit ```values.yaml```

Create Users
```
helm upgrade users . --install --namespace=dev
```
Run shell script create_config.sh для создания kubeconfig
```
./create_config.sh user1
```
