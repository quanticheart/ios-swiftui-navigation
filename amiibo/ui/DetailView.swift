import SwiftUI

struct DetailView: View {
    let amiibo: Amiibo
    @State private var showMap = false
    
    var body: some View {
        List{
            VStack {
                RemoteImage(url: amiibo.image)
                Text("\(amiibo.amiiboSeries) - \(amiibo.character)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Divider()
                HStack{
                    Text(amiibo.character)
                        .multilineTextAlignment(.leading)
                        .lineLimit(20)
                    Divider().frame(width: 10, height: 10, alignment: .center)
                    Text("Type: \(amiibo.type)")
                        .font(.subheadline)
                }
                Divider()
                HStack {
                    Button(action: { self.showMap = true }) {
                        Image(systemName: "mappin.and.ellipse")
                    }
                    .sheet(isPresented: $showMap) {
                        LocationMapDialogView(showModal: self.$showMap, amiibo: self.amiibo)
                    }
                    Text("Click to show map")
                        .font(.subheadline)
                }
            }
            .padding()
            .navigationBarTitle(Text(amiibo.name), displayMode: .inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(amiibo: amiibos[0])
    }
}

struct RemoteImage: View {
    var url: String
    @ObservedObject var imageLoader = ImageLoaderService()
    @State var image: UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(maxWidth: 300, maxHeight: 600)
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.$image) { image in
                self.image = image
            }
            .onAppear {
                imageLoader.loadImage(for: url)
            }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
    
}
