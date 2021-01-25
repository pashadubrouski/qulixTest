import Foundation

protocol Observable{
    associatedtype DataType
    var data: DataType? { get set }
    func register( _ completion: @escaping (DataType) -> Void)
}

class Observer<T> : Observable {
    typealias Callback = (T) -> Void
    var callbaks = [Callback]()
    var data: T? {
        didSet { data.map(notificate) }
    }
    
    func register(_ completion: @escaping Callback) { callbaks.append( completion ) }
    
    func notificate(_ data: T) {
        callbaks.forEach { (callback) in
            callback(data)
        }
    }
}
