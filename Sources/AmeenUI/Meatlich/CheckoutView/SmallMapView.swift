//
//  SmallMapView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.01.25.
//
import SwiftUI
import MapKit
import CoreLocation

// A struct to wrap CLLocationCoordinate2D and make it Identifiable
struct Location: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
import SwiftUI
import MapKit

struct DarkModeMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        mapView.mapType = .standard
        mapView.overrideUserInterfaceStyle = .dark // Set dark mode
        
        // Add the annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = region.center
        annotation.title = "Sakhi Halal Foods"
        mapView.addAnnotation(annotation)
        
        mapView.delegate = context.coordinator // Set the delegate
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update region and re-add the annotation if necessary
        if uiView.region.center.latitude != region.center.latitude || uiView.region.center.longitude != region.center.longitude {
            uiView.setRegion(region, animated: true)
            
            // Remove all annotations before adding the new one
            uiView.removeAnnotations(uiView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = region.center
            annotation.title = "Sakhi Halal Foods"
            uiView.addAnnotation(annotation)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        // Create a custom view for the annotation
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) // Add button
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        // Handle the callout button tap
        func mapView(_ mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let coordinate = annotationView.annotation?.coordinate else { return }
            
            // Construct Google Maps URL
            let googleMapsURL = URL(string: "comgooglemaps://?q=\(coordinate.latitude),\(coordinate.longitude)")!
            let appleMapsURL = URL(string: "http://maps.apple.com/?q=\(coordinate.latitude),\(coordinate.longitude)")!
            
            // Check if Google Maps is installed
            if UIApplication.shared.canOpenURL(googleMapsURL) {
                UIApplication.shared.open(googleMapsURL)
            } else {
                // Fallback to Apple Maps
                UIApplication.shared.open(appleMapsURL)
            }
        }
    }
}
public struct SmallMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.529491, longitude: 13.493297),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    let destinationLocation = Location(coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050)) // Berlin

    public init(region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.529491, longitude: 13.493297),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )) {
        self.region = region
    }
    public var body: some View {
        DarkModeMapView(region: $region)
            .frame(height: 250)
            .shadow(radius: 10)
//
//        ZStack {
//            Map(coordinateRegion: $region,
//                annotationItems: [destinationLocation]) { location in
//                MapMarker(coordinate: location.coordinate, tint: .red) // Destination pin
//            }
//            overrideUserInterfaceStyle = .dark
//        }
       
        
    }
    
}

struct PathView: View {
    let from: CLLocationCoordinate2D
    let to: CLLocationCoordinate2D

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let startPoint = CGPoint(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
                let endPoint = CGPoint(
                    x: geometry.size.width / 2 + CGFloat((to.longitude - from.longitude) * 100000),
                    y: geometry.size.height / 2 + CGFloat((to.latitude - from.latitude) * 100000)
                )
                path.move(to: startPoint)
                path.addLine(to: endPoint)
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

