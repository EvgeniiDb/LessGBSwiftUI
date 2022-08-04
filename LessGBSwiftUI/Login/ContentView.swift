//
//  ContentView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 27.07.2022.
//

import SwiftUI
import Combine


struct ContentView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var shouldShowLogo: Bool = true
    
    private let keyboardIsOnPublisher = Publishers.Merge (
        NotificationCenter.default.publisher(for:
            UIResponder.keyboardDidChangeFrameNotification)
                .map { _ in true },
        NotificationCenter.default.publisher(for:
            UIResponder.keyboardWillHideNotification)
        .map { _ in false }
        )
        .removeDuplicates()
    
    var body: some View {
        VStack {
            
            ScrollView {
            
                Image("VK")
                        
            HStack {
                Text("Login:")
                Spacer()
                TextField("Login", text: $login)
                    .frame(maxWidth: 200)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .frame(maxWidth: 300)
            
            HStack {
                Text("Password:")
                Spacer()
                SecureField("Password", text: $password)
                    .frame(maxWidth: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .frame(maxWidth: 300)
            .padding(.top, 25)
            
            Button(action: { print("Hello") }) {
                Text("Enter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .lineLimit(/*@START_MENU_TOKEN@*/15/*@END_MENU_TOKEN@*/)
                    
            }
            .padding(.top, 50)
            .padding(.bottom, 20)
            .disabled(login.isEmpty || password.isEmpty)
            
            ZStack {
                GeometryReader { geometry in
                    Image("")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                }
                .background(Color(red: 0.129, green: 0.533, blue: 0.959))
            }
            
            
            Button(action: { print("Reg") }) {
                Text("Registration")
                    .foregroundColor(Color.black)
            }
            .padding(.top, 5)
            .padding(.bottom, 10)
            .disabled(login.isEmpty || password.isEmpty)
            
            }
            
            .onReceive(keyboardIsOnPublisher) { isKeyboardKeyOn in
                withAnimation(Animation.easeInOut(duration:  0.5)) {
                    self.shouldShowLogo = !isKeyboardKeyOn
                }
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
            
        .background(Color(red: 0.129, green: 0.533, blue: 0.959))
        }
     
    }

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDevice("iPhone 13 Pro")
        }
    }
}
