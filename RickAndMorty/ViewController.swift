//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 12/12/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let collectionPadding: CGFloat = 10
    private var users: [Information] = []
    private var nextURL: String? = "https://rickandmortyapi.com/api/character"
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        self.fetchUsers()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let totalItem: CGFloat = 3
            let width = collectionView.frame.width
            let totalSpacing = (collectionPadding * 2) + ((totalItem - 1) * collectionPadding)
            let itemWidth: CGFloat = (width - totalSpacing) / 3
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.minimumLineSpacing = collectionPadding
            layout.minimumInteritemSpacing = collectionPadding
            collectionView.contentInset = .init(top: collectionPadding, left: collectionPadding, bottom: collectionPadding, right: collectionPadding)
        }
    }
    
    @IBAction func nextAction() {
        fetchUsers()
    }
    
    private func fetchUsers() {
        // Step 1: Create URL from string
        guard let urlStr = self.nextURL else {
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        // Step 2: Making a Request
        let request = URLRequest(url: url)
        // Step 3: Fetch data from URL
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                print(String(data: data, encoding: .utf8))
                // Step 3: Parsing data to model
                do {
                    let jsonDecoder = JSONDecoder()
                    let model: RockAndMorty = try jsonDecoder.decode(RockAndMorty.self, from: data)
                    print(model.info.count)
                    self.nextURL = model.info.next
                    self.users += model.results
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let information = users[indexPath.row]
        cell.setvalues(information)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rickmortyVC = storyboard.instantiateViewController(withIdentifier: "CharacterInfoViewController") as? CharacterInfoViewController else {
            return
        }
        rickmortyVC.characterInfo = self.users[indexPath.row]
        navigationController?.pushViewController(rickmortyVC, animated: true)
    }
    
    
}
