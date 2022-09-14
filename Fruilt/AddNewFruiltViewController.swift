//
//  AddNewFruiltViewController.swift
//  UpdateFruitViewController
//
//  Created by mr.root on 9/12/22.
//
import UIKit
protocol AddNewFruiltDelegate: AnyObject {
    func fruiltViewController(_ vc: AddNewFruiltViewController, didAdd fruit: [FruiltData])
}
class AddNewFruiltViewController: UIViewController, AddnewFruiltPresenterView {
    static func instance() -> AddNewFruiltViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddScreen") as! AddNewFruiltViewController
        vc.presenter = AddnewFruiltPresenter(with: vc)
        return vc// pushviewController
    }
    weak var addNewdelegate: AddNewFruiltDelegate?
   
    @IBOutlet private var tfListInput: [UITextField]!
    
    private var presenter: AddnewFruiltPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func btAdd(_ sender: Any) {
        let items = tfListInput.filter { !$0.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }.map { presenter.initFruit(name: $0.text!) }
        addNewdelegate?.fruiltViewController(self, didAdd: items)
    }
    
}
