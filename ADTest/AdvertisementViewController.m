//
//  AdvertisementViewController.m
//  ADTest
//
//  Created by 赵春生 on 2018/6/6.
//  Copyright © 2018 HUMiooZcs. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "AdvertisementModel.h"
#import "AdvertisementTableViewCell.h"

#define ADCellHeight 120//广告cell高度
#define IMAGESCALE 1.00//图片设置比例
#define ISSETSCALE NO//图片缩放是否启用
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AdvertisementViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UIImageView *bkimv;//图片视图
@property (assign, nonatomic) CGFloat originalHeight;//图片高度
@property (assign, nonatomic) CGFloat originalWidth;//图片宽度

@end

@implementation AdvertisementViewController
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            AdvertisementModel *model = [[AdvertisementModel alloc] init];
            //            if ((i+1)%2 == 1) {
            if (i == 8) {
                model.isShow = true;
            } else {
                model.isShow = false;
            }
            model.name = [NSString stringWithFormat:@"%d",i];
            [_array addObject:model];
        }
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI {
    self.bkimv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"001"]];
    
    self.originalHeight = self.bkimv.bounds.size.height*(ScreenWidth*IMAGESCALE/self.bkimv.bounds.size.width);
    self.originalWidth = ScreenWidth*IMAGESCALE;
    
    self.bkimv.bounds = CGRectMake(0, 0, self.originalWidth, self.originalHeight);
    
    [self.view addSubview:self.bkimv];
    
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    AdvertisementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AdvertisementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    AdvertisementModel *model = self.array[[indexPath row]];
    [cell setModel:model];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 8) {
        return ADCellHeight;
    }
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat w = self.originalWidth;//图片宽度
    CGFloat h = self.originalHeight;//图片高度
    CGFloat x = ScreenWidth/2;//中心点x坐标
    CGFloat y = scrollView.contentOffset.y/2+self.originalHeight/3;//中心点y坐标
    CGFloat scale = 1;
    if (ISSETSCALE) {
        scale = (1-scrollView.contentOffset.y/ScreenHeight);
    }
    //    CGFloat scale1 = 1;//图片移动时比例变化率
    
    NSIndexPath *path= [NSIndexPath indexPathForRow:8 inSection:0];
    CGRect rectInTableView = [self.table rectForRowAtIndexPath:path];
    CGRect rectInSuperview = [self.table convertRect:rectInTableView toView:[self.table superview]];//cell相对于屏幕位置
    
    NSLog(@"%f %f %f",scale, y , rectInSuperview.origin.y);
    
    if (rectInSuperview.origin.y <= (y-h*scale/2)) {
        self.bkimv.bounds = CGRectMake(0, 0, w*scale, h*scale);
        self.bkimv.center = CGPointMake(x, rectInSuperview.origin.y+h*scale/2);
    } else if ((rectInSuperview.origin.y + ADCellHeight) >= (y+h*scale/2)) {
        self.bkimv.bounds = CGRectMake(0, 0, w*scale, h*scale);
        self.bkimv.center = CGPointMake(x, (rectInSuperview.origin.y + ADCellHeight)-h*scale/2);
    } else {
        self.bkimv.bounds = CGRectMake(0, 0, w*scale, h*scale);
        self.bkimv.center = CGPointMake(x, y);
    }
}
@end
