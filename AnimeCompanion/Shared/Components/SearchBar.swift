//
//  SearchBar.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Wiederverwendbare Suchleiste-Komponente.
//  Diese Komponente kann überall verwendet werden, wo eine Suche benötigt wird.
//  Sie hat ein Textfeld für die Eingabe und einen Filter-Button.

import SwiftUI

/// Wiederverwendbare Suchleiste-Komponente
struct SearchBar: View {
    // MARK: - Eigenschaften
    
    /// Der aktuelle Suchtext
    /// @Binding bedeutet, dass diese Variable von außen gesetzt werden kann
    /// und Änderungen nach außen weitergegeben werden
    @Binding var searchText: String
    
    /// Placeholder-Text, der im Suchfeld angezeigt wird
    var placeholder: String = "Search..."
    
    /// Callback-Funktion, die aufgerufen wird, wenn der Filter-Button gedrückt wird
    var onFilterTap: (() -> Void)? = nil
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 12) {
            // MARK: - Such-Icon
            
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.App.textSecondary)
            
            // MARK: - Textfeld
            
            // TextField ist das Eingabefeld für Text
            TextField(placeholder, text: $searchText)
                .foregroundStyle(Color.App.textPrimary)
                // .textFieldStyle(.plain) entfernt den Standard-Stil
                .textFieldStyle(.plain)
            
            // MARK: - Clear-Button (X zum Löschen)
            
            // Zeigt den Clear-Button nur an, wenn Text eingegeben wurde
            if !searchText.isEmpty {
                Button(action: {
                    // Löscht den Suchtext
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.App.textSecondary)
                }
            }
            
            // MARK: - Filter-Button
            
            // Zeigt den Filter-Button nur an, wenn eine Callback-Funktion vorhanden ist
            if onFilterTap != nil {
                Button(action: {
                    // Ruft die Callback-Funktion auf
                    onFilterTap?()
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundStyle(Color.App.textSecondary)
                }
            }
        }
        .padding(12)
        .background(Color.App.surface)
        .cornerRadius(10)
    }
}

// MARK: - Preview
#Preview {
    // @State ist notwendig für die Preview, um den Suchtext zu speichern
    struct PreviewWrapper: View {
        @State private var searchText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                // Suchleiste mit Filter-Button
                SearchBar(
                    searchText: $searchText,
                    placeholder: "Search anime...",
                    onFilterTap: {
                        print("Filter tapped")
                    }
                )
                
                // Suchleiste ohne Filter-Button
                SearchBar(
                    searchText: $searchText,
                    placeholder: "Search..."
                )
                
                // Zeigt den aktuellen Suchtext an (nur für die Preview)
                Text("Current search: '\(searchText)'")
                    .foregroundStyle(Color.App.textSecondary)
            }
            .padding()
            .background(Color.App.bgPrimary)
            .preferredColorScheme(.dark)
        }
    }
    
    return PreviewWrapper()
}

