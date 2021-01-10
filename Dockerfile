# base image and working directory
FROM node:12-alpine


WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

#copy the defendencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install 

#copy the files that need app to run
COPY . ./

#port number at which the container should be exposed
EXPOSE 3000

#run the application
CMD ["npm","start"]