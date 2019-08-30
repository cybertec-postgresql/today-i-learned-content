FROM node:latest

RUN mkdir /today-i-learned
WORKDIR /today-i-learned

ADD https://api.github.com/repos/cybertec-postgresql/today-i-learned/git/refs/heads/master /version.json
RUN git clone https://github.com/cybertec-postgresql/today-i-learned.git /today-i-learned

RUN yarn

EXPOSE 8000
ENTRYPOINT [ "yarn", "docker" ]