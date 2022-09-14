//
//  ViewController.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import UIKit

class ListFruiltViewController: UIViewController {
    @IBOutlet private weak var fruitTable: UITableView!
  
    private lazy var presenter = ListFruiltPresenter(with: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTable()
        presenter.loadData()
        //print("\(type(of: self))", #function)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("\(type(of: self))", #function)
        if let indexPath = fruitTable.indexPathForSelectedRow {
            fruitTable.deselectRow(at: indexPath, animated: true)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("\(type(of: self))", #function)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("\(type(of: self))", #function)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("\(type(of: self))", #function)
//        print("______")
//    }
    
    @IBAction func didtapSort(_ sender: Any){
        if fruitTable.isEditing {
            fruitTable.isEditing = false
        }
        else {
            fruitTable.isEditing = true
        }
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
extension ListFruiltViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfItems()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = fruitTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListFruitCell
        cell.upDateUi(presenter.itemAtIndex(indexPath.row)!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.itemAtIndex(indexPath.row) else { return }
        let vc = EditFruiltViewController.instance(data: item)// move and passing data to EditViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeData(count: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension ListFruiltViewController: ListFruiltPresenterView {
    func addNewFruilt(count: Int) {
        let firstNewIndex = tableView(fruitTable, numberOfRowsInSection: 0) - count
        var indexPaths: [IndexPath] = []
        for i in 0..<count {
            indexPaths.append(IndexPath(row: i + firstNewIndex, section: 0))
        }
        fruitTable.insertRows(at: indexPaths, with: .automatic)
    }
    func removeFruilt(count: Int) {
        fruitTable.deleteRows(at: [IndexPath(row: count, section: 0)], with: .automatic)
    }
    func editFruilt(at index: Int) {
//        fruitTable.reloadData()
        fruitTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    func updataTable() {
        self.fruitTable.reloadData()
    }
}
extension ListFruiltViewController: EditFruiltViewdelegate {
    func editFruiltViewController(_ vc: EditFruiltViewController, endEdit: FruiltData) {
        if let indexPath = fruitTable.indexPathForSelectedRow {
            presenter.editData(data: endEdit, index: indexPath.row)
        }
        navigationController?.popViewController(animated: true)
    }
}
extension ListFruiltViewController: AddNewFruiltDelegate {
    func fruiltViewController(_ vc: AddNewFruiltViewController, didAdd fruit: [FruiltData]) {
        presenter.addFruilt(data: fruit)
        navigationController?.popViewController(animated: true)
    }
}
