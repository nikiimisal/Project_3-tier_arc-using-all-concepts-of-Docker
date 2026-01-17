FROM mysql
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=FCT
COPY init.sql /docker-entrypoint-initdb.d/
EXPOSE 3306
CMD ["mysqld"]





FROM mysql                                     # Used to pull the official MySQL image as the base image
ENV MYSQL_ROOT_PASSWORD=root                   # Used to set the MySQL root user password
ENV MYSQL_DATABASE=FCT                         # Used to create a database named FCT automatically
COPY init.sql /docker-entrypoint-initdb.d/     # Used to run SQL file during first container startup
EXPOSE 3306                                    # Used to expose MySQL default port
CMD ["mysqld"]                                 # Used to start the MySQL server
