docker build -t pawandeep2155/multi-client:latest -t pawandeep2155/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawandeep2155/multi-server:latest -t pawandeep2155/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawandeep2155/multi-worker:latest -t pawandeep2155/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawandeep2155/multi-client:latest
docker push pawandeep2155/multi-server:latest
docker push pawandeep2155/multi-worker:latest

docker push pawandeep2155/multi-client:$SHA
docker push pawandeep2155/multi-server:$SHA
docker push pawandeep2155/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=pawandeep215/multi-server:$SHA
kubectl set image deployments/client-deployment client=pawandeep215/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pawandeep215/multi-worker:$SHA
