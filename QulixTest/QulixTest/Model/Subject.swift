import Foundation
import Combine

protocol SubjectProtocol {
    associatedtype DataType
    var data: DataType { get set }
    var publisher: AnyPublisher<DataType, Never>{ get }
}

class Subject<T>: SubjectProtocol {
    typealias DataType = T
    init(_ data: T){ self.data = data }
    
    var data: T{
        didSet{
            subject.send(data)
        }
    }
    
    var publisher: AnyPublisher<T, Never>{ subject.eraseToAnyPublisher() }
    private let subject = PassthroughSubject<T, Never>()
    
    
    
    
    
}
