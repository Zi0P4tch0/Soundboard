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
//along with Soundboard.  If not, see <http://www.gnu.org/licenses/>.

#import <Foundation/Foundation.h>

/**

Class that represent an audio clip.
 
*/
@interface Clip : NSObject

/**
Clip title. 
*/
@property (nonatomic,strong) NSString* title;
/**
Size of clip (in bytes).
*/
@property (nonatomic,assign) NSUInteger size;
/**
Clip offset from the beginning of the soundboard. 
*/
@property (nonatomic,assign) NSUInteger seekStart;

@end
