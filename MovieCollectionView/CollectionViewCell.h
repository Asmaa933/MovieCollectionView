//
//  CollectionViewCell.h
//  MovieCollectionView
//
//  Created by Asmaa Tarek on 12/11/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImg;
@property (weak, nonatomic) IBOutlet UILabel *movieName;

@end

NS_ASSUME_NONNULL_END
