# Python script (Dibujar un texto en images)

## Crea y activa el entorno virtual

```shell
virtualenv venv
source venv/bin/activate
```

## Instala las librerias
```shell
pip install -r requirements.txt
```

## Ejecuta el script

python index.py [image] [fuente] [font_size] [font_color] [coordenadas] [textos] [line_width] [nombre imagen]

```shell
python index.py "https://bit.ly/2MkrH34" "https://bit.ly/2ttkV42" "18" \
  "0,0,0" "{\"coordinates\":[\"40,220\"]}" "{\"texts\":[\"Hola xD\"]}" "20" "output"
```
