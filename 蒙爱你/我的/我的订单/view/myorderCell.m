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

//已发货
@property (nonatomic,strong) UIButton *logisticsBtn;

//已完成
@property (nonatomic,strong) UIButton *evaluationBtn;

//退款
//退款状态
@property (nonatomic,strong) UIButton *refundstateBtn;

//退款原因
@property (nonatomic,strong) UILabel *refundlab;

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
        
        [self.contentView addSubview:self.logisticsBtn];
        
        [self.contentView addSubview:self.evaluationBtn];
        [self.contentView addSubview:self.refundstateBtn];
        
        [self.contentView addSubview:self.refundlab];
        
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
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    
    [self.refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payBtn.mas_top);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf.payBtn.mas_left).with.offset(-8*WIDTH_SCALE);
    }];
    
    [self.logisticsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    
    [self.evaluationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    [self.refundstateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.numLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    
    [self.refundlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totalLab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.totalLab.mas_left);
        make.width.mas_equalTo(kScreenW-28*WIDTH_SCALE);
        
    }];
}

#pragma mark - getters

-(UIImageView *)orderImg
{
    if(!_orderImg)
    {
        _orderImg = [[UIImageView alloc] init];
        //_orderImg.backgroundColor = [UIColor orangeColor];
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
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"df0842"].CGColor;
        _cancelBtn.layer.cornerRadius = 4;
        _cancelBtn.layer.borderWidth = 1;
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn setTitle:@"取消" forState:normal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setHidden:YES];
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
        [_payBtn setHidden:YES];
    }
    return _payBtn;
}

-(UIButton *)refundBtn
{
    if(!_refundBtn)
    {
        _refundBtn = [[UIButton alloc] init];
        _refundBtn.layer.masksToBounds = YES;
        _refundBtn.layer.borderColor = [UIColor colorWithHexString:@"df0842"].CGColor;
        _refundBtn.layer.cornerRadius = 4;
        _refundBtn.layer.borderWidth = 1;
        [_refundBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _refundBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_refundBtn setTitle:@"退款" forState:normal];
        [_refundBtn setHidden:YES];
        [_refundBtn addTarget:self action:@selector(refundClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundBtn;
}

-(UIButton *)changeBtn
{
    if(!_changeBtn)
    {
        _changeBtn = [[UIButton alloc] init];
        _changeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dd-btn-fk"]];
        [_changeBtn setTitle:@"修改" forState:normal];
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_changeBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_changeBtn setHidden:YES];
        [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}


-(UIButton *)logisticsBtn
{
    if(!_logisticsBtn)
    {
        _logisticsBtn = [[UIButton alloc] init];
        _logisticsBtn.layer.masksToBounds = YES;
        _logisticsBtn.layer.borderColor = [UIColor colorWithHexString:@"df0842"].CGColor;
        _logisticsBtn.layer.cornerRadius = 4;
        _logisticsBtn.layer.borderWidth = 1;
        [_logisticsBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _logisticsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_logisticsBtn setTitle:@"物流" forState:normal];
        [_logisticsBtn setHidden:YES];
        [_logisticsBtn addTarget:self action:@selector(logisticsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logisticsBtn;
}


-(UIButton *)evaluationBtn
{
    if(!_evaluationBtn)
    {
        _evaluationBtn = [[UIButton alloc] init];
        _evaluationBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dd-btn-fk"]];
        [_evaluationBtn setTitle:@"评价" forState:normal];
        _evaluationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_evaluationBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_evaluationBtn setHidden:YES];
        [_evaluationBtn addTarget:self action:@selector(evaluationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluationBtn;
}

-(UIButton *)refundstateBtn
{
    if(!_refundstateBtn)
    {
        _refundstateBtn = [[UIButton alloc] init];
        [_refundstateBtn setHidden:YES];
        _refundstateBtn.layer.masksToBounds = YES;
        _refundstateBtn.layer.borderWidth = 1;
        _refundstateBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_refundstateBtn setTitle:@"已退款" forState:normal];
        [_refundstateBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:normal];
        _refundstateBtn.layer.borderColor = [UIColor colorWithHexString:@"b3b3b3"].CGColor;
        [_refundstateBtn addTarget:self action:@selector(refundstateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refundstateBtn;
}

-(UILabel *)refundlab
{
    if(!_refundlab)
    {
        _refundlab = [[UILabel alloc] init];
        _refundlab.textColor = [UIColor colorWithHexString:@"333333"];
        _refundlab.font = [UIFont systemFontOfSize:13];
        _refundlab.text = @"退款原因:";
        [_refundlab setHidden:YES];
    }
    return _refundlab;
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

-(void)refundClick
{
    //退款
    [self.delegate myTabVClick3:self];
}

-(void)changeBtnClick
{
    //修改
    [self.delegate myTabVClick4:self];
}

-(void)logisticsBtnClick
{
    //物流
    [self.delegate myTabVClick5:self];
}

-(void)evaluationBtnClick
{
    //评价
    [self.delegate myTabVClick6:self];
}

-(void)refundstateBtnClick
{
    //退款
    [self.delegate myTabVClick7:self];
}

#pragma mark - 数据源方法

-(void)setdata:(myOrderModel *)model
{
    self.omodel = model;
    [self.orderImg sd_setImageWithURL:[NSURL URLWithString:model.orderimgstr] placeholderImage:[UIImage imageNamed:@"111501227576_.pic_hd"]];
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
        [self.cancelBtn setHidden:NO];
        [self.payBtn setHidden:NO];
        
    }
    if ([model.ordertype isEqualToString:@"2"]) {
        //已付款
        [self.refundBtn setHidden:NO];
        [self.changeBtn setHidden:NO];
        
    }
    if ([model.ordertype isEqualToString:@"3"]) {
        //已发货
        [self.logisticsBtn setHidden:NO];
        
    }
    if ([model.ordertype isEqualToString:@"4"]) {
        //已完成
        [self.evaluationBtn setHidden:NO];
    }
    if ([model.ordertype isEqualToString:@"5"]) {
        //退款／售后  审批中
        [self.refundstateBtn setHidden:NO];
        [self.refundstateBtn setTitle:@"审批中" forState:normal];
    }
    if ([model.ordertype isEqualToString:@"6"]) {
        //未退款
        [self.refundstateBtn setHidden:NO];
        [self.refundstateBtn setTitle:@"未退款" forState:normal];
        [self.refundlab setHidden:NO];
        self.refundlab.text = [NSString stringWithFormat:@"%@%@",@"退款原因:",model.refundstr];
    }
    if ([model.ordertype isEqualToString:@"7"]) {
        //已退款
        [self.refundstateBtn setHidden:NO];
        [self.refundstateBtn setTitle:@"已退款" forState:normal];
    }
    NSString *str1 = @"合计：";
    NSString *str2 = model.totalpricestr;
    NSString *str3 = [NSString stringWithFormat:@"%@%@%@",@" (已优惠¥",model.discountprice,@")"];
    NSString *newstr = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newstr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,str1.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"df0842"] range:NSMakeRange(str1.length,str2.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"b3b3b3"] range:NSMakeRange(str1.length+str2.length,str3.length)];
    self.totalLab.attributedText = str;
    self.numLab.text = [NSString stringWithFormat:@"%@%@",@"X",model.numstr];
    [super layoutIfNeeded];
}

@end
