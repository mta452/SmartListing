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

private struct Section {
    let header: ReusableItemViewModel?
    let footer: ReusableItemViewModel?
    let items: [CellViewModel]
    
    init(
        header: ReusableItemViewModel? = nil,
        footer: ReusableItemViewModel? = nil,
        items: [CellViewModel]
    ) {
        self.header = header
        self.footer = footer
        self.items = items
    }
}

final class ProfileViewModel {
    private var profile: Profile?
    private var sections: [Section]
    
    private(set) var isLoading = true
    
    var onLoadingStateChanged: (() -> Void)?
    
    init() {
        sections = [
            Section(
                items: [Loadable<HeaderCellViewModel>.loading]
            )
        ]
    }
    
    private func loadProfile() {
        profile = Profile(
            headerInfo: HeaderInfo(
                name: "Tayyab Akram",
                bannerImage: "Banner",
                profileImage: "Profile",
                headline: "Sr. Software Engineer | iOS | Swift",
                location: "Pakistan"
            ),
            experiences: [
                Experience(
                    logoImage: "SadaPayLogo",
                    jobTitle: "Senior Software Engineer",
                    company: "SadaPay",
                    duration: "Dec 2021 - June 2024 · 2 yrs 7 mos"
                ),
                Experience(
                    logoImage: "DigitifyLogo",
                    jobTitle: "Sr. Software Engineer - iOS",
                    company: "Digitify",
                    duration: "Jul 2021 - Nov 2021 · 5 mos"
                ),
                Experience(
                    logoImage: "TheEntertainerLogo",
                    jobTitle: "Senior Software Engineer (iOS)",
                    company: "The ENTERTAINER",
                    duration: "May 2020 - Jun 2021 · 1 yr 2 mos"
                ),
                Experience(
                    logoImage: "VentureDiveLogo",
                    jobTitle: "Senior Software Engineer (iOS)",
                    company: "VentureDive",
                    duration: "Dec 2017 - Feb 2020 · 2 yrs 3 mos"
                ),
                Experience(
                    logoImage: "CareemLogo",
                    jobTitle: "iOS Engineer",
                    company: "Careem",
                    duration: "Aug 2019 - Feb 2020 · 7 mos"
                ),
                Experience(
                    logoImage: "SDSolTechnologiesLogo",
                    jobTitle: "iOS Developer",
                    company: "SDSol Technologies",
                    duration: "Sep 2015 - Nov 2017 · 2 yrs 3 mos"
                )
            ],
            skills: [
                Skill(name: "iOS Development"),
                Skill(name: "Swift"),
                Skill(name: "MVVM")
            ]
        )
    }
    
    func loadData() {
        loadProfile()
        guard let profile else { return }
        
        sections = [
            Section(
                footer: FooterViewModel(),
                items: [
                    Loadable.loaded(HeaderCellViewModel(headerInfo: profile.headerInfo))
                ]
            ),
            Section(
                header: HeaderViewModel(heading: "Experience"),
                footer: FooterViewModel(),
                items: profile.experiences
                    .enumerated()
                    .map { index, experience in
                        Loadable.loaded(
                            ExperienceCellViewModel(
                                experience: experience,
                                isLast: index == profile.experiences.count - 1
                            )
                        )
                    }
            ),
            Section(
                header: HeaderViewModel(heading: "Skills"),
                footer: FooterViewModel(),
                items: profile.skills
                    .enumerated()
                    .map { index, skill in
                        Loadable.loaded(
                            SkillCellViewModel(
                                skill: skill,
                                isLast: index == profile.skills.count - 1
                            )
                        )
                    }
            )
        ]
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return sections[section].items.count
    }
    
    func header(for section: Int) -> ReusableItemViewModel? {
        return sections[section].header
    }
    
    func footer(for section: Int) -> ReusableItemViewModel? {
        return sections[section].footer
    }
    
    func item(at indexPath: IndexPath) -> CellViewModel {
        return sections[indexPath.section].items[indexPath.row]
    }
}
