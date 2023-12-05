FROM debian:12 AS builder

ENV TZ=America/New_York
RUN apt-get update -y && apt-get install -y texlive texlive-formats-extra make git

WORKDIR /out/

COPY . .

RUN make

FROM nginx:mainline

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /out/constitution.pdf /usr/share/nginx/html/constitution.pdf
