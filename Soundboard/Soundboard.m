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

#import "Soundboard.h"

#import "Clip.h"
#import "Icon.h"

@implementation Soundboard {
    
    @private
    Icon *_icon;
    NSMutableArray *_clips;
}

@synthesize file;
@synthesize name;
@synthesize version;
@synthesize author;

#pragma mark - Clip methods

-(NSUInteger)clipIndexFromTitle:(NSString*)title
{
    for(NSUInteger i = 0; i<[_clips count];i++)
    {
        if ([[[_clips objectAtIndex:i] title] isEqualToString:title])
        {
            return i;
        }
    }
    return 0;
}

-(NSData*)clipDataFromClipAtIndex:(NSUInteger)index
{
    Clip *currentClip = [_clips objectAtIndex:index];
    
    char *buffer = (char*)malloc(sizeof(char)*currentClip.size);
    
    FILE *soundboard = fopen([self.file cStringUsingEncoding:NSASCIIStringEncoding],"rb");
    
    fseek(soundboard,currentClip.seekStart,SEEK_SET);
    fread((void*)buffer,currentClip.size,1,soundboard);
    fclose(soundboard);
    
    NSData *clipData = [NSData dataWithBytes:buffer length:currentClip.size];
    
    free(buffer);
    
    return clipData;
}

-(NSString *)clipTitleAtIndex:(NSUInteger)index
{
    return [[_clips objectAtIndex:index] title];
}

-(NSUInteger)numberOfClips
{
    return [_clips count];
}

#pragma mark - Icon methods

-(NSData*)iconData
{
    char *buffer = (char*)malloc(sizeof(char)*_icon.size);
    
    FILE *soundboard = fopen([self.file cStringUsingEncoding:NSASCIIStringEncoding],"rb");
    
    fseek(soundboard,_icon.seekStart,SEEK_SET);
    fread((void*)buffer,_icon.size,1,soundboard);
    fclose(soundboard);
    
    NSData *iconData = [NSData dataWithBytes:buffer length:_icon.size];
    
    free(buffer);
    
    return iconData;
}

#pragma mark - Constructor

-(id)initWithFile:(NSString*)path
{
    if (!path || [path isEqualToString:@""])
    {
        return nil;
    }
    
    self = [super init];

    if (self)
    {
        char buffer[4096];
        NSUInteger var = 0, var2 = 0;
        
        FILE *soundboard = fopen([path cStringUsingEncoding:NSASCIIStringEncoding],"rb");
        
        self.file = path;
        
        //Name length
        fread((void*)&var,4,1,soundboard);
        //Name
        fread((void*)buffer,var,1,soundboard);
        
        //Name
        self.name = [[NSString alloc]
                     initWithBytes:buffer
                     length:var
                     encoding:NSUTF8StringEncoding];
        
        //Version length
        fread((void*)&var,4,1,soundboard);
        //Version
        fread((void*)buffer,var,1,soundboard);
        
        //Name
        self.version = [[NSString alloc]
                        initWithBytes:buffer
                        length:var
                        encoding:NSUTF8StringEncoding];
        
        //Author length
        fread((void*)&var,4,1,soundboard);
        //Author
        fread((void*)buffer,var,1,soundboard);
        
        //Name
        self.author = [[NSString alloc]
                       initWithBytes:buffer
                       length:var
                       encoding:NSUTF8StringEncoding];
        
        //Icon
        _icon = [[Icon alloc] init];
        
        fread((void*)&var,4,1,soundboard);
        
        _icon.size = var;
        _icon.seekStart = 20 + [self.name length] + [self.version length] + [self.author length];
        
        //Skip icon
        fseek(soundboard, _icon.size, SEEK_CUR);
        
        //Number of clips
        fread((void*)&var,4,1,soundboard);
        
        _clips = [[NSMutableArray alloc] initWithCapacity:var];
        
        for(int i=0;i<var;i++)
        {
            Clip *clip = [[Clip alloc] init];
            
            //Clip title size
            fread((void*)&var2,4,1,soundboard);
            //Clip title
            fread((void*)buffer,var2,1,soundboard);
            clip.title = [[NSString alloc]
                         initWithBytes:buffer
                         length:var2
                         encoding:NSUTF8StringEncoding];
            //Clip size
            fread((void*)&var2,4,1,soundboard);
            clip.size = var2;
            //Skip clip
            fseek(soundboard,clip.size,SEEK_CUR);
            //Clip seek start
            if(!i)
            {
                clip.seekStart = _icon.seekStart + _icon.size + [clip.title length] + 12;
            }
            else
            {
                Clip *previousClip = [_clips objectAtIndex:i-1];
                
                clip.seekStart = [previousClip seekStart];
                clip.seekStart += [previousClip size];
                clip.seekStart += [clip.title length];
                clip.seekStart += 8;
                    
            }
            
            [_clips addObject:clip];
            
        }
        
        fclose(soundboard);
    }

    return self;
}

#pragma mark - Static methods

+(BOOL)isValidSoundboard:(NSString*)path
{
    if (!path || [path isEqualToString:@""])
    {
        return NO;
    }
    
    FILE *soundboard = fopen([path cStringUsingEncoding:NSASCIIStringEncoding],"rb");
    NSUInteger var = 0;
    
    if (!soundboard)
    {
        fclose(soundboard);
        return NO;
    }
    
    //Name length
    if ((fread((void*)&var,4,1,soundboard) != 1) || var<1)
    {
        fclose(soundboard);
        return NO;
    }
    //Name
    if (fseek(soundboard,var,SEEK_CUR))
    {
        fclose(soundboard);
        return NO;
    }
    //Version length
    if ((fread((void*)&var,4,1,soundboard) != 1) || var<1)
    {
        fclose(soundboard);
        return NO;
    }
    //Version
    if (fseek(soundboard,var,SEEK_CUR))
    {
        fclose(soundboard);
        return NO;
    }
    //Author length
    if ((fread((void*)&var,4,1,soundboard) != 1) || var<1)
    {
        fclose(soundboard);
        return NO;
    }
    //Author
    if (fseek(soundboard,var,SEEK_CUR))
    {
        fclose(soundboard);
        return NO;
    }
    
    //Icon size
    if ((fread((void*)&var,4,1,soundboard) != 1) || var<1)
    {
        fclose(soundboard);
        return NO;
    }
    
    if (fseek(soundboard,var,SEEK_CUR))
    {
        fclose(soundboard);
        return NO;
    }
    
    //Clipsno
    if ((fread((void*)&var,4,1,soundboard) != 1) || var<1)
    {
        fclose(soundboard);
        return NO;
    }
    
    for(int i=0; i<var; i++)
    {
        int var2 = 0;
        
        //Clip title size
        if ((fread((void*)&var2,4,1,soundboard) != 1) || var2<1)
        {
            fclose(soundboard);
            return NO;
        }
        
        if (fseek(soundboard,var2,SEEK_CUR))
        {
            fclose(soundboard);
            return NO;
        }
        
        //Clip size
        if ((fread((void*)&var2,4,1,soundboard) != 1) || var2<1)
        {
            fclose(soundboard);
            return NO;
        }
        
        if (fseek(soundboard,var2,SEEK_CUR))
        {
            fclose(soundboard);
            return NO;
        }
    }
    
    return YES;
}

@end
