//
//  History UI.swift
//  CT.0
//
//  Created by Raymond Eliorda on 2/6/2024.
//

import SwiftUI

struct History_UI: View {
    var body: some View {
        
        
        @State var currentCalories:Int = 0
        @State var calorieGoal:Int = 0
        
        ZStack {
            Color(.systemFill)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 120.0) {
                Image("history template")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                HStack {
                    Text("Calories")
                        .font(.largeTitle)
                        .fontWeight(.bold)
//                    Spacer()
//                    VStack {
//                        HStack{
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.fill")
//                            Image(systemName: "star.leadinghalf.filled")
//                        }
//                        Text("Reviews")
//                    }
//                    .foregroundColor(.orange)
//                    .font(.caption)
//                    Spacer()
                }
                Text("Meal name")
                HStack {
                    Spacer()
                    Image(systemName:"fork.knife")
                    Image(systemName: "star.circle.fill")
                }
                .foregroundColor(.yellow)
                .font(.caption)
                
                        }
            .padding()
            .background(Rectangle()
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius:15))
            .padding()
        }
    }
}

#Preview {
    History_UI()
}
