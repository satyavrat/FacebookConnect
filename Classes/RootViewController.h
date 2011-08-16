//
//  RootViewController.h
//  FacebookConnect
//
//  Created by satyavrat-mac on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AsynchronousImageDownloader.h"
@interface RootViewController:UIViewController<FBRequestDelegate,
FBDialogDelegate,FBSessionDelegate,UITableViewDataSource,UITableViewDelegate,
AsynchronousImageDownloaderDelegate> {
	
	UITableView* myTableView;
	Facebook* facebook;
	UIButton* loginButton;
	UILabel* label;
	NSMutableArray* tableData;
	NSMutableDictionary* profileImages;
}

@property(nonatomic,retain)UITableView* myTableView;

@end
