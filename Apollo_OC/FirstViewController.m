//
//  FirstViewController.m
//  Apollo_OC
//
//  Created by Travel Chu on 4/18/17.
//  Copyright © 2017 Midtown Doornail. All rights reserved.
//

#import "FirstViewController.h"
#import "API.h"
#import "GQClient.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  GQClient *client = [[GQClient alloc] initWithUrl:[NSURL URLWithString:@"http://10.0.1.58:8080/graphql"]];
  [client watch:[[StarshipQuery alloc] init] resultHandler:^(GraphQLResult *result, NSError *error) {
    
  }];
  
  NSArray *arr = @[@1,@2,@3,@4,@5];
  NSLog(@"%@", [arr subarrayWithRange:NSMakeRange(3, 2)]);
}


@end
