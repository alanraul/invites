#!/usr/bin/python
#-*- coding: utf-8 -*-

import sys
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def get_file(uri):
    return cStringIO.StringIO(urllib.urlopen(uri).read())


if __name__ == '__main__':
    image = Image.open(get_file(sys.argv[1]))
    font = ImageFont.truetype(get_file(sys.argv[2]), 24)

    draw = ImageDraw.Draw(image)

    draw.text((0, 0), unicode(sys.argv[3], "utf-8"), (0,0,0), font=font)
    image.save('output.jpg')