//
//  AsynchronousImageDownloader.h
//  FacebookConnect
//
//  Created by satyavrat-mac on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
@protocol AsynchronousImageDownloaderDelegate

-(void)requestDidloadWithImage:(UIImage*)_profileImage andProfileId:(NSString*)_profileId;
@end

@interface AsynchronousImageDownloader : NSObject<FBRequestDelegate> {
	
	Facebook* facebook;
	id<AsynchronousImageDownloaderDelegate>delegate;
	NSIndexPath* indexPath;
	NSString* profileId;
	UIImage* profileImage;
}

+(id)getDownloaderWithSession:(Facebook*)facebook andIndexPath:(NSIndexPath*)indexPath andDelegate:(id)delegate;
-(void)startImageDownloadForProfileId:(NSString*)_profileId;
@property(nonatomic,retain)Facebook *facebook;
@property(nonatomic,retain)id<AsynchronousImageDownloaderDelegate>delegate;
@property(nonatomic,retain)NSIndexPath* indexPath;
@property(nonatomic,copy)NSString* profileId;
@property(nonatomic,retain)UIImage* profileImage;
@end
