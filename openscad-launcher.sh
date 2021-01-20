#!/bin/sh
DIR=$(dirname "$1")
SHA=$(git -C "$DIR" rev-parse --short HEAD)
openscad -D version=\"$SHA\" "$1"
