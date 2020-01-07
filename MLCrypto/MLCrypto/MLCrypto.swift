//
//  MLCrypto.swift
//  monalxmpp
//
//  Created by Anurodh Pokharel on 1/7/20.
//  Copyright © 2020 Monal.im. All rights reserved.
//

import UIKit
import CryptoKit

@objcMembers
public class MLCrypto: NSObject {
   
    public func encryptGCM (decryptedContent:Data) -> Data?
    {
        let key =  SymmetricKey(size: .bits128)
        let iv = AES.GCM.Nonce()
        do {
            let encrypted = try AES.GCM.seal(decryptedContent, using: key, nonce: iv)
            return encrypted.combined
        } catch  {
            return nil;
        }
    }
    
    
    public func decryptGCM (key: Data, encryptedContent:Data) -> Data?
    {
        let sealedBoxToOpen = try! AES.GCM.SealedBox(combined: encryptedContent)
        let gcmKey = SymmetricKey.init(data: key)
        do {
            let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: gcmKey)
            return decryptedData
        } catch {
            return nil;
        }
    }
}