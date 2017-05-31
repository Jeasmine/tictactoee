import SwiftMessages

class MessageBuilder {
    
    static func showWarningMessage(titleMessage: String, bodyMessage: String) {
        makeMessage(theme: .warning, titleMessage: titleMessage, bodyMessage: bodyMessage, icon: "🐮")
    }
    
    static func showErrorMessage(titleMessage: String, bodyMessage: String) {
        makeMessage(theme: .error, titleMessage: titleMessage, bodyMessage: bodyMessage, icon: "☹️")
    }
    
    static func makeMessage(theme: Theme, titleMessage: String, bodyMessage: String, icon: String) {
        SwiftMessages.show {
            let view = MessageView.viewFromNib(layout: .CardView)
            view.configureTheme(theme)
            view.configureDropShadow()
            view.button?.isHidden = true
            view.configureContent(title: titleMessage, body: bodyMessage, iconText: icon)
            return view
        }
    }
}
