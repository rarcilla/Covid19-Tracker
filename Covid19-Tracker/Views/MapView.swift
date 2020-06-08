//
//  MapView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-01.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var lat: Double
    var lon: Double

    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(uiView.regionThatFits(region), animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(lat: 34.011286, lon: -116.166868)
    }
}
