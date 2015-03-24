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
        navigationItem.title = kProfile?.firstName
    }

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        obtainTransactionData()
    }

    func obtainTransactionData()
    {
        Transaction.queryTransactions(kProfile!, completed: { (transactions, error) -> Void in
            self.transactionsArray = transactions
            println(self.transactionsArray)

            let profileCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as ProfileTableViewCell
            profileCell.fundingLabel.text = "Funding \(self.transactionsArray.count) Projects"

            self.tableView.reloadData()
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
