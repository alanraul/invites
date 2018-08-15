#!/usr/bin/python
#-*- coding: utf-8 -*-

import os
import json
import sys
import urllib, cStringIO

from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw


def add_spaces(text, number_char, align):
    """Añade espacios al texto para centrarlo.

    Args:
        text (str): Texto para dibujar.
        number_char (int): Número de caracteres por párrafo.
        align (str): Tipo de alineación.

    Returns:
        str: Texto con espacios a los lados.
    """

    white_spaces = len(text)

    if align == "center":
        white_spaces = len(text) + (number_char - len(text))

    return text.center(white_spaces)

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

def multiline_text(text, number_char, align):
    """Añade saltos de linea al texto.

    Args:
        text (str): Texto para dibujar.
        number_char (int): Número de caracteres por párrafo.
        align (str): Tipo de alineación.

    Returns:
        str: Texto con saltos de linea.
    """

    multiline_text = ""
    paragraph = ""
    counter = 0

    last_word = len(text.split(" "))
    words = text.split(" ")

    for i in range(0, len(words)):
        len_chars = len(words[i] + " ") + counter

        if len_chars < number_char:
            paragraph += words[i] + " "
            counter = len(paragraph)

        elif last_word == i+1 and paragraph != "":
            multiline_text += add_spaces(paragraph.rstrip(), number_char, align) + "\n"
            multiline_text += add_spaces(words[i], number_char, align)

            paragraph = ""
            counter = 0

        if len_chars > number_char and i+1 != last_word:
            multiline_text += add_spaces(paragraph.rstrip(), number_char, align) + "\n"
            paragraph = ""
            counter = 0
        if len_chars < number_char and last_word == i+1:
            multiline_text += add_spaces(paragraph.rstrip(), number_char, align)

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

        text["text"] = multiline_text(text["text"], text["number_char"], text["align"])

        draw.multiline_text(coordinates, text["text"], fill=color, font=font,
                        anchor=None, spacing=text["spacing"], align=text["align"])

    image.save(invite["name"] + '.jpg')
