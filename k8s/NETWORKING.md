# Сеть в K8s (minikube)

Схема: `клиент -> ingress-nginx -> Ingress -> Service -> Pod`.
Хост `foodgram.local`: `/` идёт на `frontend`, а `/api`, `/admin`, `/media`, `/s` - на `backend`.

## Запуск

```bash
minikube start
minikube addons enable ingress
kubectl get pods -n ingress-nginx

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.21.2/cert-manager.yaml
kubectl get pods -n cert-manager  

kubectl apply -f k8s/foodgram/namespace.yaml
kubectl apply -R -f k8s/foodgram/postgres
kubectl apply -R -f k8s/foodgram/backend
kubectl apply -R -f k8s/foodgram/frontend
kubectl apply -f k8s/cert-manager/cluster-issuer.yaml
kubectl apply -f k8s/foodgram/ingress
```

## Локальный домен

```bash
echo "127.0.0.1 foodgram.local" | sudo tee -a /etc/hosts
minikube tunnel   # в отдельном терминале, тк без него Ingress не получит адрес
```

## Проверка

```bash
kubectl get ingress -n foodgram
kubectl get certificate -n foodgram  
curl -k https://foodgram.local/api/recipes/
```

Сертификат self-signed, поэтому браузер покажет предупреждение.