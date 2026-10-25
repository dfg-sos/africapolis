FROM ghcr.io/descartesresearch/fishnet-deps:latest AS build
COPY ./src /sympolis/src
COPY ./lib /sympolis/lib
COPY CMakeLists.txt /sympolis/CMakeLists.txt
RUN mkdir -p /sympolis/build
WORKDIR /sympolis/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DFISHNET_TEST=OFF -DFISHNET_TEST_LIB=OFF -DFISHNET_APPS=ON -DFISHNET_EXAMPLES=OFF .. 
RUN cmake --build . --config Release -j 8
RUN cmake --install .

# Runtime stage
FROM ghcr.io/osgeo/gdal:ubuntu-small-3.12.2 AS runtime
LABEL org.opencontainers.image.source=https://github.com/dfg-sos/sympolis
COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/lib /usr/local/lib
