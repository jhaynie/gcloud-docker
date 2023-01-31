all:
	@docker buildx build --platform linux/arm64,linux/amd64 --push -t jhaynie/docker-gcloud:latest -f ./Dockerfile .
