import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = AnimeViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var showGenres = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(Color("sakuraPink"))
                }

                Text("Search")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("sakuraPink"))

                Spacer()
            }

            // Anime/Manga Switcher
            HStack(spacing: 0) {
                ForEach(["Anime", "Manga"], id: \.self) { type in
                    Button(action: {
                        viewModel.selectedType = type
                    }) {
                        Text(type)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.selectedType == type ? Color("sakuraPink") : .clear)
                            .foregroundColor(viewModel.selectedType == type ? .black : Color("sakuraPink"))
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 12).stroke(Color("sakuraPink")))

            // Suchleiste
            TextField("Search by title...", text: $viewModel.searchText)
                .font(.callout)
                .padding(10)
                .background(Color("sakuraPink"))
                .cornerRadius(10)
                .foregroundColor(.black)
                .onChange(of: viewModel.searchText) {
                    viewModel.filter()
                }

            // Genres Header mit Toggle
            HStack {
                Text("Genres")
                    .foregroundColor(Color("sakuraPink"))
                    .fontWeight(.semibold)

                Spacer()

                Button(action: {
                    withAnimation {
                        showGenres.toggle()
                    }
                }) {
                    Image(systemName: showGenres ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color("sakuraPink"))
                }
            }

            // Genres Grid (ein-/ausklappbar + scrollfähig)
            if showGenres {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(36))], spacing: 10) {
                        ForEach(viewModel.genres, id: \.self) { genre in
                            Button(action: {
                                viewModel.selectedGenre = viewModel.selectedGenre == genre ? nil : genre
                                viewModel.filter()
                            }) {
                                Text(genre)
                                    .font(.subheadline)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .foregroundColor(viewModel.selectedGenre == genre ? .black : Color("sakuraPink"))
                                    .background(viewModel.selectedGenre == genre ? Color("sakuraPink") : .clear)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("sakuraPink")))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
                .frame(height: 50)
            }

            // Ergebnisse
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.filteredAnimes) { anime in
                        AnimeRowView(anime: anime)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchView()
}
