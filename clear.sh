#!/bin/bash

. ~/.venv/supernova/bin/activate

supernova uk list | awk '{print$4}' | egrep -o '[a-z][a-z][0-9][0-9][0-9]' | xargs -n1 supernova uk delete
supernova us list | awk -F'|' '{print$3}' | egrep -o '[a-z][a-z][0-9][0-9][0-9]' | xargs -n1 supernova us delete

knife node bulk delete '[a-z][a-z][0-9][0-9][0-9]'
knife client bulk delete '[a-z][a-z][0-9][0-9][0-9]'
