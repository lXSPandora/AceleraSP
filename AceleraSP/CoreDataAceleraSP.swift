//
//  CoreDataAceleraSP.swift
//  AceleraSP
//
//  Created by Luiz Fernando Sousa Camargo on 30/05/17.
//  Copyright © 2017 Luiz Fernando. All rights reserved.
//

import UIKit
import CoreData

class CoreDataObras {
    
    //Recuperando a Context da Aplicacao
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func recuperarTodasObras() -> [Obras] {
        
        let context = self.getContext()
        
        do{
            let obras = try context.fetch( Obras.fetchRequest() ) as! [Obras]
            
            if obras.count == 0 {
                self.adicionarTodasObras()
                return self.recuperarTodasObras()
            }
            print(obras)
            
            return obras
        }catch{}
        
        return []
        
    }
    
    func adicionarTodasObras(){
        
        let context = self.getContext()
        
        self.criarObras(id: 1, nome: "Metro Oscar Freire", descricao: "O Metro Oscar Freire e uma das novas estacoes da linha 4 amarela", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.560362", longitude: "-46.6725862", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 236,9 milhões")
        self.criarObras(id: 2, nome: "Metro Higienopolis Mackenzie", descricao: "O Metro Higienopolis Mackenzie e uma das novas estacoes da linha 4 amarela que ficara proximo do Mackenzie na Consolação", endereco: "Avenida Reboucas X Rua Oscar Freire", latitude: "-23.548953", longitude: "-46.652404", status: "Em Andamento - Previsao: Fim 2017", valor: "R$ 381,6 milhões")
        self.criarObras(id: 3, nome: "MASP - Museu de Arte de SP", descricao: "Museu de Arte de São Paulo Assis Chateaubriand (mais conhecido pelo acrônimo MASP) é uma das mais importantes instituições culturais brasileiras. Localiza-se, desde 7 de novembro de 1968, na Avenida Paulista, cidade de São Paulo, em um edifício projetado pela arquiteta ítalo-brasileira Lina Bo Bardi para ser sua sede.", endereco: "Av. Paulista, 1578 - Bela Vista, São Paulo - SP, 01310-200", latitude: "-23.561414", longitude: "-46.6580706", status: "Concluida", valor: "Nao Informado")
        self.criarObras(id: 4, nome: "Mercado Municipal de SP", descricao: "Mercado Municipal Paulistano, também conhecido simplesmente como Mercadão, está localizado no centro histórico de São Paulo, capital do estado homônimo brasileiro, entre as ruas Cantareira, Comendador Assad Abdalla e as avenidas Mercúrio e do Estado, sobre uma área próxima ao rio Tamanduateí, no bairro Mercado, antiga Várzea do Carmo.", endereco: "Avenida do Estado/ Rua da Cantareira 306", latitude: "-23.5417132", longitude: "46.6291713", status: "Concluida", valor: "Nao Infomado")
        self.criarObras(id: 5, nome: "Metro Hospital São Paulo", descricao: "O Metro Hospital São Paulo e uma das novas estações da obra de expansão da linha 5 lilas", endereco: "R. dos Otonis, 844 - Vila Clementino, São Paulo - SP, 04025-002", latitude: "-23.5764399", longitude: "-46.6712695", status: "Em construção - Previsão: Fim de 2018", valor: "R$ 64,5 milhões")
        do{
            try context.save()
        }catch{}
        
    }
    func criarObras(id: Int32, nome: String, descricao: String, endereco: String, latitude: String, longitude: String, status: String, valor: String ){
        
        let context = self.getContext()
        let obras = Obras(context: context )
        
        obras.nome = nome
        obras.descricao = descricao
        obras.endereco = endereco
        obras.latitude = latitude
        obras.longitude = longitude
        obras.valor = valor
        obras.status = status
        
    }
}
