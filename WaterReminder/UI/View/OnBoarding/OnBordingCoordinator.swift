//
//  OnBordingView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 03/11/1445 AH.
//

import SwiftUI

final class OnBordingCoordinator:Coordinator {
    let storage: LocalStorage
    let api: API
    
    init(storage: LocalStorage, api: API) {
        self.storage = storage
        self.api = api
    }
    
    func rootView() -> some View {
        GeometryReader{
            let size = $0.size
            let viewModel = _PersonalViewModal(
                localStorage: self.storage,
                api: self.api,
                activeIntor:pagesIntro[0]
            )
            
            IntroView(viewModel:viewModel, size: size){
                PersonalInfoView(viewModel: viewModel)
            }
        }
        .padding()
        .customBackground()
    }  
}
