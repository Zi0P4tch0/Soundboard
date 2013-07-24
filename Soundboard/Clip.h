//
//  Clip.h
//  Soundboard
//
//  Created by Matteo Pacini on 18/07/13.
//  Copyright (c) 2013 Matteo Pacini. All rights reserved.
//

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
Size of clip (in bytes).s
*/
@property (nonatomic,assign) NSUInteger size;
/**
Clip offset from the beginning of the soundboard. 
*/
@property (nonatomic,assign) NSUInteger seekStart;

@end
