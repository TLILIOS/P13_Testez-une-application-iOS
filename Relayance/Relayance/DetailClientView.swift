//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: ClientViewModel
    var client: Client
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)
            
            // Badge "Nouveau client" si le client a été créé aujourd'hui
            if viewModel.isNewClient(client: client) {
                Text("Nouveau client")
                    .font(.headline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.bottom, 10)
            }
            
            Text(client.nom)
                .font(.title)
                .padding()
            
            Text(client.email)
                .font(.title3)
                .padding(.bottom, 5)
            
            HStack {
                Text("Date de création:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(viewModel.formatClientDate(client: client))
                    .font(.subheadline)
            }
            .padding(.top, 10)
            
            Spacer()
            
            // Bouton de suppression en bas de l'écran
            Button(action: {
                // Utilisation du ViewModel pour supprimer le client
                viewModel.deleteClient(client: client)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Supprimer ce client")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer") {
                    // Utilisation du ViewModel pour supprimer le client
                    viewModel.deleteClient(client: client)
                    self.presentationMode.wrappedValue.dismiss()
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
    }
}

#Preview {
    DetailClientView(viewModel: ClientViewModel(), client: Client(nom: "Tata", email: "tata@email", dateCreationString: "20:32 Wed, 30 Oct 2019"))
}
