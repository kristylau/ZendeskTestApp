#!/bin/bash

echo "Deploying to Zendesk..."

FILE=.zat
PASSWORD="\"password\""
APP_ID="\"app_id\""

ZAT_DOCKER=ghcr.io/zendesk/zat-docker
APP=ZendeskTestApp

if  grep -q "$APP_ID" "$FILE" ; then
    echo "App ID detected, running update" ; 
    docker run --rm -v $PWD/$APP:/app -w /app $ZAT_DOCKER zat clean
    docker run --rm -v $PWD/$APP:/app -w /app $ZAT_DOCKER zat update
elif grep -q "$PASSWORD" "$FILE" ; then
    echo "No existing APP ID detected, creating new app" ; 
    docker run --rm -v $PWD/$APP:/app -w /app $ZAT_DOCKER zat clean
    docker run --rm -v $PWD/$APP:/app -w /app $ZAT_DOCKER zat create
else
    echo "Can't deploy. Please check your .zat file" ; 
fi