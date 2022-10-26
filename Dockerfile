FROM node:18

ARG uid=1001
ARG user=jeff
ARG appname=nestapp

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/$appname && chown -R $user:$user /home/$user

WORKDIR /home/$user/$appname

COPY ./application/* .

RUN npm install

# Creates a "dist" folder with the production build
RUN npm run build

# Start the server using the production build
CMD [ "node", "dist/main.js" ]

EXPOSE 3000