docker build -t belcherman/multi-client:latest -t belcherman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t belcherman/multi-server:latest -t belcherman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t belcherman/multi-worker:latest -t belcherman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push belcherman/multi-client:latest
docker push belcherman/multi-client:$SHA

docker push belcherman/multi-server:latest
docker push belcherman/multi-server:$SHA

docker push belcherman/multi-worker:latest
docker push belcherman/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=belcherman/multi-server:$SHA
kubectl set image deployments/client-deployment client=belcherman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=belcherman/multi-worker:$SHA

