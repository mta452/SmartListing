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

import Foundation
import SmartListing

final class HeaderCellViewModel: CellViewModel {
    private let headerInfo: HeaderInfo
    
    init(headerInfo: HeaderInfo) {
        self.headerInfo = headerInfo
    }
    
    var name: String { headerInfo.name }
    var bannerImage: String { headerInfo.bannerImage }
    var profileImage: String { headerInfo.profileImage }
    var headline: String { headerInfo.headline }
}
