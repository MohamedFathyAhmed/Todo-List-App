
#import <Foundation/Foundation.h>
#import "Task.h"


@interface TaskManager : NSObject

+(TaskManager *)sharedMySingleton;

@property NSMutableArray *tasks;
@property NSMutableArray *doneTasks;
@property NSMutableArray *inProTasks;


-(void) addTask :(Task*) task;
-(void) convertTaskToInProTasks :(Task*) task;
-(void) convertTaskToDoneTasks :(Task*) task;
-(void)convertInTaskToDoneTasks:(Task *)task;


-(void) deleteTask : (NSString *) taskId;
-(void) deleteDoneTask : (NSString *) taskId;
-(void) deleteInProTasks: (NSString *) taskId;

-(NSMutableArray*) getAllTask;
-(NSMutableArray*) getAllDoneTasks;
-(NSMutableArray*) getAllInProTasks;

-(void)editTasks:(Task *)task;
-(void)editInProTasks:(Task *)task;
-(void)editDoneTasks:(Task *)task;
//-(void) saveAllTasks;
@end

