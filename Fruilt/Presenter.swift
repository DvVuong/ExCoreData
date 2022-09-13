//
//  Presenter.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import Foundation

protocol PresenterDelegate: AnyObject {
    func UpdatTable(data: [FruiltData])
    func addNewFruilt(newFruilt: [FruiltData])
    func editFruilt(edit: FruiltData, count: Int)
}
class Presenter {
    private  var fruilt = [FruiltData]()
    private weak var  view: PresenterDelegate?
    init(with view: PresenterDelegate ) {
        self.view = view
    }
    func loadData(){
        let f1 = FruiltData(name:"Cam")
        let f2 = FruiltData(name: "chuoi")
        self.fruilt.append(f1)
        self.fruilt.append(f2)
        view?.UpdatTable(data: fruilt)
    }
    func addFruilt(data: FruiltData){
        fruilt.append(data)
        view?.addNewFruilt(newFruilt: fruilt)
    }
    func editData(data: FruiltData, count: Int){
        view?.editFruilt(edit: data, count: count)
    
    }
    
}
