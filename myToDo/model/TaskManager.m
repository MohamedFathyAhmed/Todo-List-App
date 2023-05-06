

#import "TaskManager.h"
#import "UserDefault.h"

@implementation TaskManager

static TaskManager *_sharedMySingleton = nil;

+(TaskManager *)sharedMySingleton {
    @synchronized([TaskManager class]) {
        if (!_sharedMySingleton)
          _sharedMySingleton = [[self alloc] init];
        return _sharedMySingleton;
    }
    return nil;
}
//MARK: - init
- (instancetype)init
{
    self = [super init];
    if (self) {
         NSUserDefaults *defaults;
        defaults = [NSUserDefaults standardUserDefaults];
        _tasks = [[NSMutableArray alloc] init];
        _tasks = [UserDefault readArrayWithCustomObjFromUserDefaults:@"tasks" withUserDefault:defaults];
        
        _doneTasks = [[NSMutableArray alloc] init];
        _doneTasks = [UserDefault readArrayWithCustomObjFromUserDefaults:@"doneTasks" withUserDefault:defaults];
        
        _inProTasks = [[NSMutableArray alloc] init];
        _inProTasks = [UserDefault readArrayWithCustomObjFromUserDefaults:@"inProTasks" withUserDefault:defaults];
    }
    return self;
}




//MARK: - add
-(void) addTask:(Task *)task  {
    [_tasks addObject:task];
    [self saveAllTasks];
}

-(void)convertTaskToDoneTasks:(Task *)task{
    [self deleteTask:task.uniqueID];
    [_doneTasks addObject:task];
    [self saveAllTasks];
}

-(void)convertInTaskToDoneTasks:(Task *)task{
    [self deleteInProTasks:task.uniqueID];
    [_doneTasks addObject:task];
    [self saveAllTasks];
}

- (void)convertTaskToInProTasks:(Task *)task{
    [self deleteTask:task.uniqueID];
    [_inProTasks addObject:task];
    [self saveAllTasks];
}

//MARK: - edit


-(void)editTasks:(Task *)task{
    [self deleteTask:task.uniqueID];
    [_tasks addObject:task];
    [self saveAllTasks];
}

-(void)editInProTasks:(Task *)task{
    [self deleteInProTasks:task.uniqueID];
    [_inProTasks addObject:task];
    [self saveAllTasks];
}

-(void)editDoneTasks:(Task *)task{
    [self deleteDoneTask:task.uniqueID];
    [_doneTasks addObject:task];
    [self saveAllTasks];
}

//MARK: - delete

-(void) deleteTask:(NSString *)taskId {
    for (int i = 0; i < [_tasks count]; i++) {
        Task *task = [_tasks objectAtIndex:i];
        if (task.uniqueID == taskId) {
            [_tasks removeObjectAtIndex:i];
            break;
        }
    }
    [self saveAllTasks];
}

- (void)deleteDoneTask:(NSString *)taskId{
    for (int i = 0; i < [_doneTasks count]; i++) {
        Task *task = [_doneTasks objectAtIndex:i];
        if (task.uniqueID == taskId) {
            [_doneTasks removeObjectAtIndex:i];
            break;
        }
    }
    [self saveAllTasks];
}

- (void)deleteInProTasks:(NSString *)taskId{
    for (int i = 0; i < [_inProTasks count]; i++) {
        Task *task = [_inProTasks objectAtIndex:i];
        if (task.uniqueID == taskId) {
            [_inProTasks removeObjectAtIndex:i];
            break;
        }
    }
    [self saveAllTasks];
}

//MARK: - get
-(NSMutableArray*) getAllTask {
    return _tasks;
}

- (NSMutableArray *)getAllDoneTasks{
    return _doneTasks;
}

- (NSMutableArray *)getAllInProTasks{
    return _inProTasks;
}

//MARK: - save
-(void) saveAllTasks  {
    NSUserDefaults *defaults;
   defaults = [NSUserDefaults standardUserDefaults];
    [UserDefault writeArrayWithCustomObjToUserDefaults:@"tasks" withArray:_tasks withUserDefault:defaults];
    [UserDefault writeArrayWithCustomObjToUserDefaults:@"doneTasks" withArray:_doneTasks withUserDefault:defaults];
    [UserDefault writeArrayWithCustomObjToUserDefaults:@"inProTasks" withArray:_inProTasks withUserDefault:defaults];
}

@end
