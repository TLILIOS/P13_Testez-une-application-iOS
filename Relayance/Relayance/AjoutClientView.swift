//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI
import Foundation

struct AjoutClientView: View {
    @ObservedObject var viewModel: ClientViewModel
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    @State private var showDuplicateEmailError: Bool = false
    @State private var showEmailFormatError: Bool = false
    
    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            
            // Champ Nom
            TextField("Nom", text: $nom)
                .font(.title2)
                .padding(.vertical, 8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Champ Email
            TextField("Email", text: $email)
                .font(.title2)
                .padding(.vertical, 8)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            // Message d'erreur pour format d'email invalide
            if showEmailFormatError {
                Text("Format d'email invalide")
                    .foregroundColor(.red)
                    .font(.callout)
                    .padding(.top, 4)
            }
            
            // Message d'erreur pour email déjà existant
            if showDuplicateEmailError {
                Text("Un client avec cet email existe déjà")
                    .foregroundColor(.red)
                    .font(.callout)
                    .padding(.top, 4)
            }
            
            // Bouton d'ajout
            Button(action: {
                // Réinitialiser les messages d'erreur
                showDuplicateEmailError = false
                showEmailFormatError = false
                
                // Validation locale du format d'email
                if !isValidEmail(email) {
                    showEmailFormatError = true
                    return
                }
                
                // Utilisation du ViewModel pour ajouter un client
                let result = viewModel.addClient(nom: nom, email: email)
                
                // Si l'ajout a échoué, c'est un email dupliqué
                if !result {
                    showDuplicateEmailError = true
                } else {
                    // Fermer la modale uniquement si l'ajout a réussi
                    dismissModal = false
                }
            }) {
                Text("Ajouter")
                    .padding(.horizontal, 50)
                    .padding(.vertical)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            }
            .padding(.top, 50)
            .disabled(nom.isEmpty || email.isEmpty) // Désactiver le bouton si les champs sont vides
            
            Spacer()
        }
        .padding()
    }
    
    // Validation du format d'email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    AjoutClientView(viewModel: ClientViewModel(), dismissModal: .constant(false))
}
