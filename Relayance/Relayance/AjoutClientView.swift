//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
    @ObservedObject var viewModel: ClientViewModel
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Nom", text: $nom)
                .font(.title2)
            TextField("Email", text: $email)
                .font(.title2)
            Button("Ajouter") {
                // Utilisation du ViewModel pour ajouter un client
                viewModel.addClient(nom: nom, email: email)
                dismissModal.toggle()
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AjoutClientView(viewModel: ClientViewModel(), dismissModal: .constant(false))
}
