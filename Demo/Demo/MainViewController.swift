//
// Copyright (C) 2024 Muhammad Tayyab Akram
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SmartListing
import UIKit

final class DiningCellViewModel: CellViewModel {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

final class DiningCell: UITableViewCell, TableViewCellProtocol {
    static var nib: UINib? { nil }
    
    func configure(with viewModel: Loadable<DiningCellViewModel>) {
        if viewModel.isLoading {
            // Start Shimmering.
        } else {
            // Stop Shimmering.
        }
        
        if let viewModel = viewModel.value {
            textLabel?.text = viewModel.title
        }
    }
}

final class MainViewModel {
    private static let loadingItems: [CellViewModel] = [
        Loadable<DiningCellViewModel>.loading,
        Loadable<DiningCellViewModel>.loading,
        Loadable<DiningCellViewModel>.loading
    ]
    private static let loadedItems: [CellViewModel] = [
        Loadable.loaded(DiningCellViewModel(title: "Pizza")),
        Loadable.loaded(DiningCellViewModel(title: "Pasta")),
        Loadable.loaded(DiningCellViewModel(title: "Burger"))
    ]
    
    private(set) var isLoading = true
    
    var onLoadingStateChanged: (() -> Void)?
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
            self.onLoadingStateChanged?()
        }
    }
    
    var numberOfItems: Int {
        return isLoading ? Self.loadingItems.count : Self.loadedItems.count
    }
    
    func item(at index: Int) -> CellViewModel {
        isLoading ? Self.loadingItems[index] : Self.loadedItems[index]
    }
}

final class MainViewController: UIViewController {
    private let tableView = UITableView()
    private var tableViewManager: TableViewManager!
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindViewModel()
    }
    
    private func setup() {
        tableViewManager = TableViewManager(
            tableView: tableView,
            numberOfRows: { [weak self] _ in
                return self?.viewModel.numberOfItems ?? 0
            },
            cellViewModel: { [weak self] indexPath in
                return self?.viewModel.item(at: indexPath.row) ?? EmptyCellViewModel()
            }
        )
        tableViewManager.register(
            TableViewCellHandler(DiningCell.self,
                didSelect: { tableView, indexPath, viewModel in
                    guard let viewModel = viewModel.value else { return }
                    
                    print("Selected item: \(viewModel.title)")
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            )
        )
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func bindViewModel() {
        viewModel.onLoadingStateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
