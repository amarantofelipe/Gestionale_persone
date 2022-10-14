//
//  ViewModel.swift
//  Firestore
//
//  Created by Felice Marano on 13/10/22.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    
    @Published var list = [Todo]()
    
    func updateData(todoToUpdate: Todo) {
        
//        Riferimento al db
        let db = Firestore.firestore()
        
//        Set data per la modifica con le collections, in questo caso dobbiamo specificare precisamente il documento da voler modificare,       quindi utilizziamo l'id
        
        db.collection("todos").document(todoToUpdate.id).setData(["nome":"Updated:\(todoToUpdate.name)"], merge: true) { error in
            
//            Check error
            if error == nil {
                
                self.getData()
            }
        }
    }
    
    func deleteData(todoToDelete: Todo) {
        
        /*Per l'eliminazione creiamo una nuova funziona che permetterà di gestire questa...
         come sempre otteniamo il riferimento del db come è successo per le altre due funzioni...*/
        
//        Riferimento db
        let db = Firestore.firestore()
        
//        Specifica documento da eliminare
        
        /*Come gia accaduto prendiamo in riferimento la raccolta (o collection)
         per poter eliminare un campo dovremmo utilizzare l'id in quanto univoco...
         quindi, selezioniamo il document -> passiamo il parametro con l'id e specifichiamo l'eliminazione
         se vogliamo solo eliminarlo senza importarci se e andato tutto a buon fine faremo ".delete";
         altrimenti gestiremo un possibile errore facendo ".delete aggiungiendo un component"
         qualora nn ci fosse errore, noi vogliamo eliminarlo direttamente dalla lista e quindi procediamo ad eliminarlo dalla lista*/
        
        db.collection("todos").document(todoToDelete.id).delete { error in
            
            if error == nil {
                
                DispatchQueue.main.async {
                    
//                No error
                    self.list.removeAll { todo in
                                        
//                    Check remove
                    return todo.id == todoToDelete.id
                }
            }
        }
    }
        
}
    
    func addData(nome: String, cognome: String) {
        
//        Riferimento al database
//            Come fatto per il "getData" istanziamo una costante per il Firestore
        
        let db = Firestore.firestore()
        
//        Aggiunta documento alla raccolta
        
        /*Collection sta per la raccolta creata in precedenza sul db e passiamo
         il nome della collection (o raccolta)
         Successivamente con il comando ".addDocument" specifichiamo di aggiungere documenti.
         in "data" -> passiamo i valori da ritornare, nel nostro caso nome
         e cognome; l'id e autogenerato.
         mettiamo i ":" cosi che specifichiamo anche le coppie chiave-valore
         Nel secondo caso gestiamo un possibile errore che possa esserci nell'aggiunta di una valore
         all'interno del db, quindi facciamo in questo modo:
         se l'errore è nullo tutto ok e nn succederà nulla; altrimenti gestiamo l'errore.
         Per poter scrivere eseguiamo la funziona "getData" cosi da riprenderci i valori presenti
         e aggiornare l'interfaccia utenti*/
        
        db.collection("todos").addDocument(data: ["nome":nome, "cognome":cognome]) { error in
            
            if error == nil {
                
//                No error
                self.getData()
                
            } else {
                
//                error
            }
        }
    }
    
    func getData() {
        
//        MARK: Leggere i contenuti da db
        let db = Firestore.firestore()
        
//        MARK: Leggere i documenti da un path specifico
        db.collection("todos").getDocuments { snapshot, error in
            
//            Controllo errori
            if error == nil {
                
//                No error
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        self.list = snapshot.documents.map { d in
                            
                            return Todo(id: d.documentID,
                                        name: d["nome"] as? String ?? "",
                                        cognome: d["cognome"] as? String ?? "")
                        }
                    }
                }
                    
                
            } else {
                
                
            }
        }
    }
}
