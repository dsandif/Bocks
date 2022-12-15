//
//  ImageLoader.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/16/21.
//

import Foundation
import SwiftUI

let imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader: ObservableObject {
  private var task: URLSessionDataTask?

  @Published var data: Data?

  init(_ url: URL) {
    task = URLSession.shared.dataTask(with: url) { data, _, _ in
      if let data = data, let imageToCache = UIImage(data: data) {
        imageCache.setObject(imageToCache, forKey: url as AnyObject)
      }
      DispatchQueue.main.async { self.data = data }
    }
    task?.resume()
  }

  deinit {
    task?.cancel()
  }
}


let imagePlaceholder = UIImage(systemName: "person.crop.circle.fill")

struct URLImage: View {
  @ObservedObject private var imageLoader: ImageLoader
  private let url: URL

  init(url: URL) {
    self.url = url
    self.imageLoader = ImageLoader(url)
  }

  var image: UIImage? {
    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      return imageFromCache
    }

    return imageLoader.data.flatMap(UIImage.init)
  }

  var body: Image {
    Image(uiImage: (image ?? imagePlaceholder)!)
  }
}
