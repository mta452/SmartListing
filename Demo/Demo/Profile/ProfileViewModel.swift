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
    private var sections: [Section] = []
    
    private(set) var isLoading = false
    
    var onLoadingStateChanged: (() -> Void)?
    
    func loadData() {
        isLoading = true
        setupSkeletonSections()
        onLoadingStateChanged?()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            
            loadProfile()
            populateProfileSections()
            
            isLoading = false
            onLoadingStateChanged?()
        }
    }
    
    private func setupSkeletonSections() {
        sections = [
            Section(
                items: [
                    Loadable<HeaderCellViewModel>.loading
                ]
            ),
            Section(
                header: Loadable<HeaderViewModel>.loading,
                items: [
                    Loadable<AboutCellViewModel>.loading
                ]
            ),
            Section(
                header: Loadable<HeaderViewModel>.loading,
                items: [
                    Loadable<ExperienceCellViewModel>.loading,
                    Loadable<ExperienceCellViewModel>.loading,
                    Loadable<ExperienceCellViewModel>.loading
                ]
            ),
            Section(
                header: Loadable<HeaderViewModel>.loading,
                items: [
                    Loadable<EducationCellViewModel>.loading
                ]
            ),
            Section(
                header: Loadable<HeaderViewModel>.loading,
                items: [
                    Loadable<SkillCellViewModel>.loading,
                    Loadable<SkillCellViewModel>.loading,
                    Loadable<SkillCellViewModel>.loading,
                ]
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
            about: """
                   I specialize in mobile app development. My past projects included working with complex UI and custom views, web services and REST API's, push notifications, SQLite databases, background services, integration with social networks and in-app purchases.

                   Technical Skills:
                   ✓ Languages: Swift, Kotlin, JAVA, C/C++
                   ✓ Revision Control: Git, SourceTree
                   ✓ CI/CD: Bitrise, GitHub Actions
                   ✓ Development Software: Xcode, Android Studio, Visual Studio Code
                   ✓ Typography: FreeType, HarfBuzz, OpenType
                   ✓ Open Source: SheenBidi, Tehreer-Android, Tehreer-Cocoa, SmartListing
                   """,
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
            education: [
                Education(
                    logoImage: "PunjabUniversityLogo",
                    institution: "University of the Punjab",
                    field: "Bachelor’s Degree, Information Technology",
                    duration: "2011 - 2015"
                )
            ],
            skills: [
                Skill(name: "iOS Development"),
                Skill(name: "Swift"),
                Skill(name: "MVVM")
            ]
        )
    }
    
    private func populateProfileSections() {
        guard let profile else {
            sections = []
            return
        }
        
        sections = [
            Section(
                footer: FooterViewModel(),
                items: [
                    Loadable.loaded(HeaderCellViewModel(headerInfo: profile.headerInfo))
                ]
            ),
            Section(
                header: Loadable.loaded(HeaderViewModel(heading: "About")),
                footer: FooterViewModel(),
                items: [
                    Loadable.loaded(AboutCellViewModel(detail: profile.about))
                ]
            ),
            Section(
                header: Loadable.loaded(HeaderViewModel(heading: "Experience")),
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
                header: Loadable.loaded(HeaderViewModel(heading: "Education")),
                footer: FooterViewModel(),
                items: profile.education
                    .enumerated()
                    .map { index, education in
                        Loadable.loaded(
                            EducationCellViewModel(
                                education: education,
                                isLast: index == profile.education.count - 1
                            )
                        )
                    }
            ),
            Section(
                header: Loadable.loaded(HeaderViewModel(heading: "Skills")),
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
