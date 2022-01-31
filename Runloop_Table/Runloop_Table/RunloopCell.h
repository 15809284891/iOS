//
//  RunloopCell.h
//  Runloop_Table
//
//  Created by karisli(李雪) on 2021/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopCell : UITableViewCell
+ (instancetype)runloopCellForTableView:(UITableView *)tableView indtifier:(NSString *)identifier;
@property (nonatomic,copy)UIImage *image;
@end

NS_ASSUME_NONNULL_END
