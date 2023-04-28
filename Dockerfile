FROM ubuntu:18.04

ENV API_KEY=""
ENV LAT=""
ENV LON=""

WORKDIR /home

COPY openweather_wrapper.sh ./

RUN apt update && apt install -y curl

CMD ["./openweather_wrapper.sh"]