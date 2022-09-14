//
//  Presenter.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import Foundation

protocol ListFruiltPresenterView: AnyObject {
    func updataTable()
    func addNewFruilt(count: Int)
    func editFruilt(at index: Int)
    func removeFruilt(count: Int)
}
class ListFruiltPresenter {
     
    private  var fruilt = [FruiltData]()
    let saveData = UserDefaults.standard
    private weak var  view: ListFruiltPresenterView?
    init(with view: ListFruiltPresenterView ) {
        self.view = view
    }
    func loadData() {
        let f1 = FruiltData(name:"Cam")
        let f2 = FruiltData(name: "chuoi")
            do {
                let encodedData: Data = try PropertyListEncoder().encode(f1)
                UserDefaults.standard.set(encodedData, forKey: KEY_DATA)
                let data = UserDefaults.standard.value(forKey: KEY_DATA) as! Data
                let obj = try PropertyListDecoder().decode(FruiltData.self, from: data)
                dump(obj)
                
            }
            catch {
                print(error)
            }
    
        saveData.object(forKey: KEY_DATA)
        self.fruilt.append(f1)
        self.fruilt.append(f2)
        saveData.object(forKey: KEY_DATA)
        view?.updataTable()
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
        view?.addNewFruilt(count: data.count)
    }
    func editData(data: FruiltData, index: Int){
        fruilt[index] = data
        view?.editFruilt(at: index)
    }
    func removeData(count: Int){
        fruilt.remove(at: count)
        saveData.setCodableObject(fruilt, forKey: KEY_DATA)
        view?.removeFruilt(count: count)
    }
    func reMoveRow(count: Int) -> Int {
        return count
    }
    func insertRow() -> Int {
        let index = numOfItems() - 1
        return index
    }
}
extension UserDefaults {
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
            let encoded = try? JSONEncoder().encode(data)
            set(encoded, forKey: defaultName)
        }
        func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
            guard let userDefaultData = data(forKey: key) else {
                return nil
            }
            return try? JSONDecoder().decode(T.self, from: userDefaultData)
        }
}
