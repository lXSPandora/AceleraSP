//
//  ViewController.swift
//  AceleraSP
//
//  Created by Luiz Fernando Sousa Camargo on 30/05/17.
//  Copyright © 2017 Luiz Fernando. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapa.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        zoomUser()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var obras = [Obras]()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Obras")
        
        obras = try! context.fetch(fetchRequest) as! [Obras]
        
        func criarObra(id: Int32, nome: String, descricao: String, endereco: String, latitude: String, longitude: String, status: String, valor: String, orgao: String) {
            let novaObra = NSEntityDescription.insertNewObject(forEntityName: "Obras", into: context)
            novaObra.setValue(nome, forKey: "nome")
            novaObra.setValue(descricao, forKey: "descricao")
            novaObra.setValue(endereco, forKey: "endereco")
            novaObra.setValue(latitude, forKey: "latitude")
            novaObra.setValue(longitude, forKey: "longitude")
            novaObra.setValue(status, forKey: "status")
            novaObra.setValue(valor, forKey: "valor")
            novaObra.setValue(orgao, forKey: "orgao")
            do {
                try context.save()
            }
            catch {
                print("Erro durante a criacao dos objetos")
            }
        }
        if obras.count == 0 {
            //Criando Obras
            criarObra(id: 1, nome: "Metro Oscar Freire", descricao: "O Metro Oscar Freire e uma das novas estacoes da linha 4 amarela", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.560362", longitude: "-46.6725862", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 236,9 milhões", orgao: "Municipal")
            criarObra(id: 2, nome: "Metro Higienopolis Mackenzie", descricao: "O Metro Higienopolis Mackenzie e uma das novas estacoes da linha 4 amarela que ficara proximo do Mackenzie na Consolação", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.548953", longitude: "-46.652404", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 381,6 milhões", orgao: "Municipal")
            criarObra(id: 3, nome: "MASP - Museu de Arte de SP", descricao: "Museu de Arte de São Paulo Assis Chateaubriand (mais conhecido pelo acrônimo MASP) é uma das mais importantes instituições culturais brasileiras. Localiza-se, desde 7 de novembro de 1968, na Avenida Paulista, cidade de São Paulo, em um edifício projetado pela arquiteta ítalo-brasileira Lina Bo Bardi para ser sua sede.", endereco: "Av. Paulista, 1578 - Bela Vista, São Paulo - SP, 01310-200", latitude: "-23.561414", longitude: "-46.6580706", status: "Concluida", valor: "Nao Informado", orgao: "Estadual")
            criarObra(id: 4, nome: "Mercado Municipal de SP", descricao: "Mercado Municipal Paulistano, também conhecido simplesmente como Mercadão, está localizado no centro histórico de São Paulo, capital do estado homônimo brasileiro, entre as ruas Cantareira, Comendador Assad Abdalla e as avenidas Mercúrio e do Estado, sobre uma área próxima ao rio Tamanduateí, no bairro Mercado, antiga Várzea do Carmo.", endereco: "Avenida do Estado/ Rua da Cantareira 306", latitude: "-23.5417132", longitude: "46.6291713", status: "Concluida", valor: "Nao Infomado", orgao: "Municipal")
            criarObra(id:5, nome: "Metro Brigadeiro", descricao: "O Metro Brigadeiro e uma das estacoes da linha 2 verde do metro de sao paulo", endereco: "Av. Paulista, 447 - Paraíso, São Paulo - SP", latitude: "-23.5682954", longitude: "-46.6479653", status: "Concluida", valor: "R$ 64,5 milhões", orgao: "Municipal")
            criarObra(id:6, nome: "Metro Hospital São Paulo", descricao: "O Metro Hospital São Paulo e uma das novas estações da obra de expansão da linha 5 lilas", endereco: "R. dos Otonis, 844 - Vila Clementino, São Paulo - SP, 04025-002", latitude: "-23.5764399", longitude: "-46.6712695", status: "Em construção - Previsão: Fim de 2018", valor: "R$ 64,5 milhões", orgao: "Municipal")
            
        }
        class CustomPointAnnotation: MKPointAnnotation {
            var id: Int32!
        }
        for obra in obras {
            let anotacao = CustomPointAnnotation()
            let latitude = Double(obra.latitude!)
            let longitude = Double(obra.longitude!)
            anotacao.subtitle = obra.endereco
            anotacao.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            anotacao.title = obra.nome
            anotacao.id = obra.id
            self.mapa.addAnnotation(anotacao)
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotationTitle = view.annotation?.title
        {
            self.performSegue(withIdentifier: "passaDados", sender: annotationTitle )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined {
            
            //alerta
            let alertController = UIAlertController(title: "Permissão de localização",
                                                    message: "Para que você possa caçar pokemons, precisamos da sua localização!! por favor habilite",
                                                    preferredStyle: .alert)
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplicationOpenSettingsURLString ) {
                    UIApplication.shared.open(configuracoes as URL)
                }
                
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?    ) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        var titulo = sender as! String
        let predicte = NSPredicate(format: "nome == %@", titulo)
        var arrayObra = [Obras]()
        
        if (segue.identifier == "passaDados") {
            let viewControllerDestino = segue.destination as! DetalhesViewController
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Obras")
            fetchRequest.predicate = predicte
            let results = try! managedObjectContext.fetch(fetchRequest) as! [Obras]
            for result in results {
                viewControllerDestino.nomeRecebido = result.nome
                viewControllerDestino.descricaoRecebida = result.descricao
                viewControllerDestino.enderecoRecebido = result.endereco
                viewControllerDestino.statusRecebido = result.status
                viewControllerDestino.valorRecebido = result.valor
                viewControllerDestino.orgaoRecebido = result.orgao
            }
            
        }
    }
    
    func zoomUser() {
        let latitude:CLLocationDegrees = (locationManager.location?.coordinate.latitude)! //insert latitutde
        
        let longitude:CLLocationDegrees = (locationManager.location?.coordinate.longitude)!//insert longitude
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region = MKCoordinateRegionMake(location, span)
        
        mapa.setRegion(region, animated: false)
    }
    
    @IBAction func getLocation(_ sender: Any) {
        zoomUser()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

