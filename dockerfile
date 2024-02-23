FROM node:20-alpine

ENV NPM_CONFIG_LOGLEVEL=warn \
  APP_PATH=/src \

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

RUN apk --no-cache add --virtual native-deps git \
  g++ gcc libgcc libstdc++ linux-headers make python3 && \
  npm install --quiet node-gyp -g

RUN chown node:node $APP_PATH
USER node

COPY package.json package-lock.json .npmrc $APP_PATH/

RUN node -v && npm -v && npm ci --only=production

COPY --chown=node:node . $APP_PATH

# Run app
EXPOSE 3000
CMD PORT=3000 npm start