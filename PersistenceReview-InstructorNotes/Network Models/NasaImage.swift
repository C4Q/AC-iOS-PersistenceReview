//
//  NasaImage.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/2/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

struct NasaImage: Codable {
    let title: String
    let url: String
}

struct NasaAPIClient {
    private init(){}
    static let shared = NasaAPIClient()
    func getNasaImage(from urlStr: String,
                   completionHandler: @escaping (NasaImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let newImage = try JSONDecoder().decode(NasaImage.self, from: data)
                UserDefaultsHelper.manager.incrementNumberOfLoadedImages()
                FileManagerHelper.manager.addNew(newNasaImage: newImage)
                completionHandler(newImage)
            }
            catch {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
