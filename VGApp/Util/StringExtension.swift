//
//  StringExtension.swift
//  VGApp
//
//  Created by Kiara on 14.07.23.
//

import Foundation

extension String {
    var localized: String {
      return NSLocalizedString(self, comment: "")
    }
}
