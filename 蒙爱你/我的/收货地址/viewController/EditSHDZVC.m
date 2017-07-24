//
//  EditSHDZVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/18.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "EditSHDZVC.h"
#import <UITableView+FDTemplateLayoutCell.h>


@interface EditSHDZVC ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *tele;

@property (weak, nonatomic) IBOutlet UITextView *address;

@end

@implementation EditSHDZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = @"";
    self.tele.text = @"";
    self.address.text = @"sadijfsladkj flksa;dgdf gjo eri ljdk fds mlc sdlkfjsdklfj sdlkfjdkslfj slkdfjsdk sdlkjfsdlk sfj fdsfds sdf ";
    
    self.title = @"编辑收货地址";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [XDFactory addBackItemForVC:self];
}


- (IBAction)deleteBtnClicked:(id)sender {
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 10 : 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSString *str = @"sadijfsladkj flksa;dgdf gjo eri ljdk fds mlc sdlkfjsdklfj sdlkfjdkslfj slkdfjsdk sdlkjfsdlk sfj fdsfds sdf ";
        CGSize size = [str sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(self.address.size.width, 300) mode:NSLineBreakByCharWrapping];
        return size.height;
        
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        // 点击保存按钮
        
        
        
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    /*
    CGRect boudns = textView.bounds;
    CGSize maxSize = CGSizeMake(boudns.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    size = newSize;
    maxSize = CGSizeMake(boudns.size.width, newSize.height);
    boudns.size = maxSize;
    textView.bounds = boudns;
     */
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}








@end
