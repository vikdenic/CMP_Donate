//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController {

    @IBOutlet var filmImageView: PFImageView!
    @IBOutlet var synopsisTextView: UITextView!
    var film = Film()
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var verticalConstraint: NSLayoutConstraint!
    @IBOutlet var middleButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI()
    {
        title = film.title
        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)

        synopsisTextView.text = film.synopsis
        let size = synopsisTextView.contentSize;
        self.heightConstraint.constant = size.height;    }

    func resizeTextView()
    {
        let sizeThatShouldFitTheContent = synopsisTextView.sizeThatFits(synopsisTextView.frame.size)
        heightConstraint.constant = sizeThatShouldFitTheContent.height
        synopsisTextView.sizeToFit()
        synopsisTextView.layoutIfNeeded()
    }
}
