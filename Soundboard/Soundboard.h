////////////////////////////////////////////////////////////////////////////
//                                                                        //
//  This file is part of Soundboard.                                      //
//                                                                        //
//  Soundboard is free software: you can redistribute it and/or modify    //
//  it under the terms of the GNU General Public License as published by  //
//  the Free Software Foundation, either version 3 of the License, or     //
//  any later version.                                                    //
//                                                                        //
//  Soundboard is distributed in the hope that it will be useful,         //
//  but WITHOUT ANY WARRANTY; without even the implied warranty of        //
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         //
//  GNU General Public License for more details.                          //
//                                                                        //
//  You should have received a copy of the GNU General Public License     //
//  along with Soundboard.  If not, see <http://www.gnu.org/licenses/>.   //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

/**
Class that represents a soundboard.
*/
@interface Soundboard : NSObject

/**
Path to soundboard file.
*/
@property (nonatomic,strong) NSString *file;
/**
Soundboard name. 
*/
@property (nonatomic,strong) NSString *name;
/**
Soundboard version (e.g "1.0").
*/
@property (nonatomic,strong) NSString *version;
/**
Soundboard author.
*/
@property (nonatomic,strong) NSString *author;
/**
Soundboard date.
*/
@property (nonatomic,strong) NSString *date;

#pragma mark - Constructor

/**
 Initializes a new Soundboard object for the given soundboard at path <B>path</B>.
 @param path A NSString object represeting the path of the soundboard
 @returns a newly initialized Soundboard object
 */
-(id)initWithFile:(NSString*)path;

#pragma mark - Icon methods

/**
 Returns the icon data.
 @returns a NSData object.
 */
-(NSData*)iconData;

#pragma mark - Clip methods

/**
 Returns the number of clips in the sounboard.
 @returns a NSUInteger value
 */
-(NSUInteger)numberOfClips;
/**
 Returns the clip title for clip at index <B>index</B>.
 @param index A NSUInteger value representing clip index
 @returns a NSString object
 */
-(NSString*)clipTitleAtIndex:(NSUInteger)index;
/**
 Returns the clip data for clip at index <B>index</B>.
 @param index A NSUInteger value representing clip index
 @returns a NSData object
 */
-(NSData*)clipDataFromClipAtIndex:(NSUInteger)index;
/**
 Returns the clip index for clip with title <B>title</B>.
 @param title A NSString object representing clip title
 @returns a NSUInteger value
 */
-(NSUInteger)clipIndexFromTitle:(NSString*)title;

#pragma mark - Static methods

/**
 Checks wheter soundboard at path <B>path</B> is a valid one.
 @returns a BOOL value
 */
+(BOOL)isValidSoundboard:(NSString*)path;

@end
