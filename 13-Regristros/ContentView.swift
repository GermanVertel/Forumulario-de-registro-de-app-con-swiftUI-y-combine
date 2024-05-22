//
//  ContentView.swift
//  13-Regristros
//
//  Created by German David Vertel Narvaez on 21/05/24.
//

import SwiftUI

struct ContentView: View {
    
       
   @ObservedObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            
            Text("Crear nueva cuenta")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(24)
            
            FormView(fieldName: "Nombre de usuario", fieldValue: $viewModel.username)
            RequiremenText(iconName: viewModel.isUsernameLengtValid ? "lock.open" : "lock", iconColor: viewModel.isUsernameLengtValid ? Color.green : Color.red,  requirementText: "Minimo 6 caracteres", isVerified: viewModel.isUsernameLengtValid)
                .padding()
    
          
            FormView(fieldName: "Contraseña", fieldValue: $viewModel.password, isSecure: true)            
            VStack {
               
                RequiremenText(iconName: viewModel.isPasswordLengtValid ? "lock.open" : "lock", iconColor: viewModel.isPasswordLengtValid ? Color.green : Color.red,  requirementText: "Minimo 8 caracteres", isVerified: viewModel.isPasswordLengtValid)
                    
              
                RequiremenText(iconName: viewModel.isPasswordCapitalValid ? "lock.open" : "lock", iconColor: viewModel.isPasswordCapitalValid ? Color.green : Color.red,  requirementText: "Por lo menos una mayuscula", isVerified: viewModel.isPasswordCapitalValid)
                
                
                    
            }.padding()
       
      
            FormView(fieldName: "Validar contraseña", fieldValue: $viewModel.passwordValidation, isSecure: true)
            RequiremenText(iconName: viewModel.isPasswordConfirmedValid ? "lock.open" : "lock", iconColor: viewModel.isPasswordConfirmedValid ? Color.green : Color.red,  requirementText: "las contraseñas no coinciden", isVerified: viewModel.isPasswordConfirmedValid)
                .padding()
                .padding(.bottom, 46)
                
           
            
            Button(action:{
                //proceder a la siguente pantalla si tood ok
            }){
                Text("Registrarse")
                    .font(.system(.headline, design: .rounded))
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red:135/255, green: 240/255, blue: 160/255), Color(red:135/255, green:160/225, blue: 240/255)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
            }
            
            HStack{
                Text("¿Ya tienes cuenta con nosotros?")
                    .font(.system(.callout, design: .rounded))
                    .bold()
                Button(action:{
                    //TODO: Llevar a la pantalla de login
                }, label:{
                    Text("Entrar")
                        .font(.system(.callout, design: .rounded))
                        .bold()
                        .foregroundStyle(Color(red: 145/255, green: 160/255, blue: 140/255))
                })
            }
            
             
                    
            }
        .padding()
        }
    }


    
struct RequiremenText: View {
    
    var iconName = "look"
    var iconColor = Color(red: 250/255, green: 135/255, blue: 135/255)
    var requirementText = ""
    var isVerified = false
    
    var body: some View{
        HStack{
            Image(systemName : iconName)
                .foregroundStyle(iconColor)
            
            Text(requirementText)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
                .strikethrough(isVerified)
            
            Spacer()
        }
    }
}

struct FormView: View {
    
    var fieldName = ""
    @Binding var fieldValue: String
    var isSecure = false
    
    
    var body: some View {
        VStack{
            if isSecure{
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .padding(.horizontal)
            }else{
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .padding(.horizontal)
                    
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 235/255, green: 235/255, blue: 235/255))
                .padding(.horizontal)
        }
    }
}


#Preview {
    ContentView()
}
