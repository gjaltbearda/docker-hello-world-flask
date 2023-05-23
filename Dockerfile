#FROM python:3.8.2-alpine3.11
FROM alpine:latest
#ENV FLASK_APP=main.py
#ENV FLASK_ENV=development

#COPY . /app
#RUN mkdir -p /app
#COPY server.py /app/
#COPY requirements.txt /app/
#WORKDIR /app

#RUN pip install -r requirements.txt

#ENTRYPOINT FLASK_APP=/app/server.py flask run --host=0.0.0.0 --port=80

# van https://learn.microsoft.com/en-us/azure/app-service/configure-custom-container?pivots=container-linux&tabs=debian
COPY entrypoint.sh ./

# Start and enable SSH
#RUN apt-get update
RUN apt-get install -y --no-install-recommends dialog
RUN apt-get install -y --no-install-recommends openssh-server
RUN echo "root:Docker!" | chpasswd
RUN chmod u+x ./entrypoint.sh
COPY sshd_config /etc/ssh/

EXPOSE 8000 2222

ENTRYPOINT [ "./entrypoint.sh" ] 




