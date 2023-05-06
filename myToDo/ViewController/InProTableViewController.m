//
//  InProTableViewController.m
//  myToDo
//
//  Created by mo_fathy on 08/04/2023.
//

#import "InProTableViewController.h"
#import "Task.h"
#import "TaskManager.h"
#import "TableViewCell.h"
#import "AddViewController.h"
#import "ViewDetailsViewController.h"
#import "EditViewController.h"
@interface InProTableViewController ()
@property NSMutableArray *tasks;
@property NSMutableArray *lowTasks;
@property NSMutableArray *midTasks;
@property NSMutableArray *higTasks;
@property Boolean *flag;
@property TaskManager *Manager;

@end

@implementation InProTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell"bundle:nil]forCellReuseIdentifier:@"TableViewCell"];
    _Manager = [TaskManager sharedMySingleton];
    _tasks = [_Manager getAllInProTasks];
    
}


- (void)viewWillAppear:(BOOL)animated{
    _tasks = [_Manager getAllInProTasks];
    [self filter];
    [self.tableView reloadData];
}

-(void)filter{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.taskPriority == %@", @0];
    _lowTasks = [_tasks filteredArrayUsingPredicate:predicate];
    NSPredicate *mpredicate = [NSPredicate predicateWithFormat:@"SELF.taskPriority == %@", @1];
    _midTasks = [_tasks filteredArrayUsingPredicate:mpredicate];
    NSPredicate *hpredicate = [NSPredicate predicateWithFormat:@"SELF.taskPriority == %@", @2];
    _higTasks = [_tasks filteredArrayUsingPredicate:hpredicate];
}

//MARK: - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_flag){
        return 1;
    }else{
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_flag){
        return [_tasks count];
    }else{
            switch (section) {
                case 0:
                    return [_lowTasks count];
                    break;
                case 1:
                    return [_midTasks count];
                    break;
                case 2:
                    return [_higTasks count];
                    break;
                default:
                    return 0;
                    break;
            }
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_flag){
        return @"tasks";
    }else{
        switch (section) {
            case 0:
                return @"low";
                break;
            case 1:
                return @"mid";
                break;
            default:
                return @"high";
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    Task *task ;
    if(_flag){
        task = [_tasks objectAtIndex:indexPath.row];
    }else{
        switch (indexPath.section) {
            case 0:
                task = [_lowTasks objectAtIndex:indexPath.row];
                break;
            case 1:
                task = [_midTasks objectAtIndex:indexPath.row];
                break;
            default:
                task = [_higTasks objectAtIndex:indexPath.row];
                break;
        }
    }
    
    cell.title.text =task.taskName;
    cell.task=task;
    cell.layer.cornerRadius = 30;
    cell.deleg=self;
    cell.inProOutlet.hidden = YES;
    
    if(task.taskPriority == 0){
        cell.image.image = [UIImage systemImageNamed:@"arrow.down.circle"];
        cell.image.tintColor = UIColor.yellowColor;
    }else if(task.taskPriority == 1){
            cell.image.image = [UIImage systemImageNamed:@"minus.circle"];
            cell.image.tintColor = UIColor.greenColor;
    }else if(task.taskPriority == 2){
                cell.image.image = [UIImage systemImageNamed:@"arrow.up.circle"];
                cell.image.tintColor = UIColor.redColor;
            }

    return cell;
}


//MARK: -swipe button
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        // Delete the row from the data source
        Task *task;
        if(self->_flag){
            task = [self->_tasks objectAtIndex:indexPath.row];
        }else{
            switch (indexPath.section) {
                case 0:
                    task = [self->_lowTasks objectAtIndex:indexPath.row];
                    break;
                case 1:
                    task = [self->_midTasks objectAtIndex:indexPath.row];
                    break;
                default:
                    task = [self->_higTasks objectAtIndex:indexPath.row];
                    break;
            }
        }
               [self->_Manager deleteInProTasks:task.uniqueID];
               self->_tasks = [self->_Manager getAllInProTasks];
               [self.tableView reloadData];
       // [self deleteRow:indexPath];
        completionHandler(YES);
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    
    UIContextualAction *EditAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Edit"
handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
    // Delete the row from the data source
        Task *task;
        if(self->_flag){
            task = [self->_tasks objectAtIndex:indexPath.row];
        }else{
            switch (indexPath.section) {
                case 0:
                    task = [self->_lowTasks objectAtIndex:indexPath.row];
                    break;
                case 1:
                    task = [self->_midTasks objectAtIndex:indexPath.row];
                    break;
                default:
                    task = [self->_higTasks objectAtIndex:indexPath.row];
                    break;
            }
        }
        EditViewController * vc = [self.storyboard
         instantiateViewControllerWithIdentifier:@"EditViewController"];
        vc.task = task;
        vc.from=1;
        [self.navigationController pushViewController:vc animated:YES];
        
           self->_tasks = [self->_Manager getAllInProTasks];
           [self.tableView reloadData];
   // [self deleteRow:indexPath];
    completionHandler(YES);
}];
    EditAction.backgroundColor = [UIColor blueColor];
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,EditAction]];
    return swipeActionConfig;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Task *task;
    if(self->_flag){
        task = [self->_tasks objectAtIndex:indexPath.row];
    }else{
        switch (indexPath.section) {
            case 0:
                task = [self->_lowTasks objectAtIndex:indexPath.row];
                break;
            case 1:
                task = [self->_midTasks objectAtIndex:indexPath.row];
                break;
            default:
                task = [self->_higTasks objectAtIndex:indexPath.row];
                break;
        }
    }
    ViewDetailsViewController  *vc = [self.storyboard
     instantiateViewControllerWithIdentifier:@"ViewDetailsViewController"];
    [vc initWithObject:task];
    [self.navigationController pushViewController:vc animated:YES];

}



- (IBAction)addClick:(id)sender {
    _flag=!_flag;
    [self.tableView reloadData];
}






- (void)convertToinDone:(Task *)task {
    [_Manager convertInTaskToDoneTasks:task];
    _tasks = [_Manager getAllInProTasks];
    [self.tableView reloadData];
}




@end
