//
//  TodayViewController.m
//  today
//
//  Created by ryu-ushin on 2014/11/27.
//  Copyright (c) 2014年 rain. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

NSString *const kSharedKey = @"recentedViewPins";

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@end

@implementation TodayViewController{
    NSArray *_data;
    
    NSUserDefaults *_defaults;
}

-(void)awakeFromNib{
    [super awakeFromNib];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!_defaults) {
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.edu.self.todayWidget"];
    }
    
    _data = [_defaults objectForKey:kSharedKey];
    
    NSLog(@"data -> %@",_data);
    
}

#pragma mark - table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *const cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    UILabel *label = (UILabel*)[cell viewWithTag:100];
    
    NSDictionary *appDic = (NSDictionary*)[_data objectAtIndex:indexPath.row];
    
    label.text = [appDic objectForKey:@"name"];
    
    return cell;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
    
    NSDictionary *appDic = (NSDictionary*)[_data objectAtIndex:indexPath.row];
    
    NSNumber *appIndex = (NSNumber*)[appDic objectForKey:@"index"];
    
    NSURL *url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"today://today/view?%ld",
                   (long)[appIndex integerValue]
                   ]
                  ];
    
    [self.extensionContext openURL:url completionHandler:nil];
    
    NSLog(@"url -> %@", [url absoluteString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
