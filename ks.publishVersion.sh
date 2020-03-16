#!/bin/bash
# curl -XPOST -uedoweb-admin:admin -H "Content-Type: application/json" -d'{ "accessScheme" : "public" }' "http://api.localhost/resource/edoweb:100443/publishVersion";
# curl -XPOST -uedoweb-admin:admin "http://api.localhost/resource/edoweb:100443/publishVersion?accessScheme=public" -H "UserId=gatherimport" -H "Content-Type: text/plain; charset=utf-8"
# curl -XPOST -uedoweb-admin:admin "http://api.localhost/resource/edoweb:100443/publishVersion?accessScheme=restricted"
curl -XPOST -uedoweb-admin:admin "http://api.localhost/resource/edoweb:100443/publishVersion?accessScheme=public"

