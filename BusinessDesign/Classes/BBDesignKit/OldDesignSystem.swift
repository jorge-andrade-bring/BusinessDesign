//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import Foundation

/// This is the class that all the Design System engine starts from. Call `setup(with:)` to inject your own configuration.
public class OldDesignSystem {
    public static let shared = OldDesignSystem()

    public static private(set) var colors = ColorsConfiguration()
    public static private(set) var fonts = FontsConfiguration()
    public static private(set) var icons = IconsConfiguration()

    internal private(set) var configuration = DesignConfiguration()

    private init() {}
}

// MARK: - DesignSystem configuration setups
public extension OldDesignSystem {
    func configure(_ designConfiguration: DesignConfiguration) {
        self.configuration = designConfiguration
    }

    func configure(_ colors: ColorsConfiguration) {
        OldDesignSystem.colors = colors
    }

    func configure(_ fonts: FontsConfiguration) {
        OldDesignSystem.fonts = fonts
    }

    func configure(_ icons: IconsConfiguration) {
        OldDesignSystem.icons = icons
    }
}
