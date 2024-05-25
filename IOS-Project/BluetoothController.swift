import SwiftUI
import CoreBluetooth

class BluetoothController: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var isBluetoothEnabled = false
    @Published var peripherals = [CBPeripheral]()

    private var centralManager: CBCentralManager!
    private var connectingPeripheral: CBPeripheral?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            isBluetoothEnabled = true
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        default:
            isBluetoothEnabled = false
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
        }
    }

    func connect(peripheral: CBPeripheral) {
        connectingPeripheral = peripheral
        centralManager.connect(peripheral, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    }
}


struct BluetoothView: View {
    @ObservedObject var bleManager = BluetoothController()

    var body: some View {
        NavigationView {
            List(bleManager.peripherals, id: \.identifier) { peripheral in
                Text(peripheral.name ?? "Unknown")
            }
            .navigationTitle("BLE Devices")
        }
    }
}


