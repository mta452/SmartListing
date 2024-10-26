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

final class ExperienceCell: UITableViewCell, TableViewCellProtocol, ShimmeringViewProtocol {
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var jobTitleLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    var shimmeringAnimatedItems: [UIView] {
        return [logoImageView, jobTitleLabel, companyLabel, durationLabel]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: Loadable<ExperienceCellViewModel>) {
        setShimmering(viewModel.isLoading)
        
        if let viewModel = viewModel.value {
            logoImageView.image = UIImage(named: viewModel.logoImage)
            jobTitleLabel.text = viewModel.jobTitle
            companyLabel.text = viewModel.company
            durationLabel.text = viewModel.duration
            separatorView.isHidden = viewModel.isSeparatorHidden
        }
    }
}
