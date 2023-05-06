
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefault : NSObject
+(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray withUserDefault:(NSUserDefaults *)userDefault;
+(NSMutableArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName withUserDefault:(NSUserDefaults *)userDefault;


@end



NS_ASSUME_NONNULL_END
