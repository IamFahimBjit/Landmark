//
//  LandMarkListView.swift
//  Landmarks
//
//  Created by Md Fahim Faez Abir-00127 on 28/6/24.
//

import SwiftUI

struct LandMarkListView: View {
    let landmark: Landmarks
    var body: some View {
        ZStack {
            Image(landmark.imageName ?? "")
                .resizable()
                .frame(height: 100)
                .cornerRadius(10)
            HStack {
                VStack(alignment: .leading) {
                    Text(landmark.name ?? "")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                    Text(landmark.subtitle ?? "")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                }
                Spacer()
            }.padding(10)
        }
    }
}

#Preview {
    LandMarkListView(landmark: Landmarks(name: "landmark 1", id: 100, subtitle: "demolandMark", imageName: "rainbowlake"))
}
