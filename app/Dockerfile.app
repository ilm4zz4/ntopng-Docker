ARG built_image
FROM ilm4zz4/ntopng:${built_image}


RUN mkdir /workspace/data
RUN useradd -p $(openssl passwd -1 pippo) ntopng
RUN chown -R ntopng:ntopng /workspace/data
RUN chmod 777 /workspace/data
RUN ln -s /workspace/ntopng/ntopng /bin/ntopng
COPY ./entrypoint.sh /workspace/entrypoint.sh
RUN chmod +x /workspace/entrypoint.sh
RUN ln -s /workspace/entrypoint.sh  /bin/entrypoint.sh

ENTRYPOINT ["bash entrypoint.sh"]
