# Blue-Green Deployment: HTML page using nginx
blue/green deployment is a deployment strategy in which you create two separate, but identical environments. One environment (blue) is running the current application version and one environment (green) is running the new application version. Using a blue/green deployment strategy increases application availability and reduces deployment risk by simplifying the rollback process if a deployment fails. Once testing has been completed on the green environment, live application traffic is directed to the green environment and the blue environment is deprecated.

Workflow of the project:<br>

1. checkout code from github<br>

2. build a docker image<br>

3. login to dockerhub<br>

4. docker tag and push the created image to dockerhub<br>

5. logout from dockerhub<br>

6. Deployment to Kubernetes<br>

# Installation: Manual installation

1. Install docker in your system. Refer the official documentation for installing docker here: https://docs.docker.com/engine/install/ubuntu/
2. Install minikube in your system. Refer the official documentation for installing minikube here: https://minikube.sigs.k8s.io/docs/start/
3. Build the docker image for blue: (make sure that index-blue.html is mentioned in the Dockerfile)
     docker build -t ebinvarghese/myapp-blue:latest .
4. Build the docker image for green: (make sure that index-green.html is mentioned in the Dockerfile)
     docker build -t ebinvarghese/myapp-green:latest .
5. Push the docker image to dockerhub:
     docker push ebinvarghese/myapp-blue:latest
     docker push ebinvarghese/myapp-green:latest
6. Deploy the blue app:
     kubectl apply -f myapp-blue/deployment.yaml
     kubectl apply -f myapp-blue/service.yaml
7. Deploy the green app:
     kubectl apply -f myapp-green/deployment.yaml
     kubectl apply -f myapp-green/service.yaml
8. Check the service list to see the link to the deployed apps:
     minikube service list
9. Now to redirect the traffic from blue to green, edit the service file and update the selector to myapp-green:<br>
     selector:<br>
       &nbsp;&nbsp;app: myapp-green<br>
10. Refresh the blue page to see the update

# Installation: By using Jenkins and Argo (Automation)

1. Install argo. You can refer the official documentation here: https://argo-cd.readthedocs.io/en/stable/getting_started/
2. configure the pipeline for the live site with Jenkinsfile-live
3. configure the pipeline for the test site with Jenkinsfile-test
4. build the project and the following will be happen:
      image for myapp-blue and myapp-green will be created
      The image will be pushed to the dockerhub
      The application will be deployed to k8s cluster by Argo
5. Now to redirect the traffic from blue to green, update the service file with myapp-green selector:<br>
     selector:<br>
       &nbsp;&nbsp;app: myapp-green<br>
6. Refresh the live site's page and see the update

# Notes:

1. I have used the environment variable for the TAG as Date+Buildnumber. You can create as per your requirements.
2. Dockerhub login credentials needs to be configured in Jenkins.
3. Needs to authenticate the jenkins user to use minikube.
4. If any doubts, ping me in whatsapp: +91 9495885325
