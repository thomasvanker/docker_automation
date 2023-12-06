echo "Date and Time: $(date)"
variable="Linux"
echo "Operating System: $variable"
echo "Current directory: $(pwd)"
name="Tommy"
age=300
echo "CREATOR: $name is $age years old and made this script, bisous!."
echo "Loading ..."
docker stop $(docker ps -aq) >/dev/null 2>&1
docker rm $(docker ps -aq) >/dev/null 2>&1

# Remove all images
docker rmi -f $(docker images -aq) >/dev/null 2>&1

echo "All Docker containers and images have been removed."

# Create directory 'sample' if it doesn't exist
mkdir -p sample_deployment
cd sample_deployment

# Clone the Git repository
git clone https://github.com/yroosel/sample_app.git

# Create the Dockerfile
cat <<EOF > Dockerfile
FROM python:3.9.10-slim-buster
RUN python3 -m pip install flask 
COPY ./sample_app/static /home/devasc/labs/devnet-src/sample-app/static/
COPY ./sample_app/templates /home/devasc/labs/devnet-src/sample-app/templates/
COPY ./sample_app/sample_app.py /home/devasc/labs/devnet-src/sample-app/
EXPOSE 5555
CMD python3 /home/devasc/labs/devnet-src/sample-app/sample_app.py
EOF
echo "BUILDING IMAGE DOOFUS :"
docker image build -t sample_deployment_image .
echo "IMAGE BUILT"
echo "BUILDING CONTAINER DOOFUS :"
docker run -d -t -P --name sample_deployment_container sample_deployment_image
echo "CONTAINER BUILT"
docker inspect sample_deployment_container &>> sample_deploy_log.txt
docker inspect sample_deployment_image &>> sample_deploy_log.txt
echo "RUNNING IMAGE :"
docker run sample_deployment_image


