//
//  Extension.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/24.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

extension String {
    func textSize(_ fontSize: CGFloat, _ fontWeight: UIFont.Weight) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize, weight: fontWeight)])
    }
}
