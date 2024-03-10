//
//  ContentView.swift
//  Movies
//
//  Created by Dinmukhamed Arystanbekov on 2/22/24.
//
import SwiftUI
import WebKit

struct Movie: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String // Имя изображения
    var trailerURL: URL // URL трейлера
}

struct ContentView: View {
    @State private var searchText = ""
    
    let movies = [
        Movie(title: "Toy Story", imageName: "Toy Story", trailerURL: URL(string: "https://www.youtube.com/watch?v=KYz2wyBy3kc")!),
        Movie(title: "A Bug's Life", imageName: "A Bug's Life", trailerURL: URL(string: "https://www.youtube.com/watch?v=Ljk2YJ53_WI")!),
        Movie(title: "Incredibles", imageName: "Incredibles", trailerURL: URL(string:"https://www.youtube.com/watch?v=sJCjKQQOqT0")!)
         
    ]
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(filteredMovies) { movie in
                    NavigationLink(destination: WebView(url: movie.trailerURL)) { // Используем WebView для отображения трейлера
                        HStack {
                            Image(movie.imageName) // Отображение изображения
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text(movie.title)
                        }
                    }
                }
                .navigationBarTitle("Pixar Movies")
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




    
