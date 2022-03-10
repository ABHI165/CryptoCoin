//
//  CircularButton.swift
//  Coin
//
//  Created by Abhishek Agarwal on 20/02/22.
//

import SwiftUI

struct CircularButton: View {
    @State private var isClicked = false
    let imageName: String
    let onClicked: () -> Void
    
    var body: some View {
      
        Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding()
                .frame(width: 60, height: 60)
                .background {
                    ZStack {
                        Color.primary.background
                        
                        if isClicked {
                            
                            Circle()
                                .fill(.black)
                                .padding(5)
                                .offset(x: -6, y: -4)
                                .blur(radius: 11)
                                .offset(x: 5, y: 1)
                            
                            Circle()
                                .fill(.white.opacity(0.3))
                               .padding()
                                .blur(radius: 11)
                                .offset(x: 5, y: 6)
                            
                            Circle()
                                .fill(LinearGradient(colors: [.black,.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                               .padding()
                                .blur(radius: 11)
                                .offset(x: 5, y: 6)
                            
                        } else {
                            Circle()
                                .fill(.white.opacity(0.2))
                                .padding()
                                .blur(radius: 32)
                        }
                    }
                }
                .clipShape(Circle())
                .shadow(color: .white.opacity(0.18), radius: 8, x: -3, y: -2)
                .shadow(color: .black.opacity(0.7), radius: 5, x: 5, y: 2)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isClicked = true
                        }.onEnded {_ in
                            isClicked = false
                            onClicked()
                        }
                )
                
                
            
        }
            
        
        
    
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton(imageName: "info", onClicked: {
            
        })
            //.preferredColorScheme(.dark)
            .background(Color.primary.background)
           // .ignoresSafeArea()
            .previewLayout(.sizeThatFits)
    }
}
