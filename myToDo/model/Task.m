

#import "Task.h"

@implementation Task

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_taskName forKey:@"name"];
    [coder encodeInt:_taskPriority forKey:@"taskPriority"];
    [coder encodeObject:_taskDescription forKey:@"taskDescription"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeObject:_selectedFileURL forKey:@"selectedFileURL"];
    [coder encodeObject:_uniqueID forKey:@"uniqueID"];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _taskName =[coder decodeObjectForKey:@"name"];
       _taskPriority =[coder decodeIntForKey:@"taskPriority"] ;
        _taskDescription =[coder decodeObjectForKey:@"taskDescription"];
        _date=[coder decodeObjectForKey:@"date"];
        _selectedFileURL=[coder decodeObjectForKey:@"selectedFileURL"];
        _uniqueID=[coder decodeObjectForKey:@"uniqueID"];
    }
    return self;
}
@end
