IMAGE_NAME="ubuntu-install-test"
docker image rm $IMAGE_NAME
docker build --tag $IMAGE_NAME .
docker run -it --rm $IMAGE_NAME /app/start.sh

