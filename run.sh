docker stop reverseproxy
docker rm reverseproxy
docker rmi reverseproxy
docker build -t reverseproxy .
docker run -d -p 9001:5000 --name reverseproxy --restart unless-stopped reverseproxy
