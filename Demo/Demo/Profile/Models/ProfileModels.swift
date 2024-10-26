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

struct Profile {
    let headerInfo: HeaderInfo
    let experiences: [Experience]
    let skills: [Skill]
}

struct HeaderInfo {
    let name: String
    let bannerImage: String
    let profileImage: String
    let headline: String
    let location: String
}

struct Experience {
    let logoImage: String
    let jobTitle: String
    let company: String
    let duration: String
}

struct Skill {
    let name: String
}
