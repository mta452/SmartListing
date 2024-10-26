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

final class EducationCell: UITableViewCell, TableViewCellProtocol {
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var institutionLabel: UILabel!
    @IBOutlet private weak var fieldLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with viewModel: Loadable<EducationCellViewModel>) {
        if viewModel.isLoading {
            // Start Shimmering.
        } else {
            // Stop Shimmering.
        }
        
        if let viewModel = viewModel.value {
            logoImageView.image = UIImage(named: viewModel.logoImage)
            institutionLabel.text = viewModel.institution
            fieldLabel.text = viewModel.field
            durationLabel.text = viewModel.duration
            separatorView.isHidden = viewModel.isSeparatorHidden
        }
    }
}
