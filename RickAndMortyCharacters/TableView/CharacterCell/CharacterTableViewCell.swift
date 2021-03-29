//
//  CharacterTableViewCell.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 21/03/21.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel?
    @IBOutlet var lblGender: UILabel?
    @IBOutlet var lblSpecie: UILabel?
    @IBOutlet var lblStatus: UILabel?
    
    @IBOutlet var imgPhoto: UIImageView?
    
    func loadUI(item: Character) {
        
        imgPhoto?.kf.setImage(with: URL(string: item.image ?? ""))
        
        lblName?.text = item.name
        lblGender?.text = "Gender: \(item.gender ?? "")"
        lblSpecie?.text = "Specie: \(item.species ?? "")"
        lblStatus?.text = "Status: \(item.status ?? "")"
    }
}
