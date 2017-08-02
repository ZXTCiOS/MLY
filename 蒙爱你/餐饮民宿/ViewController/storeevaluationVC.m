//
//  storeevaluationVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "storeevaluationVC.h"
#import "evaluaBtn.h"
#import "WJGtextView.h"
#import "submitBtn.h"
#import "strisNull.h"
#import "MBProgressHUD+XMG.h"

@interface storeevaluationVC ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) evaluaBtn *btn0;
@property (nonatomic,strong) evaluaBtn *btn1;
@property (nonatomic,strong) evaluaBtn *btn2;
@property (nonatomic,strong) evaluaBtn *btn3;
@property (nonatomic,strong) evaluaBtn *btn4;
@property (nonatomic,strong) submitBtn *subbtn;
@property (nonatomic,strong) WJGtextView *textView;

@property (nonatomic,assign) BOOL isbtn0;
@property (nonatomic,assign) BOOL isbtn1;
@property (nonatomic,assign) BOOL isbtn2;
@property (nonatomic,assign) BOOL isbtn3;
@property (nonatomic,assign) BOOL isbtn4;

@property (nonatomic,strong) NSString *starstr;

@end

@implementation storeevaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评价";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    
    _isbtn0 = NO;
    _isbtn1 = NO;
    _isbtn2 = NO;
    _isbtn3 = NO;
    _isbtn4 = NO;
    
    [self.view addSubview:self.namelab];
    [self.view addSubview:self.btn0];
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    
    [self.view addSubview:self.textView];
    [self.view addSubview:self.subbtn];
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.view addGestureRecognizer:TapGestureTecognizer];
    
    [self setuplayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)setuplayout
{
     __weak typeof (self) weakSelf = self;
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.view).with.offset(15*HEIGHT_SCALE+64);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(24*HEIGHT_SCALE);
    }];
    [self.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.width.mas_offset(50);
        make.height.mas_offset(30);

    }];
    
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn0.mas_right).with.offset(22*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn1.mas_right).with.offset(22*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn2.mas_right).with.offset(22*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn3.mas_right).with.offset(22*WIDTH_SCALE);
        make.top.equalTo(weakSelf.btn0);
        make.width.mas_offset(50);
        make.height.mas_offset(30);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.namelab);
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(150*HEIGHT_SCALE);
    }];
    
    [self.subbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.right.equalTo(weakSelf.view).with.offset(-14*WIDTH_SCALE);
        make.width.mas_offset(60);
        make.height.mas_offset(30);
    }];
}

#pragma mark - getters

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"店铺店铺店铺店铺店铺店铺";
        _namelab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _namelab.font = [UIFont systemFontOfSize:18];
    }
    return _namelab;
}

-(evaluaBtn *)btn0
{
    if(!_btn0)
    {
        _btn0 = [[evaluaBtn alloc] init];
        _btn0.evaluaimg.image = [UIImage imageNamed:@"ms-sx-xx-g"];
        _btn0.evalualab.text = @"1";
        _btn0.layer.masksToBounds = YES;
        _btn0.layer.cornerRadius = 3;
        _btn0.evalualab.textColor = [UIColor blackColor];
        _btn0.backgroundColor = [UIColor whiteColor];
        [_btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
        _btn0.layer.masksToBounds = YES;
        _btn0.layer.borderWidth = 1;
        _btn0.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
        _btn0.layer.cornerRadius = 5;
    }
    return _btn0;
}

-(evaluaBtn *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[evaluaBtn alloc] init];
        _btn1.evaluaimg.image = [UIImage imageNamed:@"ms-sx-xx-g"];
        _btn1.evalualab.text = @"2";
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.cornerRadius = 3;
        _btn1.evalualab.textColor = [UIColor blackColor];
        _btn1.backgroundColor = [UIColor whiteColor];
        [_btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
        _btn1.layer.masksToBounds = YES;
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
        _btn1.layer.cornerRadius = 5;
    }
    return _btn1;
}

-(evaluaBtn *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[evaluaBtn alloc] init];
        _btn2.evaluaimg.image = [UIImage imageNamed:@"ms-sx-xx-g"];
        _btn2.evalualab.text = @"3";
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.cornerRadius = 3;
        _btn2.evalualab.textColor = [UIColor blackColor];
        _btn2.backgroundColor = [UIColor whiteColor];
        [_btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
        _btn2.layer.masksToBounds = YES;
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
        _btn2.layer.cornerRadius = 5;
    }
    return _btn2;
}

-(evaluaBtn *)btn3
{
    if(!_btn3)
    {
        _btn3 = [[evaluaBtn alloc] init];
        _btn3.evaluaimg.image = [UIImage imageNamed:@"ms-sx-xx-g"];
        _btn3.evalualab.text = @"4";
        _btn3.layer.masksToBounds = YES;
        _btn3.layer.cornerRadius = 3;
        _btn3.evalualab.textColor = [UIColor blackColor];
        _btn3.backgroundColor = [UIColor whiteColor];
        [_btn3 addTarget:self action:@selector(btn3click) forControlEvents:UIControlEventTouchUpInside];
        _btn3.layer.masksToBounds = YES;
        _btn3.layer.borderWidth = 1;
        _btn3.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
        _btn3.layer.cornerRadius = 5;
    }
    return _btn3;
}

-(evaluaBtn *)btn4
{
    if(!_btn4)
    {
        _btn4 = [[evaluaBtn alloc] init];
        _btn4.evaluaimg.image = [UIImage imageNamed:@"ms-sx-xx-g"];
        _btn4.evalualab.text = @"5";
        _btn4.layer.masksToBounds = YES;
        _btn4.layer.cornerRadius = 3;
        _btn4.evalualab.textColor = [UIColor blackColor];
        _btn4.backgroundColor = [UIColor whiteColor];
        [_btn4 addTarget:self action:@selector(btn4click) forControlEvents:UIControlEventTouchUpInside];
        _btn4.layer.masksToBounds = YES;
        _btn4.layer.borderWidth = 1;
        _btn4.layer.borderColor = [UIColor colorWithHexString:@"d6d6d6"].CGColor;
        _btn4.layer.cornerRadius = 5;
    }
    return _btn4;
}

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"写下您对商家的评价吧";
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        _textView.layer.cornerRadius = 4;
        _textView.delegate = self;
    }
    return _textView;
}

-(submitBtn *)subbtn
{
    if(!_subbtn)
    {
        _subbtn = [[submitBtn alloc] init];
        [_subbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subbtn;
}


-(void)keyboardHide
{
    [self.textView resignFirstResponder];
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    //允许提交按钮点击操作
    
       //实时显示字数
    self.textView.numberlabel.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    
    //字数限制操作
    if (textView.text.length >= 200) {
        
        textView.text = [textView.text substringToIndex:200];
        self.textView.numberlabel.text = @"200/200";
        
    }
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length != 0) {
        
    }
    
}

#pragma mark - 点击方法

-(void)btn0click
{
    _isbtn0 = !_isbtn0;
    if (_isbtn0) {
        self.starstr = @"1";
        _isbtn2 = NO;
        _isbtn3 = NO;
        _isbtn4 = NO;
        _isbtn1 = NO;
        
        self.btn0.backgroundColor = [UIColor redColor];
        self.btn0.evalualab.textColor = [UIColor whiteColor];
    }
    else
    {
        self.starstr = @"0";
        self.btn0.backgroundColor = [UIColor whiteColor];
        self.btn0.evalualab.textColor = [UIColor blackColor];
    }
}

-(void)btn1click
{
    _isbtn1 = !_isbtn1;
    if (_isbtn1) {
        self.starstr = @"2";
        _isbtn2 = NO;
        _isbtn3 = NO;
        _isbtn4 = NO;
        _isbtn0 = NO;
        self.btn0.backgroundColor = [UIColor redColor];
        self.btn0.evalualab.textColor = [UIColor whiteColor];
        self.btn1.backgroundColor = [UIColor redColor];
        self.btn1.evalualab.textColor = [UIColor whiteColor];
    }
    else
    {
        self.starstr = @"0";
        self.btn0.backgroundColor = [UIColor whiteColor];
        self.btn0.evalualab.textColor = [UIColor blackColor];
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.evalualab.textColor = [UIColor blackColor];
    }
}

-(void)btn2click
{
    _isbtn2 = !_isbtn2;
    if (_isbtn2) {
        self.starstr = @"3";
        _isbtn1 = NO;
        _isbtn3 = NO;
        _isbtn4 = NO;
        _isbtn0 = NO;
        self.btn0.backgroundColor = [UIColor redColor];
        self.btn0.evalualab.textColor = [UIColor whiteColor];
        self.btn1.backgroundColor = [UIColor redColor];
        self.btn1.evalualab.textColor = [UIColor whiteColor];
        self.btn2.backgroundColor = [UIColor redColor];
        self.btn2.evalualab.textColor = [UIColor whiteColor];
    }
    else
    {
        self.starstr = @"0";
        self.btn0.backgroundColor = [UIColor whiteColor];
        self.btn0.evalualab.textColor = [UIColor blackColor];
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.evalualab.textColor = [UIColor blackColor];
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.evalualab.textColor = [UIColor blackColor];
 
    }
}

-(void)btn3click
{
    _isbtn3 = !_isbtn3;
    if (_isbtn3) {
        self.starstr = @"4";
        _isbtn1 = NO;
        _isbtn2 = NO;
        _isbtn4 = NO;
        _isbtn0 = NO;
        self.btn0.backgroundColor = [UIColor redColor];
        self.btn0.evalualab.textColor = [UIColor whiteColor];
        self.btn1.backgroundColor = [UIColor redColor];
        self.btn1.evalualab.textColor = [UIColor whiteColor];
        self.btn2.backgroundColor = [UIColor redColor];
        self.btn2.evalualab.textColor = [UIColor whiteColor];
        self.btn3.backgroundColor = [UIColor redColor];
        self.btn3.evalualab.textColor = [UIColor whiteColor];
    }
    else
    {
        self.starstr = @"0";
        self.btn0.backgroundColor = [UIColor whiteColor];
        self.btn0.evalualab.textColor = [UIColor blackColor];
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.evalualab.textColor = [UIColor blackColor];
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.evalualab.textColor = [UIColor blackColor];
        self.btn3.backgroundColor = [UIColor whiteColor];
        self.btn3.evalualab.textColor = [UIColor blackColor];
    }
}

-(void)btn4click
{
    _isbtn4 = !_isbtn4;
    if (_isbtn4) {
        self.starstr = @"5";
        _isbtn0 = NO;
        _isbtn1 = NO;
        _isbtn2 = NO;
        _isbtn3 = NO;
        self.btn0.backgroundColor = [UIColor redColor];
        self.btn0.evalualab.textColor = [UIColor whiteColor];
        self.btn1.backgroundColor = [UIColor redColor];
        self.btn1.evalualab.textColor = [UIColor whiteColor];
        self.btn2.backgroundColor = [UIColor redColor];
        self.btn2.evalualab.textColor = [UIColor whiteColor];
        self.btn3.backgroundColor = [UIColor redColor];
        self.btn3.evalualab.textColor = [UIColor whiteColor];
        self.btn4.backgroundColor = [UIColor redColor];
        self.btn4.evalualab.textColor = [UIColor whiteColor];
    }
    else
    {
        self.starstr = @"0";
        self.btn0.backgroundColor = [UIColor whiteColor];
        self.btn0.evalualab.textColor = [UIColor blackColor];
        self.btn1.backgroundColor = [UIColor whiteColor];
        self.btn1.evalualab.textColor = [UIColor blackColor];
        self.btn2.backgroundColor = [UIColor whiteColor];
        self.btn2.evalualab.textColor = [UIColor blackColor];
        self.btn3.backgroundColor = [UIColor whiteColor];
        self.btn3.evalualab.textColor = [UIColor blackColor];
        self.btn4.backgroundColor = [UIColor whiteColor];
        self.btn4.evalualab.textColor = [UIColor blackColor];
    }
}

-(void)submitbtnclick
{
    NSLog(@"提交评价");
    NSLog(@"star------%@",self.starstr);
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *user_nickname = [defat objectForKey:@"user_nicknamestr"];
    NSString *user_picture = [defat objectForKey:@"user_picturestr"];
    NSString *eval_content = @"";
    
    if ([strisNull isNullToString:self.textView.text]) {
        eval_content = @"0";
    }else
    {
        eval_content = self.textView.text;
    }
    
    NSDictionary *para = @{@"home_id":self.home_id,@"user_picture":user_picture,@"user_nickname":user_nickname,@"eval_star":self.starstr,@"eval_content":eval_content};
    
    [DNNetworking postWithURLString:post_evaluate parameters:para success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showSuccess:@"成功"];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
