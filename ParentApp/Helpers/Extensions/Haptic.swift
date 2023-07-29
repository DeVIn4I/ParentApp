//
//  Haptic.swift
//  ParentApp
//
//  Created by Pavel Razumov on 29.07.2023.
//

import UIKit

enum Haptic {
    
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    static func selection() {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    static func notification(_ style:UINotificationFeedbackGenerator.FeedbackType) {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        notificationFeedbackGenerator.notificationOccurred(style)
    }
}
