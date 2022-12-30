//
//  ContentView.swift
//  amiibo
//
//  Created by Jonn Alves on 30/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var amiibosList = amiibos
    @State private var hideVisited = false
    @State var r = [UUID]()
    
    var amiibosListFilter: [Amiibo] {
        hideVisited ? amiibosList.filter {
            print($0)
            print(r.contains($0.id))
            return !r.contains($0.id)
        } : amiibosList
    }
    
    private func setReaction(_ reaction: String, for item: Amiibo) {
        self.r.appendIfNotContains(item.id)
    }
        
    var body: some View {
      NavigationView {
          List(amiibosListFilter, id: \.id) { amiibo in
          NavigationLink(
          destination: DetailView(amiibo: amiibo)) {
            Text("\(amiibo.amiiboSeries)  \(amiibo.name)")
              .onAppear() { amiibo.load() }
              .contextMenu {
                Button("Like: 💕") {
                  self.setReaction("💕", for: amiibo)
                }
                Button("OK: 🙏") {
                  self.setReaction("🙏", for: amiibo)
                }
                Button("TOP!: 🌟") {
                  self.setReaction("🌟", for: amiibo)
                }
            }
          }
        }
        .navigationBarTitle("Amiibos")
        .navigationBarItems(trailing: Toggle(isOn: $hideVisited, label: { Text("Hide Visited") }))
        
        DetailView(amiibo: amiibos[0])
      }
    }
  }

  struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
  }

extension RangeReplaceableCollection where Element: Equatable {
    @discardableResult
    mutating func appendIfNotContains(_ element: Element) -> (appended: Bool, memberAfterAppend: Element) {
        if let index = firstIndex(of: element) {
            return (false, self[index])
        } else {
            append(element)
            return (true, element)
        }
    }
}


