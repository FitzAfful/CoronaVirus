//
//  UIImageView+Extension.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 06/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func setImage(string: String) {
        if let url = URL(string: string) {
            setImage(url: url)
        }
    }

    func setImage(url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}

