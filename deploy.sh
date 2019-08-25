docker build -t limk0078/multi-client:latest -t limk0078/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t limk0078/multi-server:latest -t limk0078/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t limk0078/multi-worker:latest -t limk0078/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push limk0078/multi-client:latest
docker push limk0078/multi-server:latest
docker push limk0078/multi-worker:latest

docker push limk0078/multi-client:$SHA
docker push limk0078/multi-server:$SHA
docker push limk0078/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=limk0078/multi-server:$SHA
kubectl set image deployments/client-deployment client=limk0078/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=limk0078/multi-worder:$SHA
