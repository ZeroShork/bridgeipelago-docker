FROM python:3.12

WORKDIR /bridgeipelago

RUN git clone https://github.com/ZeroShork/bridgeipelago-docker .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "bridgeipelago.py"]

