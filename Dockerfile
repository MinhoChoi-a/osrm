FROM osrm/osrm-backend

COPY ontario-latest.osm.pbf ontario-latest.osm.pbf
RUN mkdir profiles
COPY car.lua /profiles/car.lua

RUN ls -s profiles/car.lua
RUN ls -s lib

RUN osrm-extract alberta-latest.osm.pbf
RUN osrm-contract alberta-latest.osrm

EXPOSE 5000

ENTRYPOINT ["osrm-routed", "alberta-latest.osrm"]

