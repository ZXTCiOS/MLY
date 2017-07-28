//
//  ShopDetailVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/18.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShopDetailVC.h"

@interface ShopDetailVC ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollV;

@property (nonatomic, strong) UIView *payView;


@property (nonatomic, strong) UIImageView *imgV;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *pric;

@property (nonatomic, strong) UILabel *beiZhuL;

@property (nonatomic, strong) UILabel *jianjieL;



@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIButton *jiaBtn;

@property (nonatomic, strong) UIButton *jianBtn;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *payNowBtn;



@end

@implementation ShopDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self configScrollView];
    [self configPayView];
    
    self.title = @"商品详情";
    [XDFactory addBackItemForVC:self];
    NSLog(@"%@",self.infodic);
}

#pragma  mark - textView   delegate


- (void)textViewDidChange:(UITextView *)textView{
    NSString *str = textView.text;
    if (str.length > 6) {
        textView.text = @"0";
    }
    
    if (str.length > 1) {
        char first = [str characterAtIndex:0];
        if (first == '0') {
            char secend = [str characterAtIndex:1];
            textView.text = [NSString stringWithFormat:@"%c", secend];
        }
    }
    NSInteger num = textView.text.integerValue;
    if (num < 1) {
        self.textView.text = @"0";
    }
    self.priceL.text = [NSString stringWithFormat:@"¥%.2f", num * 33.1];
}



#pragma  mark - 键盘 监听

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}



-(void) keyboardWillShow:(NSNotification *) note
{
    // 获取键盘的位置和大小
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // 获取输入框的位置和大小
    CGRect containerFrame = _payView.frame;
    // 计算出输入框的y坐标
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    
    // 动画改变位置
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        // 更改输入框的位置
        //_payView.frame = containerFrame;
        
        
        [_payView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-keyboardBounds.size.height);
        }];
        
    }];
}


-(void) keyboardWillHide:(NSNotification *) note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 获取输入框的位置和大小
    CGRect containerFrame = _payView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    // 动画改变位置
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        // 更改输入框的位置
        //_payView.frame = containerFrame;
        [_payView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
        }];
    }];
}




- (void)configScrollView{
    
    self.scrollV = [[UIScrollView alloc] init];
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.scrollV addGestureRecognizer:TapGestureTecognizer];
    [self.view addSubview:self.scrollV];
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.bottom.equalTo(-104);
    }];
    
    
    self.imgV = [[UIImageView alloc] init];
    [self.scrollV addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(0);
        make.height.equalTo(200);
    }];
    
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:[self.infodic objectForKey:@"img"]] placeholderImage:nil];
    
    self.nameL = [UILabel new];
    [self.scrollV addSubview:self.nameL];
    self.nameL.font = [UIFont systemFontOfSize:17];
    [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.imgV.mas_bottom).equalTo(20);
        //make.right.equalTo(self.pric.mas_left).equalTo(-20);
        make.height.equalTo(18);
    }];
    self.nameL.textColor = krgb(11, 121, 182, 1);
    self.nameL.text = @"工艺品名字";
    self.nameL.text = [self.infodic objectForKey:@"name"];
    
    self.pric = [UILabel new];
    [self.scrollV addSubview:self.pric];
    self.pric.font = [UIFont systemFontOfSize:16];
    self.pric.textAlignment = NSTextAlignmentRight;
    [self.pric mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgV.mas_bottom).equalTo(20);
        make.right.equalTo(-10);
        make.size.equalTo(CGSizeMake(100, 18));
        make.left.equalTo(self.nameL.mas_right);
    }];
    self.pric.textColor = krgb(223, 8, 66, 1);
    self.pric.text = [NSString stringWithFormat:@"¥%.2f", 33.0];
    self.pric.text = [NSString stringWithFormat:@"¥%.2f",[[self.infodic objectForKey:@"price"] floatValue]];
    self.beiZhuL = [UILabel new];
    [self.scrollV addSubview:self.beiZhuL];
    self.beiZhuL.numberOfLines = 0;
    self.beiZhuL.font = [UIFont systemFontOfSize:14];
    NSString *str = [NSString string];
    str = [self.infodic objectForKey:@"intro"];
    CGSize size = [str sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(kScreenW - 20, 1000) mode:NSLineBreakByWordWrapping];
    
    [self.beiZhuL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.nameL.mas_bottom).equalTo(25);
        make.height.equalTo(size.height + 5);
        make.width.equalTo(kScreenW - 20);
    }];
    
    
    self.jianjieL = [UILabel new];
    [self.scrollV addSubview:self.jianjieL];
    self.jianjieL.numberOfLines = 0;
    self.jianjieL.font = [UIFont systemFontOfSize:14];
    NSString *jiastr = [NSString string];
    jiastr = [self.infodic objectForKey:@"descrip"];
    CGSize jiansize = [jiastr sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(kScreenW - 20, 1000) mode:NSLineBreakByWordWrapping];
    
    [self.jianjieL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.beiZhuL.mas_bottom).equalTo(20);
        make.height.equalTo(jiansize.height + 5);
        make.width.equalTo(kScreenW - 20);
        make.bottom.lessThanOrEqualTo(-10);
    }];
    
    self.beiZhuL.text = str;
    self.jianjieL.text = jiastr;
    
}

- (void)configPayView{
    
    UIView *view = [[UIView alloc] init];
    self.payView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(104);
    }];
    
    
    UILabel *hejiL = [[UILabel alloc] init];
    [view addSubview:hejiL];
    hejiL.font = [UIFont systemFontOfSize:16];
    hejiL.textColor = [UIColor colorWithHexString:@"#333333"];
    hejiL.text = @"合计:";
    
     [hejiL mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.left.equalTo(30);
         make.size.equalTo(CGSizeMake(40, 17));
     }];
    
    
    
    self.priceL = [UILabel new];
    [view addSubview:_priceL];
    _priceL.textColor = krgb(223, 8, 66, 1);
    _priceL.textAlignment = NSTextAlignmentLeft;
    _priceL.text = @"¥0";                                       // 起始价格   待定
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hejiL.mas_centerY);
        make.left.equalTo(hejiL.mas_right).equalTo(20);
        make.width.equalTo(200);
        make.left.equalTo(hejiL.mas_right);
        make.height.equalTo(16);
    }];
    
    
    
    self.payNowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.payNowBtn setBackgroundImage:[UIImage imageNamed:@"lijigoumai"] forState:UIControlStateNormal];
    [view addSubview:self.payNowBtn];
    [self.payNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-10);
        make.centerX.equalTo(view.mas_centerX);
        make.left.equalTo(40);
        make.height.equalTo(34);
    }];
    [self.payNowBtn bk_addEventHandler:^(id sender) {
        if (self.textView.text.intValue == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"请选择数量" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:act];
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        } else {
            [self.view endEditing:YES];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.jiaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.jiaBtn setBackgroundImage:[UIImage imageNamed:@"sl-zj"] forState:UIControlStateNormal];
    [view addSubview:self.jiaBtn];
    [self.jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(23, 23));
        make.top.equalTo(15);
        make.right.equalTo(-30);
    }];
    [self.jiaBtn bk_addEventHandler:^(id sender) {
        
        NSString *str = self.textView.text;
        int num = [str intValue];
        num++;
        self.textView.text = [NSString stringWithFormat:@"%d", num];
        self.priceL.text = [NSString stringWithFormat:@"¥%.2f", num * 33.1];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.jianBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.jianBtn setBackgroundImage:[UIImage imageNamed:@"sl-jq"] forState:UIControlStateNormal];
    [view addSubview:self.jianBtn];
    [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(23, 23));
        make.top.equalTo(15);
    }];
    [self.jianBtn bk_addEventHandler:^(id sender) {
        NSString *str = self.textView.text;
        int num = [str intValue];
        if (num > 1) {
            num--;
        }
        self.priceL.text = [NSString stringWithFormat:@"¥%.2f", num * 33.1];
        self.textView.text = [NSString stringWithFormat:@"%d", num];
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.textView = [[UITextView alloc] init];
    self.textView.text = @"1";                              // 起始数量    待定
    self.textView.textAlignment = NSTextAlignmentCenter;
    self.textView.keyboardType = UIKeyboardTypeNumberPad;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    [view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(55, 34));
        make.right.equalTo(self.jiaBtn.mas_left);
        make.left.equalTo(self.jianBtn.mas_right);
        make.centerY.equalTo(self.jianBtn.mas_centerY);
    }];
    
    
    
    UIView *line = [[UIView alloc] init];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jianBtn.mas_bottom);
        make.centerX.equalTo(self.textView.mas_centerX);
        make.width.equalTo(55);
        make.height.equalTo(1);
    }];
    line.backgroundColor = krgb(241, 241, 241, 1);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardHide
{
    NSLog(@"keyboardHide");
    [self.textView resignFirstResponder];
}

@end
