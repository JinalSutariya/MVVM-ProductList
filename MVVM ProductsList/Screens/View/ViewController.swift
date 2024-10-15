//
//  ViewController.swift
//  MVVM ProductsList
//
//  Created by CubezyTech on 14/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    
}
extension ViewController{
    
    func configuration(){
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        
        viewModel.fetchProducts()
        
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else{
                return
            }
            
            switch event {
            case .loading:
                print("data loading.......")
            case .stopLoading:
                print("stop loading.......")
            case .dataLoaded:
                print("data loaded.......")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error) :
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let products = viewModel.products[indexPath.row]
        cell.product = products
        return cell
    }
    
    
}



