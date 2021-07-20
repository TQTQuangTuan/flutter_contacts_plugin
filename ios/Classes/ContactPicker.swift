import Foundation
import ContactsUI

class ContactPickerDelegate: NSObject, CNContactPickerDelegate {
    public var onSelectContact: (CNContact) -> Void
    public var onCancel: () -> Void

    init(onSelectContact: @escaping (CNContact) -> Void,
         onCancel: @escaping () -> Void) {
        self.onSelectContact = onSelectContact
        self.onCancel = onCancel
        super.init()
    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        picker.presentingViewController?.dismiss(animated: true, completion: nil)

        onSelectContact(contact)
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.presentingViewController?.dismiss(animated: true, completion: nil)
        onCancel()
    }
}