
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property NSString *uniqueID;
@property NSString *taskName;
@property NSString * taskDescription;
@property int taskPriority;
@property NSDate *date;
@property NSDate *endDate;
@property NSURL *selectedFileURL;
    @end

NS_ASSUME_NONNULL_END
