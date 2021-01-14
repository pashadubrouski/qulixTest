//
//  UIImageView+.swift
//  QulixTest
//
//  Created by Павел Дубровский on 14.01.21.
//  Copyright © 2021 Павел Дубровский. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageWithUrl(_ url: URL) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
