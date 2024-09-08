import SwiftUI
import SafariServices

struct SafariVC: UIViewControllerRepresentable {
    var url: URL
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.dismissButtonStyle = .close
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onClose: { dismiss() })
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        var onClose: () -> ()
        init(onClose: @escaping () -> Void) {
            self.onClose = onClose
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            onClose()
        }
    }
}
