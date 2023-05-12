//
//  PyBT+Extensions.swift
//  php_app
//
//  Created by MusicMaker on 06/04/2023.
//

import Foundation
import CoreBluetooth

extension CBService: PyConvertible, PyHashable {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBService(self) }
    public var __hash__: Int { uuid.hash }
}
extension CBService: CBService_PyProtocol {
    func __repr__() -> String { description }
    
    func __str__() -> String { description }
    
}

var temp_storage_service: CBService?

extension CBPeripheral: PyConvertible, CBPeripheral_PyProtocol, PyHashable {
    
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBPeripheral(self) }
    public var __hash__: Int { identifier.hashValue }
    func __str__() -> String { name ?? identifier.uuidString }
    func __repr__() -> String { description }
}

extension CBCharacteristic: PyConvertible, PyHashable {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBCharacteristic(self) }
    public var __hash__: Int { uuid.hash }
}

extension CBCharacteristic: CBCharacteristic_PyProtocol {
    func __repr__() -> String { description }
    func __str__() -> String { description }
}

extension CBDescriptor: PyConvertible, PyHashable, CBDescriptor_PyProtocol {
    func __repr__() -> String {
        description
    }
    
    func __str__() -> String {
        description
    }
    
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBDescriptor(self) }
    public var __hash__: Int { uuid.hash }
}

extension CBL2CAPChannel: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBL2CAPChannel(self) }
}

extension CBUUID: PyConvertible, PyHashable {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBUUID(self) }
    public var __hash__: Int { hashValue }
}

extension CBUUID: CBUUID_PyProtocol {
    func __repr__() -> String { description }
    func __str__() -> String { description }
}



extension PyCBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        self.peripheral(peripheral: peripheral, didReadRSSI: Int(truncating: RSSI), error: error)
    }
}

extension CBPeripheral {
    
    var _state: Int { state.rawValue }
    
}

