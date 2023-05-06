//
//  ViewDetailsViewController.m
//  myToDo
//
//  Created by mo_fathy on 08/04/2023.
//

#import "ViewDetailsViewController.h"
#import "Task.h"
@interface ViewDetailsViewController ()

@end

@implementation ViewDetailsViewController


- (void)initWithObject:(Task *)task {
        _viewTask=task;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_segmentPiroty setSelectedSegmentIndex:_viewTask.taskPriority];
    _TitleTextField.text=_viewTask.taskName;
    _DescriptionTextField.text=_viewTask.taskDescription;
    [_datePicker setDate:_viewTask.date];
    [_endPicker setDate:_viewTask.endDate];
    NSString *fileName = [_viewTask.selectedFileURL lastPathComponent];
    _fileText.text=fileName;
   
}



@end
