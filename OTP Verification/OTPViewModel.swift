//
//  OTPViewModel.swift
//  OTP Verification
//
//  Created by faishal on 13/09/22.
//

import SwiftUI

class OTPViewModel: ObservableObject {
    
    @Published var otpText: String = ""
    @Published var otpFields: [String] = Array(repeating: "", count: 6)
    
}


enum OTPTextField {
    case textField0
    case textField1
    case textField2
    case textField3
    case textField4
    case textField5
}
