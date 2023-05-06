
#import "TableViewController.h"
#import "Task.h"
#import "TaskManager.h"
#import "TableViewCell.h"
#import "AddViewController.h"
#import "ViewDetailsViewController.h"
#import "EditViewController.h"
@interface TableViewController ()
@property NSMutableArray *tasks;
@property TaskManager *Manager;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell"bundle:nil]forCellReuseIdentifier:@"TableViewCell"];
    _Manager = [TaskManager sharedMySingleton];
    _tasks = [_Manager getAllTask];
   
}


- (void)viewWillAppear:(BOOL)animated{
    _tasks = [_Manager getAllTask];
    [self.tableView reloadData];
}

//MARK: - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_tasks count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    Task *task ;
    
    task = [_tasks objectAtIndex:indexPath.row];
    cell.title.text =task.taskName;
    cell.task=task;
    cell.layer.cornerRadius = 30;
    cell.deleg=self;
    
    
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
        Task *task = [self->_tasks objectAtIndex:indexPath.row];
               [self->_Manager deleteTask:task.uniqueID];
               self->_tasks = [self->_Manager getAllTask];
               [self.tableView reloadData];
       // [self deleteRow:indexPath];
        completionHandler(YES);
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    
    UIContextualAction *EditAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Edit"
handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
    // Delete the row from the data source
    Task *task = [self->_tasks objectAtIndex:indexPath.row];
          
        EditViewController * vc = [self.storyboard
         instantiateViewControllerWithIdentifier:@"EditViewController"];
        vc.task = task;
        vc.from=0;
        [self.navigationController pushViewController:vc animated:YES];
        
           self->_tasks = [self->_Manager getAllTask];
           [self.tableView reloadData];
   // [self deleteRow:indexPath];
    completionHandler(YES);
}];
    EditAction.backgroundColor = [UIColor blueColor];
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,EditAction]];
    return swipeActionConfig;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Task *task = [_tasks objectAtIndex:indexPath.row];
    ViewDetailsViewController  *vc = [self.storyboard
     instantiateViewControllerWithIdentifier:@"ViewDetailsViewController"];
    [vc initWithObject:task];
    [self.navigationController pushViewController:vc animated:YES];

}



- (IBAction)addClick:(id)sender {
    AddViewController  *vc = [self.storyboard
     instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}



//MARK: - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0){
        _tasks = [_Manager getAllTask];
    }else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.taskName CONTAINS[c] %@", searchText];
       
        _tasks = [_tasks filteredArrayUsingPredicate:predicate];
        }
 
    
    [self.tableView reloadData];
}



- (void)convertToinDone:(Task *)task {
    [_Manager convertTaskToDoneTasks:task];
    _tasks = [_Manager getAllTask];
    [self.tableView reloadData];
}

- (void)convertToinProgress:(Task *)task {
    [_Manager convertTaskToInProTasks:task];
    _tasks = [_Manager getAllTask];
    [self.tableView reloadData];
}


@end
