//
//  AsynchronousImageDownloader.m
//  FacebookConnect
//
//  Created by satyavrat-mac on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageView.h"


@implementation AsynchronousImageView
@synthesize indexPath,delegate,facebook,profileId,profileImage;


// is facebook a session?????????
+(id)getDownloaderWithSession:(Facebook*)facebook  andIndexPath:(NSIndexPath*)indexPath andDelegate:(id)delegate{
	AsynchronousImageView* downloader=[[[AsynchronousImageView alloc]init] autorelease];
	downloader.facebook=facebook;
	downloader.indexPath=indexPath;
	downloader.delegate=delegate;
	return downloader;
}


// call it facebook profile id
-(void)startImageDownloadForProfileId:(NSString*)_profileId{
	profileId=_profileId;
	NSString* graphPath=[[NSString stringWithFormat:@"%@/picture",profileId] retain];
	NSMutableDictionary* params=[[NSMutableDictionary alloc] init];
	[params setObject:@"square" forKey:@"type"];
	[facebook requestWithGraphPath:graphPath andParams:params
					   andDelegate:self];
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"received response");
}

- (void)request:(FBRequest *)request didLoad:(id)result{
	
	profileImage=[[UIImage imageWithData:result] retain];
	[delegate requestDidloadWithImage:profileImage andProfileId:profileId];
}

// tell the delegate about error!!!!!
-(void)request:(FBRequest*)request didFailWithError:(NSError*)error{
	NSLog(@"error");
}


-(void)dealloc
{
	delegate = nil;
	[super dealloc];
}
@end
