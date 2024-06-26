//
//  HomeView.swift
//  Moldcell_Hackathon
//
//  Created by Dragomir Mindrescu on 16.03.2024.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("Nume") var name: String = ""
    @AppStorage("customPhoneNumber") var customPhoneNumber: String = ""
    @State private var timeOfDay: String
    @State private var feelingText: String
    
    let sadMessages = [
        "E ok să fiți trist uneori.",
        "Suntem aici pentru voi."
    ]
    
    let normalMessages = [
        "O zi calmă, o zi binecuvântată.",
        "Totul va fi bine."
    ]
    
    let happyMessages = [
        "Zâmbetul tău înseninează tot!",
        "Rază de soare!"
    ]
    
    struct NewsPlatform {
        var name: String
        var imageName: String
    }
    
    let newsPlatforms = [
        NewsPlatform(name: "Stiri.md", imageName: "stiriLogo"),
        NewsPlatform(name: "Jurnal TV", imageName: "jurnalLogo"),
        NewsPlatform(name: "TV8", imageName: "tv8Logo")
    ]
    
    init() {
        let currentDayTime = getTimeOfDay()
        _timeOfDay = State(initialValue: currentDayTime)
        _feelingText = State(initialValue: "Cum va simtiti in aceasta \(currentDayTime)?")
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        HStack {
                            Image("profilePhoto")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 50)
                                .clipShape(Circle())
                            
                            Text(name)
                                .font(.custom("BalooBhai-Regular", size: 18))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            let phoneNumber = customPhoneNumber
                            if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Image(systemName: "phone.circle.fill") // Use a phone icon
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue) // Color for the button
                        }
                        
                    }
                    .padding()
                    
                    HStack{
                        Text("Panoul Meu")
                            .font(.custom("BalooBhai-Regular", size: 30))
                        Spacer()
                    }
                    .padding(.leading, 35)
                    .padding(.bottom, 0)
                    .padding(.top, 0)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10.0)
                            .padding([.leading, .trailing], 35)
                            .padding(.top, -25)
                            .foregroundStyle(Color.blue)
                            .shadow(radius: 10)
                            .frame(height: 200)
                        
                        VStack {
                            Text(feelingText)
                                .foregroundStyle(Color.white)
                                .font(.custom("BalooBhai-Regular", size: 25))
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 36)
                            
                            HStack(spacing: 30) {
                                Button(action: {
                                    feelingText = sadMessages.randomElement() ?? "Aveți grijă de voi!"
                                }) {
                                    Text("😞")
                                        .font(.custom("BalooBhai-Regular", size: 75))
                                }
                                
                                Button(action: {
                                    feelingText = normalMessages.randomElement() ?? "O zi liniștită este o binecuvântare."
                                }) {
                                    Text("😐")
                                        .font(.custom("BalooBhai-Regular", size: 75))
                                }
                                
                                Button(action: {
                                    feelingText = happyMessages.randomElement() ?? "Zâmbetul vostru ne încălzește inimile!"
                                }) {
                                    Text("😊")
                                        .font(.custom("BalooBhai-Regular", size: 75))
                                }
                            }
                        }
                    }
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: GalleryView()) {
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("Galerie")
                                    .foregroundColor(.white)
                                    .font(.custom("BalooBhai-Regular", size: 18))
                            }
                            .frame(width: 150, height: 150)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                            .shadow(radius: 10)
                        }

                        NavigationLink(destination: AssistantView()) {
                            VStack {
                                Image(systemName: "message")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("Conversații cu un Asistent")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .font(.custom("BalooBhai-Regular", size: 18))
                            }
                            .frame(width: 150, height: 150)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                            .shadow(radius: 10)
                        }
                    }
                    .padding([.leading, .trailing], 35)
                    .padding(.top, -65)
                    
                    HStack{
                        Text("Noutati")
                            .font(.custom("BalooBhai-Regular", size: 30))
                        Spacer()
                    }
                    .padding(.leading, 35)
                    .padding(.bottom, 1)
                    .padding(.top, 0)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(newsPlatforms, id: \.name) { platform in
                                NavigationLink(destination: destinationView(for: platform.name)) {
                                    VStack {
                                        Image(platform.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                        Text(platform.name)
                                            .foregroundColor(.white)
                                            .font(.custom("BalooBhai-Regular", size: 25))
                                    }
                                    .frame(width: 200, height: 150)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                                    .shadow(radius: 3)
                                }
                            }
                        }
                        .padding(.horizontal, 35)
                        .padding(.trailing, 35)
                        .padding(.bottom, 0)
                        .padding(.top, 0)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
private func destinationView(for name: String) -> some View {
    switch name {
    case "Stiri.md":
        return AnyView(StiriMDView())
    case "Jurnal TV":
        return AnyView(JurnalTVView())
    case "TV8":
        return AnyView(DiezView())
    default:
        return AnyView(Text("Unknown Platform"))
    }
}

func getTimeOfDay() -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    
    switch hour {
    case 6..<12:
        return "dimineata"
    case 12..<17:
        return "zi"
    case 17..<21:
        return "seara"
    default:
        return "noapte"
    }
}

#Preview {
    HomeView()
}
