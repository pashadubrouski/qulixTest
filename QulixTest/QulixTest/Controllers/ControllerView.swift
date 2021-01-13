import UIKit

protocol ControllerView{
    associatedtype ControllerViewType: UIView
    var controllerView: ControllerViewType! { get }
}

extension ControllerView where Self: UIViewController {
    var controllerView: ControllerViewType! {
        guard let view = self.view as? ControllerViewType
        else { return ControllerViewType() }
        return view
    }
}
