//
//  Soundboard.h
//  Soundboard
//
//  Created by Matteo Pacini on 18/07/13.
//  Copyright (c) 2013 Matteo Pacini. All rights reserved.
//

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
