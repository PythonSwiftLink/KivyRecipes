from swift_tools.swift_types import *



def getDocumentsDirectory() -> URL: ...

def writeURLToPhotoAlbum(url: URL, success: object): ...

def writePixelsToPhotoAlbum(data: data, width: int, height: int, success: object): ...

# @wrapper
# class SavePixels(NSObject):

#     def writeToPhotoAlbum(self, url: str, succes: callable[[bool],None], error: callable[[Error],None]): ...