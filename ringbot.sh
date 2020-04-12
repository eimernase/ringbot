#!/bin/bash

# Info
#         _             __          __ 
#   _____(_)___  ____ _/ /_  ____  / /_
#  / ___/ / __ \/ __ `/ __ \/ __ \/ __/
# / /  / / / / / /_/ / /_/ / /_/ / /_  
#/_/  /_/_/ /_/\__, /_.___/\____/\__/ v0.0.2 
#             /____/  by eimernase
# 

screenres="1280x800"

# Tiles
KREUZ="$(cat assets/$screenres/kreuz.png | base64 | tail -n +20 | head -n -20)"
TEE="$(cat assets/$screenres/t.png | base64 | tail -n +20 | head -n -20)"
RAUM1="$(cat assets/$screenres/raum1.png | base64 | tail -n +20 | head -n -20)"
RAUM2="$(cat assets/$screenres/raum2.png | base64 | tail -n +20 | head -n -20)"
RAUM3="$(cat assets/$screenres/raum3.png | base64 | tail -n +20 | head -n -20)"
RAUM4="$(cat assets/$screenres/raum4.png | base64 | tail -n +20 | head -n -20)"
RAUM5="$(cat assets/$screenres/raum5.png | base64 | tail -n +20 | head -n -20)"
#ENDE="$(cat assets/$screenres/ende.png | base64 | tail -n +20 | head -n -20)"
YES="$(cat assets/$screenres/yes.png | base64 | tail -n +20 | head -n -20)"
GAMECHECK="$(cat assets/$screenres/gamecheck.png | base64 | tail -n +20 | head -n -20)"

# Opening to start with
variante=1

# Variants
v1=( 1070 980 890 800 710 620 530 )
v2=( 800 890 710 980 620 1070 530 )
v3=( 530 620 710 800 890 980 1070 )

# Playfield coordinates
posX=( 530 620 710 800 890 980 1070 )
posY=( 160 250 340 430 520 610 700 )

# Switch to desktop 2
xdotool key alt+2

function opening1() {
	for i in ${v1[@]}; do
		xdotool mousemove $i ${posY[0]} click 1		
	done
}

function opening2() {
	for i in ${v2[@]}; do
		xdotool mousemove $i ${posY[0]} click 1
	done
}

function opening3() {
	for i in ${v3[@]}; do
		xdotool mousemove $i ${posY[0]} click 1		
	done
}

function click_incpos() {
	xdotool click 1
	((park_position++))
}

function click_inckreuz() {
	case $anzahl_kreuze in
		0 )	xdotool mousemove ${posX[5]} ${posY[1]}
			;;
		1 )	xdotool mousemove ${posX[5]} ${posY[2]}
			;;
		2 )	xdotool mousemove ${posX[5]} ${posY[3]}
			;;
		3 )	xdotool mousemove ${posX[5]} ${posY[4]}
			;;
		4 )	xdotool mousemove ${posX[5]} ${posY[5]}
			;;
		5 )	xdotool mousemove ${posX[5]} ${posY[6]}
			;;
		* )	parken
	esac

	if [ "$TILE" == "$TEE" ]; then
		if [ "$anzahl_kreuze" == "0" ]; then			
			xdotool click 3 click 3

		elif [ "$anzahl_kreuze" == "5" ]; then
			:
		else
			xdotool click 3 click 3 click 3
		fi
	fi
	


	xdotool click 1
	((anzahl_kreuze++))
}	

function click_incraum() {
	case $anzahl_raeume in
		0 )	xdotool mousemove ${posX[4]} ${posY[1]}
			raum_links_rechts=0
			;;
		1 )	xdotool mousemove ${posX[6]} ${posY[1]}
			raum_links_rechts=1
			;;
		2 )	xdotool mousemove ${posX[4]} ${posY[2]}
			raum_links_rechts=0
			;;
		3 )	xdotool mousemove ${posX[6]} ${posY[2]}
			raum_links_rechts=1
			;;
		4 )	xdotool mousemove ${posX[4]} ${posY[3]}
			raum_links_rechts=0
			;;
		5 )	xdotool mousemove ${posX[6]} ${posY[3]}
			raum_links_rechts=1
			;;
		6 )	xdotool mousemove ${posX[4]} ${posY[4]}
			raum_links_rechts=0
			;;
		7 )	xdotool mousemove ${posX[6]} ${posY[4]}
			raum_links_rechts=1
			;;
		8 )	xdotool mousemove ${posX[4]} ${posY[5]}
			raum_links_rechts=0
			;;
		9 )	xdotool mousemove ${posX[6]} ${posY[5]}
			raum_links_rechts=1
			;;
		10 )	xdotool mousemove ${posX[4]} ${posY[6]}
			raum_links_rechts=0
			;;
		11 ) 	xdotool mousemove ${posX[6]} ${posY[6]}
			raum_links_rechts=1
			;;
		* )	parken
	esac
		if [ "$TILE" == "$RAUM1" ] || [ "$TILE" == "$RAUM2" ] || [ "$TILE" == "$RAUM3" ]; then
			if [ "$raum_links_rechts" == "0" ]; then
				xdotool click 3
			elif [ "$raum_links_rechts" == "1" ]; then
				xdotool click 3 click 3 click 3
			fi
		fi

		if [ "$TILE" == "$RAUM4" ]; then
			if [ "$raum_links_rechts" == "0" ]; then
				xdotool click 3	click 3 click 3
			elif [ "$raum_links_rechts" == "1" ]; then
				xdotool click 3
			fi
		fi

		if [ "$TILE" == "$RAUM5" ]; then
			if [ "$raum_links_rechts" == "0" ]; then
				xdotool click 3 click 3
			fi
		fi

	xdotool click 1
	((anzahl_raeume++))
}

function tile_holen() {
	# Copy the actual tile from the screen  
	xdotool mousemove 530 250
	sleep 0.01
	scrot assets/$screenres/screenshot.png
	convert assets/$screenres/screenshot.png -crop 89x89+483+204 assets/$screenres/tile.png 

	# Get base64 encoded image and cut the filename data
	TILE="$(cat assets/$screenres/tile.png | base64 | tail -n +20 | head -n -20)"
}

function parken() {

	if [ "$variante" == "1" ]; then
		case $park_position in		
			0 )	xdotool mousemove ${posX[3]} ${posY[1]}
				;;
			1 ) 	xdotool mousemove ${posX[2]} ${posY[1]}
				;;
			2 )	xdotool mousemove ${posX[1]} ${posY[1]}
				;;
			3 )	xdotool mousemove ${posX[3]} ${posY[2]}
				;;
			4 )	xdotool mousemove ${posX[2]} ${posY[2]}
				;;
			5 )	xdotool mousemove ${posX[1]} ${posY[2]}
				;;
			6 )	xdotool mousemove ${posX[0]} ${posY[2]}
				;;
			7 ) 	xdotool mousemove ${posX[3]} ${posY[3]}
				;;
			8 )	xdotool mousemove ${posX[2]} ${posY[3]}
				;;
			9 )	xdotool mousemove ${posX[1]} ${posY[3]}
				;;
			10 )	xdotool mousemove ${posX[0]} ${posY[3]}
				;;
			11 )	xdotool mousemove ${posX[3]} ${posY[4]}
				;;
			12 )	xdotool mousemove ${posX[2]} ${posY[4]}
				;;
			13 )	xdotool mousemove ${posX[1]} ${posY[4]}
				;;
			14 )	xdotool mousemove ${posX[0]} ${posY[4]}
				;;
			15 )	xdotool mousemove ${posX[3]} ${posY[5]}
				;;
			16 )	xdotool mousemove ${posX[2]} ${posY[5]}
				;;
			17 )	xdotool mousemove ${posX[1]} ${posY[5]}
				;;
			18 )	xdotool mousemove ${posX[0]} ${posY[5]}
				;;
			19 )	xdotool mousemove ${posX[3]} ${posY[6]}
				;;
			20 )	xdotool mousemove ${posX[2]} ${posY[6]}
				;;
			21 )	xdotool mousemove ${posX[1]} ${posY[6]}
				;;
			22 )	xdotool mousemove ${posX[0]} ${posY[6]}
				;;
			* ) 	#nochsetzen	
		esac

	elif [ "$variante" == "2" ]; then
		case $park_position in		
			0 )	xdotool mousemove ${posX[1]} ${posY[1]} 
				;;
			1 ) 	xdotool mousemove ${posX[2]} ${posY[1]}
				;;
			2 )	xdotool mousemove ${posX[3]} ${posY[1]}
				;;
			3 )	xdotool mousemove ${posX[1]} ${posY[2]}
				;;
			4 )	xdotool mousemove ${posX[0]} ${posY[2]}
				;;
			5 )	xdotool mousemove ${posX[3]} ${posY[2]}
				;;
			6 )	xdotool mousemove ${posX[2]} ${posY[2]}
				;;
			7 ) 	xdotool mousemove ${posX[1]} ${posY[3]}
				;;
			8 )	xdotool mousemove ${posX[0]} ${posY[3]}
				;;
			9 )	xdotool mousemove ${posX[3]} ${posY[3]}
				;;
			10 )	xdotool mousemove ${posX[2]} ${posY[3]}
				;;
			11 )	xdotool mousemove ${posX[1]} ${posY[4]}
				;;
			12 )	xdotool mousemove ${posX[0]} ${posY[4]}
				;;
			13 )	xdotool mousemove ${posX[3]} ${posY[4]}
				;;
			14 )	xdotool mousemove ${posX[2]} ${posY[4]}
				;;
			15 )	xdotool mousemove ${posX[1]} ${posY[5]} 
				;;
			16 )	xdotool mousemove ${posX[0]} ${posY[5]} 
				;;
			17 )	xdotool mousemove ${posX[3]} ${posY[5]} 
				;;
			18 )	xdotool mousemove ${posX[2]} ${posY[5]}
				;;
			19 )	xdotool mousemove ${posX[1]} ${posY[6]}
				;;
			20 )	xdotool mousemove ${posX[0]} ${posY[6]}
				;;
			21 )	xdotool mousemove ${posX[3]} ${posY[6]}
				;;
			22 )	xdotool mousemove ${posX[2]} ${posY[6]}
				;;
			* ) 	#nochsetzen
		esac
	elif [ "$variante" == "3" ]; then
		case $park_position in		
			0 )	xdotool mousemove ${posX[2]} ${posY[1]}
				;;
			1 ) 	xdotool mousemove ${posX[3]} ${posY[1]}
				;;
			2 )	xdotool mousemove ${posX[1]} ${posY[1]}
				;;
			3 )	xdotool mousemove ${posX[2]} ${posY[2]}
				;;
			4 )	xdotool mousemove ${posX[3]} ${posY[2]}
				;;
			5 )	xdotool mousemove ${posX[1]} ${posY[2]}
				;;
			6 )	xdotool mousemove ${posX[0]} ${posY[2]}
				;;
			7 ) 	xdotool mousemove ${posX[2]} ${posY[3]}
				;;
			8 )	xdotool mousemove ${posX[3]} ${posY[3]}
				;;
			9 )	xdotool mousemove ${posX[1]} ${posY[3]}
				;;
			10 )	xdotool mousemove ${posX[0]} ${posY[3]}
				;;
			11 )	xdotool mousemove ${posX[2]} ${posY[4]}
				;;
			12 )	xdotool mousemove ${posX[3]} ${posY[4]}
				;;
			13 )	xdotool mousemove ${posX[1]} ${posY[4]}
				;;
			14 )	xdotool mousemove ${posX[0]} ${posY[4]}
				;;
			15 )	xdotool mousemove ${posX[2]} ${posY[5]}
				;;
			16 )	xdotool mousemove ${posX[3]} ${posY[5]}
				;;
			17 )	xdotool mousemove ${posX[1]} ${posY[5]}
				;;
			18 )	xdotool mousemove ${posX[0]} ${posY[5]}
				;;
			19 )	xdotool mousemove ${posX[2]} ${posY[6]}
				;;
			20 )	xdotool mousemove ${posX[3]} ${posY[6]}
				;;
			21 )	xdotool mousemove ${posX[1]} ${posY[6]}
				;;
			22 )	xdotool mousemove ${posX[0]} ${posY[6]}
				;;
			* ) #nochsetzen	
		esac
	fi
	click_incpos

#	for i in ${posX[@]}; do
#		for j in ${posY[@]}; do
#			xdotool mousemove $i $j
#			xdotool click 1
#		done				
#	done

}

function run() {

	# (re)set variables
	anzahl_kreuze=0
	anzahl_raeume=0
	park_position=0

	# Click on available game and "Play selected"
	xdotool mousemove 215 215 click 1
	xdotool mousemove 75 160 click 1

	# Restart?
	scrot assets/$screenres/restart_screenshot.png
	convert assets/$screenres/restart_screenshot.png -crop 256x106+504+298 assets/$screenres/yes_check.png 
	
	YES_CHECK="$(cat assets/$screenres/yes_check.png | base64 | tail -n +20 | head -n -20)"

	if [ "$YES_CHECK" == "$YES" ]; then
		xdotool mousemove 660 380 click 1	
	fi

	# Lay down line tiles 0-6
	case $variante in
		1 )	opening1
			;;
		2 )	opening2
			;;
		3 )	opening3
			;;
		* )
	esac
	
	# Compare tiles and end when tiledump is full (should be updated)
	while :; do
		tile_holen

		if [ "$park_position" == "23" ]; then
			break
		fi

		if [ "$TILE" == "$KREUZ" ] || [ "$TILE" == "$TEE" ]; then
			click_inckreuz
		
		elif [ "$TILE" == "$RAUM1" ] || [ "$TILE" == "$RAUM2" ] || [ "$TILE" == "$RAUM3" ] || [ "$TILE" == "$RAUM4" ] || [ "$TILE" == "$RAUM5" ]; then
			click_incraum
		
		else
			# Park tile on the sideline
			parken
		
		fi
		
	done

	# Click away possible error windows
	xdotool mousemove 765 380 click 1
	xdotool mousemove 805 380 click 1


}

while :; do
	# Scan for games every x seconds and start if possible
	sleep 0.5
	scrot assets/$screenres/gamecheck_screenshot.png
	convert assets/$screenres/gamecheck_screenshot.png -crop 438x77+17+177 assets/$screenres/gamecheck_new.png 
	GAMECHECK_NEW="$(cat assets/$screenres/gamecheck_new.png | base64 | tail -n +20 | head -n -20)"
	
	if [ "$GAMECHECK_NEW" != "$GAMECHECK" ]; then
		case $variante in
			1 )	variante=2
				;;
			2 )	variante=3
				;;
			3)	variante=1
				;;
			*)
		esac
		run
	fi
done
