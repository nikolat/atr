FROM node:18.14.1-buster
RUN mkdir -p /app
RUN mkdir -p /app/files

WORKDIR /app
ADD ./atproto ./
RUN npm i -g npm
RUN npm i -g node-gyp
RUN npm i -g lerna
RUN rm -rf node_modules
RUN npm i
#RUN npm run verify
#RUN npm run prettier
#RUN npm run build
WORKDIR /app/packages/dev-env
CMD ["node", "dist/cli.js"]
#WORKDIR /app/packages/plc
#CMD ["node","dist/bin.js"]
#WORKDIR /app/packages/pds
#ENTRYPOINT ["node","dist/bin.js"]
