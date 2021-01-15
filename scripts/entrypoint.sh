#!/usr/bin/env bash

/usr/sbin/set-app-permissions

exec gosu $APP_USER "$@"
