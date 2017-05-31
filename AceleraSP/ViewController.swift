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

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Exibindo dados no mapa
        
        var locationManager = CLLocationManager()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var obras = [Obras]()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Obras")
        obras = try! context.fetch(fetchRequest) as! [Obras]
        
        func criarObra(nome: String, descricao: String, endereco: String, latitude: String, longitude: String, status: String, valor: String) {
            let novaObra = NSEntityDescription.insertNewObject(forEntityName: "Obras", into: context)
            novaObra.setValue(nome, forKey: "nome")
            novaObra.setValue(descricao, forKey: "descricao")
            novaObra.setValue(endereco, forKey: "endereco")
            novaObra.setValue(latitude, forKey: "latitude")
            novaObra.setValue(longitude, forKey: "longitude")
            novaObra.setValue(status, forKey: "status")
            novaObra.setValue(valor, forKey: "valor")
            do {
                try context.save()
            }
            catch {
                print("Erro durante a criacao dos objetos")
            }
        }
        if obras.count == 0 {
            //Criando Obras
            criarObra(nome: "Metro Oscar Freire", descricao: "O Metro Oscar Freire e uma das novas estacoes da linha 4 amarela", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.560362", longitude: "-46.6725862", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 236,9 milhões")
            criarObra(nome: "Metro Higienopolis Mackenzie", descricao: "O Metro Higienopolis Mackenzie e uma das novas estacoes da linha 4 amarela que ficara proximo do Mackenzie na Consolação", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.548953", longitude: "-46.652404", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 381,6 milhões")
            criarObra(nome: "MASP - Museu de Arte de SP", descricao: "Museu de Arte de São Paulo Assis Chateaubriand (mais conhecido pelo acrônimo MASP) é uma das mais importantes instituições culturais brasileiras. Localiza-se, desde 7 de novembro de 1968, na Avenida Paulista, cidade de São Paulo, em um edifício projetado pela arquiteta ítalo-brasileira Lina Bo Bardi para ser sua sede.", endereco: "Av. Paulista, 1578 - Bela Vista, São Paulo - SP, 01310-200", latitude: "-23.561414", longitude: "-46.6580706", status: "Concluida", valor: "Nao Informado")
            criarObra(nome: "Mercado Municipal de SP", descricao: "Mercado Municipal Paulistano, também conhecido simplesmente como Mercadão, está localizado no centro histórico de São Paulo, capital do estado homônimo brasileiro, entre as ruas Cantareira, Comendador Assad Abdalla e as avenidas Mercúrio e do Estado, sobre uma área próxima ao rio Tamanduateí, no bairro Mercado, antiga Várzea do Carmo.", endereco: "Avenida do Estado/ Rua da Cantareira 306", latitude: "-23.5417132", longitude: "46.6291713", status: "Concluida", valor: "Nao Infomado")
            criarObra(nome: "Metro Hospital São Paulo", descricao: "O Metro Hospital São Paulo e uma das novas estações da obra de expansão da linha 5 lilas", endereco: "R. dos Otonis, 844 - Vila Clementino, São Paulo - SP, 04025-002", latitude: "-23.5764399", longitude: "-46.6712695", status: "Em construção - Previsão: Fim de 2018", valor: "R$ 64,5 milhões")
            
        }
        for obra in obras {
            let anotacao = MKPointAnnotation()
            let latitude = Double(obra.latitude!)
            let longitude = Double(obra.longitude!)
            anotacao.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            anotacao.title = obra.nome
            self.mapa.addAnnotation(anotacao)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

