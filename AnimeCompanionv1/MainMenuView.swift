import SwiftUI

struct MainMenuView: View {
    @Binding var isLoggedIn: Bool
    @State private var showProfileMenu = false
    @State private var profileButtonFrame: CGRect = .zero
    @State private var menuOffset: CGPoint = .zero

    let menuItems: [(icon: String, title: String)] = [
        ("eye", "WATCHED"),
        ("clock", "TO WATCH"),
        ("book", "READ"),
        ("book.fill", "TO READ"),
        ("magnifyingglass", "SEARCH"),
        ("bookmark", "MY MANGA")
    ]

    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()

                VStack(spacing: 24) {
                    // Header
                    HStack(spacing: 16) {
                        // Left side - Logo and Title
                        HStack(spacing: 8) {
                            Image("AppLogo")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .clipShape(RoundedRectangle(cornerRadius: 6))

                            Text("AnimeCompanion")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("sakuraPink"))
                        }
                        
                        Spacer(minLength: 20)
                        
                        // Right side - Action buttons
                        HStack(spacing: 12) {
                            Button(action: {}) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(5)
                                    .clipShape(Circle())
                                    .foregroundColor(Color("sakuraPink"))
                            }

                            Button(action: {
                                withAnimation {
                                    showProfileMenu.toggle()
                                }
                            }) {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(5)
                                    .clipShape(Circle())
                                    .foregroundColor(Color("sakuraPink"))
                            }
                            .background(
                                GeometryReader { geo -> Color in
                                    let frame = geo.frame(in: .global)
                                    if profileButtonFrame != frame {
                                        DispatchQueue.main.async {
                                            profileButtonFrame = frame
                                            menuOffset = CGPoint(
                                                x: frame.maxX - 160,
                                                y: frame.maxY + 2
                                            )
                                        }
                                    }
                                    return Color.clear
                                }
                            )

                            Button(action: {}) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(5)
                                    .clipShape(Circle())
                                    .foregroundColor(Color("sakuraPink"))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 44)

                    // Begrüßung
                    VStack(spacing: 4) {
                        Text("Your personal")
                            .font(.largeTitle)
                            .foregroundColor(Color("sakuraPink"))
                            .fontWeight(.bold)

                        Text("Companion")
                            .foregroundColor(Color("sakuraPink"))
                            .fontWeight(.medium)
                    }

                    // Grid-Menü
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(menuItems, id: \.title) { item in
                            if item.title == "SEARCH" {
                                NavigationLink(destination: SearchView()) {
                                    menuButton(icon: item.icon, title: item.title)
                                }
                            } else {
                                Button(action: {
                                    // Weitere Aktionen
                                }) {
                                    menuButton(icon: item.icon, title: item.title)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }

                // Profilmenü
                if showProfileMenu {
                    ProfileMenuView {
                        withAnimation {
                            showProfileMenu = false
                            isLoggedIn = false
                        }
                    }
                    .position(x: menuOffset.x + 80, y: menuOffset.y - 40)
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    func menuButton(icon: String, title: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .foregroundColor(Color("sakuraPink"))
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("sakuraPink"), lineWidth: 5)
        )
    }
}

// Preview
struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMenuView(isLoggedIn: .constant(true))
        }
        .previewDevice("iPhone 16 Pro")
    }
}
