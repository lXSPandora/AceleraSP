//
//  ObraAnotacao.swift
//  AceleraSP
//
//  Created by Luiz Fernando Sousa Camargo on 30/05/17.
//  Copyright © 2017 Luiz Fernando. All rights reserved.
//

import UIKit
import MapKit

class ObraAnotacao: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var obra: Obras
    
    init(coordenadas: CLLocationCoordinate2D, obra: Obras) {
        self.coordinate = coordenadas
        self.obra = obra
    }
}
