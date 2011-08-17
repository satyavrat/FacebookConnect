//
//  AsynchronousImageDownloader.h
//  FacebookConnect
//
//  Created by satyavrat-mac on 16/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

/*write dealloc every where and release accordingly!!!*/

// why the hell it needs indexPath....


@protocol AsynchronousImageViewDelegate;

/*!
 @class		AsynchronousImageDownloader
 @brief		sdfkfjksdfj
 @details	sdkfsdf
 */
@interface AsynchronousImageView : UIImageView<FBRequestDelegate> {
	
	Facebook* facebook;
	id<AsynchronousImageViewDelegate>delegate;
	NSIndexPath* indexPath;
	NSString* profileId;
	UIImage* profileImage;
}

/*!
 @brief			skdfjksdf
 @details		sdjfhdjsfh
 @param			facebook the facebook singleton instance
 @return		jsdfjsdf
 */
+(id)getDownloaderWithSession:(Facebook*)facebook andIndexPath:(NSIndexPath*)indexPath andDelegate:(id)delegate;
-(void)startImageDownloadForProfileId:(NSString*)_profileId;

/*!
 @property		facebook
 @brief			sdfhsdjkfhjksdfj
 @details		asfhsjdkfhkjsdhfk
 */
@property(nonatomic,retain)Facebook *facebook;
@property(nonatomic,retain)id<AsynchronousImageViewDelegate>delegate;
@property(nonatomic,retain)NSIndexPath* indexPath;
@property(nonatomic,copy)NSString* profileId;
@property(nonatomic,retain)UIImage* profileImage;
@end


@protocol AsynchronousImageViewDelegate
// pass the delegate instance also in the method!!!
-(void)requestDidloadWithImage:(UIImage*)_profileImage andProfileId:(NSString*)_profileId;
@end