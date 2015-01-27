//
//  MoviesViewController.m
//  Rotten Tomatoes
//
//  Created by Fabián Uribe Herrera on 1/21/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "MovieCell.h"
#import "MoviesViewController.h"
#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation MoviesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Movies";
    
    self.errorView.alpha = 0;
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 128;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=axjww2tvhfp76cvssc9agenx"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError) {
            self.errorView.alpha = 1;
            
        } else {
            self.errorView.alpha = 0;
            
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.movies = responseDictionary[@"movies"];
            
            [self.tableView reloadData];
        }

    }];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    cell.ratingLabel.text = movie[@"mpaa_rating"];
    
    [cell.thumbnail setImageWithURL:[NSURL URLWithString: [movie valueForKeyPath:@"posters.thumbnail"]]];
    
    return cell;
}

- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc] init];
    
    movieDetailVC.movie = self.movies[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController: movieDetailVC animated:YES];
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=axjww2tvhfp76cvssc9agenx"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if(connectionError) {
            self.errorView.alpha = 1;

        } else {
            self.errorView.alpha = 0;
            
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = responseDictionary[@"movies"];
            [self.tableView reloadData];
            
        }
        
        [self.refreshControl endRefreshing];
    }];
}


@end
