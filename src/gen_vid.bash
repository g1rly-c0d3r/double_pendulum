cd target/data

ffmpeg -y -framerate 1000 -pattern_type glob -i '*.png' -c:v libx264 -r 200 double_pendulum.mp4
