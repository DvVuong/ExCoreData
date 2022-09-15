//
//  ListFruitCell.swift
//  UpdateFruitViewController
//
//  Created by admin on 12/09/2022.
//

import UIKit
class ListFruitCell: UITableViewCell {
    @IBOutlet weak var lbNamefruilt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updataUI(_ fruilt: FruiltData) {
        lbNamefruilt.text = fruilt.name
        
    }
    

}
