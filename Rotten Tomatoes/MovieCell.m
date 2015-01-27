//
//  MovieCell.m
//  Rotten Tomatoes
//
//  Created by Fabián Uribe Herrera on 1/21/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
    
    self.ratingLabel.layer.borderColor =[UIColor whiteColor].CGColor;
    self.ratingLabel.layer.borderWidth =.8;
    [self.ratingLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
