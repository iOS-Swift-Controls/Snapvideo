//
//  ParameterListViewSnapshotTests.swift
//  SnapshotTests
//
//  Created by Anastasia Petrova on 23/02/2020.
//  Copyright © 2020 Anastasia Petrova. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import Snapvideo

final class ParameterListViewSnapshotTests: XCTestCase {
    func test_single_row() {
        let vc = UIViewController()
        let view = ParameterListView(parameters: [
            Parameter(name: "Hello", value: 10, minPercent: 0)
        ])
        add(view, on: vc)
        view.backgroundColor = .red
        assertSnapshot(matching: vc, as: .image)
    }
    
    func test_multiple_row() {
        let vc = UIViewController()
        let view = ParameterListView(parameters: [
            Parameter(name: "Hello", value: 10, minPercent: 0),
            Parameter(name: "World", value: 0, minPercent: 0),
            Parameter(name: "Foo", value: 3, minPercent: 0),
            Parameter(name: "Bar", value: -23, minPercent: 0),
        ])
        add(view, on: vc)
        view.backgroundColor = .red
        
        assertSnapshot(matching: vc, as: .image)
    }
    
    func add(_ view: UIView, on vc: UIViewController) {
        view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.backgroundColor = .black
        vc.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: vc.view.widthAnchor, multiplier: 0.7),
            view.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
        ])
        vc.viewDidLoad()
        vc.view.layoutIfNeeded()
    }
}
