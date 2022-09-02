//
//  LoginView.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 27.07.2022.
//

import SwiftUI
import Combine


struct LoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var shouldShowLogo: Bool = true
    
    @State private var alertIsShown: Bool = false
    @State private var showIncorrentCredentialsWarning = false
    
    
    @State var showMainScreen: Bool = false
    //@State var isLoggedIn = false
    @Binding var isLoggedIn: Bool
    
    @State private var mainIsShow = false
    
//    private func buttonAction() {
//        mainIsShow = true
//    }
    
    private func verifyLoginData() {
        if login == "Zzz" && password == "111" {
            isLoggedIn = true
        } else {
            alertIsShown = true
        }
//        //сброс пароля
//        password = ""
       
    }
    
    
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
        
//        VStack {
//        if isLoggedIn {
//            MainScreen()
//        } else {
//            LoginView(isLoggedIn: $isLoggedIn)
//            }
//        }
        
        HStack {
            
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
                passwordInput
            }

            
            Button(action: verifyLoginData) {
                Text("Log in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .lineLimit(15)
            }
            .padding(.top, 50)
            .padding(.bottom, 20)
            .disabled(login.isEmpty || password.isEmpty)
            .alert(isPresented: $alertIsShown) {
                Alert(title: Text("Error"),
                      message: Text("Incorrect Login/Password was entered"),
            dismissButton: .default(Text("OK"))
                    )
            }

                ZStack {
                    
                    GeometryReader { geometry in
                        Image("")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: geometry.size.width)
                                   
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
            
            }
        
        
        
            .onReceive(keyboardIsOnPublisher) { isKeyboardKeyOn in
                withAnimation(Animation.easeInOut(duration:  0.5)) {
                    self.shouldShowLogo = !isKeyboardKeyOn
                }
        
    }.onTapGesture {
            UIApplication.shared.endEditing()
        }

        .background(Color(red: 0.129, green: 0.533, blue: 0.959))
        
        
    }
    
}


private extension LoginView {
    var passwordInput: some View {
        HStack {
            Text("Password:")
            Spacer()
            SecureField("Password", text: $password)
                .frame(maxWidth: 200)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .frame(maxWidth: 300)
        .padding(.top, 25)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(isLoggedIn: .constant(false))
//            LoginView(isLoggedIn: .constant(true))
//                .preferredColorScheme(.dark)
//                .previewInterfaceOrientation(.landscapeLeft)
//                .previewDevice("iPhone 13 Pro")
            }
        }
    }


