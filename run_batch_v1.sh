#!/bin/sh

################################
### PythonDelaunay
################################

# remove old generated data
rm split/*.png
rm output/*.png

# generate PNG files every N seconds / frames
ffmpeg -i load/in.mp4 -vf fps=1 -r 3 split/out%03d.png
#ffmpeg -i load/in.mp4 -framerate 15 -r 15  -vf fps=1 split/out%03d.png

# start batch process
# php -S localhost:8080

# https://developer.mozilla.org/en-US/docs/Mozilla/Command_Line_Options
# wget  -qO- http://0.0.0.0:8080/jsDelaunay3/?imgk=../split/out001.png &> /dev/null
# curl http://0.0.0.0:8080/jsDelaunay3/?imgk=../split/out001.png
# firefox http://0.0.0.0:8080/jsDelaunay3/?imgk=../split/out001.png -foreground -headless --sync 

TABS=""
for i in split/*.png
  do
   #echo -private-window http://0.0.0.0:8080/jsDelaunay3/?imgk=../$i -foreground -headless
   TABS+=" -url http://0.0.0.0:8080/jsDelaunay3/?imgk=../$i -fwait 5 "
    #sleep 2
done
firefox $TABS
pkill -f firefox
num=0; for i in output/*.png; do mv "$i" "output/out$(printf '%03d' $num).png"; ((num++)); done

# merge generated PNG delaunay images in one video
ffmpeg -i output/out%3d.png -r 15 -b:v 10000k tmp/out_$(date +%s).mp4


# ffmpeg -i in1.mp4 -filter:v "setpts=1.5*PTS" -y output.mp4
# ffmpeg -i output.mp4 -vf eq=saturation=1.5 -y output2.mp4


