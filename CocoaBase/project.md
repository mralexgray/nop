CocoaBase Project
---

- le but est de mettre en oeuvre la plupart des composants COCOA afin de les maitriser.


---
---




 - Actions
 - TableView
 	- double click
 		- on file => open file
 		- on directory => enter directory
 - Buttons
 	- parent => goto parent of current list
 		- savoir quelle table view est la dernerie selectionnée (laquelle est DST ?)
 
- splitter JsDirectoryTableViewDelegate
	- une instance de TableViewDelegate comune pour "left" et "right"
	- deux instances de TableViewDataSource une pour "left" et l'autre pour "right"

 
- getCurrentSourceDirectory
 	- créer une structure qui englobe les deux TableViewDataSource
- getDirectorySelectionIterator
- GetDirectoryCurrentSelection

- obtenir l'effet de la touche CTRL de maniere permanente (multi-selection)
 
- créer une progress view qui prend la place des boutons pendant les actions

- créer une classe ActionDispatcher ? (qui recoit les notifications des boutons)

- add fullscreen mode
- subclass toolbar
- subclass nstableview (custom draw)
- subclass button (EPS/PDF/WebKit draw)



 - NSTableViewDelegate Protocol Reference
 	- Providing Views for Rows and Columns
 		- tableView:viewForTableColumn:row:
 		- tableView:rowViewForRow:
 - Notification of Row Views Being Added or Removed.
 		- tableView:didAddRowView:forRow:
 		- tableView:didRemoveRowView:forRow:
 - Grouping Rows
 		- tableView:isGroupRow:
 - Providing Cells for Rows and Columns
 		- tableView:willDisplayCell:forTableColumn:row:
 		- tableView:dataCellForTableColumn:row:
 		- tableView:shouldShowCellExpansionForTableColumn:row:
 		- tableView:toolTipForCell:rect:tableColumn:row:mouseLocation:
 - Editing Cells
 		- tableView:shouldEditTableColumn:row:
 - Setting Row and Column Size
 		- tableView:heightOfRow:
 		- tableView:sizeToFitWidthOfColumn:
 - Selecting Rows
 		- selectionShouldChangeInTableView:
 		- tableView:shouldSelectRow:
 		- tableView:selectionIndexesForProposedSelection:
 		- tableView:shouldSelectTableColumn:
 		- tableViewSelectionIsChanging:
 		- tableViewSelectionDidChange:
 		- tableView:shouldTypeSelectForEvent:withCurrentSearchString:
 		- tableView:typeSelectStringForTableColumn:row:
 		- tableView:nextTypeSelectMatchFromRow:toRow:forString:
 - Moving and Resizing Columns
 		- tableView:shouldReorderColumn:toColumn:
 		- tableView:didDragTableColumn:
 		- tableViewColumnDidMove:
 		- tableViewColumnDidResize:
 - Responding to Mouse Events
 	- tableView:didClickTableColumn:
 	- tableView:mouseDownInHeaderOfTableColumn:
 	- tableView:shouldTrackCell:forTableColumn:row:
 





NSTableViewDataSource Protocol Reference
========================================
 
 - Getting Values
   - numberOfRowsInTableView:
   - tableView:objectValueForTableColumn:row:
 - Setting Values
 - tableView:setObjectValue:forTableColumn:row:
 Implementing Pasteboard Support
 - tableView:pasteboardWriterForRow:
 Drag and Drop
 - tableView:acceptDrop:row:dropOperation:
 - tableView:namesOfPromisedFilesDroppedAtDestination:forDraggedRowsWithIndexes:
 - tableView:validateDrop:proposedRow:proposedDropOperation:
 - tableView:writeRowsWithIndexes:toPasteboard:
 - tableView:draggingSession:willBeginAtPoint:forRowIndexes:
 - tableView:updateDraggingItemsForDrag:
 - tableView:draggingSession:endedAtPoint:operation:
 - Sorting
 	- tableView:sortDescriptorsDidChange:

 



// poster un message
// [[NSNotificationCenter defaultCenter] postNotificationName:@"LE_NOM_DE_MON_EVENT" object:UnObjetOuNil];

// implémenter une methode pour l'ecouteur
// - (void) onEventXX:(NSNotification *)notification
// {
// 	id unObjetOuNil = notification.object;
// }

// declarer un ecouteur avec une methode associé
// [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEventXX:) name:@"LE_NOM_DE_MON_EVENT" object:nil];

// supprimer la methode de la liste des ecouteurs
//[[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"LE_NOM_DE_MON_EVENT"];


 + blackColor
 + blueColor
 + brownColor
 + clearColor
 + cyanColor
 + darkGrayColor
 + grayColor
 + greenColor
 + lightGrayColor
 + magentaColor
 + orangeColor
 + purpleColor
 + redColor
 + whiteColor
 + yellowColor
 
(NSColor *)colorWithPatternImage:(NSImage *)image 
 
 self.customBackgroundColour = [NSColor colorWithPatternImage:[NSImage imageNamed:@"light-linen-texture.png"]];
 
 

