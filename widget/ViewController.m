//
//  ViewController.m
//  widget
//
//  Created by ryu-ushin on 2014/11/27.
//  Copyright (c) 2014年 rain. All rights reserved.
//

#import "ViewController.h"

NSString *const kSharedKey = @"recentedViewPins";

@interface ViewController ()


@end

@implementation ViewController{
    NSArray *_data;
    
    NSMutableArray *_sharedData;
    
    NSUserDefaults *_defaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _data =@[@"aaa",@"bbb",@"ccc",@"ddd",@"eee",@"fff",@"ggg",@"hhh",@"iii",@"jjj",@"kkk",@"lll",@"aaa1",@"bbb1",@"ccc1",@"ddd1",@"eee1",@"fff1",@"ggg1",@"hhh1",@"iii1",@"jjj1",@"kkk1",@"lll1",@"aaa2",@"bbb2",@"ccc2",@"ddd2",@"eee2",@"fff2",@"ggg2",@"hhh2",@"iii2",@"jjj2",@"kkk2",@"lll2"];
    
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
    
    label.text = _data[indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
    
    if (!_defaults) {
        _defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.edu.self.todayWidget"];
        
    }
    
    NSArray *buffer = [_defaults objectForKey:kSharedKey];
    
    //create data
    if (!_sharedData) {
        _sharedData = [NSMutableArray arrayWithCapacity:4];
    }
    
    if (buffer) {
        _sharedData = [buffer  mutableCopy];
    }

    //check if contain, just change index, if not, add new object
    if (![self checkWhetherContain:[NSNumber numberWithInteger:indexPath.row]]) {
        
    
        if ([_sharedData count] >= 3) {
        [_sharedData removeObject:[_sharedData lastObject]];
    
        }
    
   
        NSDictionary *dicData = @{@"name":_data[indexPath.row],
                              @"index":[NSNumber numberWithInteger:indexPath.row]
                              };
    
    
        [_sharedData insertObject:dicData atIndex:0];
    
    
    
        [_defaults setObject:_sharedData forKey:kSharedKey];
    }
    
    
    NSLog(@"data!!! -> %@", [_defaults objectForKey:kSharedKey]);
    
    
    NSString *message = _data[indexPath.row];
    
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alterView show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)checkWhetherContain:(NSNumber*)index{
    __block BOOL isContain = NO;
    
    NSArray *array = [_defaults objectForKey:kSharedKey];
    
    NSMutableArray *buffer = [array mutableCopy];
    
    [buffer enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *hadIndex = [obj objectForKey:@"index"];
        
        
        if ([hadIndex isEqualToNumber:index]) {
            isContain = YES;
            
            //change index
            [buffer exchangeObjectAtIndex:idx withObjectAtIndex:0];
            
            //save change
            [_defaults setObject:buffer forKey:kSharedKey];
            
            
            *stop = YES;
        }
    }];
    
    
    return isContain;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
