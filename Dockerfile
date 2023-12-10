FROM bitwalker/alpine-erlang:20

LABEL maintaner="Ilia Ivanin <poison@rjhost.ru>"

ENV SSH_PROXY_ROOT=/opt/ssh-proxy

RUN mkdir -p \
        $SSH_PROXY_ROOT/bin \
        $SSH_PROXY_ROOT/auth \
        $SSH_PROXY_ROOT/users \
        $SSH_PROXY_ROOT/server

ADD ssh-proxy.erl $SSH_PROXY_ROOT/bin
ADD ssh_host_rsa_key $SSH_PROXY_ROOT/server/ssh_host_rsa_key
ADD id_rsa.pub /opt/ssh-proxy/auth/id_rsa.pub
ADD id_rsa /opt/ssh-proxy/auth/id_rsa
ADD user /opt/ssh-proxy/users/user

EXPOSE 2202

ENTRYPOINT ["/bin/sh", "-c", "$SSH_PROXY_ROOT/bin/ssh-proxy.erl -i $SSH_PROXY_ROOT/auth -u $SSH_PROXY_ROOT/users -t $SSH_PROXY_ROOT/server -p 2202"] 
