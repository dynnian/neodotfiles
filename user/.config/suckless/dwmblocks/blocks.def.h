//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Command*/	 	                             /*Update Interval*/	/*Update Signal*/
	{"", "$HOME/.config/dwmblocks/scripts/memory",	        1,		            1},

	{"", "$HOME/.config/dwmblocks/scripts/layout",	        1,		            1},

	{"", "$HOME/.config/dwmblocks/scripts/battery",         1,		            1},

	{"", "$HOME/.config/dwmblocks/scripts/volume",			1,		            1},

	{"", "$HOME/.config/dwmblocks/scripts/clock",			5,		            0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
