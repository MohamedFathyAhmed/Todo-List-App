//
//  EditViewController.m
//  myToDo
//
//  Created by mo_fathy on 08/04/2023.
//
#import <UserNotifications/UserNotifications.h>
#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fileText;
@property (weak, nonatomic) IBOutlet UITextField *TitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *DescriptionTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPiroty;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endPicker;
@property NSURL *selectedFile ;
- (IBAction)addButton:(id)sender;
@property TaskManager *Manager;
- (IBAction)addFileClick:(id)sender;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Manager = [TaskManager sharedMySingleton];
   

    _TitleTextField.text=_task.taskName;
    _DescriptionTextField.text=_task.taskDescription;
   _selectedFile= _task.selectedFileURL;
   [_datePicker setDate: _task.date];
    _endPicker.date = _task.endDate;
    _segmentPiroty.selectedSegmentIndex= _task.taskPriority ;
    
}



- (IBAction)addButton:(id)sender {
    NSDate* currentDate = [NSDate date];
    if ( currentDate ==_endPicker.date){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"check" message:@"check alert time can't be now" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    
    if ([_TitleTextField.text isEqualToString:@""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"check" message:@"check input title can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        _task.taskName=_TitleTextField.text;
        _task.taskDescription=_DescriptionTextField.text;
        _task.selectedFileURL=_selectedFile;
        _task.date=_datePicker.date;
       _task.endDate=_endPicker.date;
        _task.taskPriority= _segmentPiroty.selectedSegmentIndex;
        
        if(_from == 0){
            [_Manager editTasks:_task];
        }else if(_from == 1){
            [_Manager editInProTasks:_task];
        }else{
            [_Manager editDoneTasks:_task];
    }
        [self.navigationController popViewControllerAnimated:YES];
        
        
        //MARK: - notification
        int time = _endPicker.date.timeIntervalSinceNow;
        // Request permission to send notifications
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // Set up notification content
                UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
                content.title = [NSString localizedUserNotificationStringForKey:@"to do!" arguments:nil];
                content.body = [NSString localizedUserNotificationStringForKey:_task.taskName
                            arguments:nil];
                content.sound = [UNNotificationSound defaultSound];

                // Set up notification trigger
                UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                            triggerWithTimeInterval:time repeats:NO];

                // Set up notification request
                UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:_task.uniqueID
                            content:content trigger:trigger];

                // Set up notification center delegate
                [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];

                // Schedule the notification
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    if (error != nil) {
                        NSLog(@"Error scheduling notification: %@", error);
                    }
                }];
            } else {
                NSLog(@"Permission denied for notifications");
            }
        }];
        
    }
    
}

- (IBAction)addFileClick:(id)sender {
    

    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.content"] inMode: UIDocumentPickerModeImport];
        documentPicker.delegate = self;
        [self presentViewController:documentPicker animated:true completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    _selectedFile = urls.firstObject;
    NSLog(@"%@", _selectedFile);
    NSString *fileName = [_selectedFile lastPathComponent];
       NSLog(@"%@", fileName);
    _fileText.text=fileName;
}








@end
