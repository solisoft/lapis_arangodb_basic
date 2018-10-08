# Lapis Sample

To run it via docker

`docker run -d -p 9000:80 -p 8080:8080 -v /home/soli/workspace/lapis:/opt/openresty/nginx/conf --name lapis   solisoft/lapis server development`

Then the app should run in development mode on port `8080`

To run the `moonc` script :

`$ docker exec -it lapis /bin/bash`
`$ moonc -w *.moon`

If you run it in production mode, restart the app with :

`$ lapis build production`
