#!/bin/bash
echo 'What is the ip that you wish to connect to?'
read ip
echo 'Who do you want to connect to?'
read user
echo 'Connecting...'
ssh $user@$ip -L 2000:$ip:3000
