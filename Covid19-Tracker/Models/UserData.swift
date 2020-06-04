//
//  UserData.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
}
