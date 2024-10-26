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

final class HeaderCell: UITableViewCell, TableViewCellProtocol, ShimmeringViewProtocol {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var headlineLabel: UILabel!
    
    var shimmeringAnimatedItems: [UIView] {
        return [nameLabel, bannerImageView, profileImageView, headlineLabel]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with viewModel: Loadable<HeaderCellViewModel>) {
        setShimmering(viewModel.isLoading)
        
        if let viewModel = viewModel.value {
            nameLabel.text = viewModel.name
            bannerImageView.image = UIImage(named: viewModel.bannerImage)
            profileImageView.image = UIImage(named: viewModel.profileImage)
            headlineLabel.text = viewModel.headline
        }
    }
}
