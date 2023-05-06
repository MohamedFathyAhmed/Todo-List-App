
#import "UserDefault.h"
#import "TaskManager.h"
@implementation UserDefault
+(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray withUserDefault:(NSUserDefaults *)userDefault
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [userDefault setObject:data forKey:keyName];
    [userDefault synchronize];
}
+(NSMutableArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName withUserDefault:(NSUserDefaults *)userDefault
{
    
    NSData *data = [userDefault objectForKey:keyName];
    NSMutableArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    [userDefault synchronize];
    return myArray;
}
@end
