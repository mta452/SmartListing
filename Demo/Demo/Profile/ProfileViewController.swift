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

final class ProfileViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var tableViewManager: TableViewManager!
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindViewModel()
    }
    
    private func setup() {
        tableViewManager = TableViewManager(
            tableView: tableView,
            numberOfSections: { [weak self] in
                return self?.viewModel.numberOfSections ?? 0
            },
            numberOfRows: { [weak self] section in
                return self?.viewModel.numberOfItems(in: section) ?? 0
            },
            cellViewModel: { [weak self] indexPath in
                return self?.viewModel.item(at: indexPath) ?? EmptyCellViewModel()
            },
            headerViewModel: { [weak self] section in
                return self?.viewModel.header(for: section) ?? EmptyReusableItemViewModel()
            },
            footerViewModel: { [weak self] section in
                return self?.viewModel.footer(for: section) ?? EmptyReusableItemViewModel()
            }
        )
        tableViewManager.register(HeaderView.self)
        tableViewManager.register(FooterView.self)
        tableViewManager.register(HeaderCell.self)
        tableViewManager.register(ExperienceCell.self)
        tableViewManager.register(SkillCell.self)
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = .zero
    }
    
    private func bindViewModel() {
        viewModel.onLoadingStateChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.loadData()
    }
}
