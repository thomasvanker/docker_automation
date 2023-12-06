FROM python:3.9.10-slim-buster
RUN python3 -m pip install flask 
COPY ./sample_app/static /home/devasc/labs/devnet-src/sample-app/static/
COPY ./sample_app/templates /home/devasc/labs/devnet-src/sample-app/templates/
COPY ./sample_app/sample_app.py /home/devasc/labs/devnet-src/sample-app/
EXPOSE 5555
CMD python3 /home/devasc/labs/devnet-src/sample-app/sample_app.py
