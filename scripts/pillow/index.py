#!/usr/bin/python
#-*- coding: utf-8 -*-

import json
import sys
import textwrap
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def get_file(uri):
    return cStringIO.StringIO(urllib.urlopen(uri).read())

def set_font_color(color):
    [r, g, b] = color.split(",")
    return (int(r), int(g), int(b))

def set_coordinates(coordinates):
    list = []

    for c in coordinates:
        [x, y] = c.split(",")
        list.append({"x": int(x), "y": int(y)})

    return list

def draw_text(draw, color, coordinates, font, text):
    for line in textwrap.wrap(text, width=int(sys.argv[7])):
        draw.text((coordinates["x"], coordinates["y"]), line, fill=color, font=font)
        coordinates["y"] += font.getsize(line)[1]

    return draw

if __name__ == '__main__':
    image = Image.open(get_file(sys.argv[1]))

    font = ImageFont.truetype(get_file(sys.argv[2]), int(sys.argv[3]))

    color = set_font_color(sys.argv[4])
    coordinates = set_coordinates(json.loads(sys.argv[5])["coordinates"])
    counter = 0

    draw = ImageDraw.Draw(image)

    for t in json.loads(sys.argv[6])["texts"]:
        draw = draw_text(draw, color, coordinates[counter], font, t)
        counter += 1

    image.save(sys.argv[8] + '.jpg')
