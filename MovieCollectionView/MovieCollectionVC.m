//
//  MovieCollectionVC.m
//  MovieCollectionView
//
//  Created by Asmaa Tarek on 12/11/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "MovieCollectionVC.h"
#import "CollectionViewCell.h"
#import <AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import "Reachability.h"


@interface MovieCollectionVC ()
{
    NSString *baseURL;
     NSMutableArray* title;
     NSMutableArray* image;
     NSMutableArray* rating;
     NSMutableArray* releaseYear;
    NSMutableArray* response;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *movieCollectionVC;
@property (strong,nonatomic) Reachability* reach ;

@end

@implementation MovieCollectionVC

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    baseURL = @"https://api.androidhive.info/json/movies.json";
    image = [[NSMutableArray alloc]initWithObjects:@"1.jpg", nil];
    title = [[NSMutableArray alloc]initWithObjects:@"", nil];
    
    response = [NSMutableArray new];
    

    [self getApiData];
    


}
- (void)viewDidAppear:(BOOL)animated
{
    [self reachabilityForInternet];

}
-(void) reachabilityForInternet
{
    self.reach =[Reachability reachabilityForInternetConnection];
    switch ([_reach currentReachabilityStatus]){
            case NotReachable:
            printf("unreachable");
            [self showalert:@"Unreachable"];
                break;
            default:
                break;
        }
}
    


-(void) getApiData
{
 NSURL *URL = [NSURL URLWithString:baseURL];
 AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
 [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
     NSLog(@"JSON: %@", responseObject);
        //  self->title = [self->dict objectForKey:@"title"];
     self->response = responseObject;
     [self->image removeObjectAtIndex:0] ;
     [self->title removeObjectAtIndex:0];

     for (int i =0 ; i< [self->response count];i++)
     {
         [self->image addObject: [[self->response objectAtIndex:i] objectForKey:@"image"]];
         [self->title addObject:[[self->response objectAtIndex:i] objectForKey:@"title"]];
         
     }
     [self->_movieCollectionVC reloadData];

     printf("////////");
     NSLog(@"%@",self->image);
     
        //   self->rating = [self->dict objectForKey:@"rating"];
          // self->releaseYear = [self->dict objectForKey:@"releaseYear"];
   //  NSLog(@"%@",self->image); // Works Fine

 } failure:^(NSURLSessionTask *operation, NSError *error) {
     NSLog(@"Error: %@", error);
 }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [image count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell
   // cell.movieImg.image = [UIImage imageNamed:@"1.jpg"];
    [cell.movieImg sd_setImageWithURL:[NSURL URLWithString:[image objectAtIndex:indexPath.row]]];
    cell.movieName.text = [title objectAtIndex:indexPath.row];
    
  //[cell.movieImg sd_setImageWithURL:[NSURL URLWithString:[image objectAtIndex: indexPath.row]] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)showalert :(NSString*) message
{
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

@end


