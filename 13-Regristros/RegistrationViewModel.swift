//
//  RegistrationViewModel.swift
//  13-Regristros
//
//  Created by German David Vertel Narvaez on 22/05/24.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    //entradas
    @Published var username = ""
    @Published var password = ""
    @Published var passwordValidation = ""
    
    //salidas
    @Published var isUsernameLengtValid = false
    @Published var isPasswordLengtValid = false
    @Published var isPasswordCapitalValid = false
    @Published var isPasswordConfirmedValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(){
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 6
            }
            .assign(to: \.isUsernameLengtValid , on: self)
            .store(in: &cancellableSet)
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengtValid, on: self)
            .store(in: &cancellableSet)
        
        
        
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]" //DIGOSTOS "[0-9]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalValid, on: self)
            .store(in: &cancellableSet)
           
        Publishers.CombineLatest($password, $passwordValidation)
            .receive(on: RunLoop.main)
            .map { (password1, password2) in
                return !password1.isEmpty && !password2.isEmpty && (password1 == password2)
            }
            .assign(to: \.isPasswordConfirmedValid, on: self)
            .store(in: &cancellableSet)
    }
    
    
}
