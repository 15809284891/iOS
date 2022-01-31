//
//  RunloopCell.m
//  Runloop_Table
//
//  Created by karisli(李雪) on 2021/3/18.
//

#import "RunloopCell.h"
@interface RunloopCell(){
    NSMutableArray *_imageViews;
}
@end
@implementation RunloopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(!self){
        return self;
    }
    _imageViews = [NSMutableArray array];
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width-4*10)/3.0;
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, 100)];
        imageView.layer.borderWidth = 2;
        imageView.layer.borderColor = [UIColor blueColor].CGColor;
        [_imageViews addObject:imageView];
        [self.contentView addSubview:imageView];
    }
    return self;
}
+(instancetype)runloopCellForTableView:(UITableView *)tableView indtifier:(nonnull NSString *)identifier{
    RunloopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RunloopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    for (UIImageView *imageV in _imageViews) {
        imageV.image = image;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
