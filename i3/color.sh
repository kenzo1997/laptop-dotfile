FILE=$(find ~/Pictures/wallpapers/ -type f -print0 | shuf -z -n 1)

wal -c
wal -i $FILE
feh --bg-scale $FILE
