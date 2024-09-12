//
//  Extension1.swift
//  GuideBuddy
//
//  Created by Deivson Pereira da Silva on 10/09/24.
//

import Foundation
import SwiftUI

extension View {
    func blurredSheet<Content: View>(_ style:AnyShapeStyle, show: Binding<Bool>, onDismiss:
                                     @escaping()->(), @ViewBuilder content: @escaping ()->Content)-> some View{
        self
            .sheet(isPresented: show, onDismiss: onDismiss) {
                content()
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background{
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    }
                
            }
    }
}


                                 
