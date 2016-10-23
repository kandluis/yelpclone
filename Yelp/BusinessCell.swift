//
//  BusinessCell.swift
//  Yelp
//
//  Created by Luis Perez on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var business: Business! {
        didSet {
            businessImageView.setImageWith(business.imageURL!)
            ratingsImageView.setImageWith(business.ratingImageURL!)
            
            titleLabel.text = business.name
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            tagsLabel.text = business.categories
            distanceLabel.text = business.distance
            addressLabel.text = business.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        businessImageView.layer.cornerRadius = 3
        businessImageView.clipsToBounds = true
        
        // Immediate text wrap.
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Imediate text wrap.
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
