FROM python:3.8.2-alpine3.11

ENV FLASK_APP=main.py
ENV FLASK_ENV=development

#COPY . /app
RUN mkdir -p /app
COPY server.py /app/
COPY requirements.txt /app/
WORKDIR /app

RUN pip install -r requirements.txt

#ENTRYPOINT FLASK_APP=/app/server.py flask run --host=0.0.0.0 --port=80

COPY entrypoint.sh ./

# Start and enable SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends dialog \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd \
    && chmod u+x ./entrypoint.sh
COPY sshd_config /etc/ssh/

EXPOSE 8000 2222

ENTRYPOINT [ "./entrypoint.sh" ] 




