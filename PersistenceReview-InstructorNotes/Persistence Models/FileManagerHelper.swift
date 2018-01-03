//
//  FileManagerHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

protocol Foo {
    func bar() -> ()
}

class FileManagerHelper {
    private init() {}
    let nasaImagesPath = "allNasaImages.plist"
    static let manager = FileManagerHelper()
    
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func getImage(with urlStr: String) -> UIImage? {
        do {
            let imagePathName = urlStr.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private var nasaImages = [NasaImage]() {
        didSet {
            print(nasaImages)
            removeDupes()
            saveImages()
        }
    }
    
    func removeDupes() {
        var imageURLSet = Set<String>()
        var noDupeArr = [NasaImage]()
        for image in nasaImages {
            let (inserted, _) = imageURLSet.insert(image.url)
            if inserted {
                noDupeArr.append(image)
            }
        }
        if nasaImages.count != noDupeArr.count { nasaImages = noDupeArr }
    }
    
    func addNew(newNasaImage: NasaImage) {
        nasaImages.append(newNasaImage)
    }
    func getAllNasaImages() -> [NasaImage] {
        return nasaImages
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(nasaImages)
            let phoneURL = dataFilePath(withPathName: nasaImagesPath)
            try encodedData.write(to: phoneURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let phoneURL = dataFilePath(withPathName: nasaImagesPath)
            let encodedData = try Data(contentsOf: phoneURL)
            let savedImages = try propertyListDecoder.decode([NasaImage].self, from: encodedData)
            nasaImages = savedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //USE THIS ONE
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    //THIS IS ONLY FOR THE ABOVE METHOD
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
