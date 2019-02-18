FROM alpine:3.9 as ca
RUN adduser -D -g '' appuser
RUN apk add -U --no-cache ca-certificates

FROM scratch
COPY --from=ca /etc/passwd /etc/passwd
COPY --from=ca /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/app .

ARG appname=app
USER appuser

ENTRYPOINT  ["./app" ]