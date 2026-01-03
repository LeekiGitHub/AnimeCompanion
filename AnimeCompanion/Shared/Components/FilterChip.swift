//
//  FilterChip.swift
//  AnimeCompanion
//
//  Created by Yannik Luca Leekes on 01.01.26.
//
//  Wiederverwendbare Filter-Chip-Komponente.
//  Ein Chip ist ein kleiner Button, der anzeigt, ob er ausgewählt ist oder nicht.
//  Wird für Filter-Optionen verwendet (z.B. "All", "TV", "Movie").

import SwiftUI

/// Wiederverwendbare Filter-Chip-Komponente
struct FilterChip: View {
    // MARK: - Eigenschaften
    
    /// Der Text, der auf dem Chip angezeigt wird
    let title: String
    
    /// Ob der Chip ausgewählt ist
    let isSelected: Bool
    
    /// Callback-Funktion, die aufgerufen wird, wenn der Chip gedrückt wird
    var onTap: (() -> Void)? = nil
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            // Ruft die Callback-Funktion auf, falls vorhanden
            onTap?()
        }) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(
                    // Wenn ausgewählt: accentPrimary, sonst: textSecondary
                    isSelected ? Color.App.accentPrimary : Color.App.textSecondary
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    // Wenn ausgewählt: surface mit accentPrimary Border, sonst: nur surface
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.App.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    isSelected ? Color.App.accentPrimary : Color.clear,
                                    lineWidth: isSelected ? 1.5 : 0
                                )
                        )
                )
        }
    }
}

// MARK: - Preview
#Preview {
    HStack(spacing: 12) {
        // Ausgewählter Chip
        FilterChip(
            title: "All",
            isSelected: true
        )
        
        // Nicht ausgewählter Chip
        FilterChip(
            title: "TV",
            isSelected: false
        )
        
        FilterChip(
            title: "Movie",
            isSelected: false
        )
    }
    .padding()
    .background(Color.App.bgPrimary)
    .preferredColorScheme(.dark)
}

