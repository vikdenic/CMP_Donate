//
//  ProfileViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

//TODO: Safen user profile after registration (if no profile data, currently crashes)

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var transactionsArray = [Transaction]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        navigationItem.title = kProfile?.firstName

        self.obtainTransactionData()

//        Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
//            UniversalProfile.sharedInstance.profile = profile!
//            self.obtainTransactionData()
//        })
    }

    func obtainTransactionData()
    {
        Transaction.queryTransactions(UniversalProfile.sharedInstance.profile!, completed: { (transactions, error) -> Void in

            if error != nil
            {
                showAlertWithError(error, self)
            }
            else
            {
                self.transactionsArray = transactions!

                let profileCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as ProfileTableViewCell

                if self.transactionsArray.count == 1
                {
                    profileCell.fundingLabel.text = "Funding 1 Project"
                }
                else
                {
                    profileCell.fundingLabel.text = "Funding \(self.transactionsArray.count) Projects"
                }
                
                self.tableView.reloadData()
            }
        })
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kProfileCell) as ProfileTableViewCell
            cell.profilePicImageView.file = kProfile?.imageFile
            cell.profilePicImageView.loadInBackground(nil)
            cell.clipsToBounds = true
            cell.coverPhotoImageView.clipsToBounds = true
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kFundedFilmCell) as FundedFilmTableViewCell

            let transaction = transactionsArray[indexPath.row - 1]
            cell.filmImageView.file = transaction.film!.imageFile
            cell.filmImageView.loadInBackground(nil)
            cell.filmTitleLabel.text = transaction.film!.title
            cell.amountLabel.text = "$\(transaction.amount)"
            cell.clipsToBounds = true
            cell.filmImageView.clipsToBounds = true
            return cell
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.transactionsArray.count > 0
        {
            return self.transactionsArray.count + 1
        }
        else
        {
            return 1
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if indexPath.row == 1
        {
            return 120
        }
        else
        {
            return 180
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kFundedCellToIndividualSegue
        {
            let individualVC = segue.destinationViewController as IndividualFilmViewController
            individualVC.film = transactionsArray[tableView.indexPathForSelectedRow()!.row - 1].film
        }
    }
}
