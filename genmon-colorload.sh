#!/bin/bash

#COLOR echo "<txt><span weight='Bold' fgcolor='Red'><i>Test</i></span></txt>"
LOAD1=$(awk '{print $1}' < /proc/loadavg)
LOAD5=$(awk '{print $2}' < /proc/loadavg)
LOAD15=$(awk '{print $3}' < /proc/loadavg)
NPROC=$(nproc)


#PERSONAL SETTINGS
###
#TRESHOLDS
###
HI_TRESHOLD="0.8"
LOW_TRESHOLD="0.4"

###
#COLOURS
#You can use a HEX code too
###
HI_COLOR="Red"
MED_COLOR="Orange"
LOW_COLOR="Green"

color_load(){

    [[ $(echo "$1 >= $NPROC * $HI_TRESHOLD"  | bc) -eq 1 ]] && echo -ne "<span weight='Bold' fgcolor='$HI_COLOR'>$1 </span>"
    [[ $(echo "$1 > $NPROC * $LOW_TRESHOLD" |  bc) -eq 1 ]] && [[ $(echo "$1 < $NPROC * $HI_TRESHOLD" |  bc) -eq 1 ]] && echo -ne "<span weight='Bold' fgcolor='$MED_COLOR'>$1 </span>"
    [[ $(echo "$1 <= $NPROC * $LOW_TRESHOLD" | bc) -eq 1 ]] && echo -ne "<span weight='Bold' fgcolor='$LOW_COLOR'>$1 </span>"

}
echo -ne "<txt>"
for i in $LOAD1 $LOAD5 $LOAD15
do
    color_load "$i"
done
echo -ne "</txt>"
