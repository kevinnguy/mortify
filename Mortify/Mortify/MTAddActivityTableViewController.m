//
//  MTAddActivityTableViewController.m
//  Mortify
//
//  Created by America on 10/19/13.
//  Copyright (c) 2013 Kevin Nguy. All rights reserved.
//

#import "MTAddActivityTableViewController.h"

#import "MTActivityCell.h"

@interface MTAddActivityTableViewController () <UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;

@property (nonatomic, strong) NSMutableArray *searchResultsMutableArray;
@property (nonatomic, strong) NSArray *recurringActivitiesArray;
@end

@implementation MTAddActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSearchDisplay];
    [self setupNavigationBar];
    
    self.searchResultsMutableArray = [[NSMutableArray alloc] init];
    
    self.searchResultsMutableArray = [@[[[MTActivity alloc] initWithActivity:@"Smoking" score:-0.7],
                                       [[MTActivity alloc] initWithActivity:@"Driving" score:-0.3],
                                       [[MTActivity alloc] initWithActivity:@"Biking" score:-0.8],
                                       [[MTActivity alloc] initWithActivity:@"Skydiving" score:-7.0],
                                       [[MTActivity alloc] initWithActivity:@"Ecstasy" score:-0.5],
                                       [[MTActivity alloc] initWithActivity:@"Coffee" score:1.0],
                                       [[MTActivity alloc] initWithActivity:@"Exercise" score:1.0],
                                       [[MTActivity alloc] initWithActivity:@"Sitting" score:-0.2],
                                        [[MTActivity alloc] initWithActivity:@"Eating fruits/vegetables" score:0.2],
                                       ] mutableCopy];
    
    // Hack to populate table view when viewDidLoad
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelBarButtonPressed:)];
}

- (void)setupSearchDisplay {
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.displaysSearchBarInNavigationBar = YES;
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    
    [self.tableView registerClass:[MTActivityCell class] forCellReuseIdentifier:ACTIVITY_CELL];
}

- (void)cancelBarButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addActivity:(MTActivity *)activity {
    [self.delegate didAddActivity:activity];
    [self cancelBarButtonPressed:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = 0;
    
    if (tableView == self.searchController.searchResultsTableView) {
        count = [self.searchResultsMutableArray count];
    } else if (tableView == self.tableView) {
        count = [self.searchResultsMutableArray count];
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:ACTIVITY_CELL];
    
    if (cell == nil) {
        cell = [[MTActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ACTIVITY_CELL];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MTActivity *activity = self.searchResultsMutableArray[indexPath.row];
    cell.activityLabel.text = activity.name;
    
    if (activity.score > 0) {
        cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score];
        cell.microMortLabel.layer.borderColor = [UIColor greenMortifyColor].CGColor;
        cell.microMortLabel.backgroundColor = [UIColor greenMortifyColor];
    } else {
        cell.microMortLabel.text = [NSString stringWithFormat:@"%0.1f", activity.score * -1];
        cell.microMortLabel.layer.borderColor = [UIColor orangeMortifyColor].CGColor;
        cell.microMortLabel.backgroundColor = [UIColor orangeMortifyColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Go to Activity Details and call delegate to update list in home view
    MTActivity *activity = self.searchResultsMutableArray[indexPath.row];
    [self addActivity:activity];
}

#pragma mark - UISearchDisplayController delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark - UISearchBar delegate methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    // Add object in search result
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // Go to Activity Details and call delegate to update list in home view
//    [self addActivity:@"Smoking" score:0.7];
}




@end
