//
//  EditViewController.h
//  myToDo
//
//  Created by mo_fathy on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "TaskManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate>
@property Task *task;
@property int from;
@end

NS_ASSUME_NONNULL_END
