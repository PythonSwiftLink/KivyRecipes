//
//  PyBT+Extensions.swift
//  php_app
//
//  Created by MusicMaker on 06/04/2023.
//

import Foundation
import CoreBluetooth

extension CBService: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBService(self) }
}

var temp_storage_service: CBService?

extension CBPeripheral: PyConvertible, CBPeripheral_PyProtocol {
    
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBPeripheral(self) }
}

extension CBCharacteristic: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBCharacteristic(self) }
}

extension CBCharacteristic: CBCharacteristic_PyProtocol {
    func __repr__() -> String { description }
    func __str__() -> String { description }
}

extension CBDescriptor: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBDescriptor(self) }
}

extension CBL2CAPChannel: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBL2CAPChannel(self) }
}

extension CBUUID: PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    public var pyPointer: PyPointer { create_pyCBUUID(self) }
}

extension CBUUID: CBUUID_PyProtocol {
    func __repr__() -> String { description }
    func __str__() -> String { description }
}





