//
//  CharactersViewController.swift
//  RickAndMortyCharacters
//
//  Created by Felipe Bastos on 21/03/21.
//

import UIKit

class CharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var characters: [Character] = []
    var pageLimit: Int = 0
    var page: Int = 1
    
    @IBOutlet var tbCharacters: UITableView?
    @IBOutlet var vwLottie: UIView?
    
    //-----------------------------------------------------------------------
    //  MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        let lottie = Util.getLottieLoadingAnimation(center: CGPoint(x: 0, y: 0),
                                                    size: 150)
        
        vwLottie?.addSubview(lottie)
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let character = self.characters[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as? CharacterTableViewCell
        cell?.loadUI(item: character)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == characters.count - 1 {
            
            self.page = UserDefaults.standard.integer(forKey: "currentPage") + 1
            
            self.loadCharacters()
        }
    }
    
    //-----------------------------------------------------------------------
    //  MARK: - Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        
        if DatabaseCharacter.shared.getAll().count > 0 {
            self.characters = DatabaseCharacter.shared.getAll()
            self.tbCharacters?.reloadData()
        }else{
            self.loadCharacters()
        }
    }

    func loadCharacters() {
        
        RequestManager().loadData(page: page) { (object, pageLimit) in
            
            self.pageLimit = pageLimit
            self.characters = object
            
            UserDefaults.standard.setValue(self.page, forKey: "currentPage")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.tbCharacters?.reloadData()
            }
        }
    }
}

