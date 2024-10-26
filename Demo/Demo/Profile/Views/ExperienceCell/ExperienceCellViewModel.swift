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

final class ExperienceCellViewModel: CellViewModel {
    private let experience: Experience
    private let isLast: Bool
    
    init(
        experience: Experience,
        isLast: Bool = false
    ) {
        self.experience = experience
        self.isLast = isLast
    }
    
    var logoImage: String { experience.logoImage }
    var jobTitle: String { experience.jobTitle }
    var company: String { experience.company }
    var duration: String { experience.duration }
    var isSeparatorHidden: Bool { isLast }
}
