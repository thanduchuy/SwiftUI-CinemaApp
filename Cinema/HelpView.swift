//
//  HelpView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image("popcorn")
                .resizable()
                .frame(width: 300,height: 300)
            Spacer()
            HStack(spacing: 20) {
                Spacer()
                Image("facebook").resizable().frame(width:40,height:40)
                Image("youtube").resizable().frame(width:40,height:40)
                Image("github").resizable().frame(width:40,height:40)
                Spacer()
            }
            Text("Coppy Right By DucHuy-17CNTT2").font(.callout).foregroundColor(.white)
            Spacer()
        }.padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("Color"), .orange]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
          
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
