FROM python:3

ARG repo=weboob

RUN apt-get update && \
    apt-get install -y git python-pdfminer && \
    useradd -m -s /bin/bash weboob && \
    mkdir -p /home/weboob/.config /home/weboob/.local/share /config /data && \
    ln -s /config /home/weboob/.config/weboob && \
    ln -s /data /home/weboob/.local/share/weboob && \
    chown -R weboob:weboob ~weboob /config /data && \
    pip install prettytable pdfminer git+https://git.weboob.org/weboob/${repo}.git && \
    apt-get remove --purge -y git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

USER weboob
WORKDIR "/config"
VOLUME ["/config", "/data"]

# ENTRYPOINT ["/usr/local/bin/weboob"]
CMD ["weboob"]
