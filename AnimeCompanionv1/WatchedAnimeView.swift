import SwiftUI

struct WatchedAnimeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedSortOption = "Name"
    @State private var showSortDropdown = false

    let sortOptions = ["Name", "Rating", "Zuletzt geschaut"]

    var body: some View {
        ZStack {
            // Hintergrund – reagiert auf Tap zum Schließen des Dropdowns
            Color.black
                .ignoresSafeArea()
                .onTapGesture {
                    if showSortDropdown {
                        withAnimation {
                            showSortDropdown = false
                        }
                    }
                }

            VStack(alignment: .leading, spacing: 0) {
                
                // HEADER-Zeile mit Zurück, Titel & Sortier-Button
                HStack {
                    // 🔙 Zurück-Button mit erweitertem Tap-Bereich (mind. 44x44)
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundColor(Color("sakuraPink"))
                            .frame(width: 44, height: 44) // Apple Guideline: min Tap-Ziel
                            .contentShape(Rectangle()) // stellt sicher, dass ganzer Bereich tappbar ist
                    }

                    // Titel
                    Text("Watched Anime")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("sakuraPink"))

                    Spacer()
                    
                    // Sort by Button mit aktueller Auswahl
                    Button(action: {
                        withAnimation {
                            showSortDropdown.toggle()
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text("Sort by: \(selectedSortOption)")
                            Image(systemName: showSortDropdown ? "chevron.up" : "chevron.down")
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("sakuraPink"))
                        )
                        .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                // Dropdown außerhalb des Headers, klappt darunter auf
                if showSortDropdown {
                    VStack(spacing: 0) {
                        ForEach(sortOptions, id: \.self) { option in
                            Button(action: {
                                selectedSortOption = option
                                withAnimation {
                                    showSortDropdown = false
                                }
                            }) {
                                Text(option)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color("sakuraPink"))
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .padding(.top, 4)
                }

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WatchedAnimeView()
}
