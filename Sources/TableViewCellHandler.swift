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

import UIKit

public final class TableViewCellHandler {
    private let cellType: any TableViewCellProtocol.Type
    private let viewModelType: any CellViewModel.Type
    
    let configure: ((UITableView, IndexPath, _ viewModel: CellViewModel) -> UITableViewCell)
    let didSelect: ((UITableView, IndexPath, _ viewModel: CellViewModel) -> Void)?
    
    public init<Cell: TableViewCellProtocol<ViewModel>, ViewModel: CellViewModel>(
        _ cellType: Cell.Type,
        configure: ((UITableView, IndexPath, Cell, ViewModel) -> Void)? = nil,
        didSelect: ((UITableView, IndexPath, ViewModel) -> Void)? = nil
    ) {
        self.cellType = Cell.self
        self.viewModelType = ViewModel.self
        
        self.configure = { tableView, indexPath, viewModel in
            guard let viewModel = viewModel as? ViewModel else {
                fatalError("Expected view model of type \(ViewModel.self)")
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
                fatalError("Expected cell of type \(Cell.self))")
            }
            
            if let configure {
                configure(tableView, indexPath, cell, viewModel)
            } else {
                cell.configure(with: viewModel)
            }
            
            return cell
        }
        
        if let didSelect {
            self.didSelect = { tableView, indexPath, viewModel in
                guard let viewModel = viewModel as? ViewModel else {
                    fatalError("Expected view model of type \(ViewModel.self)")
                }
                
                didSelect(tableView, indexPath, viewModel)
            }
        } else {
            self.didSelect = nil
        }
    }
    
    var cellIdentifier: String { cellType.identifier }
    var viewModelIdentifier: String { viewModelType.identifier }
    
    func register(in tableView: UITableView) {
        if let cellNib = cellType.nib {
            tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        } else {
            tableView.register(cellType, forCellReuseIdentifier: cellIdentifier)
        }
    }
}
