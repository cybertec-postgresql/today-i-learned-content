FROM node:latest

RUN mkdir /today-i-learned
WORKDIR /today-i-learned

# TODO: Cache...
RUN git clone https://github.com/cybertec-postgresql/today-i-learned.git /today-i-learned

RUN yarn

EXPOSE 8000
ENTRYPOINT [ "yarn", "docker" ]