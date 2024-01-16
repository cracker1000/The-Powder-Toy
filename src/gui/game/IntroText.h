#pragma once
#include "Config.h"
#include "common/String.h"

inline ByteString VersionInfo()
{
	ByteStringBuilder sb;
	sb << SAVE_VERSION << "." << MINOR_VERSION << "." << BUILD_NUM << " " << IDENT;
	return sb.Build();
}

inline ByteString IntroText()
{
	ByteStringBuilder sb;
	sb << "\bo                                           |-----------------------------------|\n"
		"\bw                                            Welcome To The Cracker1000's Mod \n"
		"\bo                                           |-----------------------------------|\n"
		"                                                   \br<< \bwVersion: 57.5\br >>"
		"\n\n   \boImportant Instructions (Do Not Skip):\n"
		"\bt *\bw There's a new 'Cr-Menu' button at the bottom, press it to open the Mod menu ('J' key acts as a shortcut).\n"
		"\bg *\bw Texter, element editor, autosave and various other features can be found in Cr-Menu\n"
		"\bt *\bw Other important customisation options such as themes can be found under Cr-Menu > Control centre settings.\n"
		"\bg *\bw There's a dedicated offline WIKI for the mod elements, make sure to check it out.\n"
		"\bt *\bw You can unhide all the hidden elements using 'Hidden elements' option.\n"
		"\bg *\bw There's a feedback option in the mod menu, report any bug or suggest changes using the same.\n"
		"\bt *\bw Build Number: \bg"<< BUILD_NUM <<"\bw Version: \bg"<< IDENT <<"\n\n"
		"\bw  \bw Contributors: \bt@Cracker1000, @Xphere07, @Maticzpl, @RebMiami, @NF and @Grenadier.\n\n"
		"\br   Press Any Key (except power) To Continue...";
	return sb.Build();
}