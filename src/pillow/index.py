#!/usr/bin/python
#-*- coding: utf-8 -*-

import os
import json
import sys
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def get_file(uri, name):
    """Obtiene un archivo por medio de una URI.

    Args:
        uri (str): URI del bucket.
        name (str): Nombre del archivo.

    Returns:
        StringIO: Template de la invitación.
    """

    return cStringIO.StringIO(urllib.urlopen(uri + name).read())

def set_font_color(color):
    """Convierte una cadena hexadecimal en un color RGB.

    Args:
        color (str): Color hexadecimal.

    Returns:
        tuple: tupla de int con valores RGB.
    """

    return tuple(int(color.lstrip('#')[i:i+2], 16) for i in (0, 2 ,4))

def multiline_text(text, number_char):
    """Añade saltos de linea al texto.

    Args:
        text (str): Texto para dibujar.
        number_char (int): Número de caracteres por párrafo.

    Returns:
        str: Texto con saltos de linea.
    """

    i = 0
    multiline_text = ""

    while i <= len(text):
        multiline_text += text[i:number_char] + "\n"

        i += number_char
        number_char += number_char

    return multiline_text

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

        text["text"] = multiline_text(text["text"], text["number_char"])

        draw.multiline_text(coordinates, text["text"], fill=color, font=font,
                        anchor=None, spacing=text["spacing"], align=text["align"])

    image.save(invite["name"] + '.jpg')
