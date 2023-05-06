
#import <UIKit/UIKit.h>
#import "deleg.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate>
@property id<deleg> delegVC;
@end

NS_ASSUME_NONNULL_END
