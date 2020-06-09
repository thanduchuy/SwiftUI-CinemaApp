//
//  ActivityView.swift
//  Cinema
//
//  Created by MacBook Pro on 4/5/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ActivityView: View {
    
    @EnvironmentObject var activity : ActivitySevice
    var body: some View {
        NavigationView {
            VStack {
                ItemActivity(data: Binding<[Activity]>.constant(self.activity.data))
            }.padding()
            .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Activity")
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
