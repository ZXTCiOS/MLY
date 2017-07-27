//
//  myorderCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myorderCell.h"
#import "myOrderModel.h"

@interface myorderCell()
@property (nonatomic,strong) UIImageView *orderImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *numLab;
@property (nonatomic,strong) UILabel *totalLab;

//待付款
//取消
@property (nonatomic,strong) UIButton *cancelBtn;
//付款
@property (nonatomic,strong) UIButton *payBtn;

//已付款
//退款
@property (nonatomic,strong) UIButton *refundBtn;
//修改
@property (nonatomic,strong) UIButton *changeBtn;

//已完成
@property (nonatomic,strong) UIButton *evaluationBtn;

//退款
//退款状态
@property (nonatomic,strong) UIButton *refundstateBtn;


@property (nonatomic,strong) myOrderModel *omodel;
@end

@implementation myorderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.orderImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.numLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.totalLab];
        [self.contentView addSubview:self.cancelBtn];
        [self.contentView addSubview:self.payBtn];
        
        [self.contentView addSubview:self.refundBtn];
        [self.contentView addSubview:self.changeBtn];
        
        
        [self.contentView addSubview:self.evaluationBtn];
        [self.contentView addSubview:self.refundstateBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.orderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.height.mas_equalTo(90*WIDTH_SCALE);
        make.width.mas_equalTo(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_equalTo(120);
        
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_top);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.orderImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.totalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderImg.mas_bottom).with.offset(45*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.width.mas_equalTo(kScreenW/2);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payBtn.mas_top);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf.payBtn.mas_left).with.offset(-8*WIDTH_SCALE);
    }];
}

#pragma mark - getters


-(UIImageView *)orderImg
{
    if(!_orderImg)
    {
        _orderImg = [[UIImageView alloc] init];
        _orderImg.backgroundColor = [UIColor orangeColor];
    }
    return _orderImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _nameLab.font  = [UIFont systemFontOfSize:18];
        _nameLab.text = @"大床房";
        
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.numberOfLines = 2;
        _contentLab.text = @"接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）";
    }
    return _contentLab;
}


-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = [UIColor colorWithHexString:@"df0842"];
        _priceLab.font = [UIFont systemFontOfSize:15];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.text = @"90/天";
    }
    return _priceLab;
}

-(UILabel *)numLab
{
    if(!_numLab)
    {
        _numLab = [[UILabel alloc] init];
        _numLab.textColor = [UIColor colorWithHexString:@"999999"];
        _numLab.textAlignment = NSTextAlignmentRight;
        _numLab.font = [UIFont systemFontOfSize:14];
        _numLab.text = @"X2";
    }
    return _numLab;
}

-(UILabel *)totalLab
{
    if(!_totalLab)
    {
        _totalLab = [[UILabel alloc] init];
       // _totalLab.text = @"根据规定，只要是用于";
        _totalLab.font = [UIFont systemFontOfSize:14];
//        _totalLab.backgroundColor = [UIColor greenColor];
    }
    return _totalLab;
}

-(UIButton *)cancelBtn
{
    if(!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@""] forState:normal];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"df0842"].CGColor;
        _cancelBtn.layer.cornerRadius = 4;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitle:@"取消" forState:normal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [[UIButton alloc] init];
       // [_payBtn setImage:[UIImage imageNamed:@"dd-btn-fk"] forState:normal];
        _payBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dd-btn-fk"]];
        [_payBtn setTitle:@"付款" forState:normal];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_payBtn addTarget:self action:@selector(payBtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

-(UIButton *)refundBtn
{
    if(!_refundBtn)
    {
        _refundBtn = [[UIButton alloc] init];
        
    }
    return _refundBtn;
}

-(UIButton *)changeBtn
{
    if(!_changeBtn)
    {
        _changeBtn = [[UIButton alloc] init];
        
    }
    return _changeBtn;
}


-(UIButton *)evaluationBtn
{
    if(!_evaluationBtn)
    {
        _evaluationBtn = [[UIButton alloc] init];
        
    }
    return _evaluationBtn;
}

-(UIButton *)refundstateBtn
{
    if(!_refundstateBtn)
    {
        _refundstateBtn = [[UIButton alloc] init];
        
    }
    return _refundstateBtn;
}

#pragma mark -点击方法

-(void)cancelBtnclick
{
    [self.delegate myTabVClick1:self];
}

-(void)payBtnclick
{
    [self.delegate myTabVClick2:self];
}

#pragma mark - 数据源方法

-(void)setdata:(myOrderModel *)model
{
    self.omodel = model;
    [self.orderImg sd_setImageWithURL:[NSURL URLWithString:model.orderimgstr] placeholderImage:nil];
    self.nameLab.text = model.namestr;
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",model.pricestr,@"/天"];
    if (model.contentstr.length!=0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.contentstr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:8];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.contentstr length])];
        self.contentLab.attributedText = attributedString;
        [self.contentLab sizeToFit];
    }
    
    if ([model.ordertype isEqualToString:@"1"]) {
        //待付款
        
    }
    if ([model.ordertype isEqualToString:@"2"]) {
        //已付款
        
    }
    if ([model.ordertype isEqualToString:@"3"]) {
        //已发货
        
    }
    if ([model.ordertype isEqualToString:@"4"]) {
        //已完成
        
    }
    if ([model.ordertype isEqualToString:@"5"]) {
        //退款／售后
        
    }
    
    self.totalLab.text = [NSString stringWithFormat:@"%@%@",@"合计:",model.totalpricestr];
    self.numLab.text = [NSString stringWithFormat:@"%@%@",@"X",model.numstr];
    [super layoutIfNeeded];
}

@end
