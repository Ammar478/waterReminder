//
//  IntroView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 04/11/1445 AH.
//

import SwiftUI

struct IntroView<VM:PersonalViewModal, ActiveView:View>:View {
    @EnvironmentObject var nlManger:NotificationLocalManager
    @State var viewModel:VM
    
    var size:CGSize
    var activeView :ActiveView
  
    
    init( viewModel:VM,size: CGSize, @ViewBuilder activeView: @escaping() -> ActiveView) {
        self._viewModel = .init(initialValue: viewModel)
        self.size = size
        self.activeView = activeView()
    }
    
    @State private var showView:Bool = false
    @State private var hideHoolView:Bool = false
    
    var body: some View{
        VStack{
            GeometryReader { geometry in
                Image(viewModel.activeIntor.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .offset(y:showView ? 0 :-size.height/2)
            .opacity(showView ? 1 : 0)
            
            VStack(alignment: .leading,spacing: 10){
                Spacer(minLength: 0)
                Text(viewModel.activeIntor.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundStyle(.p1)
                
                Text(viewModel.activeIntor.subTitle)
                    .font(.caption)
                    .foregroundStyle(.sText)
                    .padding(.top,15)
                
                if !viewModel.activeIntor.dispaysActions {
                    Group{
                        Spacer(minLength: 25)
                        
                        CustomIndicatorView(totalPages: filterPages.count, currentPage: filterPages.firstIndex(of: viewModel.activeIntor) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button{
                            if viewModel.activeIntor.introAssetImage == "image4"{
                                Task{
                                    await nlManger.requestAuthorization()
                                    changeInrto()
                                }
                            } else{
                                changeInrto()
                            }
                        }label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical,15)
                                .background{
                                    Capsule()
                                        .fill(.pointer)
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }else{
                    activeView
                        .offset(y:showView ? 0 :size.height/2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .offset(y:showView ? 0 :size.height/2)
            .opacity(showView ? 1 : 0)
        }
        .offset(y:hideHoolView ? size.height/2 : 0 )
        .opacity(hideHoolView ? 0 : 1)
        
        .overlay(alignment:.topLeading){
            if viewModel.activeIntor != pagesIntro.first{
                Button{
                    changeInrto(true)
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.pointer)
                        .fontWeight(.semibold)
                        .contentShape(Rectangle())
                }
                .padding(10)
                .offset(y:showView ? 0 :-200 )
                .offset(y:hideHoolView ? -200 : 0)
            }
        }
        .onAppear{
            withAnimation(.spring(response: 0.8,dampingFraction: 0.8,blendDuration: 0).delay(0.1)){
                showView = true
            }
        }
    }
    
    func changeInrto(_ isPrevious:Bool = false){
        withAnimation(.spring(response: 0.8,dampingFraction: 0.8,blendDuration: 0)){
            hideHoolView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            if let index = pagesIntro.firstIndex(of: viewModel.activeIntor),(isPrevious ? index != 0 : index != pagesIntro.count - 1 ){
                viewModel.activeIntor = isPrevious ? pagesIntro[index - 1] : pagesIntro[index + 1]
            }else{
                viewModel.activeIntor = isPrevious ? pagesIntro[0] : pagesIntro[pagesIntro.count - 1]
            }
            
            hideHoolView = false
            showView = false
            
            withAnimation(.spring(response: 0.8,dampingFraction: 0.8,blendDuration: 0)){
                showView = true
            }
        }
        
    }
    
    var filterPages:[PageIntro]{
        return pagesIntro.filter{!$0.dispaysActions}
    }
}
