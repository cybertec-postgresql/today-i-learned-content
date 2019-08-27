FROM node:latest

RUN mkdir /today-i-learned
WORKDIR /today-i-learned

# TODO: Cache...
RUN git clone https://sascha8a:2da4f5fd0bf34fd326a088a7d058a45d42d11702@github.com/cybertec-postgresql/today-i-learned.git /today-i-learned

RUN yarn

EXPOSE 8000
ENTRYPOINT [ "yarn", "docker" ]