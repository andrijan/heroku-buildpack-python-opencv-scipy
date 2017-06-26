#!/bin/bash
docker build -t bgeneto/opencvvendor:latest .
docker run --rm -v data:/vendoring bgeneto/opencvvendor:latest
