//
//  IntroView.swift
//  WaterReminder
//
//  Created by Ammar Ahmed on 04/11/1445 AH.
//

import SwiftUI

struct IntroView<ActiveView:View>:View {
    @EnvironmentObject var nlManger:NotificationLocalManager
    
    @Binding var inro:PageIntro
    var size:CGSize
    var activeView :ActiveView
    
    init(inro: Binding<PageIntro>, size: CGSize, @ViewBuilder activeView: @escaping() -> ActiveView) {
        self._inro = inro
        self.size = size
        self.activeView = activeView()
    }
    
    @State private var showView:Bool = false
    @State private var hideHoolView:Bool = false
    
    var body: some View{
        VStack{
            GeometryReader { geometry in
                Image(inro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .offset(y:showView ? 0 :-size.height/2)
            .opacity(showView ? 1 : 0)
            
            VStack(alignment: .leading,spacing: 10){
                Spacer(minLength: 0)
                Text(inro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .foregroundStyle(.p1)
                
                Text(inro.subTitle)
                    .font(.caption)
                    .foregroundStyle(.sText)
                    .padding(.top,15)
                
                if !inro.dispaysActions {
                    Group{
                        Spacer(minLength: 25)
                        
                        CustomIndicatorView(totalPages: filterPages.count, currentPage: filterPages.firstIndex(of: inro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button{
                            if inro.introAssetImage == "image4"{
                                Task{
                                    try? await nlManger.requestAuthorization()
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
            if inro != pagesIntro.first{
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
            if let index = pagesIntro.firstIndex(of: inro),(isPrevious ? index != 0 : index != pagesIntro.count - 1 ){
                inro = isPrevious ? pagesIntro[index - 1] : pagesIntro[index + 1]
            }else{
                inro = isPrevious ? pagesIntro[0] : pagesIntro[pagesIntro.count - 1]
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
