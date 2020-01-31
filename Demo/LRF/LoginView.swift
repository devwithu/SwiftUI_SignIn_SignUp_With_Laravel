//
//  LoginView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI
import Alamofire


struct LoginView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    @State var email: String = ""
    @State var password: String = ""
    @State var alertMsg = ""
    
    @State private var showForgotPassword = false
    @State private var showSignup = false
    @State var showAlert = false
    @State var showDetails = false
    
    @State var loginSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
        VStack {
            
            VStack {
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                
                RoundedImage()
                
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_email")
                            .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)
                        
                        TextField("Email", text: $email)
                            .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                            .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        
                    }
                    seperator()
                }
                
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                
                VStack {
                    
                    HStack {
                        Image("ic_password")
                            .padding(.leading, (UIScreen.main.bounds.width * 20) / 414)
                        
                        SecureField("Password", text: $password)
                            .frame(height: (UIScreen.main.bounds.width * 40) / 414, alignment: .center)
                            .padding(.leading, (UIScreen.main.bounds.width * 10) / 414)
                            .padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .regular, design: .default))
                            .imageScale(.small)
                    }
                    seperator()
                    
                }
                
                Spacer(minLength: (UIScreen.main.bounds.width * 15) / 414)
                
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.showForgotPassword = true
                        }) {
                            Text("Forgot Passowrd?")
                                .foregroundColor(Color("TextColor"))
                                .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))
                            
                        }.sheet(isPresented: self.$showForgotPassword) {
                            ForgotPasswordView()
                        }
                        
                    }.padding(.trailing, (UIScreen.main.bounds.width * 10) / 414)
                }
                
                
                VStack {
                    Spacer()
                    Button(action: {
                        if  self.isValidInputs() {
                            
                            print("action")
                            
                            
//                            AF.request("https://dev.jdj.kr/api/auth/login").responseData { (resData) -> Void in
//                                print(resData.result)
////                                let strOutput = String(data : resData.result, encoding : String.Encoding.utf8)
////                                print(strOutput)
//                            }
                            
                            let parameter = [
                                "email": self.email,
                                "password": self.password
                            ]
                            
                            
                            //let session = Alamofire.Session()
                            //let request = session.request(
                            let request = AF.request(
                              "https://dev.jdj.kr/api/auth/login",
                              method: .post,
                              parameters: parameter, // or `userDictionary` because both conform to `Encodable`
                              encoder: JSONParameterEncoder.default)

                            // Receive and decode the server's JSON response,
                            // where `ExpectedResponse` is a struct that conforms to
                            // either `Codable` or just `Decodable`.
                            request.responseDecodable(of: LoginResponse.self) { response in
                              switch response.result {
                              case let .success(result):
                                // Do something useful with `result`, the decoded result of
                                // type `ExpectedResponse` that you received from the server
                                print(result.access_token)
                                
                                UserDefaults.standard.set(true, forKey: "Loggedin")
                                UserDefaults.standard.set(result.access_token, forKey: "access_token")
                                UserDefaults.standard.synchronize()
                                self.settings.loggedIn = true
                                
                              case let .failure(error):
                                // Handle the error, a 404 for example.
                                 print(error)
                              }
                            }
                            
                           
                            
                            
                            print("end")
                            
                            
                            // For use with property wrapper
//                            UserDefaults.standard.set(true, forKey: "Loggedin")
//                            UserDefaults.standard.synchronize()
//                            self.settings.loggedIn = true
                            // ==========
                            
                            // For use with property wrapper
                            //                self.dataStore.loggedIn = true
                            // ==========
                        }
                        
                    }) {
                        buttonWithBackground(btnText: "LOGIN")
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer(minLength: (UIScreen.main.bounds.width * 10) / 414)
                    Button(action: {
                        self.showSignup = true
                    }) {
                        Text("New User? Create an account")
                            .foregroundColor(Color("TextColor"))
                            .font(.system(size: (UIScreen.main.bounds.width * 15) / 414, weight: .bold, design: .default))
                        
                    }.sheet(isPresented: self.$showSignup) {
                        SignUpView()
                            .environmentObject(self.settings)
                    }
                    
                    Spacer(minLength: (UIScreen.main.bounds.width * 20) / 414)
                }
            }
                
            .alert(isPresented: $showAlert, content: { self.alert })
        }
    }
    
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.email == "" {
            self.alertMsg = "Email can't be blank."
            self.showAlert.toggle()
            return false
        } else if !self.email.isValidEmail {
            self.alertMsg = "Email is not valid."
            self.showAlert.toggle()
            return false
        } else if self.password == "" {
            self.alertMsg = "Password can't be blank."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
