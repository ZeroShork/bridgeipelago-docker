FROM python:3.12

WORKDIR /bridgeipelago

RUN git clone https://github.com/ZeroShork/bridgeipelago-docker .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "bridgeipelago.py"]

# Add start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]
