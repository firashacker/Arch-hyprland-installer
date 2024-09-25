#!/bin/bash

song_info=$(playerctl metadata --format '{{title}}  {{artist}}')

if [[ -z $song_info ]];then
	song_info=$(mpc current  -f '%artist%  %title%')
fi

echo "$song_info" 
