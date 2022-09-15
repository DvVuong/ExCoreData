//
//  EditFruiltPresenter.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/13/22.
//

import Foundation
protocol EditFruiltView: AnyObject {
    func showFruilt(fruilt: FruiltData)
}
class EditFruiltPresenter {
    private var view: EditFruiltView?
    private var fruilt: FruiltData
   
    init(with view: EditFruiltView, fruilt: FruiltData) {
        self.view = view
        self.fruilt = fruilt
    }
    
    func loadData(){
        view?.showFruilt(fruilt: fruilt)
    }
    
    func reloadData(name: String) -> FruiltData{
        fruilt.name = name
        return fruilt
    }
}
