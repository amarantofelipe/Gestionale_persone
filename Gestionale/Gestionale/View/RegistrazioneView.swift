//
//  RegistrazioneView.swift
//  Gestionale
//
//  Created by Felice Marano on 14/10/22.
//

import SwiftUI
import Firebase

struct RegistrazioneView: View {
    
    @State var email = ""
    @State var password = ""
    @State var userLoggedIn = false
    @State var isShowing = false
    
    var body: some View {
        
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
                
                TextField("Inserisci mail", text: $email)
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
                
                SecureField("Inserisci la assword", text: $password)
                    .font(Font.system(size: 18))
                    .padding()
                    
            }.frame(width: 300, height: 45)
            .background(RoundedRectangle(cornerRadius: 13)
            .fill(Color.white))
            .foregroundColor(.black)
            .padding()
                
             
            Button {
                
                register()
                
            } label: {
                
                Text("Registrati")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 130, height: 40)
                    .background(RoundedRectangle(cornerRadius: 13)
                    .fill(Color.orange))
            }

            
            }
        } .ignoresSafeArea(.all)
        
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                
                print(error!.localizedDescription ?? "Non registrato")
            }
        }
    }
}

struct RegistrazioneView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrazioneView()
    }
}
