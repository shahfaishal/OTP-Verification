//
//  VerifyOTPView.swift
//  OTP Verification
//
//  Created by faishal on 13/09/22.
//

import SwiftUI

struct VerifyOTPView: View {
    
    //MARK: - PROPERTIES AND INITIALIZERS
    @StateObject var otpModel: OTPViewModel = .init()
    @FocusState var activeTextField: OTPTextField?
    
    var body: some View {
        VStack {
            OTPField()
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: otpModel.otpFields) { newValue in
            otpCondition(value: newValue)
        }
    }
    
    //MARK: - CUSTOM OTP TEXTFIELD
    @ViewBuilder
    private func OTPField() -> some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                VStack(spacing: 5) {
                    TextField("", text: $otpModel.otpFields[index])
                    .frame(width: 45, height: 45)
                    .background(Color.init(uiColor: .systemGray6))
                    .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeTextField, equals: activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill(activeTextField == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                        .frame(height: 5)
                }
            }
        }
    }
    
    private func activeStateForIndex(index: Int) -> OTPTextField {
        switch index {
        case 0: return .textField0
        case 1: return .textField1
        case 2: return .textField2
        case 3: return .textField3
        case 4: return .textField4
//        case 5: return .textField5
        default: return .textField5
        }
    }
    
    private func otpCondition(value: [String]) {
        //Move to next field
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeTextField {
                activeTextField = activeStateForIndex(index: index+1)
            }
        }
        
        //Back to previous field
        for index in 1...5 {
            if value[index].isEmpty && !value[index-1].isEmpty {
                activeTextField = activeStateForIndex(index: index-1)
            }
        }
        
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
}

struct VerifyOTPView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyOTPView()
    }
}
