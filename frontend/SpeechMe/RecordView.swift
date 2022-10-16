//
//  RecordView.swift
//  SpeechMe
//
//  Created by Haruka Masamura on 10/15/22.
//

import SwiftUI
import AVKit

// creating audio recorder

struct Record : View {
    @State var record = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    // Fetch Audios...
    @State var audios : [URL] = []
    
    let viewModel = RecordViewModel()
    
    var body: some View{
        NavigationView{
            VStack{
                
                List(self.audios,id: \.self){i in
                    
                    // printing only file name...
                    
                    Text(i.relativeString)
                }
                
                
                Button(action: {

                    // Now going to record audio...
                    
                    // Intialization...
                    
                    // Were going to store audio in document directory...
                    
                    do{
                        
                        if self.record {
                            
                            // Already Started Recording means stopping and saving...
                            
                            self.recorder.stop()
                            self.record.toggle()
                            // updating data for every rcd...
                            self.getAudios()
                            return
                        }
                        
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        // same file name...
                        // updating based on audio count...
                        let fileURL = url.appendingPathComponent("myRcd\(self.audios.count + 1).m4a")
                        viewModel.fileName = "myRcd\(self.audios.count + 1).m4a"
                        viewModel.fileURL = fileURL
                        
                        let settings = [
                        
                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey : 12000,
                            AVNumberOfChannelsKey : 1,
                            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                        
                        ]
                        
                        self.recorder = try AVAudioRecorder(url: fileURL, settings: settings)
                        self.recorder.record()
                        self.record.toggle()
                    }
                    catch{
                        
                        print(error.localizedDescription)
                    }
                    
                    
                }) {
                    
                    ZStack{
                        VStack{
                            Text("Record Audio").font(.custom("KumbhSans-SemiBold", size: 40))
                        }.padding(.bottom, 120)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70).padding(.top, 90)
                        
                        if self.record{
                            
                            Circle()
                                .stroke(Color.gray, lineWidth: 6)
                                .frame(width: 85, height: 85).padding(.top, 90)
                        }
                    }
                }
                .padding(.vertical, 70)
                NavigationLink("Get Results") {
                    ResultView()
                }
                .onTapGesture {
                    guard let fileURL = viewModel.fileURL else {
                        return
                    }
                    guard let fileName = viewModel.fileName else {
                        return
                    }
                    try? sendAudio(fileURL: fileURL, fileName: fileName)
                }
                .font(Font.custom("KumbhSans-SemiBold", size: 20))
                .padding()
                .background(Color("AccentColor"))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
            }.padding(60)
        
        }
        .alert(isPresented: self.$alert, content: {
            
            Alert(title: Text("Error"), message: Text("Enable Access"))
        })
        .onAppear {
            
            do{
                
                // Intializing...
                
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
                
                // requesting permission
                // for this we require microphone usage description in info.plist...
                self.session.requestRecordPermission { (status) in
                    
                    if !status{
                        
                        // error msg...
                        self.alert.toggle()
                    }
                    else{
                        
                        // if permission granted means fetching all data...
                        
                        self.getAudios()
                    }
                }
                
                
            }
            catch{
                
                print(error.localizedDescription)
            }
        }
    }
    
    func getAudios(){
        
        do{
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // fetch all data from document directory...
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            // updated means remove all old data..
            
            self.audios.removeAll()
            
            for i in result{
                
                self.audios.append(i)
            }
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}

func sendAudio(fileURL: URL, fileName: String) throws {
//    let fileLocation = Bundle.main.path(forResource: fileName, ofType: "m4a")
//    guard let fileLocation = fileLocation else {
//        return //TODO: handle
//    }
//    let fileURL = URL(fileURLWithPath: fileLocation)
    let fileData = try Data(contentsOf: fileURL, options: .dataReadingMapped)
    let base64String = fileData.base64EncodedString()
//    makePostReq(audio: base64String)
    uploadAudio(paramName: "audio", fileURL: fileURL, fileName: fileName)
}

struct RecordView: View {
    var body: some View {
        Record()
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}

func uploadAudio(paramName: String, fileURL: URL, fileName: String) {
    let url = URL(string: "http://api-host-name/v1/api/uploadfile/single")

    // generate boundary string using a unique per-app string
    let boundary = UUID().uuidString

    let session = URLSession.shared

    // Set the URLRequest to POST and to the specified URL
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "POST"

    // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
    // And the boundary is also set here
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    var data = Data()

    // Add the image data to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)
//    data.append(image.pngData()!)
    do {
        data.append(try Data(contentsOf: fileURL))
    } catch {
        print("file not found")
    }

    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

    // Send a POST request to the URL, with the data we created earlier
    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
        if error == nil {
            let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
            if let json = jsonData as? [String: Any] {
                print(json)
            }
        }
    }).resume()
}

//func makePostReq(audio: String) {
//    guard let url = URL(string: "") else {
//        return
//    }
//
//    var request = URLRequest(url: url)
//    // method, body, headers
//    request.httpMethod = "POST"
//    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "")
//    let body: [String: AnyHashable] = [
//        "audio": audio,
//        "text": "Hello"
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//    // make the request
//    let task = URLSession.shared.dataTask(with: request) { data, _, error in
//        guard let data = data, error == nil else {
//            return
//        }
//
//        do {
//            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//            print("SUCESS: \(response)")
//        } catch {
//            print(error)
//        }
//    }
//    task.resume()
//}

class RecordViewModel {
    var fileURL: URL?
    var fileName: String?
}
