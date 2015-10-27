# App name
NAME = news-getter

###############
# DOCKER
###############

# Build docker image
docker-build:
	docker build -t $(NAME) .

# Start application on port 5000
docker-run:
	docker run -e REDIS_HOST=$(REDIS_HOST) -p 80:9494 --name $(NAME) --rm $(NAME)

# Build and run
docker:
	make docker-build
#	make docker-run
