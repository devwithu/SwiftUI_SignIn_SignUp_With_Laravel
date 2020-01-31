//
//  SignUpView.swift
//  DemoSwiftUI
//
//  Created by mac-00018 on 10/10/19.
//  Copyright © 2019 mac-00018. All rights reserved.
//

import SwiftUI
import Alamofire

struct SignUpView: View {
    
    @EnvironmentObject var settings: UserSettings
    @State var name: String = ""
    @State var email: String = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    
    @State var alertMsg = ""
    @State var selection: Int = 1
    @State var integers: [String] = ["0", "1", "2", "3", "4", "5"]
    
    @State var date = Date()
    
    @State var showImagePicker: Bool = false
    @State var showCamera: Bool = false
    @State var image: Image? = nil
    
    @State var showAlert = false
    @State var showActionSheet: Bool = false
    
    @State var signupSelection: Int? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var birthDate = Date()
    
    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    var body: some View {
        
//        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        
        ScrollView {
            
            VStack {
                
                VStack {
                    
                    Spacer(minLength: 20)
                    
                    HStack {
                        
                        Image("ic_user")
                            .padding(.leading, 20)
                        
                        TextField("Name", text: $name)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                        
                    }
                    seperator()
                }
                

                
                VStack {
                    
                    HStack {
                        
                        Image("ic_email")
                            .padding(.leading, 20)
                        
                        TextField("Email", text: $email)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                            .keyboardType(.emailAddress)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        
                    }
                    seperator()
                }
                

                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Password", text: $password)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
                VStack {
                    
                    HStack {
                        
                        Image("ic_password")
                            .padding(.leading, 20)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .frame(height: 40, alignment: .center)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .imageScale(.small)
                        
                    }
                    seperator()
                }
                
               
                VStack {
                    
//                    VStack {
//
//                        NavigationLink(destination: LoginView(), tag: 1, selection: $signupSelection) {
//                            Button(action: {
//                                if  self.isValidInputs() {
//                                    print("Signup tapped")
//                                    self.signupSelection = 1
//                                }
//
//                            }) {
//                                HStack {
//                                    buttonWithBackground(btnText: "SUBMIT")
//                                }
//                            }
//
//                        }
//                    }
                 
                    Button(action: {

                        if self.isValidInputs() {
                            self.presentationMode.wrappedValue.dismiss()
                            
                            
    
                               print("action")
                                
                                
    //                            AF.request("https://dev.jdj.kr/api/auth/login").responseData { (resData) -> Void in
    //                                print(resData.result)
    ////                                let strOutput = String(data : resData.result, encoding : String.Encoding.utf8)
    ////                                print(strOutput)
    //                            }
                                
                                let parameter = [
                                    "name": self.name,
                                    "email": self.email,
                                    "password": self.password
                                ]
                                
                                
                                //let session = Alamofire.Session()
                                //let request = session.request(
                                let request = AF.request(
                                  "https://dev.jdj.kr/api/auth/register",
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
    
    
//                            UserDefaults.standard.set(true, forKey: "Loggedin")
//                            UserDefaults.standard.synchronize()
//                            self.settings.loggedIn = true
                        }
                    }) {

                        buttonWithBackground(btnText: "SignUp")
                    }
                    .padding(.bottom, (UIScreen.main.bounds.width * 30) / 414)
                    .alert(isPresented: $showAlert, content: { self.alert })
                }
            
            }
            
        }.navigationBarTitle("SignUp")
            .font(.system(size: 20, weight: .semibold, design: .default))
            .padding(.top, 40)
            .alert(isPresented: $showAlert, content: { self.alert })
    }
    
    fileprivate func isValidInputs() -> Bool {
        
        if self.name == "" {
            self.alertMsg = "Name can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.email == "" {
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
        } else if self.confirmPassword == "" {
            self.alertMsg = "Confirm password can't be blank."
            self.showAlert.toggle()
            return false
        } else if self.password != self.confirmPassword {
            self.alertMsg = "Password and confirm password dose not matched."
            self.showAlert.toggle()
            return false
        }
        
        return true
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
