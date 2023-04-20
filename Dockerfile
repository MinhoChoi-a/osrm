FROM osrm/osrm-backend

RUN mkdir /app
COPY ["./car.lua", "/app/car.lua"]
COPY ["./ontario-latest.osrm", "/app/ontario-latest.osm.pbf"]

WORKDIR /app

RUN osrm-extract -p /app/car.lua /app/ontario-latest.osm.pbf
RUN osrm-partition /app/ontario-latest.osm.pbf
RUN osrm-customize /app/ontario-latest.osm.pbf

EXPOSE 8080

CMD ["osrm-routed", "--algorithm", "mld", "/app/ontario-latest.osrm"]