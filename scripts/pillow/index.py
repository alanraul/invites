#!/usr/bin/python
#-*- coding: utf-8 -*-

import sys
import textwrap
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def get_file(uri):
    return cStringIO.StringIO(urllib.urlopen(uri).read())

if __name__ == '__main__':
    image = Image.open(get_file(sys.argv[1]))
    font = ImageFont.truetype(get_file(sys.argv[2]), 18)

    [x, y] = sys.argv[3].split(",")
    x = int(x)
    y = int(y)

    text = unicode(sys.argv[4], "utf-8")

    draw = ImageDraw.Draw(image)

    for line in textwrap.wrap(text, width=20):
        draw.text((x, y), line, fill=(0,0,0), font=font)
        y += font.getsize(line)[1]

    image.save(sys.argv[5] + '.jpg')
