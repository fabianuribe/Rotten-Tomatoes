//
//  MovieDetailViewController.m
//  Rotten Tomatoes
//
//  Created by Fabián Uribe Herrera on 1/24/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"


@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *poster;

@property (weak, nonatomic) IBOutlet UIView *detailViewContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewContainer;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.poster setImageWithURL:[NSURL URLWithString: [self.movie valueForKeyPath:@"posters.thumbnail"]]];
    
    NSMutableString *posterUrl = [NSMutableString stringWithString:[self.movie valueForKeyPath:@"posters.thumbnail"]];
    
    [posterUrl replaceCharactersInRange:[posterUrl rangeOfString:@"_tmb.jpg"]  withString:@"_ori.jpg"];
    [self.poster setImageWithURL:[NSURL URLWithString: posterUrl]];
    


    NSString *cardTitle = [NSString stringWithFormat:@"%@ (%@)", self.movie[@"title"] , self.movie[@"year"]];
    
    self.titleLabel.text = cardTitle ;
    self.synopsisLabel.text = self.movie[@"synopsis"];
    self.ratingLabel.text = self.movie[@"mpaa_rating"];
    
    [self.synopsisLabel sizeToFit];
    
    CGSize maxSize = CGSizeMake(320, 4000);
    
    CGSize detailsSize = [self.synopsisLabel sizeThatFits:maxSize ];
    detailsSize.width = 320;
    detailsSize.height += 397;
    
    CGRect newFrame = self.detailViewContainer.frame;
    newFrame.size = detailsSize;

    [self.detailViewContainer setFrame:newFrame];
    self.scrollViewContainer.contentSize = detailsSize;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
