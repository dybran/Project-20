## CONTAINERIZING A PHP APPLICATION USING DOCKER

To deploy many small applications such as web front-end, web-backend, processing jobs, monitoring, logging solutions, etc, some of the applications will require various OS and runtimes of different versions and conflicting dependencies – in such case you would need to spin up serves for each group of applications with the exact OS/runtime/dependencies requirements. When it scales out to tens/hundreds and even thousands of applications, this approach becomes very tedious and challenging to maintain.

Also, when a developer develops an application and sends the application to another developer or DevOps Engineer in the software development team, there is always a problem where the code runs on the developer's computer but doesnt work on the computer of the team member. 

__SOLUTION:__

Containerization solves this problem. Unlike a VM, Docker allocates not the whole guest OS for your application, but only isolated minimal part of it – this isolated container has all that your application needs and at the same time is lighter, faster, and can be shipped as a Docker image to multiple physical or virtual environments, as long as this environment can run Docker engine. This approach also solves environment incompatibility issue.

In other words, if an application is shipped as a container it has its own environment isolated from the rest of the world, and it will always work the same way on any server that has Docker engine.

