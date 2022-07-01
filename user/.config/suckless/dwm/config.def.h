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

/* |||--- TAG NAMES ---||| */
static const char *tags[] = { "EDIT", "FILE", "WEB", "CHAT", "MUSIC", "GAMES", "WORK1", "WORK2", "MISC" };

/* |||--- RULES ---||| */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            0,           -1 },
	{ "Firefox",  NULL,       NULL,       3 << 7,       0,           -1 },
};

/* |||--- LAYOUTS ---||| */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
#include "layouts.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ NULL,       NULL },
};


/* |||--- VARIABLES ---||| */
/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(CHAIN,KEY,TAG) \
	{ MODKEY,                       CHAIN,    KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           CHAIN,    KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             CHAIN,    KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, CHAIN,    KEY,      toggletag,      {.ui = 1 << TAG} },
/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define CMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
/* dmenu */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "dmenu_run", "-i", "-b", "-l", "10", "-p", "Run: ", NULL };
/* terminal */
static const char *termcmd[]     = { "alacritty", NULL };


/* |||--- KEY BIDINGS ---||| */
static Key keys[] = {
/* modifier             chain key      key        function        argument */

/* Terminal */
	{ MODKEY,               -1,        XK_Return, spawn,          {.v = termcmd } },

/* Top bar toggle */
	{ MODKEY,               -1,        XK_b,      togglebar,      {0} },

/* WINDOW TAG AND LAYOUT MANIPULATION */

	/* Tag Bindings */
	TAGKEYS(                -1,        XK_1,                      0)
	TAGKEYS(                -1,        XK_2,                      1)
	TAGKEYS(                -1,        XK_3,                      2)
	TAGKEYS(                -1,        XK_4,                      3)
	TAGKEYS(                -1,        XK_5,                      4)
	TAGKEYS(                -1,        XK_6,                      5)
	TAGKEYS(                -1,        XK_7,                      6)
	TAGKEYS(                -1,        XK_8,                      7)
	TAGKEYS(                -1,        XK_9,                      8)
	/* Close Window */
	{ MODKEY|ShiftMask,     -1,        XK_c,      killclient,     {0} },
	/* Cycle between tags */
	{ MODKEY|ControlMask,   -1,        XK_Tab,    view,           {0} },
	/* Window moving */
	{ MODKEY|ShiftMask,     -1,        XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,     -1,        XK_k,      rotatestack,    {.i = -1 } },
	/* Window focusing */
	{ MODKEY,               -1,        XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,               -1,        XK_k,      focusstack,     {.i = -1 } },
	/* Increase and decrease master windows count */
	{ MODKEY,               -1,        XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,               -1,        XK_d,      incnmaster,     {.i = -1 } },
	/* Increase and decrease master window size */
	{ MODKEY,               -1,        XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,               -1,        XK_l,      setmfact,       {.f = +0.05} },
	/* Move window to master */
	{ MODKEY|ControlMask,   -1,        XK_Return, zoom,           {0} },
	/* Cycle between layouts fowards and backwards */
	{ MODKEY,               -1,        XK_Tab,    cyclelayout,    {.i = -1 } },
	{ MODKEY|ShiftMask,     -1,        XK_Tab,    cyclelayout,    {.i = +1 } },
	/* Cycle between recently used layouts */
	{ MODKEY,               -1,        XK_space,  setlayout,      {0} },
	/* Switch to tiling layout */
	{ MODKEY,               -1,        XK_t,      setlayout,      {.v = &layouts[0]} },
	/* Switch to floating layout */
	{ MODKEY,               -1,        XK_f,      setlayout,      {.v = &layouts[1]} },
	/* Switch to monocle layout */
	{ MODKEY,               -1,        XK_m,      setlayout,      {.v = &layouts[2]} },
	/* Switch to grid layout */
	{ MODKEY,               -1,        XK_g,      setlayout,      {.v = &layouts[3]} },
	/* Toggle floating mode */
	{ MODKEY|ShiftMask,     -1,        XK_space,  togglefloating, {0} },
	/* View all windows of all tags in the current tag */
	{ MODKEY,               -1,        XK_0,      view,           {.ui = ~0 } },
	/* Show focused window on all tags */
	{ MODKEY|ShiftMask,     -1,        XK_0,      tag,            {.ui = ~0 } },
	/* Focusing between monitors */
	{ MODKEY,               -1,        XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,               -1,        XK_period, focusmon,       {.i = +1 } },
	/* Move focused window between monitors */
	{ MODKEY|ShiftMask,     -1,        XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,     -1,        XK_period, tagmon,         {.i = +1 } },

/* VOLUME CONTROL */
	/* Increase volume by 5% */
	{ MODKEY|ShiftMask,     -1,        XK_equal,  spawn,          CMD("pamixer -i 5") },
	/* Decrease volume by 5% */
	{ MODKEY|ShiftMask,     -1,        XK_minus,  spawn,          CMD("pamixer -d 5") },

/* BRIGHTNESS CONTROL */
	/* Increase brightness by 5% */
	{ MODKEY|ControlMask,   -1,        XK_equal,  spawn,          CMD("xbacklight -inc 5") },
	/* Decrease brightness by 5% */
	{ MODKEY|ControlMask,   -1,        XK_minus,  spawn,          CMD("xbacklight -dec 5") },

/* KEYBOARD LAYOUTS changed with emacs-style keychords SUPER + k (keyboard) followed by "key" */
	/* Switch to the spanish keyboard layout */
	{ MODKEY,               XK_k,      XK_e,      spawn,          CMD("setxkbmap -layout es") },
	/* Switch to the english keyboard layout */
	{ MODKEY,               XK_k,      XK_u,      spawn,          CMD("setxkbmap -layout us") },

/* PROGRAMS launched with emacs-style keychords SUPER + a (app) followed by "key" */
	/* Text editor */
	{ MODKEY,               XK_a,      XK_1,      spawn,          CMD("/usr/bin/emacsclient -c -a emacs") },
	/* File manager */
	{ MODKEY,               XK_a,      XK_2,      spawn,          CMD("alacritty -e $HOME/.config/vifm/scripts/vifmrun") },
	/* Web browser */
	{ MODKEY,               XK_a,      XK_3,      spawn,          CMD("librewolf") },
	/* Chat app */
	{ MODKEY,               XK_a,      XK_4,      spawn,          CMD("alacritty -e gomuks") },
	/* Music player */
	{ MODKEY,               XK_a,      XK_5,      spawn,          CMD("alacritty -e cmus") },
	/* Game app */
	{ MODKEY,               XK_a,      XK_6,      spawn,          CMD("retroarch") },

/* MISC PROGRAMS launched with emacs-style keychords SUPER + m (app) followed by "key" */
	/* Audio mixer */
	{ MODKEY,               XK_a,      XK_F1,      spawn,          CMD("alacritty -e pulsemixer") },
	/* Rss reader */
	{ MODKEY,               XK_a,      XK_F2,      spawn,          CMD("alacritty -e newsboat") },
	/* Ytfzf */
	{ MODKEY,               XK_a,      XK_F3,      spawn,          CMD("alacritty -e ytfzf -flst") },
	/* Ani-cli */
	{ MODKEY,               XK_a,      XK_F4,      spawn,          CMD("alacritty -e ani-cli") },
	/* Flix-cli */
	{ MODKEY,               XK_a,      XK_F5,      spawn,          CMD("alacritty -e flix-cli") },

/* DMENU PROMPTS launched with emacs-style keychords SUPER + p (prompt) followed by "key" */
	/* dmenu */
	{ MODKEY,               XK_p,      XK_r,      spawn,          {.v = dmenucmd } },
	/* dmenu_power */
	{ MODKEY,               XK_p,      XK_q,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_power") },
	/* dmenu_wifi */
	{ MODKEY,               XK_p,      XK_w,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_wifi") },
	/* dmenu_wall */
	{ MODKEY,               XK_p,      XK_b,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_wall") },
	/* dmenu_edit */
	{ MODKEY,               XK_p,      XK_e,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_edit") },
	/* dmenu_scrot */
	{ MODKEY,               XK_p,      XK_s,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_scrot") },
	/* dmenu_drun */
	{ MODKEY,               XK_p,      XK_d,      spawn,          CMD("$HOME/.config/suckless/dmenu/scripts/dmenu_drun") },


/* DWM BOOTSTRAP */
	{ MODKEY|ShiftMask,     -1,        XK_q,      quit,           {0} },
    { MODKEY|ControlMask,   -1,        XK_r,      quit,           {1} },
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

