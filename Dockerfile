FROM python:3.7-buster

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN mkdir -p .cvlib/

RUN pip install tensorflow==2.5.0 opencv-python==4.5.3.56

WORKDIR /usr/src/app

RUN mkdir -p images_uploaded

COPY requirements.txt ./

RUN pip install -r requirements.txt

EXPOSE 8000

ENV DOCKER-SETUP=TRUE

COPY deploy_yolo.py ./

ENTRYPOINT ["python", "deploy_yolo.py"]
