//
//  EditFruiltViewController.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/13/22.
//

import UIKit
protocol EditFruiltViewdelegate : AnyObject{
    func editFruiltViewController(_ vc: EditFruiltViewController, endEdit: FruiltData)// back and passing data
}
class EditFruiltViewController: UIViewController, EditFruiltView {
    func showFruilt(fruilt: FruiltData) {
        tfFruilt.text = fruilt.name
    }
    static func instance(data: FruiltData) -> EditFruiltViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditFruilt") as! EditFruiltViewController
        vc.presenter = EditFruiltPresenter(with: vc, fruilt: data)
        return vc
    }
    @IBOutlet private weak var tfFruilt: UITextField!
    private var presenter: EditFruiltPresenter!
    weak var delegate: EditFruiltViewdelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
        //print("\(type(of: self))", #function)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("\(type(of: self))", #function)
//    }
//
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
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @IBAction func btEdit(_ sender: Any) {
        let edit = presenter.reloadData(name: tfFruilt.text! )
        delegate?.editFruiltViewController(self, endEdit: edit)
    }
}
