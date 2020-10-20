docker build -t japharr/multi-client:latest -t japharr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t japharr/multi-server:latest -t japharr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t japharr/multi-worker:latest -t japharr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push japharr/multi-client:latest
docker push japharr/multi-server:latest
docker push japharr/multi-worker:latest

docker push japharr/multi-client:$SHA
docker push japharr/multi-server:$SHA
docker push japharr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=japharr/multi-server:$SHA
kubectl set image deployments/client-deployment client=japharr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=japharr/multi-worker:$SHA