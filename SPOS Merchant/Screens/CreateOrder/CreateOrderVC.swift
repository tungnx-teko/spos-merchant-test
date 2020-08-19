//
//  CreateOrderVC.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import UIKit
import SVProgressHUD
import TekOrderService
import TekCoreService
import Minerva
import MinervaCore

class CreateOrderVC: BaseViewController {

    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    let price: Int = 284000
    
    var quantity: Int = 1 {
        didSet {
            payButton.setTitle("Thanh toán \((price * quantity).toCurrencyString() ?? "") ₫", for: .normal)
            quantityLabel.text = "\(quantity)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func didChangeQuantity(_ sender: UIStepper) {
        quantity = Int(sender.value)
    }
    
    @IBAction func didTapPayment(_ sender: Any) {
        SVProgressHUD.show()
        createOrder()
    }
    
}

extension CreateOrderVC {
    
    func createOrder() {
        let item = OrderItem(quantity: quantity, sellerId: 1, sku: "1600596",
                             price: price, rowTotal: price * quantity,
                             lineItemId: UUID().uuidString,
                             unitPrice: "\(price)",
                            displayName: "Chuot khong day", name: "Chuot khong day")
        let orderPayload = OrderPayload(grandTotal: price * quantity,
                                        channelId: 6,
                                        terminalCode: "CP01",
                                        channelCode: "pv_showroom",
                                        items: [item])
        do {
            let data = try JSONEncoder().encode(orderPayload)
            let params = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            OrderManager.shared.createOrder(params: params ?? [:], completion: { [weak self] order, error in
                SVProgressHUD.dismiss()
                if let order = order {
                    self?.payOrder(order: order)
                    return
                } else {
                    self?.showAlert(title: "Có lỗi xảy ra", message: error?.localizedDescription)
                }
            })
        } catch {
            print(error)
            SVProgressHUD.dismiss()
        }
    }
    
    func payOrder(order: Order) {
        let config = MinervaGatewayConfig(clientCode: "PVSDK1",
                                          terminalCode: ClientManager.shared.terminalCode ?? "",
                                          serviceCode: "RETAIL",
                                          secretKey: "354deb9bf68088199d8818f71c01951f",
                                          baseUrl: "https://payment.stage.tekoapis.net/api")
        
        MinervaGateway.addPaymentMethods([.qr, .spos])
        MinervaGateway.setUp(config, environment: .development)
        
        Minerva.Theme.primaryColor = UIColor.primary!
        Minerva.Strings.sposWaitingResult = "Vui lòng chuyển sang thanh toán bằng SPOS"
        Minerva.Strings.paymentSPOSMethod = "VNPay POS"
        
        let request = PaymentRequest(orderId: order.id, orderCode: order.code, amount: order.grandTotal)
        
        let pm = PaymentRouter.createModule(request: request, delegate: self)
        pm.modalPresentationStyle = .fullScreen
        present(pm, animated: true, completion: nil)
    }
}

extension CreateOrderVC: PaymentDelegate {
    
    func onCancel() {
        
    }
    
    func onResult(_ result: PaymentResult) {
        switch result {
        case .success(let transaction):
            showAlert(title: "Thanh toán thành công", message: "Thanh toán thành công đơn hàng \(transaction.amount ?? 0) ₫")
        default:
            showAlert(title: "Thất bại", message: "Có lỗi xảy ra khi thanh toán đơn hàng")
        }
    }
    
}
