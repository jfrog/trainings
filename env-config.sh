#!/bin/bash

read  -p "Enter JFrog Access Token: " JF_TOKEN

echo "export JFROG_ACCESS_TOKEN=${JF_TOKEN}" >> ~/.bashrc

jf rt ping
