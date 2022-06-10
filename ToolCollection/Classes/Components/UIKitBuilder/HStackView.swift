//
//  HStackView.swift
//  UIKitBuilder
//
//  Created by Nghia on 4/26/20.
//  Copyright © 2020 Nghia. All rights reserved.
//

import UIKit

public class HStackView: StackView {
    public init(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = 0,
        layoutMargins: UIEdgeInsets = .zero,
        @StackViewBuilder builder: () -> StackNode) {
        super.init(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            layoutMargins: layoutMargins,
            nodes: builder)
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
