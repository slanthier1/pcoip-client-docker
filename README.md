![pterribledici](/static/pterribledici.png)

## pcoip-client-docker
This is a fork of PaulGallon's pcoip-client-docker that brings it a bit more up to date.

This lets you run Teradici's PCoIP Client for Linux in a Docker container; this repo works on my Debian bullseye/sid i3 Intel NUC running dwm but might require tweaks for your setup.

YMMV.

### Setup
* Don't forget to update the Dockerfile with your own local username/uid/gid (so bad).
* Repo is currently setup to work from a host with an nvidia card.  If this is not the case, you'll need to remove those bits.  Eventually this will be some sort of auto-evaluated thing but not today is not that day!

### Thanks
* Teradici's setup instructions [here](https://www.teradici.com/web-help/pcoip_client/linux/20.07/reference/docker_containers/)
* @jlucas for the logo
