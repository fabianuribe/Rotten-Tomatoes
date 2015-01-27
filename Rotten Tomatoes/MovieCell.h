//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Fabián Uribe Herrera on 1/21/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;


@end
