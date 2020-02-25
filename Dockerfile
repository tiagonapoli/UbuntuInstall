FROM ubuntu

RUN apt-get update && apt-get -y install sudo gnupg

WORKDIR /app

COPY . .

CMD [ './start.sh' ]