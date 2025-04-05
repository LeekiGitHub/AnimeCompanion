//
//  ProfileMenuView.swift
//  AnimeCompanionv1
//
//  Created by Yannik Leekes on 02.04.25.
//


import SwiftUI

struct ProfileMenuView: View {
    var onLogout: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onLogout) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Logout")
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
        .frame(width: 160)
        .background(Color("sakuraPink"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
