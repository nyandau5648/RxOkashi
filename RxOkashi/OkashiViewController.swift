//
//  ViewController.swift
//  RxOkashi
//
//  Created by Newton on 2020/12/24.
//

import UIKit
import RxSwift
import RxCocoa

class OkashiViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "お菓子の名前を入力してください"
        
        let viewModel = OkashiSearchViewModel(searchWord: searchBar.rx.text.orEmpty.asObservable(),
                                              okashiAPI: OkashiDefaultAPI(URLSession: .shared))
        viewModel.okashiPages
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
                index, result, cell in
                cell.textLabel?.text = result.name
            }
            .disposed(by: disposeBag)
    }

}

