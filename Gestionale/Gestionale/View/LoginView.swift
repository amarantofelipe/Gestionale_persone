//
//  LoginView.swift
//  Gestionale
//
//  Created by Felice Marano on 14/10/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @State var userLoggedIn = false
    @State var isShowing = false
    
    var body: some View {
        
        
        if userLoggedIn {
            
            HomeView()
            
        } else {
            
            content
        }
}
    
    var content: some View {
        ZStack {
            
            sfondo()
        
//        MARK: TEXTFIELDS
            
        VStack () {
                
            Text("Gestionale")
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "person.fill")
                    .padding()
                
                TextField("Email", text: $email)
                    .font(Font.system(size: 18))
                    .padding()
                    
            }.frame(width: 300, height: 45)
                .background(RoundedRectangle(cornerRadius: 13)
                .fill(Color.white))
                .foregroundColor(.black)
                .padding()
            
            HStack {
                Image(systemName: "lock.fill")
                    .padding()
                
                SecureField("Password", text: $password)
                    .font(Font.system(size: 18))
                    .padding()
                    
            }.frame(width: 300, height: 45)
            .background(RoundedRectangle(cornerRadius: 13)
            .fill(Color.white))
            .foregroundColor(.black)
            .padding()
                
//            MARK: PARTE DI LOGIN
                Button {
                    
                    login()
                    isShowing.toggle()
                    
                } label: {
                        
                    Text("Accedi")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 40)
                        .background(RoundedRectangle(cornerRadius: 13)
                        .fill(Color.orange))
                    
                }
                .onAppear {
                    Auth.auth().addStateDidChangeListener { auth, user in
                        
                        if user != nil {
                            
                            userLoggedIn.toggle()
                        }
                    }
                }
                
//            MARK: PARTE DELLA REGISTRAZIONE
            HStack {
                
                Text("Non sei ancora registrato?")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.orange)
                    .padding()
                
                Button {
                    
                    isShowing.toggle()
                        
                } label: {
                        
                Text("Registrati")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.orange)
                    .padding()
                
                }.sheet(isPresented: $isShowing, content: {
                    
                    RegistrazioneView()
                })
            }
        }
        } .ignoresSafeArea(.all)
    }

    //    MARK: REGISTRAZIONE
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                
                print(error!.localizedDescription )
            }
        }
    }

    //    MARK: LOGIN
    func login() {
                
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
            if error != nil {
                        
                print(error?.localizedDescription ?? "non accesso")
                        
            } else {
                        
                print("aaa")
                
            }
        }
    }
}

struct sfondo: View {
    var body: some View {
        
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 420)
                .rotationEffect(.degrees(135))
                .offset(y:-350)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 420)
                .rotationEffect(.degrees(135))
                .offset(y:350)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(Color.black)
                .frame(width: 350, height: 350)
                .opacity(1.0)
                .shadow(radius: 60)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
