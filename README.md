This project has been created as part of the 42 curriculum by ehenry.

# Description:

## What is Docker ?
Docker is a platform that allows to develop, deploy and execute applications in isolated environment that is called containers.
Instead of a traditional material virtualization, Docker uses a virtualization at the level of the exploitation system, allowing applications with all their dependencies (library, code, tools,...) but shared the same kernel of the host exploitation system.
The containers are all lightweight, fast and portable.

## Virtual machines vs Docker
### Virtual machines:
VM is a complete computer simulated in a virtual manner. It must be rely on two things; Hypervisor (Oracle VirtualBox, VMware,..) and a complete exploitation system guest (Linux, MacOS, Windows). Based on this, all the dependencies and applications can run.

Disadvantages: heavyweight (multiple Go needed), not fast to launch and consuming a lot of CPU/RAM resources.

### Docker:
No virtualization of the materials but 'isolated' the process.
Several containers shared the same OS as the host machine through the Docker engine.

Advantages: lightweight (likely few Mo), fast launch and allow running many applications on the same machine with fewer resources.

- Isolated the process : Docker uses native features of the Linux kernel partition applications.

	- Namespaces: They create parts for each container. It sees only its own PID, network and file system.
	- Control Groups: They limit the hardware resources (CPU, memory) that a container can consume, and ensure that a container doesn't overconsume the host machine.
	- Layered file system: Each container has its own image (dependencies, applications) separate from the host.


## Secrets vs Environment Variables
### Environment Variables:
They are used to communicated information between the programmes which do not fall under the same hierarchical line and therefore need an agreement in order to communicate their choices to each other.
They are defined in an `.env` file or directly in `docker-compose.yml`.

Disadvantages: They are not very secure for sensitive data. They are visible plain view if the container is inspected (`docker inspect`) and can easily leak the logs or if a child process displays the `.env`.

### Secrets:
It is a mechanism designed specifically for sensitive data. The secret is mounted directly in the container as a RAM file (often in `run/secrets/`), not written to disk.

Advantages: Much more secure. Data is not exposed in the environment variables not in the image history.

## Docker Network vs Host Network
So that how containers (NGINX, Wordpress, MariaDB) communicate together.

### Host Network:
The container shares the network stack of the machine. If he listens on port 8080, he directly uses the port 8080 of your computer.

Disadvantages: No isolation. High risk of ports conflicts if two containers want to use the same port. This is not recommended for secure multi-service architectures.

### Docker Network:
Docker creates an internal and isolated virtual network. Each container receives its own internal IP address.

Advantages: Total isolation. Containers can communicate with each other in a secure way without being exposed outside. Only the container serving as an entry point (NGINX) will need a port mapped to the host to be used from your browser. 

## Docker Volumes vs Bind Mounts:
In Docker, containers are ephemeral. If a container is destroyed, its internal data is too. To persist the database or Wordpress files, you need to store the data outside the container.
### Bind Mounts:
Link a specific and absolute folder of your host machine (ex: `/home/user/data`) to a folder in a container.

Disadvantages: Depends entirely on the host machine's file tree. If you change to an other machine the paths may break.

### Docker Volumes:
The storage space is fully managed by Docker (in `var/lib/volumes/` on the host).

Advantages: Fully manage by Docker, independent of the host's file system, easier to back up and is the official recommended method for data persistence in production.
# Instructions:
## Requirements:
Before starting the project, make sure that the following elements are installed on the machine:

- Docker and Docker Compose.
- Make

### Install requirements:
`sudo apt update`

`sudo apt install docker.io docker-compose`

## Compilation and Execution:
`make all` to make all the project, that will build up all the containers.

`make down` to deconstruct all the containers.

`make clean` to clean and remove all the containers.

### Connection:
Wordpress site: `http://ehenry.42.fr` or `https://ehenry.42.fr`

Administration panel: `https://ehenry.42.fr/wp-admin`

# Resources:
### Internet ressource:
- Docker Hub: used as a main resource to find the basic images (Alpine) and consult documentation to correctly configure the environments of each service.

- Stack Overflow: used to fix some issues with some Dockerfiles.

### AI:

- ChatGPT : used to helped me solve an issue with limited memory allocated to PHP.
I used it to the sed commadn to modify the php.init file during the imagine build.

`RUN sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php81/php.ini`

IA allowed me to find the right regular expression to target and replace the default value with 512M, and the correct path for PHP 8.1.