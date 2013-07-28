#License

	This file is part of Soundboard.

	Soundboard is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
	any later version.

    Soundboard is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Soundboard.  If not, see <http://www.gnu.org/licenses/>.

#Cocoapods 

	pod 'Soundboard', :git => 'https://github.com/Zi0P4tch0/Soundboard.git'

#Soundboard

I wrote this library to aid me in the development of a soundboard App for iPhone.
I'm using a custom soundboard binary format (simple but effective).

##Preface 

Values are stored in little endian.

All strings are encoded in UTF-8, and they're not C-Style (no trailing '\0').

Icon format is PNG.

All clips are encoded using MPEG Layer-3 codec (mp3).

Clips must have unique titles.

##Format

-- BEGINNING OF FILE --

[4 BYTES] 			Length of soundboard name, in bytes (unsigned integer)

[VARIABLE BYTES]	Soundboard name (string)

[4 BYTES] 			Length of soundboard version, in bytes (unsigned integer)

[VARIABLE BYTES]	Soundboard version (string)(e.g. "1.0")

[4 BYTES] 			Length of soundboard author, in bytes (unsigned integer)

[VARIABLE BYTES]	Soundboard author (string)

[4 BYTES]			Icon size, in bytes (unsigned integer)

[VARIABLE BYTES]	Icon data (a .png image in my case)

[4 BYTES]			Number of clips (unsigned integer)

### For each clip

[4 BYTES]			Clip title length, in bytes (unsigned integer)

[VARIABLE BYTES]	Clip title (string)

[4 BYTES]			Clip size, in bytes (unsigned integer).

[VARIABLE BYTES]	Clip data 

### After last clip

-- END OF FILE

##Sample Code

	Soundboard *s = [[Soundboard alloc] initWithFile:@"PATH"];
	NSData *iconData = [s iconData];
	NSData *firstClipData = [s clipDataFromClipAtIndex:0];
