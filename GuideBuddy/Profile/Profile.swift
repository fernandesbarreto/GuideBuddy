//
//  Profile.swift
//  GuideBuddy
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 29/08/24.
//

import SwiftUI
import SwiftData

@Model
class ProfilePhoto {
    var profilePhotoData: Data
    
    init(profilePhoto: UIImage) {
        self.profilePhotoData = profilePhoto.jpegData(compressionQuality: 1.0) ?? Data()
    }
    func getProfilePhoto() -> UIImage? {
        return UIImage(data: self.profilePhotoData)
    }
}

@Model
class BackgroundPhoto {
    var backgroundPhotoData: Data
    
    init(backgroundPhoto: UIImage) {
        self.backgroundPhotoData = backgroundPhoto.jpegData(compressionQuality: 1.0) ?? Data()
    }
    
    func getBackgroundPhoto() -> UIImage? {
        return UIImage(data: self.backgroundPhotoData)
    }
}

struct Profile: View {
    @Query private var profilePhotos: [ProfilePhoto]
    @Query private var backgroundPhotos: [BackgroundPhoto]
    
    @State private var selectedImage: UIImage?
    @State private var selectedBackground: UIImage?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    ZStack {
                        NavigationLink(destination: BackgroundImageView(selectedBackground: selectedBackground ?? nil), label: {
                            if let selectedBackground = selectedBackground {
                                Image(uiImage: selectedBackground)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 393, height: 300)
                                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                    .shadow(radius: 5)
                            } else {
                                Image("backgroundImage")
                                    .frame(width: 393, height: 300)
                                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                    .shadow(radius: 5)
                            }
                        })
                    }
                    Spacer()
                        .frame(height: 20)
                    VStack{
                        ZStack {
                            Circle()
                                .foregroundStyle(Color.white)
                                .frame(width: 120, height: 120)
                            if let selectedImage = selectedImage {
                                NavigationLink(destination: {
                                    ProfilePhotoView(selectedImage: selectedImage)
                                }, label: {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 106, height: 106)
                                        .clipShape(Circle())
                                })
                                
                            } else {
                                NavigationLink(destination: {
                                    ProfilePhotoView()
                                }, label: {
                                    Image("profileImage")
                                        .frame(width: 106, height: 106)
                                        .scaledToFill()
                                        .clipShape(Circle())})
                            }
                        }
                        VStack {
                            Text("Pedro Nunes")
                                .font(.system(size: 24,weight: .regular , design: .rounded))
                                .padding(.top, 10)
                            
                            Text("29")
                                .font(.system(size: 24,weight: .regular , design: .rounded))
                                .padding(.top, 2)
                        }
                    }
                    .offset(y: -78)
                }
                .offset(y:-110)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear.opacity(0.1), for: .navigationBar)
            .navigationTitle("Perfil")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Text("Editar")
                            .foregroundStyle(Color.background)
                    })
                }
            }
            .onAppear {
                loadImages()
            }
        }
    }
    
    func loadImages() {
        if let profilePhoto = profilePhotos.last {
            selectedImage = profilePhoto.getProfilePhoto()
        }
        
        if let backgroundPhoto = backgroundPhotos.last {
            selectedBackground = backgroundPhoto.getBackgroundPhoto()
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

#Preview {
    Profile()
}

