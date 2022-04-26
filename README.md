# Tiled-JSON-to-Godot

script for loading tiled json files into godot at runtime

still wip btw

you can help if you want ig


## NOT SUPPORTED:

- embeded maps

- image layers

- groups

- more than 1 tileset

- more than 1 collection of images tileset


youll have to edit the tiled.gd for adding other objects in an object layer


## how to use

1)make a map in tiled

2)save it as a JSON

3)make a tileset in godot 

4)make the image the same one you used to make the map in tiled

5)make it an atlas texture and make it the same size as the image

5.5) if you're using a collection of images tileset in your map add the images you used to the same tileset file and make each one a single tile the same size as the image

6)copy the paths to both the tileset you made in godot and the json file and paste each one in "tileset1Path" and "mapPath"

7)run

