//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ronak Garg on 15/02/22.
//

import UIKit
import WidgetKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        WidgetCenter.shared.reloadAllTimelines()
        WidgetCenter.shared.reloadTimelines(ofKind: String)
        WidgetCenter.shared.getCurrentConfigurations { <#Result<[WidgetInfo], Error>#> in
            <#code#>
        }
    }
}

