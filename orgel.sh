#/bin/sh

pkill autoconnect
pkill midichan
aconnect -x

# Aeolus changes its Alsa MIDI name after connecting, and that isn't
# caught by autoconnect for some reason, so we start it first and wait
# a bit before trying to connect.
echo ===== Starting Aeolus
aeolus -A -d hw:CARD=Intel,DEV=0 -N aeolus -W $HOME/waves -u&
sleep 5

echo ===== Starting MIDI channel remapper
miditools/midichan -v -n 4 &
sleep 1

echo ===== Starting MIDI autoconnector
miditools/autoconnect -v \
	'Channel Enforcer':4 aeolus \
	'Keystation 61e' 'Channel Enforcer':0 \
	'eKeys-49 USB MIDI Keyboard' 'Channel Enforcer':1 \
	'UM-ONE' 'Channel Enforcer':3 &

