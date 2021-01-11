# base image and working directory
FROM node:alpine


WORKDIR /app
# ENV PATH /app/node_modules/.bin:$PATH

#copy the defendencies
COPY package.json /app
 COPY package-lock.json /app
RUN npm install 

#copy the files that need app to run
COPY . /app

#port number at which the container should be exposed
EXPOSE 3000

#run the application
CMD ["npm","start"]