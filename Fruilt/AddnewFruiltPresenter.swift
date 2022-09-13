//
//  AddnewFruiltPresenter.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/12/22.
//

import Foundation
protocol AddnewFruiltPresenterView: AnyObject {
}
class AddnewFruiltPresenter {
    private weak var view: AddnewFruiltPresenterView?
    init(with view: AddnewFruiltPresenterView){
        self.view = view
    }
    func loadData(name: String) -> FruiltData  {
        let fruilt = FruiltData(name: name)
        return fruilt
    }
}

