//
//  FileManagerWorker.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 01/02/2022.
//

import UIKit


class FileManagerWorker {

  func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
      let documentsDirectory = paths[0]
      return documentsDirectory
  }

  func fetchImage(fileName: String) -> String {

    let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(fileName)

    return imagePath

  }

  func saveImage(image: UIImage) {

      // get the documents directory url
      let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      // choose a name for your image
      let fileName = "userPick.jpg"
      // create the destination file url to save your image
      let fileURL = documentsDirectory.appendingPathComponent(fileName)
      // get your UIImage jpeg data representation and check if the destination file url already exists
      if let data = image.jpegData(compressionQuality:  1.0) {
        do {
          // writes the image data to disk
          try data.write(to: fileURL)
          print("file saved")
        } catch {
          print("error saving file:", error)
        }
      }


  }

}
