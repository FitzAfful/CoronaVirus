//
//  UIButton+Extension.swift
//  CoronaVirus
//
//  Created by Fitzgerald Afful on 06/04/2020.
//  Copyright © 2020 Fitzgerald Afful. All rights reserved.
//

import UIKit

@IBDesignable
class LeftAlignedIconButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}
