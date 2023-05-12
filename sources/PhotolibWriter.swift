//
//  UIImage+PyPointer.swift
//  gallery
//
//  Created by MusicMaker on 08/05/2023.
//

import Foundation
import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

let srgbColorSpaceRef: CGColorSpace = .init(name: CGColorSpace.sRGB)!

func imageFromPixelValues(pixelValues: Data, width: Int, height: Int, bytesPerPixel: Int = 4) -> CGImage? {
    //assert(pixelValues.count == width * height * 4)
    guard let providerRef = CGDataProvider(data: pixelValues as NSData) else { return nil }
    let bitsPerComponent = 8
    let bitsPerPixel = bytesPerPixel * bitsPerComponent
    let bytesPerRow = bytesPerPixel * width
    let totalBytes = height * bytesPerRow
    
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)
    
    let imageRef = CGImage(
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bitsPerPixel: bitsPerPixel,
        bytesPerRow: bytesPerRow,
        space: srgbColorSpaceRef,
        bitmapInfo: bitmapInfo,
        provider: providerRef,
        decode: nil,
        shouldInterpolate: false,
        intent: CGColorRenderingIntent.defaultIntent
    )
    return imageRef
}

func writeURLToPhotoAlbum(url: URL, success: PyPointer) {
    if let data = try? Data(contentsOf: url) {
        PhotoLibWriter().writeToPhotoAlbum(data: data, success: success.isNone ? nil : success)
    }
}

func writePixelsToPhotoAlbum(data: Data, width: Int, height: Int, success: PyPointer) {
    if let image = imageFromPixelValues(pixelValues: data, width: width, height: height) {
        PhotoLibWriter().writeToPhotoAlbum(image: .init(cgImage: image), success: success.isNone ? nil : success)
    } else { PyErr_SetString(PyExc_MemoryError, "writePixelsToPhotoAlbum failed") }
    
    
    
}

class PhotoLibWriter: NSObject {
    //static let shared = PhotoLibWriter()
    var successHandler: PyPointer? {
        get { _successHandler }
        set {
            if let newValue = newValue {
                _successHandler = newValue.xINCREF
            }
        }
    }
    var _successHandler: PyPointer? = nil
    var errorHandler: ((Error) -> Void)
    
    override init() {
        
        errorHandler = { err in
            PyErr_SetString(PyExc_MemoryError, "writeURLToPhotoAlbum - \(err.localizedDescription)")
        }
    }
    
    deinit {
        if let _successHandler = _successHandler {
            withGIL {
                _successHandler.decref()
            }
            
        }
    }
    
    func writeToPhotoAlbum(data: Data, success: PyPointer?) {
        successHandler = success
        if let ui_image = UIImage(data: data) {
            writeToSavedPhotosAlbum(image: ui_image)
        } else {
            errorHandler(PythonError.memory("UIImage pixel data Error"))
        }
        
    }
    
    func writeToPhotoAlbum(image: UIImage, success: PyPointer?) {
        successHandler = success
        writeToSavedPhotosAlbum(image: image)
        
    }
    
    func writeToDocuments(pixels: Data, success: PyPointer?) {
        successHandler = success
        
        guard let ui_image = UIImage(data: pixels), let ui_data = ui_image.pngData() else {
            errorHandler(PythonError.memory("UIImage pixel data Error"))
            return
        }
        try? ui_data.write(to: getDocumentsDirectory() )
    }
    
    
    
    func writeToSavedPhotosAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler(error)
        } else {
            if let successHandler = successHandler {
                withGIL {
                    try? successHandler() as Void
                }
            }
            
        }
    }
}
