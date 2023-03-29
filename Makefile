image_name=detexer
container_name=detexer_c
input_tex=outside.tex

all: docker docker_run run

repo:
	git clone https://github.com/ID/REPO

docker:
	docker build -t detexer -f `pwd`/DockerFile . # build image

docker_run:
	docker run -dit --name $(container_name) --mount type=bind,source=`pwd`,target=/app $(image_name) # run the container in background

run:
	docker exec $(container_name) pandoc --to=plain $(input_tex)

clean:
	docker stop $(container_name)
	docker container rm $(container_name)
