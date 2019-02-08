docker build -t andreicalazans/multi-client:latest -t andreicalazans/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andreicalazans/multi-server:latest -t andreicalazans/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andreicalazans/multi-worker:latest -t andreicalazans/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andreicalazans/multi-client:latest
docker push andreicalazans/multi-server:latest
docker push andreicalazans/multi-worker:latest

docker push andreicalazans/multi-client:$SHA
docker push andreicalazans/multi-server:$SHA
docker push andreicalazans/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andreicalazans/multi-server:$SHA
kubectl set image deployments/client-deployment client=andreicalazans/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andreicalazans/multi-worker:$SHA
