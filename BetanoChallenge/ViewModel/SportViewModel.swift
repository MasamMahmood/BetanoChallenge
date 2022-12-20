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
    
    func sortData(sortValue: String, completion: @escaping () -> Void) {
        for (index,j) in self.arrCodigo.enumerated() {
            for (index2, h) in j.e.enumerated() {
                if h.i == sortValue {
                    if h.sortType == false {
                        self.arrCodigo[index].e[index2].sortType = true
                    } else {
                        self.arrCodigo[index].e[index2].sortType = false
                    }
                    
                }
                
            }
            
        }
        
        let sortedArray = self.arrCodigo.map( { SportElement(i: $0.i, d: $0.d, e: $0.e.sorted { $0.sortType && !$1.sortType }) })
        self.arrCodigo = sortedArray
        completion()
    }
}

