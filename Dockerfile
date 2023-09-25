############################
# STEP - First Hello World
############################
FROM golang:1.20 AS builder

WORKDIR /usr/src/app

COPY . .

# Compilando o binário removendo informações de debug
RUN go build -ldflags '-s -w' first.go

CMD [ "go","run","first.go" ]

# docker build -t manscalh/golang .
# docker run manscalh/golang

FROM golang:1.20.0-alpine3.17
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app .
CMD [ "go","run","first.go" ]

############################
# STEP - build a small image
############################

# Iniciando com scratch
FROM scratch

# diretório de trabalho
WORKDIR /

# copiando o binário
COPY --from=builder /usr/src/app / 

# executando 
CMD ["./first"]