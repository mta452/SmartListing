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

public enum Loadable<Value> {
    case loading
    case loaded(Value)
}

public extension Loadable {
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    var value: Value? {
        switch self {
        case .loaded(let value):
            return value
        default:
            return nil
        }
    }
}

extension Loadable: TypeIdentifiable where Value: ReusableItemViewModel { }
extension Loadable: ReusableItemViewModel where Value: ReusableItemViewModel { }
