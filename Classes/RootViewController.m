//
//  RootViewController.m
//  FacebookConnect
//
//  Created by satyavrat-mac on 12/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import"AsynchronousImageDownloader.h"
@implementation RootViewController

@synthesize myTableView;
#pragma mark -
#pragma mark View lifecycle
static NSString *kAppId= @"246139905408010";

-(void)loadView{
	[super loadView];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	facebook =[[ Facebook alloc] initWithAppId:kAppId];
	label=[[UILabel alloc]initWithFrame:CGRectMake(70, 70, 200, 100)];
	label.text=@"Please Login First";
	[self.view addSubview:label];
	
	loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
	loginButton.frame=CGRectMake(100, 160, 100, 20);
	[loginButton setTitle:@"Login" forState:UIControlStateNormal];
	[loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:loginButton];
	
}
-(void)logout{
	NSLog(@"logout");
}

-(void)login{
	[facebook authorize:nil delegate:self];
}
- (void)fbDidLogin {
	self.title=@"Friend List";
	self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
	loginButton.hidden=YES;
	myTableView=[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	myTableView.delegate=self;
	myTableView.dataSource=self;
	label.text=@"Loading Friend List";
	[facebook requestWithGraphPath:@"me/friends" andDelegate:self];
}

#pragma mark FBRequestDelegate
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	
}

- (void)request:(FBRequest *)request didLoad:(id)result{
	tableData=[[result valueForKey:@"data"]retain];
	[self.view addSubview:myTableView];
}
#pragma mark AsynchronousImageDownloaderDelegate

-(void)requestDidloadWithImage:(UIImage*)profileImage andProfileId:(NSString*)profileId{
	if (profileImages==nil) {
		profileImages=[[NSMutableDictionary alloc] init];
	}
	[profileImages setObject:profileImage forKey:profileId];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	// Configure the cell.
	cell.textLabel.text=[[tableData objectAtIndex:[indexPath row]] valueForKey:@"name"];
	AsynchronousImageDownloader* imageDownloader;
	if([profileImages objectForKey:[[tableData objectAtIndex:[indexPath row]] valueForKey:@"id"]]==nil)
	{
		imageDownloader=[[[AsynchronousImageDownloader getDownloaderWithSession:facebook andIndexPath:indexPath andDelegate:self]retain] autorelease];
		[imageDownloader startImageDownloadForProfileId:[[tableData objectAtIndex:[indexPath row] ] valueForKey:@"id"] ];
		cell.imageView.image=[UIImage imageNamed:@"not_there.jpg"];
	}
	else{
		cell.imageView.image=[profileImages objectForKey:[[tableData objectAtIndex:[indexPath row]] valueForKey:@"id"]];
	}
	
	return cell;
}




#pragma mark -
#pragma mark Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 
}

*/
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

