#import "FLXSVersion.h"
/**
	 * When enableSelectionExclusion=true, the grid.selectionInfo points to an object of this class
	 *
	 * This class contains a boolean variable, isSelectAll, that indicates whether or not the user has the select
	 * all header checkbox selected.
	 * It also contains an array of LevelSelectionInfo objects, that contain an excludedObjects array and a selectedObjects
	 * array for each hierarchical level in this grid.
	 *
	 * When the isSelectAll flag is true, to identify the list of records that have been selected, you have to consider the entire
	 * data provider as selected, except the ones explicitly marked in each of the level selection info object's excludedObjects
	 * collection.
	 *
	 * When the isSelectAll flat is false, to identify the list of records that have been selected, you have to cnosider each
	 * of the level selection info objects, and in those objects, look at the selectedObjects collection. This will give you
	 * the selected objects at each hierarchical level in the grid.
	 *
	 * The following snippet of code tells you how to iterate through the level selection info objects in this selection info object.
	 * <code>
	 * <pre>
	 * var selection:SelectionInfo= grid.selectionInfo;
	 * if(selection.isSelectAll){
	 * 		var userSelectedAllButThese:Array=[];
	 * 		for each(var level:LevelSelectionInfo in levelSelections){
	 * 			userSelectedAllButThese = userSelectedAllButThese.concat(level.excludedObjects);
	 * 		}
	 * }else{
	 * 		var userExplicitySelected:Array=[];
	 * 		for each(var level:LevelSelectionInfo in levelSelections){
	 * 			userExplicitySelected = userExplicitySelected.concat(level.selectedObjects);
	 * 		}
	 * }
	 * </pre>
	 * </code>
	 *
	 */
@interface FLXSSelectionInfo : NSObject
{
}
/**
* Array of LevelSelectionInfo
*/
@property (nonatomic, strong) NSMutableArray* levelSelections;
/**
		 * The top level selection.
		 */
@property (nonatomic, assign) BOOL isSelectAll;

 -(BOOL)hasAnySelections;

@end

