//
//  HomeView.swift
//  Firestore
//
//  Created by Felice Marano on 14/10/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State private var isShowing = false
    @State private var isShowingUtenti = false
    
    @State private var logOut = false
    
    @State var nome = ""
    @State var cognome = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("Gestionale")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Spacer()
                
                Button {
                    
                    isShowing.toggle()
                    
                } label: {
                    
                    Image(systemName: "gear")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }.sheet(isPresented: $isShowing) {
                    
                    HStack {
                        
                        Button {

                            logoutUser()
                                
                        } label: {
                            
                            Text("Log out")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        didDismiss()
                            .onAppear {
                                Auth.auth().addStateDidChangeListener { auth, user in
                                    
                                    if user != nil {
                                        
                                        logOut.toggle()
                                    }
                                }
                            }
                    }
                }

                
                    
            }.padding()
            
            List (model.list) { item in
                
                HStack {
                    Text(item.name)
                    Text(item.cognome)
                    
                    Spacer()
                    
                    Button {
                        
                        model.updateData(todoToUpdate: item)
                        
                    } label: {
                        
                        Image(systemName: "pencil")
                        }.buttonStyle(BorderedButtonStyle())
                    
                    Button {
                        
                        model.deleteData(todoToDelete: item)
                    } label: {
                        
                        Image(systemName: "minus.circle")
                    }.buttonStyle(BorderedButtonStyle())
                }
            }
            
            HStack {
                
                Spacer()
                
                Button {
                    
                    isShowingUtenti.toggle()
                    
                } label: {
                    
                    Image(systemName: "plus")
//                        .font(.title)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                    
                }.sheet(isPresented: $isShowingUtenti) {
                    
                    VStack(spacing: 6) {
                        
                        HStack {
                            
                            Text("Aggiunta utenti")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding()
                            
                            Spacer()
                            
                            didDismiss()
                        }.padding()
                        
                        Spacer()
                     
                        TextField("Nome", text: $nome)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        TextField("Cognome", text: $cognome)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Spacer()
                        Button {
                            
//                Aggiungiamo il modello che aggiunge i dati
//                passando i rispettivi parametri chiave-valore impostati prima
                            
                            model.addData(nome: nome, cognome: cognome)
                            
//                Aggiungiamo che successivamente l'inserimento si cancellino i form
                            
                            nome = ""
                            cognome = ""
                            
                        } label: {
                            
                            HStack {
                                Text("Aggiungi utente")
                                Image(systemName: "person.fill")
                            }
                        }
                    }
                    Spacer()
                    .padding()
                }
            }.padding()
        }
        
        
    }
    
    init() {
        model.getData()
    }
    
    func logoutUser() {
        // call from any screen
        
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
       
    }
    
}


struct didDismiss: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        Button("Chiudi") {
            dismiss()
        }
        .font(.title3)
        .padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
