//
//  EncryptAndDecrypt.swift
//  BreakingBadTest
//
//  Created by 100 on 12.03.2021.
//

import Foundation
import CryptoKit
import CommonCrypto

class EncryptAndDecrypt {
   
    func testCrypt(data:[UInt8], keyData:[UInt8], ivData:[UInt8], operation:Int) -> [UInt8]? {
        let cryptLength  = size_t(data.count+kCCBlockSizeAES128)
        var cryptData    = [UInt8](repeating:0, count:cryptLength)

        let keyLength             = size_t(kCCKeySizeAES128)
        let algoritm: CCAlgorithm = UInt32(kCCAlgorithmAES128)
        let options:  CCOptions   = UInt32(kCCOptionPKCS7Padding)

        var numBytesEncrypted :size_t = 0

        let cryptStatus = CCCrypt(CCOperation(operation),
                                  algoritm,
                                  options,
                                  keyData, keyLength,
                                  ivData,
                                  data, data.count,
                                  &cryptData, cryptLength,
                                  &numBytesEncrypted)

        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)

        } else {
            Swift.print("Error: \(cryptStatus)")
        }

        return cryptData;
    }

//    let message       = "Don´t try to read this text. Top Secret Stuff"
//    let messageData   = Array(message.utf8)
//    let keyData       = Array("12345678901234567890123456789012".utf8)
//    let ivData        = Array("abcdefghijklmnop".utf8)
//    let encryptedData = testCrypt(data:messageData,   keyData:keyData, ivData:ivData, operation:kCCEncrypt)!
//    let decryptedData = testCrypt(data:encryptedData, keyData:keyData, ivData:ivData, operation:kCCDecrypt)!
//    var decrypted     = String(bytes:decryptedData, encoding:NSUTF8StringEncoding)!
//
//    print("message:       \(message)");
//    print("messageData:   \(NSData(bytes:messageData,   length:messageData.count))");
//    print("keyData:       \(NSData(bytes:keyData,       length:keyData.count))");
//    print("ivData:        \(NSData(bytes:ivData,        length:ivData.count))");
//    print("encryptedData: \(NSData(bytes:encryptedData, length:encryptedData.count))");
//    print("decryptedData: \(NSData(bytes:decryptedData, length:decryptedData.count))");
//    print("decrypted:     \(String(bytes:decryptedData,encoding:NSUTF8StringEncoding)
}
