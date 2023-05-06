
#import "AddViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "deleg.h"
#import "TaskManager.h"
@interface AddViewController ()
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

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Manager = [TaskManager sharedMySingleton];
    NSDate* currentDate = [NSDate date];
    NSDate* newDate = [currentDate dateByAddingTimeInterval:60];
    _endPicker.date=newDate;
    
}



- (IBAction)addButton:(id)sender {
    
    if ([_TitleTextField.text isEqualToString:@""]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"check" message:@"check input title can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        Task *task = [Task new];
        task.taskName=_TitleTextField.text;
        task.taskDescription=_DescriptionTextField.text;
        task.selectedFileURL=_selectedFile;
        task.date=_datePicker.date;
        task.endDate=_endPicker.date;
        task.taskPriority= _segmentPiroty.selectedSegmentIndex;
        task.uniqueID=[[NSUUID UUID] UUIDString];
        
        [_Manager addTask:task];
        [self.navigationController popViewControllerAnimated:YES];
        
        
        //MARK: - notification
        int time = _endPicker.date.timeIntervalSinceNow;
        // Request permission to send notifications
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // Set up notification content
                UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
                content.title = [NSString localizedUserNotificationStringForKey:@"to do!" arguments:nil];
                content.body = [NSString localizedUserNotificationStringForKey:task.taskName
                            arguments:nil];
                content.sound = [UNNotificationSound defaultSound];

                // Set up notification trigger
                UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                            triggerWithTimeInterval:time repeats:NO];

                // Set up notification request
                UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"reminder"
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
