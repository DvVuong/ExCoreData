//
//  AddNewFruiltViewController.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/12/22.
//

import UIKit
protocol AddNewFruiltDelegate: AnyObject {
    func addNewFruiltViewController(_ vc: AddNewFruiltViewController, didAdd: FruiltData)
}
class AddNewFruiltViewController: UIViewController, AddnewFruiltPresenterView {
    static func instance() -> AddNewFruiltViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddScreen") as! AddNewFruiltViewController
        vc.presenter = AddnewFruiltPresenter(with: vc)
        return vc// pushviewController
    }
    weak var addNewdelegate: AddNewFruiltDelegate?
    @IBOutlet private weak var tfInputFruilt:UITextField!
    private var presenter: AddnewFruiltPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @IBAction func btAdd(_ sender: Any) {
        let data =  presenter.loadData(name: tfInputFruilt.text!)
        addNewdelegate?.addNewFruiltViewController(self, didAdd: data)
    }
    
}
