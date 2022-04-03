//
//  ViewModel.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/03.
//

import Foundation
import UIKit

class ViewModel {
    var modelArr = [Model]()
    var imageArr = [UIImage]()

    private var isDownloading = false
    private var cachedImg: UIImage?
    private var callback: ((UIImage?) -> Void)?
    
    init() {
        for i in 0..<100 {
            let size = Int.random(in: 100...300)
            let model = Model(urlStr: "https://source.unsplash.com/random/\(size)x\(size)")
            
            modelArr.append(model)
//            self.downloadImage(row: i) { [weak self] image in
//                DispatchQueue.main.async {
//                    self!.imageArr.append(image!)
//                }
//            }
//            { [weak self] image in
//                DispatchQueue.main.async {
//                    self!.imageArr.append(image!)
//                }
//            }
        }
    }
    //,
    func downloadImage(row: Int, completion: ((UIImage?) -> Void)?) {
        
        if let image = cachedImg {
            self.imageArr.append(image)
            completion?(image)
            return
        }
        guard !isDownloading else {
            callback = completion
            return
        }
        isDownloading = true
                
        let task = URLSession.shared.dataTask(with: modelArr[row].url) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                guard let img = UIImage(data: data) else { return }
                self.cachedImg? = img
                self.imageArr.append(img)
                self.callback?(img)
                self.callback = nil
                completion?(img)
            }
        }
    
        task.resume()
    }
        
}
