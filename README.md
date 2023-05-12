```python
# Image URL
image_path: str  =  join(self.app.user_data_dir,"tmp.png")
self.export_to_png(image_path)
# with callback on success
writeURLToPhotoAlbum(image_path, lambda: print("saved url to photolib"))

# without callback on success
writeURLToPhotoAlbum(image_path, None)

  

# Raw Pixels

tex: Texture =  self.tex
pixels  =  tex.pixels
width  =  tex.width
height  =  tex.height

# with callback on success
writePixelsToPhotoAlbum(pixels, width, height, lambda: print("saved pixels to photolib"))

# without callback on success
writePixelsToPhotoAlbum(pixels, width, height, None)
```
