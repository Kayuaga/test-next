SHELL := /bin/bash

say_hello:
	echo "Hello World"
login:
	aws ecr-public get-login-password \
		--region us-east-1 \
		--profile test_console \
		| docker login \
		--username AWS \
		--password-stdin public.ecr.aws/w2o7t2u6

docker-build:
	docker build --platform=linux/x86_64 -t kayuga . \
	& docker tag kayuga:latest public.ecr.aws/w2o7t2u6/kayuga:latest \
	& docker push public.ecr.aws/w2o7t2u6/kayuga:latest