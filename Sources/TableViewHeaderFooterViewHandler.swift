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

public final class TableViewHeaderFooterViewHandler {
    private let viewType: any TableViewHeaderFooterViewProtocol.Type
    private let viewModelType: any ReusableItemViewModel.Type
    
    let configure: ((UITableView, _ section: Int, _ viewModel: ReusableItemViewModel) -> UIView)
    
    public init<View: TableViewHeaderFooterViewProtocol<ViewModel>, ViewModel: ReusableItemViewModel>(
        _ viewType: View.Type,
        configure: ((UITableView, _ section: Int, View, ViewModel) -> Void)? = nil
    ) {
        self.viewType = View.self
        self.viewModelType = ViewModel.self
        
        self.configure = { tableView, section, viewModel in
            guard let viewModel = viewModel as? ViewModel else {
                fatalError("Expected view model of type \(ViewModel.self)")
            }
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: View.identifier) as? View else {
                fatalError("Expected view of type \(View.self))")
            }
            
            if let configure {
                configure(tableView, section, view, viewModel)
            } else {
                view.configure(with: viewModel)
            }
            
            return view
        }
    }
    
    var viewIdentifier: String { viewType.identifier }
    var viewModelIdentifier: String { viewModelType.identifier }
    
    func register(in tableView: UITableView) {
        if let viewNib = viewType.nib {
            tableView.register(viewNib, forHeaderFooterViewReuseIdentifier: viewIdentifier)
        } else {
            tableView.register(viewType, forHeaderFooterViewReuseIdentifier: viewIdentifier)
        }
    }
}
