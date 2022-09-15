//
//  Presenter.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import Foundation
import UIKit
protocol ListFruiltPresenterView: AnyObject {
    func addNewFruilt(count: Int)
    func editFruilt(at index: Int)
    func removeFruilt(at index: Int)
    func reloadData()
}
class ListFruiltPresenter {
    private var fruilt = [FruiltData]()
    private weak var  view: ListFruiltPresenterView?
    init(with view: ListFruiltPresenterView ) {
        self.view = view
    }
    func loadData() {
        fruilt = DataManger.sharedInstance.getFruilt()
        view?.reloadData()
    }
    
    func numOfItems() -> Int {
        return fruilt.count
    }
    
    func itemAtIndex(_ index: Int) -> FruiltData? {
        guard index >= 0 && index < numOfItems() else {
            return nil
        }
        return fruilt[index]
    }
    
    func addFruilt(data: [FruiltData]) {
        fruilt.append(contentsOf: data)
    
        DataManger.sharedInstance.saveFruits(data)
        view?.addNewFruilt(count: data.count)
    }
    func editData(data: FruiltData, index: Int){
        guard let id = data.id else { return }
        fruilt[index] = data
        DataManger.sharedInstance.updateName(data.name, with: id)
        view?.editFruilt(at: index)
    }
    func removeData(index: Int){
        guard let id = itemAtIndex(index)?.id else { return }
        DataManger.sharedInstance.deleteById(id)
        fruilt.remove(at: index)
        view?.removeFruilt(at: index)
    }
    func reMoveRow(count: Int) -> Int {
        return count
    }
    func insertRow() -> Int {
        let index = numOfItems() - 1
        return index
    }
}

