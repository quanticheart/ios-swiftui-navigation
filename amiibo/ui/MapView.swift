import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  var coordinate: CLLocationCoordinate2D

  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }

  func updateUIView(_ view: MKMapView, context: Context) {
    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    let region = MKCoordinateRegion(center: coordinate, span: span)

    // Added annotation for PublicArt project
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    view.addAnnotation(annotation)

    view.setRegion(region, animated: true)
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 21.290959, longitude: -157.851265))
  }
}
