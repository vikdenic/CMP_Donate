//
//  EditGeneralInfoViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/28/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class EditGeneralInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kGeneralInfoCell) as EditGeneralInfoTableViewCell

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
