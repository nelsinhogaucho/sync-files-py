# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
#RUN chmod +x entrypoint.sh
RUN ls -la
COPY entrypoint.sh /entrypoint.sh
RUN ls -la
RUN chmod -R 765 entrypoint.sh
RUN ls -la
# Code file to execute when the docker container starts up (`entrypoint.sh`)
CMD ["./","entrypoint.sh"]
#ENTRYPOINT ["entrypoint.sh"]