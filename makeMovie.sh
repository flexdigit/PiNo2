#!/bin/bash



#avconv -f image2 -i 'image_%d.jpg' film.mpg

#avconv -f image2 -i 'image_%d.jpg' -b 4096k Film5.mpg

avconv -f image2 -i 'image_%d.jpg' -b 10000k $(date '+%Y-%m-%d_%H-%M').mpg


