import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            // Logo
            VStack(spacing: 8) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .clipShape(Rectangle())

                Text("AnimeCompanion")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)

                Text("Your Anime and Manga App")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            }

            // Eingabefelder
            VStack(spacing: 16) {
                TextField("Email address", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .fontWeight(.heavy)

                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(Color("sakuraPink"))
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .fontWeight(.heavy)
            }

            // Remember Me & Forgot Password
            HStack {
                Toggle(isOn: $rememberMe) {
                    Text("Remember me")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                }
                .toggleStyle(CheckboxToggleStyle())

                Spacer()

                Button("Forgot password?") {
                    // Aktion
                }
                .foregroundColor(Color("sakuraPink"))
                .fontWeight(.heavy)
            }

            // Login Button
            Button(action: {
                if email == "test" && password == "test" {
                    isLoggedIn = true
                }
            }) {
                Text("Sign in")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("sakuraPink"))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .fontWeight(.heavy)
            }

            // Divider
            HStack {
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.4))
                Text("or").foregroundColor(.white)
                Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.4))
            }

            // Social Buttons
            HStack(spacing: 16) {
                SocialLoginButton(icon: "f.circle")
                SocialLoginButton(icon: "g.circle")
                SocialLoginButton(icon: "applelogo")
            }

            Spacer()

            // Sign up Hinweis
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.white)
                Button("Sign up") {
                    // Registrierung
                }
                .foregroundColor(Color("sakuraPink"))
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

// MARK: - Social Button
struct SocialLoginButton: View {
    var icon: String

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 60, height: 60)
                .background(Color("sakuraPink"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.black)
        }
    }
}

// MARK: - Custom Checkbox Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                configuration.label
            }
            .foregroundColor(.white)
        }
    }
}
#Preview {
    ContentView()
}
