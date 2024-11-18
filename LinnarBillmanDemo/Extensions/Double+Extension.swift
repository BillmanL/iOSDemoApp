//
//  Double+Extension.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import SwiftUI

extension Double {
    var ratingColor: Color {
        if self < 4 {
            return .red
        } else if self < 8 {
            return .yellow
        } else {
            return .green
        }
    }
}
