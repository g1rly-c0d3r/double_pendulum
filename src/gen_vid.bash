cd target/data

for file in *.dat; do
	gnuplot -e "set term png;
              set output '${file}.png';
              set grid;
              set xrange[-2:2];
              set yrange[-2:2];
              plot '${file}' w linespoints lt 7 "
done

ffmpeg -y -framerate 167 -pattern_type glob -i '*.png' -c:v libx264 -r 200 double_pendulum.mp4
