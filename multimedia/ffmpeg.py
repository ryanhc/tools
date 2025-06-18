#!/usr/bin/python

import sys
import os
from subprocess import call

fileSuffix = "_e"

def getMovieFiles(dirName):
    listOfFiles = list()
    for (dirpath, _dirnames, filenames) in os.walk(dirName):
        for file in filenames:
            ext = file[file.rfind('.') + 1:].lower()
            if file.rfind(fileSuffix+"."+ext) >= 0:
                continue
            elif ext == "mov" or ext == 'mp4':
                listOfFiles += [os.path.join(dirpath, file)]
    return listOfFiles

# -c:v [ libx264, libx265 ]
# -crf [ 0 - 51 ], where 0 = lossless, 23 = default, and 51 = worst
# preset [ultrafast, superfast, veryfast, faster, fast,
#         medium, slow, slower, veryslow]
def encode(input):
    ffmpeg = "ffmpeg"
    options = [
            "-c:v libx264",
            "-crf 22",
            "-c:a aac",
            "-b:a 192k",
            "-ar 44100",
            "-preset slow",
            "-map_metadata 0",
            # "-vf transpose=2",
            "-movflags +faststart",
            "-y",
            ]

    ext = input[input.rfind('.'):].lower()
    output = input[:input.rfind('.')] + fileSuffix + ext

    options = ' '.join(options).split()
    cmd = [ffmpeg, "-i" , input] + options + [output]
    print(' '.join(cmd))
    call(cmd)

def main():
    if len(sys.argv) == 2:
        movies = [sys.argv[1]]
    else:
        movies = getMovieFiles('.')

    print(movies)
    for movie in movies:
        encode(movie)

if __name__ == '__main__':
    main()
