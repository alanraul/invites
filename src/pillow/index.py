#!/usr/bin/python
#-*- coding: utf-8 -*-

import os
import json
import sys
import textwrap
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def get_file(uri, name):
    return cStringIO.StringIO(urllib.urlopen(uri + name).read())

def set_font_color(color):
    return tuple(int(color.lstrip('#')[i:i+2], 16) for i in (0, 2 ,4))

def draw_text(draw, color, coordinates, column_width, font, text):
    for line in textwrap.wrap(text, width=15):
        draw.text(coordinates, line, fill=color, font=font, anchor=None, spacing=0, align="right")

        (x, y) = coordinates
        y += font.getsize(line)[1]
        coordinates = (x, y)


if __name__ == '__main__':
    invite = json.loads(sys.argv[1])

    image = Image.open(get_file(os.environ["TEMPLATES_BUCKET"], invite["template"]))
    draw = ImageDraw.Draw(image)

    for text in invite["texts"]:
        [x, y] = text["coordinates"].split(",")
        coordinates = (int(x), int(y))

        color = set_font_color(text["color"])

        font = get_file(os.environ["FONTS_BUCKET"], text["font"])
        font = ImageFont.truetype(font, text["size"])

        draw_text(draw, color, coordinates, text["column_width"], font, text["text"])

    image.save(invite["name"] + '.jpg')
