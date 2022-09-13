//
//  EditFruiltViewController.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/13/22.
//

import UIKit
protocol EditFruiltViewdelegate : AnyObject{
    func editFruiltViewController(_ vc: EditFruiltViewController, endEdit: FruiltData, count: Int)
}
class EditFruiltViewController: UIViewController, EditFruiltView {
    func editFruilt(editFruilt: FruiltData, count: Int) {
        presenter.loadData()
    }
    func showFruilt(fruilt: FruiltData) {
        tfFruilt.text = fruilt.name
    }
    static func instance(data: FruiltData, count: Int) -> EditFruiltViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditFruilt") as! EditFruiltViewController
        vc.presenter = EditFruiltPresenter(with: vc, fruilt: data, count: count)
        return vc
    }
    @IBOutlet private weak var tfFruilt: UITextField!
    private var presenter: EditFruiltPresenter!
    weak var delegate: EditFruiltViewdelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @IBAction func btEdit(_ sender: Any) {
        let edit = presenter.reloadData(name: tfFruilt.text! )
        let count = presenter.loadcount()
        delegate?.editFruiltViewController(self, endEdit: edit, count: count)
    }
}
