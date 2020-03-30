#!/bin/sh
set -e;

# Replace environment variables in template files
envs=`printf '${%s} ' $(sh -c "env|cut -d'=' -f1")`;
for filename in $(find /etc/dnsmasq.d -name '*.tmpl'); do
    envsubst "$envs" < "$filename" > ${filename: :-5};
    rm "$filename";
done

exec $@
