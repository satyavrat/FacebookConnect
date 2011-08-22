//
//  AsynchronousImageDownloader.m
//  FacebookConnect
//
//  Created by satyavrat-mac on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageView.h"

@interface AsynchronousImageView ()
@property(nonatomic,retain) NSURLConnection* connection;
@property(nonatomic,retain) NSMutableURLRequest* request;
@property(nonatomic,retain) NSMutableData* data;
@end

@implementation AsynchronousImageView
@synthesize url,delegate,profileId,data,request,connection;


-(id)initWithImageURL:(NSURL*)_url andProfileId:_profileId andDelegate:_delegate {
	[super init];
	delegate=_delegate;
	url=_url;
	profileId=_profileId;
	return self;
}

-(void)startImageDownload
{	
	 self.request =[NSMutableURLRequest requestWithURL:url];
	 self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
}


#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
		
	}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data {
	if (data==nil) {
	self.data=[NSMutableData data];
	}
	
	[data appendData:_data];

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	self.image=[UIImage imageWithData:data];
	[delegate imageView:self withImage:self.image andProfileId:self.profileId];
}


-(void)dealloc
{	[profileId release];
	[url release];
	[data release];
	[request release];
	[connection release];
	[super dealloc];
}
@end
