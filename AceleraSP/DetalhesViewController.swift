//
//  DetalhesViewController.swift
//  AceleraSP
//
//  Created by Luiz Fernando Sousa Camargo on 31/05/17.
//  Copyright © 2017 Luiz Fernando. All rights reserved.
//

import Foundation
import UIKit

class DetalhesViewController: UIViewController {
    
    var nomeRecebido: String!
    var descricaoRecebida: String!
    var statusRecebido: String!
    var valorRecebido: String!
    var enderecoRecebido: String!
    var orgaoRecebido: String!
    
    @IBOutlet weak var orgao: UILabel!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var valor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nome.text = nomeRecebido
        descricao.text = descricaoRecebida
        status.text = statusRecebido
        endereco.text = enderecoRecebido
        valor.text = valorRecebido
        orgao.text = orgaoRecebido
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
