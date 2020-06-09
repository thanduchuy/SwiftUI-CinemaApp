//
//  Indicator.swift
//  Cinema
//
//  Created by MacBook Pro on 3/31/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    func updateUIView(_ uiView:  UIActivityIndicatorView , context: UIViewRepresentableContext<Indicator>) {
        
    }
}
