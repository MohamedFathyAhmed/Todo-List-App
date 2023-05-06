

#import <UIKit/UIKit.h>
#import "deleg.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property id<deleg> deleg;
@property Task *task;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
- (IBAction)inProClick:(id)sender;
- (IBAction)doneClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *inProOutlet;
@property (weak, nonatomic) IBOutlet UIButton *doneOutlet;



@end

NS_ASSUME_NONNULL_END
