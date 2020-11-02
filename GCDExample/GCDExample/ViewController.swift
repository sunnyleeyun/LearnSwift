//
//  ViewController.swift
//  GCDExample
//
//  Created by 李昀 on 2020/11/1.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
//    serialSync()
//    concurrentAsync()
//    concurrentGroupEnterLeave()
    qos()
  }

  private func serialSync() {
    let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
    serialQueue.sync {
      for i in 1...10 {
        print("i \(i)")
      }
    }
    for j in 101...110 {
      print("j \(j)")
    }
  }
  
  private func concurrentAsync() {
    let concurrent: DispatchQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    concurrent.async {
      for i in 1...100 {
        print("i \(i)")
      }
    }
    
    concurrent.async {
      for j in 1...100 {
        print("j \(j)")
      }
    }
    
    concurrent.async {
      for k in 1...100 {
        print("k \(k)")
      }
    }
  }
  
  private func concurrentGroup() {
    let group: DispatchGroup = DispatchGroup()
    let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
    queue1.async(group: group) {
      for i in 1...100 {
        print("i \(i)")
      }
    }
    
    let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)
    queue2.async(group: group) {
      for j in 101...200 {
        print("j \(j)")
      }
    }
    
    group.notify(queue: .main) {
      print("處理完 queue1 和 queue2")
    }
  }

  private func concurrentGroupEnterLeave() {
    let group: DispatchGroup = DispatchGroup()
    let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent)
    group.enter()
    queue1.async(group: group) {
      print("call 1")
      group.leave()
    }
    
    let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent)
    group.enter()
    queue2.async(group: group) {
      print("call 2")
      group.leave()
    }
    
    group.notify(queue: .main) {
      print("完成所有 call api")
    }
    
  }
  
  private func qos() {
    let queue1 = DispatchQueue.global(qos: .userInteractive)
    let queue2 = DispatchQueue.global(qos: .unspecified)
    
    queue1.async {
      for i in 1...100 {
        print("i \(i)")
      }
    }
    
    queue2.async {
      for j in 101...200 {
        print("j \(j)")
      }
    }
  }
}

