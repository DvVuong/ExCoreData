//
//  ViewController.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var fruitTable: UITableView!
    private var fruilt = [FruiltData]()
    private lazy var presenter = Presenter(with: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTable()
        presenter.loadData()
        
    }
    @IBAction func btAddNewFruilt(_ sender: Any) {
        let vc = AddNewFruiltViewController.instance()
        vc.addNewdelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setupTable(){
        fruitTable.delegate = self
        fruitTable.dataSource = self
        fruitTable.tableFooterView = UIView()
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruilt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = fruitTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListFruitCell
        let item = fruilt[indexPath.row]
        cell.lbNamefruilt.text = item.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditFruiltViewController.instance(data: fruilt[indexPath.row],count: indexPath.row)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: PresenterDelegate {
    func editFruilt(edit: FruiltData, count: Int) {
        fruilt[count] = edit
        fruitTable.reloadData()
    }
    func addNewFruilt(newFruilt: [FruiltData]) {
        self.fruilt = newFruilt
        DispatchQueue.main.async {
            self.fruitTable.reloadData()
        }
    }
    func UpdatTable(data: [FruiltData]) {
        self.fruilt = data
        DispatchQueue.main.async {
            self.fruitTable.reloadData()
        }
    }
}
extension ViewController: EditFruiltViewdelegate {
    func editFruiltViewController(_ vc: EditFruiltViewController, endEdit: FruiltData, count: Int) {
        presenter.editData(data: endEdit, count: count)
    }
}
extension ViewController: AddNewFruiltDelegate {
    func addNewFruiltViewController(_ vc: AddNewFruiltViewController, didAdd: FruiltData) {
        presenter.addFruilt(data: didAdd )
        navigationController?.popViewController(animated: true)
    }
}
