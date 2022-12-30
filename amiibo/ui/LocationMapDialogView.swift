import SwiftUI
import MapKit

struct LocationMapDialogView: View {
    @Binding var showModal: Bool
    var amiibo: Amiibo
    
    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: 21.290959, longitude: -157.851265))
            HStack {
                Text("\(self.amiibo.character) Store Location")
                Spacer()
                Button("Close") { self.showModal = false }
            }
            .padding()
        }
    }
}

struct LocationMapDialogView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapDialogView(showModal: .constant(true), amiibo: amiibos[0])
    }
}
