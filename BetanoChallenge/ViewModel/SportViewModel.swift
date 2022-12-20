//
//  SportViewModel.swift
//  BetanoChallenge
//
//  Created by Masam Mahmood on 14/12/2022.
//

import Foundation

class SportViewModel {
    
    var arrCodigo: [SportElement] = []

    //MARK:- get data
    func getDataTask(_ Success: @escaping (() -> Void)) {
        ServiceController.serviceGET(path: Globs.apiCodigos, withSuccess: { response, data in
            
            let model = try! JSONDecoder().decode([SportElement].self, from: data)
            self.arrCodigo = model
            Success()
            
        }) { error in
            print(error?.localizedDescription as Any)
            Success()
        }
    }
}

