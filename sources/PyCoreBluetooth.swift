import CoreBluetooth

//class PyCBPeripheralDelegate: PyCBPeripheralDelegate_PyProtocol {
//    required init(py_callback: PythonPointer) {
//        self.py_callback = .init(callback: py_callback)
//    }
//
//    var py_callback: PyCBPeripheralDelegatePyCallback?
//
//
//}

class PyCBPeripheralDelegateTest: NSObject, CBPeripheralDelegate {

    override init() {
    }

    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        fatalError()
    }

    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        fatalError()
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        fatalError()
        
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        fatalError()
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        fatalError()
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        fatalError()
    }

//    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
//        fatalError()
//        //py_callback?.didDiscoverIncludedServices(peripheral: peripheral.pyPointer, service: service.pyPointer, error: error?.localizedDescription)
//    }

    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        fatalError()
        //py_callback?.didReadRSSI(peripheral: peripheral.pyPointer, RSSI: Int(truncating: RSSI), error: error?.localizedDescription)
    }

    func peripheral(_ peripheral: CBPeripheral, didOpen channel: CBL2CAPChannel?, error: Error?) {
        fatalError()
        //py_callback?.didOpenChannel(peripheral: peripheral.pyPointer, channel: channel?.pyPointer ?? .PyNone, error: error?.localizedDescription)
    }

    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        fatalError()
        //py_callback?.didModifyServices(peripheral: peripheral.pyPointer, invalidatedServices: invalidatedServices.pyPointer)
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        fatalError()

    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        fatalError()
        
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        fatalError()

    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        fatalError()
    }
}


extension PyCBPeripheralDelegate: CBPeripheralDelegate {
    
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        
    }
}

extension PyCBPeripheralDelegate: PyConvertible {
    var pyObject: PythonObject {
        .init(getter: pyPointer)
    }
    
    var pyPointer: PyPointer {
        create_pyPyCBPeripheralDelegate(self)
    }
}

class PyCBCentralManager: NSObject {
    private var centralManager: CBCentralManager?
    var peripherals: [CBPeripheral] = []
    private var selectedPeripheral: CBPeripheral?
    //@Published var peripheralNames: [String] = []
    //@Published var isConnected: Bool = false
    
    private var _isConnected: Bool = false
    var isConnected: Bool {
        get {
            _isConnected
        }
        set {
            _isConnected = newValue
            self.py_callback?.connect_status(status: newValue)
        }
    }
    
    var py_callback: PyCBCentralManagerPyCallback?
    
    
    override init()
    {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .global())
    }
    
    func getPeripherals() -> [CBPeripheral] {
        return self.peripherals
        //        return self.peripherals.filter { $0.name != nil }
    }
    
    
}

extension PyCBCentralManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            print("didDiscover",RunLoop.current == RunLoop.main)
            DispatchQueue.main.async {
                self.py_callback?.add_peripheral(peripheral: peripheral)
            }
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        py_callback?.did_connect(peripheral: peripheral)
        //peripheral.discoverServices(nil)
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        py_callback?.remove_peripheral(peripheral: peripheral)
    }
    
}



extension PyCBCentralManager: PyCBCentralManager_PyProtocol {
    
    
    func connect(peripheral: CBPeripheral) {
        self.selectedPeripheral = peripheral
        self.centralManager?.connect(peripheral, options: nil)
        
    }
    
    func disconnect(peripheral: CBPeripheral) {
        self.centralManager?.cancelPeripheralConnection(peripheral)
    
    }

}
