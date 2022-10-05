#!/bin/sh
kill -9 $(pgrep -P $(pgrep dwmbar.sh) sleep)
