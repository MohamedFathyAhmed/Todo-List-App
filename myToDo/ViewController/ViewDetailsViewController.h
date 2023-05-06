//
//  ViewDetailsViewController.h
//  myToDo
//
//  Created by mo_fathy on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface ViewDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *fileText;
@property (weak, nonatomic) IBOutlet UITextField *TitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *DescriptionTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPiroty;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endPicker;
@property Task *viewTask;
- (void)initWithObject:(Task *)task;
@end

NS_ASSUME_NONNULL_END
