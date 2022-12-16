//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 12/12/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    // MARK: - Variables
    private let collectionPadding: CGFloat = 10
    private var users: [Information] = []
    private var pageNumber: Int = 1
    private var isFetching: Bool = false
    private var totalPages: Int = 1
    private var searchText: String = ""
    private var isFiltered: Bool = false
    //@IBOutlet weak var nextButton: UIButton!
    
    var queryItemArray: [URLQueryItem] = []
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        self.fetchUsers()
        configCollectionView()
        setupSearchbar()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let filterVC = segue.destination as? FilterViewController {
            filterVC.delegate = self
        }
    }
    
    // MARK: - Other methods
    private func configCollectionView() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        let totalItem: CGFloat = 3
        let width = collectionView.frame.width
        let totalSpacing = (collectionPadding * 2) + ((totalItem - 1) * collectionPadding)
        let itemWidth: CGFloat = (width - totalSpacing) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = collectionPadding
        layout.minimumInteritemSpacing = collectionPadding
        collectionView.contentInset = .init(top: collectionPadding, left: collectionPadding, bottom: collectionPadding, right: collectionPadding)
    }
    
    private func setupSearchbar() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }
    
    /*@IBAction func nextAction() {
     pageNumber += 1
     fetchUsers()
     
     }*/
    
    func nextAction() {
        pageNumber += 1
        fetchUsers()
    }
    
    private func fetchUsers() {
       
        let url = "https://rickandmortyapi.com/api/character/"
        var urlComps = URLComponents(string: url)!
        urlComps.queryItems = queryItemArray
        urlComps.queryItems?.append(.init(name: "page", value: String(pageNumber)))
        print(urlComps.url?.absoluteString ?? "")
        guard let url = urlComps.url else {
            return
        }
        isFetching = true
        // Step 2: Making a Request
        let request = URLRequest(url: url)
        // Step 3: Fetch data from URL
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.isFetching = false
            if let error = error {
                print(error)
            } else if let data = data {
                print(String(data: data, encoding: .utf8))
                // Step 3: Parsing data to model
                do {
                    let jsonDecoder = JSONDecoder()
                    let model: RockAndMorty = try jsonDecoder.decode(RockAndMorty.self, from: data)
                    print(model.info.count)
                    self.totalPages = model.info.pages
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

// MARK: - CollectionView methods
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFetching == false
            && pageNumber < totalPages
            && indexPath.item == users.count - 1 {
            self.nextAction()
        }
    }
}

// MARK: - Searchbar methods
extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        isFiltered = false
        pageNumber = 1
        users = []
        collectionView.reloadData()
        self.fetchUsers()
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pageNumber = 1
        searchText = searchBar.text ?? ""
        users = []
        collectionView.reloadData()
        fetchUsers()
    }
    
}

// MARK: - Filter delegate

extension ViewController: FilterDelegate {
    func filterCharacter(didSelectFilterOptions options: [URLQueryItem]) {
        self.queryItemArray = options
        self.pageNumber = 1
        self.users = []
        self.collectionView.reloadData()
        self.fetchUsers()
    }
}
