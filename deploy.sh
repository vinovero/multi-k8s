docker build -t vinovero/multi-client:latest -t vinovero/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinovero/multi-server:latest -t vinovero/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinovero/multi-worker:latest -t vinovero/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vinovero/multi-client:latest
docker push vinovero/multi-server:latest
docker push vinovero/multi-worker:latest

docker push vinovero/multi-client:$SHA
docker push vinovero/multi-server:$SHA
docker push vinovero/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinovero/multi-server:$SHA
kubectl set image deployments/client-deployment client=vinovero/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vinovero/multi-worker:$SHA