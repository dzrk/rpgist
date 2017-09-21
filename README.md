# rpgist


### 21 September

---
File Changes:

- Add PopupDueDateController

- TasksController swipe to remove task function:

      func tableView(_ taskView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
      //      let task = tasks[indexPath.row]
      //
      //      task.itemRef?.removeValue()
          }
      }
