//
//  ContentView.swift
//  IOS-Project
//
//  Created by admin on 4/26/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            
            //Dynamic screen variables
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            VStack(alignment: .center) {
                Text("World Controller")
               
                Image("upArrow")
                    .onTapGesture {
                        Task{
                            await apiRequest(endpoint:"moveForward")
                        }
                    }
                
                HStack(spacing: screenWidth/4){
                    Image("leftArrow")
                    .onTapGesture {
                        Task{
                            await apiRequest(endpoint:"turnLeft")
                        }
                    }
                    Image("rightArrow")
                    .onTapGesture {
                        Task{
                            await apiRequest(endpoint:"turnRight")
                        }
                    }
                }
                .padding(20)
                
                Image("downArrow")
                    .onTapGesture {
                        Task{
                            await apiRequest(endpoint:"moveBackward")
                        }
                }
            }
            .padding()
            .frame(width: screenWidth, height:screenHeight)
        }
    }
}

#Preview {
    ContentView()
}
