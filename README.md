# rpgist


### 21 September
---
File Changes:

- Added PopupDueDateController
- TasksController swipe to remove task function:

      func tableView(_ taskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
      //      let task = tasks[indexPath.row]
      //
      //      task.itemRef?.removeValue()
          }
      }
      
- Modified HeroViewController
  - Look for marked modifications (//*********************************************************//)
  - Modified calcLevel function
- Added RewardsTableViewController
- Added RewardsTableViewCellController
- Added CollectionViewCellController
- Modified Model



---
### 27 September
---
File Changes:

- Modified RewardsTableViewController
- Added/Modified viewWillAppear() function in HeroViewController, FirstViewController, TasksController & TaskDetailsController
- Modified Model



---
### 4 October
---
File Changes:

- Modified AppDelegate:
  - Added code to initialize theme colour
- Modified FirstViewController:
  - Modified code related to alert colours to be able to change according to the theme
  - Added cancel option to addCategory alert
  - Added code related to changing colours according to the theme in viewWillAppear
  - Modified one of tableView functions with code related to changing colours according to the theme
- Modified PopupViewController:
  - Added IBOutlets for all objects in the view so that their colours will be able to be modified
  - Added code related to changing colours according to the theme in viewDidLoad
- Modified TasksController:
  - Modified code related to alert colours to be able to change according to the theme
  - Added cancel option to addTask alert
  - Added code related to changing colours according to the theme in viewWillAppear
  - Modified one of tableView functions with code related to changing colours according to the theme
- Modified PopupSliderController:
  - Added IBOutlets for all objects in the view so that their colours will be able to be modified
  - Added code related to changing colours according to the theme in viewDidLoad
- Modified TaskDetailsController:
  - Added IBOutlets for all objects in the view so that their colours will be able to be modified
  - Added code related to changing colours according to the theme in viewWillAppear
- Modified HeroViewController:
  - Added IBOutlets for all objects in the view so that their colours will be able to be modified
  - Added code related to changing profile pictures and changing colours according to the theme in viewWillAppear
- Modified PopupDueDateController:
  - Added IBOutlets for all objects in the view so that their colours will be able to be modified
  - Added code related to changing colours according to the theme in viewDidLoad
- Modified RewardsTableViewController:
  - Addition and modification of code related to changing themes and profile picture
- Modified Model
  - Modification and addition of colours for themes



---
### 6 October
---
File Changes:
- Added CompletedTasksViewController
- Modified some files



---
### 7 October
---
File Changes:
- Modified TasksController
- Modified HeroViewController
- Modified RewardsTableViewController
- Modified Model
- Removed "first", "second" and previous random avatars from asset
- Added new avatars and checkboxes to asset

#### Notes:
If you copy my storyboard and find some stuffs not working on it, check the outlets again cause we have some different outlet names which I can't remember, sorry for the inconvenience.


---
### Themes
---
1. #636363, #85C7F2, #FFFFFF
2. #555B6E, #64817F, #BEE3DB, #FAF9F9, #FFD6BA
3. #0B3948, #416165, #ACB0BD, #D0CDD7, #D9DBF1
4. #114B5F, #1A936F, #88D498, #C6DABF, #F3E9D2
5. #38413D, #4E222F, #A04668, #BC8DA0, #D9D0DE
6. #3C1642, #086375, #1DD3B0, #AFFC41, #B2FF9E
7. #694A38, #A61C3C, #F4AC45, #92BFB1, #DAD6D6


### Website Credits:
- http://www.freepik.com
- https://www.flaticon.com/
- http://creativecommons.org/licenses/by/3.0/
- https://icons8.com/icon/19336/Unchecked-Checkbox
- https://icons8.com/icon/11697/Tick-Box
