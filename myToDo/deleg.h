
#import "Task.h"
@protocol deleg
-(void) convertToinProgress :(Task*)task;
-(void) convertToinDone :(Task*)task;
@end
