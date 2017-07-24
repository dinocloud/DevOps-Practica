FROM ubuntu:latest
MAINTAINER Juan Diaz "juan.diaz@dinocloudconsulting.com"
RUN apt-get update -y
RUN apt-get install -y git python-pip python-dev build-essential

######
# Clone and install the application
######
ARG BACKEND_REVISION=master
RUN mkdir -p /opt
RUN git clone https://github.com/dinocloud/Backend-Practica /opt/backend-${BACKEND_REVISION} \
    && cd /opt/backend-${BACKEND_REVISION}\
    && git checkout ${BACKEND_REVISION}

WORKDIR /opt/backend-${BACKEND_REVISION}

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt
# Run the application
ENTRYPOINT ["python"]
CMD ["application.py"]