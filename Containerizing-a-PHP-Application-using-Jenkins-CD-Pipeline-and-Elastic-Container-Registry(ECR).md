## CONTAINERIZING A PHP APPLICATION USING JENKINS CI/CD PIPELINE, SORNAQUBE AND ELASTIC CONTAINER REGISTRY (ECR).

To deploy many small applications such as web front-end, web-backend, processing jobs, monitoring, logging solutions, etc, some of the applications will require various OS and runtimes of different versions and conflicting dependencies – in such case you would need to spin up serves for each group of applications with the exact OS/runtime/dependencies requirements. When it scales out to tens/hundreds and even thousands of applications, this approach becomes very tedious and challenging to maintain.

Also, when a developer develops an application and sends the application to another developer or DevOps Engineer in the software development team, there is always a problem where the code runs on the developer's computer but doesnt work on the computer of the team member. 

__SOLUTION:__

Containerization solves this problem. Unlike a VM, Docker allocates not the whole guest OS for your application, but only isolated minimal part of it – this isolated container has all that your application needs and at the same time is lighter, faster, and can be shipped as a Docker image to multiple physical or virtual environments, as long as this environment can run Docker engine. This approach also solves environment incompatibility issue.

In other words, if an application is shipped as a container it has its own environment that is isolated, and it will always work the same way on any server that has Docker engine.

This Project provides step-by-step instructions on how to containerize a PHP application using Jenkins (CI/CD) tool and Amazon Elastic Container Registry (ECR).

__Prerequisites__

- A Jenkins server installed and configured. You can install Jenkins by following the official documentation - [jenkins.io](https://www.jenkins.io/doc/book/installing/)
- Docker installed on the machine where Jenkins is running.
- AWS CLI installed in the jenkins server.

__Build the tooling and the PHP-todo Application manually__

First, we will proceed with manually building the Docker images for the application to make sure they work properly. Following this step, the CI/CD pipeline will be implemented, incorporating SonarQube and quality gate as a critical component within the pipeline for code analysis.

Sornaqube and Quality gates typically involve running various automated tests, such as unit tests, integration tests, security scans, performance tests, and code analysis, to assess the quality and stability of the codebase.

__For tooling__

First, create a network:

Creating a custom network is not necessary because even if we do not create a network, Docker will use the default network for all the containers you run. 
There are use cases where this is necessary. If there is a requirement to control the __cidr__ range of the containers running the entire application stack. This will be an ideal situation to create a network and specify the __--subnet__

I will create a network with a subnet dedicated for this project and use it for both MySQL and the application so that they can connect.

`$ docker network create --subnet=10.0.0.0/24 tooling_app_network`

Verify this by running

`$ docker network ls`

![](./images/to.PNG)

Run the MySQL Server container using the created network.

First, let us create an environment variable to store the root password:

`$ export MYSQL_PW=<password>`

verify the environment variable is created

`$ echo $MYSQL_PW`

Then, pull the image and run the container in the network that was created earlier.

`$ docker run --network tooling_app_network -h mysqlserverhost --name=toolingdb -e MYSQL_ROOT_PASSWORD=$MYSQL_PW  -d mysql/mysql-server:latest`


To verify whether an image has been successfully pulled and if the container is running

`$ docker images`

`$ docker ps`

![](./images/ad.PNG)

Establishing remote connections to the MySQL server using the root user is discouraged to adhere to best security practices. Consequently, our approach involves crafting an SQL script to generate a new user specifically intended for remote connection purposes.

Create a file and name it __create_user.sql__ and add the below code in the file:

`CREATE USER 'dybran'@'%' IDENTIFIED BY '<password>';`

`GRANT ALL PRIVILEGES ON * . * TO 'dybran'@'%';` 

![](./images/Capture.PNG)

Ensure you are in the directory __create_user.sql__ file is located or declare the path.

Run the script

`$ docker exec -i toolingdb mysql -uroot -p$MYSQL_PW < create_user.sql`

![](./images/12.PNG)

Connect to the MySQL server from a second container running the MySQL client utility.

The advantage inherent in this approach is the elimination of the necessity to install any client-side tool on your laptop and the avoidance of direct connectivity to the container hosting the MySQL server.

Run the MySQL Client Container:

`$ docker run --network tooling_app_network --name toolingdb-client -it --rm mysql mysql -h mysqlserverhost -u dybran -p`

![](./images/aqa.PNG)