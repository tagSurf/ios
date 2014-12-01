//  Copyright (c) 2014 URX. All rights reserved.

#import "URXListenButtonSearchViewController.h"
#import <URXSearch/URXTerm.h>
#import <URXSearch/URXSearchResult.h>
#import <URXSearch/NSDictionary+JSONLD.h>
#import <URXSearch/URXActionFilter.h>
#import <URXSearch/URXAnd.h>

@interface URXSearchResultGenericTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *resultImageView;
@property (strong, nonatomic) UILabel *resultName;
@property (strong, nonatomic) UILabel *appName;
@property (strong, nonatomic) UILabel *resultDescription;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end

@implementation URXSearchResultGenericTableViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIView *contentWrapper = [[UIView alloc] init];
        contentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:contentWrapper];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentWrapper attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentWrapper attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        
        UIImageView *resultImageView = [[UIImageView alloc] init];
        resultImageView.translatesAutoresizingMaskIntoConstraints = NO;
        UILabel *resultName = [[UILabel alloc] init];
        resultName.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        resultName.textColor = [UIColor colorWithRed:0 green:0.47843137254902 blue:1 alpha:1];
        resultName.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIColor *grayTextColor = [UIColor colorWithRed:0.26666666666667 green:0.26666666666667 blue:0.26666666666667 alpha:1];
        
        UILabel *appName = [[UILabel alloc] init];
        appName.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        appName.textColor = grayTextColor;
        appName.translatesAutoresizingMaskIntoConstraints = NO;
        
        UILabel *resultDescription = [[UILabel alloc] init];
        resultDescription.font = [UIFont fontWithName:@"Helvetica" size:12];
        resultDescription.textColor = grayTextColor;
        resultDescription.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIView *rightColumnWrapper = [[UIView alloc] init];
        rightColumnWrapper.translatesAutoresizingMaskIntoConstraints = NO;
        
        [contentWrapper addSubview:resultImageView];
        // Make the image 64x64 square
        [contentWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeWidth multiplier:0 constant:64]];
        [contentWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeHeight multiplier:0 constant:64]];
        [contentWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentWrapper attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        // Clip the image if necessary
        resultImageView.contentMode = UIViewContentModeScaleAspectFill;
        resultImageView.clipsToBounds = YES;
        
        [contentWrapper addSubview:rightColumnWrapper];
        
        [contentWrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[resultImageView(64)]-[rightColumnWrapper(>=0)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(resultImageView, rightColumnWrapper)]];
        
        // Set up right column
        [rightColumnWrapper addSubview:resultName];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [rightColumnWrapper addSubview:appName];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:appName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:appName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [rightColumnWrapper addSubview:resultDescription];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultDescription attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [rightColumnWrapper addConstraint:[NSLayoutConstraint constraintWithItem:resultDescription attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rightColumnWrapper attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [rightColumnWrapper addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[resultName(14)]-[appName(14)]-[resultDescription(>=28)]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:NSDictionaryOfVariableBindings(resultName, appName, resultDescription)]];
        
        self.resultImageView = resultImageView;
        self.resultName = resultName;
        self.appName = appName;
        self.resultDescription = resultDescription;
    }
    return self;
}

-(void)prepareForReuse {
    NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"URXWidgetsResources.bundle"];

    self.resultImageView.image = [UIImage imageNamed:@"search-result-main-image@2x.png" inBundle:[NSBundle bundleWithPath:frameworkBundlePath] compatibleWithTraitCollection:nil];
}

@end

@interface URXListenButtonSearchViewController ()

@property (strong, nonatomic) NSString *lastQuery;
@property (strong, nonatomic) UIViewController *callingViewController;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UILabel *resultsLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIColor *modalBarColor;
@property (strong, nonatomic) NSString *modalBarTitle;
@property (strong, nonatomic) UIColor *modalBarTextColor;
@property (strong, nonatomic) NSString *backButtonText;
@property (strong, nonatomic) UIColor *backButtonColor;
@property (nonatomic) BOOL backButtonBoldText;


-(void) backButtonPressed;
-(void) runQuery:(NSString *)keywords;

@end

@implementation URXListenButtonSearchViewController {
    __block BOOL _queryInProgress;
}

-(instancetype)initWithInitialQuery:(NSString *)initialQuery modalBarColor:(UIColor *)modalBarColor modalBarTitle:(NSString *)modalBarTitle modalBarTextColor:(UIColor *)modalBarTextColor backButtonText:(NSString *)backButtonText backButtonColor:(UIColor *)backButtonColor backButtonBoldText:(BOOL)backButtonBoldText andCallingViewController:(UIViewController *)callingViewController {
    if (self = [super init]) {
        self.lastQuery = initialQuery;
        self.callingViewController = callingViewController;
        self.modalBarColor = modalBarColor;
        self.modalBarTitle = modalBarTitle;
        self.modalBarTextColor = modalBarTextColor;
        self.backButtonText = backButtonText;
        self.backButtonColor = backButtonColor;
        self.backButtonBoldText = backButtonBoldText;
        _queryInProgress = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.bounds];
    [baseView setBackgroundColor:[UIColor whiteColor]];
    self.view = baseView;
    
    UIView *statusSpacer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, baseView.bounds.size.width, 22)];
    statusSpacer.backgroundColor = self.modalBarColor;
    statusSpacer.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:statusSpacer];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:statusSpacer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:statusSpacer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:0 constant:22]];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:self.modalBarTextColor, NSForegroundColorAttributeName, nil];
    navigationBar.barTintColor = self.modalBarColor;
    if (self.backButtonColor) {
        navigationBar.tintColor = self.backButtonColor;
    }
    navigationBar.translucent = NO;
    navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:navigationBar];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:navigationBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    UINavigationItem *navigationItem = [[UINavigationItem alloc]initWithTitle:self.modalBarTitle];
    UIBarButtonItemStyle barButtonItemStyle;
    if (self.backButtonBoldText) {
        barButtonItemStyle = UIBarButtonItemStyleDone;
    } else {
        barButtonItemStyle = UIBarButtonItemStylePlain;
    }
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.backButtonText style:barButtonItemStyle target:self action:@selector(backButtonPressed)];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, baseView.bounds.size.width, 44)];
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    [baseView addSubview:searchBar];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.lastQuery != nil) {
        [searchBar setText:self.lastQuery];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,0,0) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.rowHeight = 89;
    [baseView addSubview:tableView];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    self.tableView = tableView;

    
    [baseView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[statusSpacer(22)]-[navigationBar]-[searchBar]-[tableView(>=0)]|" options:NSLayoutFormatAlignAllLeft metrics:@{} views:NSDictionaryOfVariableBindings(statusSpacer, navigationBar, searchBar, tableView)]];
    
    
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.hidden = YES;
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:activityIndicatorView];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    self.activityIndicatorView = activityIndicatorView;
    
    UILabel *resultsLabel = [[UILabel alloc] init];
    resultsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    resultsLabel.text = @"Search for music to listen to!";
    resultsLabel.textColor = [UIColor colorWithHue:0 saturation:0 brightness:0.7 alpha:1];
    resultsLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:resultsLabel];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:resultsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:resultsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:resultsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [baseView addConstraint:[NSLayoutConstraint constraintWithItem:resultsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:baseView attribute:NSLayoutAttributeWidth multiplier:0 constant:30]];
    self.resultsLabel = resultsLabel;
    
    if (self.lastQuery != nil) {
        [self runQuery:self.lastQuery];
    }
}

-(void)runQuery:(NSString *)keywords {
    _queryInProgress = YES;
    self.resultsLabel.hidden = YES;
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    self.lastQuery = keywords;
    [[[URXTerm termWithKeywords:keywords] and:[URXActionFilter listenAction]] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        _queryInProgress = NO;
        [self updateTableViewWithSearchResults:response.results];
        // Handle results
    } andFailureHandler:^(URXAPIError *error) {
        // There was an error
        NSLog(@"%@", error.errorMessage);
        
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        _queryInProgress = NO;
        [self updateTableViewWithSearchResults:@[]];
        if (error.errorType == URXNoSearchResultsError) {
            self.resultsLabel.text = @"No results found.";
        } else {
            self.resultsLabel.text = @"There was an error, please try again.";
        }
        self.resultsLabel.hidden = NO;
    }];
}

-(void)updateTableViewWithSearchResults:(NSArray *)searchResults {
    [self.tableView beginUpdates];
    NSMutableArray *updateIndexPaths = [NSMutableArray array];
    NSMutableArray *insertIndexPaths = [NSMutableArray array];
    NSMutableArray *deleteIndexPaths = [NSMutableArray array];
    for (int i = 0; i < self.searchResults.count || i < searchResults.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if (i < self.searchResults.count && i < searchResults.count) {
            [updateIndexPaths addObject:indexPath];
        } else if (i < self.searchResults.count) {
            [deleteIndexPaths addObject:indexPath];
        } else {
            [insertIndexPaths addObject:indexPath];
        }
    }
    self.searchResults = searchResults;
    [self.tableView reloadRowsAtIndexPaths:updateIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return !_queryInProgress;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (_queryInProgress) {
        searchBar.text = self.lastQuery;
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""]) {
        if (self.lastQuery != nil) {
            searchBar.text = self.lastQuery;
        }
    } else {
        [self runQuery:searchBar.text];
    }
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""] && self.lastQuery != nil) {
        searchBar.text = self.lastQuery;
    }
}

-(void) backButtonPressed {
    [self.callingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    URXSearchResultGenericTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[URXSearchResultGenericTableViewCell alloc]initWithReuseIdentifier:@"cell"];
        
        
    }
    
    URXSearchResult *searchResult = [self.searchResults objectAtIndex:indexPath.row];
    cell.resultName.text = searchResult.name;
    cell.resultDescription.text = searchResult.descriptionText;
    cell.appName.text = [[searchResult.entityData getSingle:@"potentialAction"] getSingle:@"name"];
    
    NSURLRequest *imageRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:searchResult.imageUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10000];
    [NSURLConnection sendAsynchronousRequest:imageRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // If the data for this table hasn't changed
        if (data != nil && connectionError == nil && [[tableView indexPathsForVisibleRows] indexOfObject:indexPath] != NSNotFound) {
            cell.resultImageView.image = [UIImage imageWithData:data];
        }
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    URXSearchResult *result = [self.searchResults objectAtIndex:indexPath.row];
    [result resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *error) {
        NSLog(@"URX API ERROR: %@", error.errorMessage);
        [[[UIAlertView alloc] initWithTitle:@"There was a problem launching your content." message:@"The content could not be resolved, please try again." delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil] show];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89;
}

- (NSArray *)searchResults {
    if (_searchResults == nil) {
        _searchResults = @[];
    }
    return _searchResults;
}

- (UIColor *)modalBarColor {
    if (_modalBarColor == nil) {
        _modalBarColor = [UIColor colorWithRed:0.974 green:0.974 blue:0.974 alpha:1];
    }
    return _modalBarColor;
}

- (NSString *)modalBarTitle {
    if (_modalBarTitle == nil) {
        _modalBarTitle = @"Listen to Music";
    }
    return _modalBarTitle;
}

- (UIColor *)modalBarTextColor {
    if (_modalBarTextColor == nil) {
        _modalBarTextColor = [UIColor blackColor];
    }
    return _modalBarTextColor;
}

- (NSString *)backButtonText {
    if (_backButtonText == nil) {
        _backButtonText = @"Back";
    }
    return _backButtonText;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
