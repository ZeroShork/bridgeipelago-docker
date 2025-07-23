FROM python:3.12

WORKDIR /bridgeipelago

RUN git clone https://github.com/Quasky/bridgeipelago.git .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "bridgeipelago.py"]

