//
//  UIImageExtensions.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 30/01/2022.
//

import UIKit

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
