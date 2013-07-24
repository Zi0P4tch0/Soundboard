//This file is part of Soundboard.
//
//Soundboard is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.

//Soundboard is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.

//You should have received a copy of the GNU General Public License
//along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>.

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

-(id)initWithFile:(NSString*)path;

#pragma mark - Icon methods

-(NSData*)iconData;

#pragma mark - Clip methods

-(NSUInteger)numberOfClips;
-(NSString*)clipTitleAtIndex:(NSUInteger)index;
-(NSData*)clipDataFromClipAtIndex:(NSUInteger)index;
-(NSUInteger)clipIndexFromTitle:(NSString*)title;

#pragma mark - Static methods

+(BOOL)isValidSoundboard:(NSString*)path;

@end
