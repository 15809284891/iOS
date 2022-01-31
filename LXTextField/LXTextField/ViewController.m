//
//  ViewController.m
//  LXTextField
//
//  Created by karisli(李雪) on 2020/3/19.
//  Copyright © 2020 tencentyun.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UITextField *textFiled;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSArray *pickerDatas;
@property (nonatomic,strong)WKWebView *webView;
@end

@implementation ViewController
-(instancetype)init{
    self = [super  init];
    if (!self) {
        return self;
    }
    _pickerDatas = @[@"1",@"2",@"3"];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self.view addSubview:_tableView];
//    _pickerDatas = @[@"1",@"2",@"3"];
    //allWebsiteDataTypes清除所有缓存
 
    
    NSSet *type = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache]];
           NSDate *date = [NSDate date];
           [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:type modifiedSince:date completionHandler:^{}];
    
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *cookiePath = [libPath stringByAppendingString:@"/Cookies"];
    [[NSFileManager defaultManager] removeItemAtPath:cookiePath error:nil];
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
  
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:[WKWebViewConfiguration new]];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://cloud.tencent.com/login"]]];
   
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(void)toolBarDoneClick:(UIBarButtonItem *)item{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
     UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
      UITextField *textF = [cell viewWithTag:102];
     [textF resignFirstResponder];
    self.pickerDatas = @[@"8",@"9",@"5"];
    [self.tableView reloadRowsAtIndexPaths:index withRowAnimation:UITableViewRowAnimationFade];
     
 
}

-(void)setPickerDatas:(NSArray *)pickerDatas{
    _pickerDatas = pickerDatas;
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
    UITextField *textF = [cell viewWithTag:102];
    [textF becomeFirstResponder];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"1"];
    cell.contentView.userInteractionEnabled = NO;
//      NSMutableArray *barItems = [NSMutableArray array];
//        // Do any additional setup after loading the view.
//        self.view.backgroundColor = [UIColor yellowColor];
//        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//        UIView *accessView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
//    //    _textFiled.delegate = self;
//        UIToolbar *toobar = [[UIToolbar alloc]init];
//        [toobar sizeToFit];
//        toobar.barStyle = UIBarStyleDefault;
//        UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"dialog.cancel",nil) style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCanelClick:)];
//        [barItems addObject:cancleItem];
//        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//
//        [barItems addObject:flexSpace];
//        UIBarButtonItem *flex1Space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//
//        [barItems addObject:flex1Space];
//        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"dialog.confirm",nil) style:UIBarButtonItemStylePlain target:self action:@selector(toolBarDoneClick:)];
//        [barItems addObject:doneItem];
//        [toobar setItems:barItems];
//        textFiled.tag = 102;
//        textFiled.inputAccessoryView = toobar;
//        textFiled.backgroundColor = [UIColor redColor];
//        UIPickerView *pickerView= [[UIPickerView alloc]init];
//        pickerView.layer.borderWidth = 0.5;
//        pickerView.backgroundColor = [UIColor whiteColor];
//        pickerView.dataSource = self;
//        pickerView.delegate = self;
//        _pickerView = pickerView;
//        textFiled.inputView = pickerView;
//        [cell.contentView addSubview:textFiled];
//        ;
    cell.detailTextLabel.backgroundColor = [UIColor redColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.text = @"fwsf";
    cell.detailTextLabel.text = @"heelollllllllllllllll金柳露lllllllll";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    UITextField *textF = [cell viewWithTag:102];
//    [textF becomeFirstResponder];
    NSLog(@"wewewewewew");
    
}




// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerDatas.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickerDatas[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    self.selectRegion = _pickerDatas[row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lable = (UILabel *)view;
    if (lable == nil) {
    lable = [[UILabel alloc]init];
    }
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = [self pickerView:pickerView titleForRow:row forComponent:component];

    return lable;
}

@end
