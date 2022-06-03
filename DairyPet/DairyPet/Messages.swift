
import SwiftUI

struct Message: View {
    enum MessageStyle {
        case error
        case message
        case success
        case warning

        var backgroundColor: Color {
            switch self {
            case .error: return Message.errorRed
            case .message: return .white
            case .success: return Message.successGreen
            case .warning: return Message.warningYellow
            }
        }

        var textColor: Color {
            switch self {
            case .error: return .white
            case .message: return .black
            case .success: return .white
            case .warning: return .black
            }
        }
    }

    let title: String
    let message: String
    let borderColor: Color
    let borderWidth: CGFloat
    let style: MessageStyle

    private let cornerRadius: CGFloat = 8

    init(title: String, message: String, borderColor: Color = .black, borderWidth: CGFloat = 0, style: MessageStyle = .message) {
        self.title = title
        self.message = message
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.style = style
    }

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                style.backgroundColor
                    .cornerRadius(cornerRadius)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(style.textColor)
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(style.textColor)
                }
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .padding()
            Spacer()
        }
        .transition(.move(edge: .top)) // 1
        
        .animation(.spring()) // 2
        

    }
}

extension Message {
    static let errorRed = Color(red: 236/255, green: 32/255, blue: 32/255)
    static let successGreen = Color(red: 19/255, green: 127/255, blue: 13/255)
    static let warningYellow = Color(red: 236/255, green: 187/255, blue: 32/255)
}
