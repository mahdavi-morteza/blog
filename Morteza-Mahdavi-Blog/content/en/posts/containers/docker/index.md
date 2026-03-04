---
title: Docker Write-ups Morteza Mahdavi
date: 2026-03-04
draft: false
categories: Docker
tags:
  - Docker
---
# Docker Write-ups Morteza Mahdavi


## Docker Concepts

## Overview

Docker helps developers build, ship, and run applications using **containers**.

A container packages an application together with everything it needs to run, such as libraries and dependencies. This makes the application easier to move between environments like development, testing, and production.

Docker provides tools to **build, store, share, and run containers** in a consistent way.

---

# Core Docker Components

## Dockerfile

A **Dockerfile** is a text file that contains instructions for building a Docker image.

It describes:

- The base image to start from
- Environment variables
- The working directory
- Dependencies to install
- Application files to copy
- Ports to expose
- The command that starts the application

Docker reads this file step-by-step to create an image.

---

## Container

A **container** is a running instance of a Docker image.

Containers:

- Run as processes on the host machine
- Are lightweight
- Are isolated from other containers
- Can be started, stopped, and deleted easily

Because of this, containers are very useful for deploying and scaling applications.

---

## Docker Image Storage

Docker images are stored in **registries**.

A registry is a place where images are saved and shared.

There are two common types:

**Public registries**

Example: Docker Hub

These contain many ready-to-use images created by the community and organizations.

**Private registries**

Organizations often use private registries to control access to their images.

---

## Where Docker Images Exist

Docker images usually exist in two places.

### Local Machine

When you build an image, Docker stores it locally on your computer.

You can see your local images with:


```
bash
docker images
```

## Registry

Images can also be uploaded (pushed) to a registry.

Once an image is in a registry, it can be downloaded (pulled) and used on other machines.

## Example Dockerfile

Below is a simple example Dockerfile for a Node.js application.


```
FROM node:22
  
ENV NODE_ENV=production
ENV PORT=3000
  
WORKDIR /usr/src/app
  
COPY package*.json ./
  
RUN npm install --production
  
COPY . .
  
ADD public/index.html /app/public/index.html
  
EXPOSE $PORT
  
CMD ["node", "app.js"]
  
LABEL version="1.0"  
LABEL description="Node.js application Docker image"
LABEL maintainer="Your Name"  
  
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
CMD curl -fs http://localhost:$PORT || exit 1
  
USER node
```

# Understanding the Dockerfile

## 1. Base Image

```
FROM node:22
```


`FROM` defines the base image used to build the container.

In this example, we use the official **Node.js version 14** image.

---

## 2. Environment Variables

```
ENV NODE_ENV=production  
ENV PORT=3000
```

`ENV` sets environment variables inside the container.

- `NODE_ENV=production` tells Node.js the application runs in production mode.
    
- `PORT=3000` defines which port the application will use.
    

---

## 3. Working Directory

```
WORKDIR /usr/src/app
```


`WORKDIR` sets the directory inside the container where commands will run.

All following instructions will use this directory.

---

## 4. Copy Package Files


```
COPY package*.json ./
```


`COPY` moves files from your local machine into the container.

Here we copy:

- `package.json`
    
- `package-lock.json`
    

These files describe the application dependencies.

---

## 5. Install Dependencies

```
RUN npm install --production
```

`RUN` executes commands during the image build process.

This command installs the required Node.js dependencies.

---

## 6. Copy Application Code

```
COPY . .
```

This copies the rest of the application files into the container.

---

## 7. Add Additional Files

```
ADD public/index.html /app/public/index.html
```

`ADD` can also copy files into the image.

Here it adds an HTML file to the container.

---

## 8. Expose the Port

```
EXPOSE $PORT
```

`EXPOSE` tells Docker which port the container will listen on.

This does not publish the port automatically, but it documents the expected port.

---

## 9. Default Command

```
CMD ["node", "app.js"]
```

`CMD` defines the command that runs when the container starts.

In this case, it runs the Node.js application.

Note: The main file may have a different name depending on the project.

---

## 10. Image Metadata

```
LABEL version="1.0"  
LABEL description="Node.js application Docker image"  
LABEL maintainer="Your Name"
```

`LABEL` adds metadata to the image.

This information helps identify and document the image.

---

## 11. Health Check

```
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -fs http://localhost:$PORT || exit 1
```

`HEALTHCHECK` allows Docker to verify that the container is working correctly.

Docker periodically sends a request to the application.

If the request fails several times, Docker marks the container as unhealthy.

---

## 12. Use a Non-Root User

```
USER node
```

`USER` sets which user runs the application inside the container.

Running applications as a non-root user improves security.

---

# Summary

A Dockerfile defines how an image is built.

Docker processes each instruction step-by-step to create a reusable image.  
That image can then be used to run containers in many environments.