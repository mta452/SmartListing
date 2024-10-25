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

open class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let tableView: UITableView
    
    private let numberOfSections: (() -> Int)?
    private let numberOfRows: ((_ section: Int) -> Int)
    
    private let cellViewModel: ((IndexPath) -> CellViewModel)
    private let headerViewModel: ((_ section: Int) -> ReusableItemViewModel)?
    private let footerViewModel: ((_ section: Int) -> ReusableItemViewModel)?
    
    private var headerFooterViewHandlers: [String: TableViewHeaderFooterViewHandler] = [:]
    private var cellHandlers: [String: TableViewCellHandler] = [:]
    
    public init(
        tableView: UITableView,
        numberOfSections: (() -> Int)? = nil,
        numberOfRows: @escaping ((_ section: Int) -> Int),
        cellViewModel: @escaping ((IndexPath) -> CellViewModel),
        headerViewModel: ((_ section: Int) -> ReusableItemViewModel)? = nil,
        footerViewModel: ((_ section: Int) -> ReusableItemViewModel)? = nil
    ) {
        self.tableView = tableView
        self.numberOfSections = numberOfSections
        self.numberOfRows = numberOfRows
        self.headerViewModel = headerViewModel
        self.footerViewModel = footerViewModel
        self.cellViewModel = cellViewModel
        
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public func register<View: TableViewHeaderFooterViewProtocol<ViewModel>, ViewModel: ReusableItemViewModel>(_ viewType: View.Type) {
        register(TableViewHeaderFooterViewHandler(viewType))
    }
    
    public func register<Cell: TableViewCellProtocol<ViewModel>, ViewModel: CellViewModel>(_ cellType: Cell.Type) {
        register(TableViewCellHandler(cellType))
    }
    
    public func register(_ handler: TableViewHeaderFooterViewHandler) {
        handler.register(in: tableView)
        headerFooterViewHandlers[handler.viewModelIdentifier] = handler
    }
    
    public func register(_ handler: TableViewCellHandler) {
        handler.register(in: tableView)
        cellHandlers[handler.viewModelIdentifier] = handler
    }
    
    private func headerFooterViewHandler(for viewModel: ReusableItemViewModel) -> TableViewHeaderFooterViewHandler? {
        let identifier = type(of: viewModel).identifier
        return headerFooterViewHandlers[identifier]
    }
    
    private func cellHandler(for viewModel: CellViewModel) -> TableViewCellHandler? {
        let identifier = type(of: viewModel).identifier
        return cellHandlers[identifier]
    }
    
    // MARK: - UITableViewDataSource Methods
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections?() ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = cellViewModel(indexPath)
        
        if let handler = cellHandler(for: viewModel) {
            return handler.configure(tableView, indexPath, viewModel)
        }
        
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate Methods
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if headerViewModel == nil {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if footerViewModel == nil {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = headerViewModel?(section),
              let handler = headerFooterViewHandler(for: viewModel) else {
            return nil
        }
        
        return handler.configure(tableView, section, viewModel)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let viewModel = footerViewModel?(section),
              let handler = headerFooterViewHandler(for: viewModel) else {
            return nil
        }
        
        return handler.configure(tableView, section, viewModel)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = cellViewModel(indexPath)
        
        if let handler = cellHandler(for: viewModel) {
            handler.didSelect?(tableView, indexPath, viewModel)
        }
    }
}
