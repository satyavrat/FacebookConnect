//
//  RootViewController.h
//  FacebookConnect
//
//  Created by satyavrat-mac on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AsynchronousImageView.h"


@interface RootViewController:UIViewController<FBRequestDelegate,
FBDialogDelegate,FBSessionDelegate,UITableViewDataSource,UITableViewDelegate,
AsynchronousImageViewDelegate> {
	
	UITableView* myTableView;
	Facebook* facebook;
	
	@private
	UIButton* loginButton;
	UILabel* statusLabel; 
	NSMutableArray* arrayOfFriendsData; 
	NSMutableDictionary* profileImages; 
}

@property(nonatomic,copy)NSMutableArray *arrayOfFriendsData;

@end
