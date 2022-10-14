//
//  ContentView.swift
//  Firestore
//
//  Created by Felice Marano on 13/10/22.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var nome = ""
    @State var cognome = ""
    
    var body: some View {
        
        
        LoginView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
