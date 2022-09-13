//
//  EditFruiltPresenter.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/13/22.
//

import Foundation
protocol EditFruiltView: AnyObject {
    func showFruilt(fruilt: FruiltData)
    func editFruilt(editFruilt: FruiltData, count: Int)
}
class EditFruiltPresenter {
    private var view: EditFruiltView?
    private var fruilt: FruiltData!
    private var count: Int
    init(with view: EditFruiltView, fruilt: FruiltData, count: Int) {
        self.view = view
        self.fruilt = fruilt
        self.count = count
    }
    func loadData(){
        view?.showFruilt(fruilt: fruilt)
    }
    func reloadData(name: String) -> FruiltData{
        let f1 = FruiltData(name: name)
        view?.editFruilt(editFruilt: f1, count: count)
        return f1
    }
    func loadcount() -> Int{
        return count
    }
}
