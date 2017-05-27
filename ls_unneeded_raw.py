#!/usr/bin/python

from os import walk
import os.path

for (dirpath, dirnames, filenames) in walk("."):
    for f in filenames:
        if f.lower().endswith(".cr2"):
            name = f[0:f.rfind(".")]
            jpegfile = dirpath+"/"+name+".JPG"
            rawfile = dirpath+"/"+f

            if not os.path.exists(jpegfile):
                print rawfile
