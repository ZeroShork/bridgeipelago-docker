# Bridgeipelago - Docker

Before we start; This is fairly untested, so use at your own risk. I'm not responsible for lost data when running Bridgeipelago inside docker (or at all)



**This document assumes you know how docker works. I don't have the time or knowledge to explain this to you.**

## Step 0) Download the files
You really only need the `dockerfile` and `bridgeipelago-docker.yaml`, you can delete/ignore the rest of the project.  
The docker image will clone the repo for you.

## Step 1) Bridgeipelago setup
Complete 99% of the setup tasks as specified in the main [setup.md](setup.md) documentation though step **4**.  
(Do not complete step 5 and 6)

## Step 2) Build the image
In the same location as the `dockerfile`, run `docker build -t bridgeipelago .`  
This preps the bridgeipelago docker image.

## Step 3) Fill out the yaml
Open `bridgeipelago-docker.yaml` and fill out the infomation as you would the .env file.  
You can refrence the main [readme](/README.md) for detailed explincations on the environment variables.  

**IMPORTANT:** If you change the **filepaths** in the advanced-config: make sure to also change the **mounts** as well. Or the data will be lost upon the container closing. (You should know this)

## Step 4) Start the container
Once you're ready, in the same directory as `bridgeipelago-docker.yaml` run `docker compose -d -f bridgeipelago-docker.yaml up`  
This will start the container and run it in the background.  

It will also create a folder named "bridgeipelago" and mount the file directories to the same location for data persistence.  

Tee - Daa! :)

(if something doesn't work please open an issue in GitHub)



