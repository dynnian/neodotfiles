/*       ____             __                                               */
/*      / __ \_________ _/ /_____                                          */
/*     / / / / ___/ __ `/ //_/ _ \                                         */
/*    / /_/ / /  / /_/ / ,< /  __/  Clay Gomera (Drake)                    */
/*   /_____/_/   \__,_/_/|_|\___/   My custom dwm build                    */

/* |||--- APPEARANCE ---||| */
static const unsigned int borderpx = 2;   /* border pixel of windows */
static const unsigned int snap     = 32;  /* snap pixel */
static const unsigned int gappx    = 6;   /* pixel gap between clients */
static const int showbar           = 1;   /* 0 means no bar */
static const int topbar            = 1;   /* 0 means bottom bar */
static const int horizpadbar       = 6;   /* horizontal padding for statusbar */
static const int vertpadbar        = 7;   /* vertical padding for statusbar */
static const char *fonts[]     = {"mononoki Nerd Font:size=9:antialias=true:autohint=true"};
static const char col_1[]  = "#1d2021"; /* background color of bar */
static const char col_2[]  = "#928374"; /* border color unfocused windows */
static const char col_3[]  = "#fbf1c7";
static const char col_4[]  = "#cc241d"; /* border color focused windows and tags */

/* bar opacity
 * 0xff is no transparency.
 * 0xee adds wee bit of transparency.
 * 0xdd adds adds a bit more transparency.
 * Play with the value to get desired transparency.
 */
static const unsigned int baralpha    = 0xff;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]        = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_3, col_1, col_2 },
	[SchemeSel]  = { col_3, col_4, col_4 },
};
static const unsigned int alphas[][3] = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = {"alacritty", "-t", "sptrm", "--class", "sptrm,sptrm", NULL };
const char *spcmd2[] = {"alacritty", "-t", "spmsc", "--class", "spmsc,spmsc", "-e", "cmus", NULL };
const char *spcmd3[] = {"alacritty", "-t", "sptop", "--class", "sptop,sptop", "-e", "btop", NULL };
const char *spcmd4[] = {"alacritty", "-t", "spfli", "--class", "spfli,spfli", "-e", "flix-cli", NULL };
const char *spcmd5[] = {"alacritty", "-t", "spani", "--class", "spani,spani", "-e", "ani-cli", NULL };
const char *spcmd6[] = {"alacritty", "-t", "spytf", "--class", "spytf,spytf", "-e", "ytfzf", "-flst", NULL };
const char *spcmd7[] = {"alacritty", "-t", "spamx", "--class", "spamx,spamx", "-e", "alsamixer", NULL };
const char *spcmd8[] = {"alacritty", "-t", "sppmx", "--class", "sppmx,sppmx", "-e", "pulsemixer", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"sptrm",      spcmd1},
	{"spmsc",      spcmd2},
	{"sptop",      spcmd3},
	{"spfli",      spcmd4},
	{"spani",      spcmd5},
	{"spytf",      spcmd6},
	{"spamx",      spcmd7},
	{"sppmx",      spcmd8},
};

/* |||--- TAG NAMES ---||| */
static const char *tags[] = { "dev", "exp", "web", "vdp", "adp", "ext", "gfx", "doc", "gms" };

/* |||--- RULES ---||| */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                           instance                 title       tags mask     isfloating   monitor */
	{ "Emacs",                            NULL,                 NULL,              1,       0,           -1 },
	{ "Godot",                            NULL,                 NULL,              1,       0,           -1 },
	{ "Virt-manager",                     NULL,                 NULL,              1,       0,           -1 },
	{ "Galculator",                       NULL,                 NULL,              0,       1,           -1 },
	{ "exp",                              NULL,                 NULL,         1 << 1,       0,           -1 },
	{ "librewolf",                        NULL,                 NULL,         1 << 2,       0,           -1 },
	{ "kdenlive",                         NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "Blender",                          NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "Natron",                           NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "SimpleScreenRecorder",             NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "Ghb",                              NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "obs",                              NULL,                 NULL,         1 << 3,       0,           -1 },
	{ "Audacity",                         NULL,                 NULL,         1 << 4,       0,           -1 },
	{ "Ardour",                           NULL,                 NULL,         1 << 4,       0,           -1 },
	{ "Carla2",                           NULL,                 NULL,         1 << 4,       0,           -1 },
	{ "Carla2-Control",                   NULL,                 NULL,         1 << 4,       0,           -1 },
	{ "QjackCtl",                         NULL,                 NULL,         1 << 5,       1,           -1 },
	{ "lsp-plugins",                      NULL,                 NULL,         1 << 5,       1,           -1 },
	{ "qpwgraph",                         NULL,                 NULL,         1 << 5,       0,           -1 },
	{ "Gimp-2.10",                        NULL,                 NULL,         1 << 6,       0,           -1 },
	{ "krita",                            NULL,                 NULL,         1 << 6,       0,           -1 },
	{ "Inkscape",                         NULL,                 NULL,         1 << 6,       0,           -1 },
	{ "Xournalpp",                        NULL,                 NULL,         1 << 6,       0,           -1 },
	{ "DesktopEditors",                   NULL,                 NULL,         1 << 7,       0,           -1 },
	{ "retroarch",                        NULL,                 NULL,         1 << 8,       0,           -1 },
	{ NULL,                            "sptrm",                 NULL,       SPTAG(0),       1,           -1 },
	{ NULL,                            "spmsc",                 NULL,       SPTAG(1),       1,           -1 },
	{ NULL,                            "sptop",                 NULL,       SPTAG(2),       1,           -1 },
	{ NULL,                            "spfli",                 NULL,       SPTAG(3),       1,           -1 },
	{ NULL,                            "spani",                 NULL,       SPTAG(4),       1,           -1 },
	{ NULL,                            "spytf",                 NULL,       SPTAG(5),       1,           -1 },
	{ NULL,                            "spamx",                 NULL,       SPTAG(6),       1,           -1 },
	{ NULL,                            "sppmx",                 NULL,       SPTAG(7),       1,           -1 },
};

/* |||--- LAYOUTS ---||| */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
#include "grid.c"
#include "tcl.c"
#include "fbc.c"
#include "tlwide.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ "|||",      tcl },
 	{ "[@]",      spiral },
 	{ "[\\]",     dwindle },
	{ "[][]=",    tilewide },
	{ NULL,       NULL },
};


/* |||--- VARIABLES ---||| */
/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG)												\
	{1, {{MODKEY, KEY}},								view,           {.ui = 1 << TAG} },	\
	{1, {{MODKEY|ControlMask, KEY}},					toggleview,     {.ui = 1 << TAG} }, \
	{1, {{MODKEY|ShiftMask, KEY}},						tag,            {.ui = 1 << TAG} }, \
	{1, {{MODKEY|ControlMask|ShiftMask, KEY}},			toggletag,      {.ui = 1 << TAG} },
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
/* dmenu */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-i", "-b", "-l", "10", "-p", "Run: ", NULL };
/* terminal */
static const char *termcmd[]     = { "alacritty", NULL };


/* |||--- KEY BIDINGS ---||| */
static Keychord keychords[] = {
/* modifier             chain key      key        function        argument */

/* Terminal */
	{1, {{MODKEY, XK_Return}},			 spawn,           {.v = termcmd } },

/* Top bar toggle */
	{1, {{MODKEY|ControlMask, XK_b}},		  togglebar,      {0} },

/* WINDOW TAG AND LAYOUT MANIPULATION */

	/* Tag Bindings */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	/* Close Window */
	{1, {{MODKEY, XK_q}},                   killclient,     {0} },
	/* Cycle between tags */
	{1, {{MODKEY|ControlMask, XK_Tab}},     view,           {0} },
	/* Window moving */
	{1, {{MODKEY|ShiftMask, XK_j}},		    rotatestack,    {.i = +1 } },
	{1, {{MODKEY|ShiftMask, XK_k}},		    rotatestack,    {.i = -1 } },
	/* Window focusing */
	{1, {{MODKEY, XK_j}},				    focusstack,     {.i = +1 } },
	{1, {{MODKEY, XK_k}},				    focusstack,     {.i = -1 } },
	/* Increase and decrease master windows count */
	{1, {{MODKEY, XK_equal}},				incnmaster,     {.i = +1 } },
	{1, {{MODKEY, XK_minus}},				incnmaster,     {.i = -1 } },
	/* Increase and decrease master window size */
	{1, {{MODKEY, XK_h}},				    setmfact,       {.f = -0.05} },
	{1, {{MODKEY, XK_l}},				    setmfact,       {.f = +0.05} },
	/* Move window to master */
	{1, {{MODKEY|ControlMask, XK_Return}},  zoom,           {0} },
	/* Cycle between layouts fowards and backwards */
	{1, {{ MODKEY, XK_Tab}},                cyclelayout,    {.i = -1 } },
	{1, {{ MODKEY|ShiftMask, XK_Tab}},      cyclelayout,    {.i = +1 } },
	/* Switch to tiling layout */
	{1, {{MODKEY, XK_t}},				    setlayout,      {.v = &layouts[0]} },
	/* Switch to floating layout */
	{1, {{MODKEY, XK_f}},				    setlayout,      {.v = &layouts[1]} },
	/* Switch to monocle layout */
	{1, {{MODKEY, XK_m}},   		        setlayout,      {.v = &layouts[2]} },
	/* Switch to grid layout */
	{1, {{MODKEY, XK_g}},				    setlayout,      {.v = &layouts[3]} },
	/* Switch to three column layout */
	{1, {{MODKEY, XK_c}},				    setlayout,      {.v = &layouts[4]} },
	/* Switch to fibonacci spiral layout */
	{1, {{MODKEY, XK_s}},				    setlayout,      {.v = &layouts[5]} },
	/* Switch to fibonacci dwindle layout */
	{1, {{MODKEY, XK_d}},				    setlayout,      {.v = &layouts[6]} },
	/* Switch to tilewide layout */
	{1, {{MODKEY|ControlMask, XK_t}},       setlayout,      {.v = &layouts[7]} },
	/* Toggle floating mode */
	{1, {{MODKEY|ControlMask, XK_f}},       togglefloating, {0} },
	/* Toggle fullscreen mode */
	{1, {{MODKEY, XK_space}},	            togglefullscr,  {0} },
	/* View all windows of all tags in the current tag */
	{1, {{MODKEY, XK_0}},				    view,           {.ui = ~0 } },
	/* Show focused window on all tags */
	{1, {{MODKEY|ShiftMask, XK_0}},		    tag,            {.ui = ~0 } },
	/* Focusing between monitors */
	{1, {{MODKEY, XK_comma}},               focusmon,       {.i = -1 } },
	{1, {{MODKEY, XK_period}},              focusmon,       {.i = +1 } },
	/* Move focused window between monitors */
	{1, {{MODKEY|ShiftMask, XK_comma}},	    tagmon,         {.i = -1 } },
	{1, {{MODKEY|ShiftMask, XK_period}},    tagmon,         {.i = +1 } },

/* VOLUME CONTROL */
	/* Toggle mute */
    {1, {{MODKEY, XK_F1}},                  spawn,          SHCMD("pamixer -t") },
	/* Decrease volume by 5% */
    {1, {{MODKEY, XK_F2}},                  spawn,          SHCMD("pamixer -d 5") },
	/* Increase volume by 5% */
    {1, {{MODKEY, XK_F3}},                  spawn,          SHCMD("pamixer -i 5") },
	/* Toggle microphone mute */
    {1, {{MODKEY, XK_F4}},                  spawn,          SHCMD("pamixer --default-source -t") },

/* BRIGHTNESS CONTROL */
	/* Decrease brightness by 5% */
    {1, {{MODKEY, XK_F5}},                  spawn,          SHCMD("xbacklight -dec 10") },
	/* Increase brightness by 5% */
    {1, {{MODKEY, XK_F6}},                  spawn,          SHCMD("xbacklight -inc 10") },
	/* Set screen backlight to off */
    {1, {{MODKEY, XK_F7}},                  spawn,          SHCMD("xbacklight -set 0") },

/* KEYBOARD LAYOUTS changed with emacs-style keychords SUPER + k (keyboard) followed by "key" */
	/* Switch to the spanish keyboard layout */
	{2, {{MODKEY, XK_x}, {0, XK_e}},        spawn,          SHCMD("setxkbmap -layout es") },
	/* Switch to the english keyboard layout */
	{2, {{MODKEY, XK_x}, {0, XK_u}},        spawn,          SHCMD("setxkbmap -layout us") },

/* EMACS PROGRAMS launched with emacs-style heychords SUPER + e (app) followed by "key" */
	{2, {{MODKEY, XK_e}, {0, XK_e}},        spawn,          SHCMD("emacsclient -c -a 'emacs'") },
	{2, {{MODKEY, XK_e}, {0, XK_b}},        spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(ibuffer)'") },
	{2, {{MODKEY, XK_e}, {0, XK_d}},        spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(dired nil)'") },
	{2, {{MODKEY, XK_e}, {0, XK_v}},        spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'") },
	{2, {{MODKEY, XK_e}, {0, XK_s}},        spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(eshell)'") },
	{2, {{MODKEY, XK_e}, {0, XK_w}},        spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(doom/window-maximize-buffer(eww \"gnu.org\"))'") },

/* WEB browser and web apps launched with emacs-style heychords SUPER + b (app) followed by "key" */
	{2, {{MODKEY, XK_w}, {0, XK_w}},                  spawn,          SHCMD("librewolf") },
	{3, {{MODKEY, XK_w}, {0, XK_c}, {0, XK_e}},       spawn,          SHCMD("librewolf --new-tab https://app.element.io") },
	{3, {{MODKEY, XK_w}, {0, XK_c}, {0, XK_d}},       spawn,          SHCMD("librewolf --new-tab https://discord.com/channels/@me") },
	{3, {{MODKEY, XK_w}, {0, XK_c}, {0, XK_w}},       spawn,          SHCMD("librewolf --new-tab https://web.whatsapp.com") },
	{3, {{MODKEY, XK_w}, {0, XK_c}, {0, XK_t}},       spawn,          SHCMD("librewolf --new-tab https://web.telegram.org") },
	{3, {{MODKEY, XK_w}, {0, XK_y}, {0, XK_y}},       spawn,          SHCMD("librewolf --new-tab https://youtube.com") },
	{3, {{MODKEY, XK_w}, {0, XK_y}, {0, XK_m}},       spawn,          SHCMD("librewolf --new-tab https://music.youtube.com") },
	{3, {{MODKEY, XK_w}, {0, XK_i}, {0, XK_a}},       spawn,          SHCMD("librewolf --new-tab https://lms.intec.edu.do") },
	{3, {{MODKEY, XK_w}, {0, XK_i}, {0, XK_c}},       spawn,          SHCMD("librewolf --new-tab https://outlook.office.com") },
	{3, {{MODKEY, XK_w}, {0, XK_i}, {0, XK_p}},       spawn,          SHCMD("librewolf --new-tab https://procesos.intec.edu.do") },
	{3, {{MODKEY, XK_w}, {0, XK_m}, {0, XK_g}},       spawn,          SHCMD("librewolf --new-tab https://mail.google.com") },
	{3, {{MODKEY, XK_w}, {0, XK_m}, {0, XK_t}},       spawn,          SHCMD("librewolf --new-tab https://mail.tutanota.com") },
	{3, {{MODKEY, XK_w}, {0, XK_m}, {0, XK_o}},       spawn,          SHCMD("librewolf --new-tab https://outlook.live.com/mail") },
	{3, {{MODKEY, XK_w}, {0, XK_a}, {0, XK_b}},       spawn,          SHCMD("librewolf --new-tab https://vault.bitwarden.com") },

/* PROGRAMS launched with emacs-style keychords SUPER + a (app) followed by "key" */
	/* File manager */
	{2, {{MODKEY, XK_a}, {0, XK_f}},        spawn,          SHCMD("alacritty -t exp --class exp,exp -e $HOME/.config/vifm/scripts/vifmrun") },
	/* Game app */
	{2, {{MODKEY, XK_a}, {0, XK_g}},        spawn,          SHCMD("retroarch") },
	/* Virtual machine manager */
	{2, {{MODKEY, XK_a}, {0, XK_v}},        spawn,          SHCMD("virt-manager") },

/* DMENU PROMPTS launched with emacs-style keychords SUPER + p (prompt) followed by "key" */
	/* dmenu */
	{2, {{MODKEY, XK_p}, {0, XK_r}},        spawn,          {.v = dmenucmd } },
	/* dmenu_power */
	{2, {{MODKEY, XK_p}, {0, XK_q}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_power") },
	/* dmenu_wifi */
	{2, {{MODKEY, XK_p}, {0, XK_i}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_wifi") },
	/* dmenu_wall */
	{2, {{MODKEY, XK_p}, {0, XK_w}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_wall") },
	/* dmenu_edit */
	{2, {{MODKEY, XK_p}, {0, XK_e}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_edit") },
	/* dmenu_scrot */
	{2, {{MODKEY, XK_p}, {0, XK_s}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_scrot") },
	/* dmenu_drun */
	{2, {{MODKEY, XK_p}, {0, XK_d}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_drun") },
	/* dmenu_blue */
	{2, {{MODKEY, XK_p}, {0, XK_b}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_blue") },
	/* dmenu_emoji */
	{2, {{MODKEY, XK_p}, {0, XK_z}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_emoji") },
	/* dmenu_pipe */
	{2, {{MODKEY, XK_p}, {0, XK_p}},        spawn,          SHCMD("$HOME/.config/suckless/dmenu/scripts/dmenu_pipe") },

/* SCRATCHPADS */
	{1, {{MODKEY|ShiftMask, XK_Return}},    togglescratch,  {.ui = 0 } },
	{1, {{MODKEY|ShiftMask, XK_c}},         togglescratch,  {.ui = 1 } },
	{1, {{MODKEY|ShiftMask, XK_b}},         togglescratch,  {.ui = 2 } },
	{1, {{MODKEY|ShiftMask, XK_f}},         togglescratch,  {.ui = 3 } },
	{1, {{MODKEY|ShiftMask, XK_a}},         togglescratch,  {.ui = 4 } },
	{1, {{MODKEY|ShiftMask, XK_y}},         togglescratch,  {.ui = 5 } },
	{1, {{MODKEY|ShiftMask, XK_m}},         togglescratch,  {.ui = 6 } },
	{1, {{MODKEY|ShiftMask, XK_p}},         togglescratch,  {.ui = 7 } },

/* DWM BOOTSTRAP */
	{1, {{MODKEY|ControlMask, XK_r}},       quit,           {1} },
	{1, {{MODKEY|ShiftMask,   XK_q}},       quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click           event mask   button          function        argument */
	{ ClkLtSymbol,     0,           Button1,        setlayout,      {0} },
	{ ClkLtSymbol,     0,           Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,     0,           Button2,        zoom,           {0} },
	{ ClkStatusText,   0,           Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,    MODKEY,      Button1,        movemouse,      {0} },
	{ ClkClientWin,    MODKEY,      Button2,        togglefloating, {0} },
	{ ClkClientWin,    MODKEY,      Button3,        resizemouse,    {0} },
	{ ClkTagBar,       0,           Button1,        view,           {0} },
	{ ClkTagBar,       0,           Button3,        toggleview,     {0} },
	{ ClkTagBar,       MODKEY,      Button1,        tag,            {0} },
	{ ClkTagBar,       MODKEY,      Button3,        toggletag,      {0} },
};

