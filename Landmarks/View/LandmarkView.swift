//
//  ContentView.swift
//  Landmarks
//
//  Created by Md Fahim Faez Abir-00127 on 28/6/24.
//

import SwiftUI

struct LandmarkView: View {
    let jsonHandler = JsonHandler.shared
    @State var landmarks = [Landmarks]()
    @State var isLandmarkNotAvailable: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                List(landmarks) { landmark in
                    LandMarkListView(landmark: landmark)
                }
            }
            .onAppear {
                Task {
                    if let landmarkData = await jsonHandler.getData() {
                        switch(landmarkData) {
                        case .success(let _landmarks):
                            landmarks = _landmarks
                            dump(landmarks)
                        case .failure(_):
                           isLandmarkNotAvailable = true
                        }
                    } else {
                        isLandmarkNotAvailable = true
                    }
                }
            }.overlay(content: {
                if isLandmarkNotAvailable {
                    ContentUnavailableView(label: {
                        Label("No Landmark available", systemImage:  "multiply.circle.fill")
                            .foregroundStyle(.red)
                    })
                }
            })
            .navigationTitle("Landmarks")
        }
    }
}

#Preview {
    LandmarkView()
}

