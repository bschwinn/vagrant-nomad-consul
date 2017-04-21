#!/bin/sh

vagrant ssh nom1 -c "consul join 192.168.7.77 192.168.7.78 192.168.7.79"
vagrant ssh prom -c "consul join 192.168.7.77"
vagrant ssh web -c "consul join 192.168.7.77"