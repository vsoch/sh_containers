# sh_containers

Testing different containers to run interactive notebooks and tools on a
research cluster.

 - [sh_rstudio](sh_rstudio): Create an rstudio session and tunnel via localhost.

I was going off of these resources to help guide:

 - [reverse proxy](https://linode.com/docs/development/r/how-to-deploy-rstudio-server-using-an-nginx-reverse-proxy/)
 - [rstudio with proxy](https://support.rstudio.com/hc/en-us/articles/200552326-Running-RStudio-Server-with-a-Proxy)

I'm not sure the extent to which this can work well because most of the above
state that we need to restart things. I don't think we can do that easily 
as a user.
