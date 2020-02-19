
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    let notificationCenters = NotificationCenters()
    let conсreteObserver = ConсreteObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func updateActionButton(_ sender: Any) {
        notificationCenters.someBusinessLogic()
    }
    
    @IBAction func subscribeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            notificationCenters.subscribe(self)
            notificationCenters.subscribe(conсreteObserver)
        } else {
            notificationCenters.unSubscribe(self)
            notificationCenters.unSubscribe(conсreteObserver)
        }
    }
}

//MARK: - ObserverProtocol
protocol ObserverProtocol: class {
    func update(subject: NotificationCenters)
}

//MARK: - NotificationCenters
class NotificationCenters {
    var  state: Int = {
        return Int(arc4random_uniform(10))
    }()
    private lazy var observers = [ObserverProtocol]()
    
    func subscribe(_ observer: ObserverProtocol) {
        print(#function)
        observers.append(observer)
    }
    
    func unSubscribe(_ observer: ObserverProtocol) {
        if let index = observers.firstIndex(where: {$0 === observer}) { //удаляем обьект по ссылке
            observers.remove(at: index)
            print(#function)
        }
    }
    
    func notify() {
        print(#function)
        observers.forEach( { $0.update(subject: self)} )
    }
    
    func someBusinessLogic() {
        print(#function)
        state = Int(arc4random_uniform(10))
        notify()
    }
}

//MARK: - ConсreteObserver
class ConсreteObserver: ObserverProtocol {
    
    func update(subject: NotificationCenters) {
        print("ConсreteObserver - ", subject.state)
    }
}

//MARK: - Extension ViewController
extension ViewController:  ObserverProtocol {
    
    func update(subject: NotificationCenters) {
        textLabel.text = "subject state: - \(subject.state)"
    }
}
