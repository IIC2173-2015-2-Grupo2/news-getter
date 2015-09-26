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
	docker run --publish 5000:5000 --name $(NAME) --rm $(NAME)

# Build and run
docker:
	make docker-build
	make docker-run
