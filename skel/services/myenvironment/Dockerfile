# base image
FROM alpine AS base
RUN apk \
    add \
    --quiet \
    --no-cache \
    --no-progress \
    nodejs-current
WORKDIR /app
# don't copy all of the code to use Docker's caching
COPY package.json package-lock.json ./

# install dependencies
FROM base AS dependencies
RUN npm install --silent --only=production
RUN cp -R node_modules prod_node_modules
RUN npm --silent install

# run tests
FROM dependencies AS test
COPY  src .
RUN npm run test

# build release image
FROM base AS release
COPY --from=test /app/prod_node_modules ./node_modules
COPY . .
EXPOSE 5555
CMD npm run start
