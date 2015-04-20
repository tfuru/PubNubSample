//
//  ViewController.swift
//  PubNubSample
//
//  Created by 古川信行 on 2015/04/20.
//  Copyright (c) 2015年 古川信行. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PNDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //PubNub 初期設定
        var config: PNConfiguration = PNConfiguration(forOrigin: "pubsub.pubnub.com",
                                                        publishKey: PUBNUB_PUBLISH_KEY,
                                                        subscribeKey: PUBNUB_SUBSCRIBE_KEY,
                                                        secretKey: PUBNUB_SECRET_KEY)
        PubNub.setConfiguration(config)
        PubNub.setDelegate(self)
        PubNub.connect()
        
        
        // チャンネル作って接続
        var channel: PNChannel =  PNChannel.channelWithName("TestChannel", shouldObservePresence: true) as! PNChannel
        // Subscribe on the channel
        PubNub.subscribeOn([channel])
        
        // チャンネルにメッセージを送信
        PubNub.sendMessage("Hello world", toChannel: channel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: PNDelegate ----

    //接続 成功
    func pubnubClient(client: PubNub!, didConnectToOrigin origin: String!) {
        println("Connected to PubNub");
    }
    
    //メッセージを受信した時
    func pubnubClient(client: PubNub!, didReceiveMessage message: PNMessage!) {
        println("didReceiveMessage \(message)")
    }
    
}

