
#import "TableViewCell.h"
#import "Task.h"
#import "TaskManager.h"
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
   
}

- (IBAction)inProClick:(id)sender {
    
    [_deleg convertToinProgress:_task];
}
- (IBAction)doneClick:(id)sender {
    
    [_deleg convertToinDone:_task];
    
}
@end
