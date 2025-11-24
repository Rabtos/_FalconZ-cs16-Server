#define PLUGINNAME	"Weapon Arena"
#define VERSION		"2.0.4"
#define AUTHOR		"JGHG/JTP10181"

#define ACCESSNEEDED ADMIN_LEVEL_A

/*
Copyleft 2003-2005
AMX Mod X versions:
http://www.amxmodx.org/forums/viewtopic.php?p=4173

AMX Mod versions:
http://amxmod.net/forums/viewtopic.php?t=15549


WEAPON ARENA
============
Lets admin start an "<insert your favourite weapon here> arena" which means that everyone will instantly be given specified weapon,
and infinite (optional) ammo for it. By default no other weapons will be visible on ground in game. As long as Weapon Arena is enabled
you can't change to any other weapon than the given one, grenades, knife or C4. Upon new round you will be given a new weapon, if you
lost your previous... Upon default you will not even have to reload any clips - you will always have bullets to fire! This can be changed
with a cvar.

...and more features.


INSTALLATION
============
1. Compile sma to weaponarena.amxx
2. Move weaponarena.amx into amxmodx/plugins
3. Add a line at the end of amxmodx/plugins.ini to say:
   weaponarena.amxx
4. Look through all commands and cvars below to understand their use. You might want to configure your settings by changing the cvar values.
5. Done


USAGE
=====
weaponarena_menu
----------------
(client command) Menu driven weapon selection. Only for connected clients, that have access ADMIN_CFG. Use it to start and stop Weapon Arena in an easy way. There is a subset of menus to select which weapons will be selected in random mode.

weaponarena_randomlist
----------------------
(client/server command) Displays what weapons are available for random mode. When run from command line it also displays the letters used to specify these when changing the random setting from command line.

It may look like this on STEAM, though you'd want to double check it to make sure the letters are the same:

Weapon          status  letter
p228            off     a
scout           off     b
hegrenade       on      c
xm1014          off     d
mac10           off     e
aug             off     f
elite           off     g
fiveseven       off     h
ump45           on      i
sg550           off     j
galil           off     k
famas           off     l
usp             off     m
glock18         off     n
awp             off     o
mp5navy         off     p
m249            off     q
m3              off     r
m4a1            off     s
tmp             off     t
g3sg1           off     u
deagle          off     v
sg552           off     w
ak47            off     x
knife           off     y
p90             off     z

weaponarena_random <abc...> [save]
----------------------------------
(client/server command) Specify what weapons will be available in random mode through command line/config files. To see which weapon has which letter, do a "weaponarena_randomlist".
If "save" is specified as 2nd parameter, this command also stores the current setting to AMX Mod X vault which means that it will be loaded again when next map starts,
so no need of executing this command again if you want to keep the same setting.
If no record exists in vault this will default to all weapons enabled. If no weapons are enabled when random mode executes, it will always select Knife Arena.
A complete line for steam: "weaponarena_random abcdefghijklmnopqrstuvwxyz" and for won: (old and outdated :-/).

weaponarena <weaponnumber|random|list|off>
------------------------------------------
(client/server command) Specify a valid weaponnumber as argument, to turn it on, or change current weapon type if Weapon Arena is already on. Specify "random" to automatically change
current Weapon Arena weapon on every new round. Will enable Weapon Arena if it is disabled. Specify "list" to have a list of valid weapon numbers in a "message of the day" window
(or in server console). Specify "off" to turn Weapon Arena off.

	Examples:
	weaponarena off
	(Turns it off)

	weaponarena 10
	(Starts Weapon Arena with Berettas)

	weaponarena list
	(Displays valid weapon numbers)

	weaponarena random
	(Starts Weapon Arena, making a random selection of gun
	for every new round to give to all players.)

weaponarena_unlimitedammo
-------------------------
(cvar) Values:
0 - to disable unlimited ammo. You will receive full ammo at round start.
1 - to enable unlimited ammo, AND you will NOT have to reload any clips, so you can fire forever without reloading! This is default.
2 - to enable unlimited ammo, but you will have to reload inbetween clips.

weaponarena_invisibleweapons
----------------------------
(cvar) Values:
0 - to disable all weapons but current Arena weapon from going invisible. You might want to use this if playing with bots: some bots still "see" the weapons (they are still there, just invisible and you can't touch them), and get stuck when they can't pick them up.
1 - to enable all weapons but current Arena weapon to go invisible. This is default.

weaponarena_delay
-----------------
(cvar) Standard delay of seconds from the time a player spawns until he receives the weapon.
Don't set to anything other than 0 (default) if you aren't having any problems. You might
want to set this to 1.5 or something for maps consisting of player_weaponstrip entities.
These maps, like ka_matrix and ka_legoland, usually make it so you lose your glock/usp at
round starts, and sometimes you are given other weapons. This interferes with Weapon Arena.
To have different configs for specific maps, put a cfg file inside amxmodx/configs/maps directory,
create it if you don't have it. For a specific cfg file for ka_legoland.bsp, your file could have this name:
amxmodx/configs/maps/ka_legoland.cfg, and it could contain this: weaponarena_delay 1.0

weaponarena_holdknife
---------------------
(cvar) Values:
0 - when a player tries to hold a weapon that is not the current Arena weapon, he will be forced to drop it. (default)
1 - when a player tries to hold a weapon that is not the current Arena weapon, he will be forced to hold the knife.

weaponarena_randomteamspecific
------------------------------
(cvar) Values:
0 - in random mode, the two teams will always get the same weapon.
1 - in random mode, the two teams will randomly have one of the defined available weapons independent of the other team (deagle VS scout scenarios etc). (default)

weaponarena_stealrandomteam
---------------------------
(cvar) Values:
0 - with random arena and weaponarena_randomteamspecific set to 1, you CANNOT steal the other team's weapon.
1 - with random arena and weaponarena_randomteamspecific set to 1, you CAN steal the other team's weapon. Only if you killed an enemy with it, not a weapon
that is on ground from map start (think fy_iceworld). (default)


VERSIONS
========

v2.0.4 - JTP10181 - 09/16/06
	- Fixed a few small bugs from the last version

v2.0.3 - JTP10181 - 08/06/06
	- Fixed MOTD and console output
	- Ported fully to fakemeta
	- Merged in HE Arena
	- Force weapon drop at each new round to prevent having multiple primaries

v2.0.2 - JTP10181 - 07/01/06
	- Now gives full backpack ammo in shield arena with unlimited ammo off

v2.0.1 - JTP10181 - 06/13/06
	- Fixed shield arena
	- Made it impossible to have a 0 delay because it causes problems

v2.0 - JTP10181 - 05/08/06
	- Fixed runtime error caused by alive spectators, now basically ignores these people
	- Fixed runtime error trying to set ammo on weapon entity 0

v1.9.9 - JTP10181 - 04/04/06
	- Fixed runtime error in "disabled" from get_user_team

v1.9.8 - JTP10181 - 03/23/06
	- Fixed runtime error in holdwpn_event that was reported in 2004 ;)


-= Everything Below Here was updated by JGHG =-

Released	Version		Comment
050528		1.9.7		Small patch thanks to MattOG.
050528		1.9.6		By request: Now also supports (to a certain degree, this is largely untested) grenades. To use grenades with this, you need my HE Arena X plugin.
						Url of HE Arena X: http://www.amxmodx.org/forums/viewtopic.php?p=71722
						It _should_ work also with random mode, not sure though if it works if having team specific weapons. If it doesn't, don't use that! :-)
						Maybe I'll fix it later then if it doesn't work.
						Note that because grenades were added, if you had a weaponarena randomlist you need to update it. Rerun weaponarena_randomlist
						to see the new weapon codes. Or just use the ingame menu.

050405		1.9.5		Updated to compile with AMX Mod X 1.01...

041228		1.9.4		With Knife Arena you could always shoot one shot before it forced you to hold knife if you spawned with a glock/usp. Should be fixed.

						Very minor bug fix.

041212		1.9.3		A few fixes and tweaks thanks to jtp10181 was made in holdwpn_event().

041119		1.9.2		Crash related to the one below. (Some?) bots could still buy anything and thus bring server down. For now bots always have $0
						when Weapon Arena is on to fix this. >:-)

						If a terrorist dropped the C4 backpack noone could pick it up again because it was made invisible and untouchable.

041118		1.9.1		Fatal crash/overflow bug when buying full set of secondary ammo while Weapon Arena is running. Hope this is fixed now -
						buying of any ammo should now also be blocked, it's not needed anyway. Kudos to -=|$uD|=-BigJay for finding this one. :-)

041018		1.9			Bug found and fixed: Changing ACCESSNEEDED, the define telling what flag you need for the menu, didn't have any difference.

041008		1.8.2		With updated AMX Mod X 0.20 a menu item for Weapon Arena will be added to amxmodmenu.

040930		1.8.1		Bug fixes:
						- Rewrote part of weapons autodropping routine.
						- More forgotten fixes...

						Also rebuy and autobuy is now blocked, as well as purchase of the shield and any primary and secondary weapon.

						Even if weaponarena_stealrandomteam is set to 1 you should now only be able to pick up the enemy's weapon if it
						fell from his hand after you killed him. Ie, you cannot pick up the enemy's weapon if it was on ground from map start (fy_iceworld).

040926		1.8			Now uses fakemeta module!

						New/edited features:
						- With weaponarena_unlimitedammo set to 1 you should now not even be able to reload at all, since it's not necessary.
						- New cvar: weaponarena_stealrandomteam (you can now steal the other team's weapon in random mode)

						(Hopefully) fixed a lot of bugs:
						- Starting a "normal" (nonrandom) arena would only hide weapons on ground instantly, and not on the next rounds.
						- Changing from random arena to a "normal" arena by using console command would only change to that weapon for the rest
						of the round. The next round it was random arena again.
						- More small bug fixes and tweaks...

						+ some optimizing...

040922		1.7.2		Fixed problem with hiding one of the weapons active for team specific random mode.
						Also with weaponarena_unlimitedammo set to 2 you should now get full stock of ammo from start...

040916		1.7.1		Small bug fixed.

040915		1.7			Added a new mode to random mode, and the cvar weaponarena_randomteamspecific.
						Last selected weapon in random mode will not be available for next round (if amount of random weapons is above 1).

040915		1.6.3c		Cleaned out old WON specific code. No new features.

040915		1.6.3b		Nothing changed, but should now be possible to compile on the forum's compiler. No new features.

040627		1.6.3		"weaponarena list" didn't display all weapons in server console.

040505		1.6.2		Now defaults to dropping a weapon if it's not the current Arena weapon. You can change this behaviour through the weaponarena_holdknife cvar.

040408		1.6.1		Couldn't select AWP from menu.

040331		1.6			Update to weaponarena_random cmd: Must now add "save" as last parameter for it to save that setting to vault.

040325		1.5			Weaponarena_randomlist didn't work from client. Now it only displays weapon letters when run from console.
						Command weaponarena_random now stores current setting to vault. The setting will be retrieved when map loads. If no setting is in vault, it defaults to all weapons enabled.

040324		1.4			Added a new menu set for random arena. Use it to select which weapons will be selected in random mode.
						Made a command to set weapons for random mode from console/config files.
						Fixed up some code: works better with bots and when changing weapons. Guns are now never dropped, instead it ultimately forces you to hold the knife.
						All weapons but current Arena weapon are made invisible and untouchable on ground.
						Cvar added to enable/disable invisibility of illegal weapons.

040322		1.3			Fixed unlimited ammo bug in previous version.
						Removed use of jghg2 module, now requires cstrike module.

040321		1.2			Remade for AMX Mod X.
						Setting 1 of weaponarena_unlimitedammo now works better, you can buy ammo but will never have to reload...
						Removed possibility of shield coming up when using random weapons, as the shield part isn't really working well.

			1.1			Added shield.
						Some bugfixing.
						Changed STEAM define to look for NO_STEAM define in amxconst.inc. Make sure you set it to the right setting before compile!

			1.01		First update for a time. Trying this script out under CS 1.6/Steam/Metamod 1.17/AMX 0.9.7j,
						the engclient_cmd() seems to not work really as expected. It did crash the server when forcing
						drops of weapons, and it couldn't force a player to hold the current WA weapon, resulting in
						really odd behaviour. Change to client_cmd() fixes this.

						#define STEAM is now default, so if you run CS 1.5 you must comment it.

			1.0			Added "weaponarena_unlimitedammo 2"

			0.91		Added support for Galil and Famas. Uncomment #define STEAM and recompile of you want this.

			0.9			Removed weaponarena_stripdelay, and so also the need
						for xtrafun module is removed.

			0.8.3b		Bug fixing, unlimited ammo off didn't work properly.

			0.8.3a		Bug fixing

			0.8.3		Maps with "player_weaponstrip" entities, like
						ka_matrix where you only get a knife at start,
						wouldn't work very well with Weapon Arena.
						This version postpones the giving of weapon
						1.5 seconds (default) from when player spawns.
						Seems to fix the problem. If you have problems
						still, try changing cvar weaponarena_stripdelay
						to hold how many seconds the giving of weapons
						should be postponed.

			0.8.2		Minor tweak.

			0.8.1		Minor tweak.

			0.8			Unlimited ammo added.

			0.7			Found (thanks to boundary checking) a bug/typo
						since newest RC (8) of AMX 0.9.4.
						So this version is fixed to work with newest
						AMX Mod. Thanks to DoubleTap for help with this.

						weaponarena_delay is another new cvar that works
						like weapon_arenastripdelay, only that it
						is used on all maps that don't have these
						"player_weaponstrip"s. Defaults to 0.

			0.6			Seemed previous version crashes,
						this version has some stuff that might help.

			0.5			Knife added

			0.4			Added random new weapon for every new round

			0.3			Added menu for selecting weapons

			0.2			Touch up...

			0.1			First version


TO DO
=====

- Make it so ammo displayed is updated instantly when your clip is replenished...
- Some maps (and plugins) strip knife from players so Knife Arena is impossible...
	- Johnny got his gun

- Clean up all this scary code :0
- Try to get strip user weapons to work so knife wont even be allowed
	- JTP10181

*/

#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <fun>
#include <cstrike>


#if !defined CSW_SHIELD
	#define CSW_SHIELD			2
#endif

#define NADEAMOUNT 2
#define NROFITEMS				34
#define MAXGIVEWEAPONS			1
#define MENUBUTTON1				(1<<0)
#define MENUBUTTON2				(1<<1)
#define MENUBUTTON3				(1<<2)
#define MENUBUTTON4				(1<<3)
#define MENUBUTTON5				(1<<4)
#define MENUBUTTON6				(1<<5)
#define MENUBUTTON7				(1<<6)
#define MENUBUTTON8				(1<<7)
#define MENUBUTTON9				(1<<8)
#define MENUBUTTON0				(1<<9)
#define MENUSELECT1				0
#define MENUSELECT2				1
#define MENUSELECT3				2
#define MENUSELECT4				3
#define MENUSELECT5				4
#define MENUSELECT6				5
#define MENUSELECT7				6
#define MENUSELECT8				7
#define MENUSELECT9				8
#define MENUSELECT0				9
#define FORCEACTION_DROP		0
#define FORCEACTION_HOLDKNIFE	1
#define OFFSET_WEAPON_TYPEID	43

// Global vars below
new bool:g_weaponArena
new bool:g_randomWeapon = false
new g_randomflags = 67108863 // 67108863 means all flags enabled on STEAM, should work for WON also... (hmmm I forgot, what is WON anyway? :-))
//new bool:g_randomTeamSpecific = false
new g_waWeapon[4]
new g_weaponString[3][50]
new g_ammoString[3][50]
new const g_WEAPONNUMBERS[] = "P228			1^nSHIELD			2^nSCOUT			3^nGRENADE			4^nXM1014			5^nMAC10			7^nAUG			8^nELITE			10^nFIVESEVEN		11^nUMP45			12^nSG550			13^nGALIL			14^nFAMAS			15^nUSP			16^nGLOCK18			17^nAWP			18^nMP5NAVY			19^nM249			20^nM3			21^nM4A1			22^nTMP			23^nG3SG1			24^nDEAGLE			26^nSG552			27^nAK47			28^nKNIFE			29^nP90			30"
new g_hadThisRound[33] = {0, ...}
new bool:g_randomizedThisRound = false
new bool:g_hidThisRound = false
new bool:g_initedGives = false
new const CVAR_RANDOMTEAMSPECIFIC[] = "weaponarena_randomteamspecific"
new const CVAR_STEALRANDOMWEAPON[] = "weaponarena_stealrandomteam"
new const DEFAULTDELAY[] = "0.2"
new g_MsgSync
/*
new weapondescriptions[31][] = {
	"ERROR: Invalid weapon (0)","Sig Sauer P228","Shield","Steyr Scout",
	"High explosive grenade","Benelli XM1014","C4 bomb","Ingram Mac-10",
	"Steyr Aug","Smoke grenade","Dual Beretta 96G Elites","Fabrique Nationale Five-seven",
	"Heckler & Koch UMP45","Sig SG-550 Commando","Galil","Famas",
	"Heckler & Koch USP45","Glock 18","Accuracy Int. Arctic Warfare/Magnum (AW/M)","Heckler & Koch MP5/Navy",
	"FN M249 Para","Benelli M3 Super 90","Colt M4A1","Steyr Tactical Machine Pistol",
	"Heckler & Koch G3/SG-1","Flashbang","IMI Desert Eagle","Sig SG-552 Commando",
	"Avtomat Kalashnikov AK-47","Combat knife","Fabrique Nationale P90"}
*/
new const g_weaponstrings[NROFITEMS][] = {
	"",						// 0 First should be empty
	"weapon_p228",
	"weapon_shield",
	"weapon_scout",
	"weapon_hegrenade",
	"weapon_xm1014",
	"",						// 6 C4 CSW_C4
	"weapon_mac10",
	"weapon_aug",
	"weapon_smokegrenade",
	"weapon_elite",
	"weapon_fiveseven", // = "models/w_fiveseven.mdl"
	"weapon_ump45",
	"weapon_sg550",
	"weapon_galil",			// 14
	"weapon_famas",			// 15
	"weapon_usp",
	"weapon_glock18",
	"weapon_awp",
	"weapon_mp5navy",
	"weapon_m249",
	"weapon_m3",
	"weapon_m4a1",
	"weapon_tmp",
	"weapon_g3sg1",
	"weapon_flashbang",
	"weapon_deagle",
	"weapon_sg552",
	"weapon_ak47",
	"weapon_knife",						// 29 knife CSW_KNIFE
	"weapon_p90",
	"item_kevlar",
	"item_assaultsuit",
	"item_thighpack"
}
new const MAXAMMOINCLIP[] = {
	0,						// 0 First should be empty
	13,		// weapon_p228
	0,		// weapon_shield
	10,		// weapon_scout
	1,		// weapon_hegrenade (max is 1 (default anyway;-))
	7,		// weapon_xm1014
	0,		// 6 C4 CSW_C4
	30,		// weapon_mac10
	30,		// weapon_aug
	0,		// weapon_smokegrenade (max is 1)
	30,		// weapon_elite
	20,		// weapon_fiveseven
	25,		// weapon_ump45
	30,		// weapon_sg550
	35,		// weapon_galil
	25,		// weapon_famas
	12,		// weapon_usp
	20,		// weapon_glock18
	10,		// weapon_awp
	30,		// weapon_mp5navy
	100,	// weapon_m249
	8,		// weapon_m3
	30,		// weapon_m4a1
30,		// weapon_tmp
	20,		// weapon_g3sg1
	0,		// weapon_flashbang (max is 2)
	7,		// weapon_deagle
	30,		// weapon_sg552
	30,		// weapon_ak47
	0,		// 27 knife CSW_KNIFE
	50		// weapon_p90
/*	"",		// item_kevlar
	"",		// item_assaultsuit
	""		// item_thighpack
*/
}
new const BLED[2][] = {"off", "on"}
new const VAULTKEY_RANDOM[] = "weaponarena_random"
new g_maxclients
new g_authorized
new g_lastweaponentity[33]
new g_blockforceweapon[33]
#define WEAPONSTOBLOCK 27
new const g_Aliases[WEAPONSTOBLOCK][] = {
	"usp", //Pistols 1
	"glock", // 2
	"deagle", // 3
	"p228", // 4
	"elites", // 5
	"fn57", // 6

	"m3", //Shotguns7
	"xm1014", // 8

	"mp5", //SMG9
	"tmp", // 10
	"p90", // 11
	"mac10", // 12
	"ump45", // 13

	"ak47", //Rifles14
	"galil", // 15
	"famas", // 16
	"sg552", // 17
	"m4a1", // 18
	"aug", // 19
	"scout", // 20
	"awp", // 21
	"g3sg1", // 22
	"sg550", // 23

	"m249", //Machine Gun 24

	//"vest", //Equipment
	//"vesthelm",
	//"flash",
	//"hegren",
	//"sgren",
	//"defuser",
	//"nvgs", never block
	"shield", // 25

	// This buys ammo to limit
	"primammo", //Ammo26
	"secammo" // 27
}
new const g_Aliases2[WEAPONSTOBLOCK][] = {
	"km45", //Pistols
	"9x19mm",
	"nighthawk",
	"228compact",
	"elites",
	"fiveseven",

	"12gauge", //Shotguns
	"autoshotgun",

	"smg", //SMG
	"mp",
	"c90",
	"mac10",
	"ump45",

	"cv47", //Rifles
	"defender",
	"clarion",
	"krieg552",
	"m4a1",
	"bullpup",
	"scout",
	"magnum",
	"d3au1",
	"krieg550",

	"m249", //Machine Gun

	//"vest", //Equipment
	//"vesthelm",
	//"flash",
	//"hegren",
	//"sgren",
	//"defuser",
	//"nvgs",
	"shield",

	// This buys just a clip of each ammo
	"buyammo1", //Ammo
	"buyammo2"
}
// Global vars above

public client_command(id) {
	if (!g_weaponArena)
		return PLUGIN_CONTINUE

	new command[13]

	// Longest buy command has 11 chars so if command is longer then don't care
	if (read_argv(0, command, 12) > 11)
		return PLUGIN_CONTINUE

	//new CsTeams:team = cs_get_user_team(id)
	for (new i = 0; i < WEAPONSTOBLOCK; i++) {
		if (equali(g_Aliases[i], command) ||
			equali(g_Aliases2[i], command))
		{
			// This is a buy command of a possibly restricted weapon. Block if this isn't the current arena weapon.
			client_print(id, print_center, "You can't buy that during Weapon Arena!")
			//server_print("%d tries to buy a %s, blocking it...", id, command)
			return PLUGIN_HANDLED
		}
	}


	return PLUGIN_CONTINUE
}

bool:authorized(id) {
	return (g_authorized & (1<<id-1)) ? true : false
}

public client_connect(id) {
	g_authorized &= ~(1<<(id-1))
}

public client_authorized(id) {
	g_authorized |= (1<<(id-1))
}

public unsetblockforceweapon(id) {
	g_blockforceweapon[id] = false
}

public newround_event(id) {
	// Is WA on and is player alive?
	if (!g_weaponArena || !is_user_alive(id))
		return PLUGIN_CONTINUE

	g_blockforceweapon[id] = true
	set_task(0.5, "unsetblockforceweapon", id)

	if (get_cvar_num("weaponarena_invisibleweapons") == 1 && !g_hidThisRound && !g_randomWeapon) {
		set_task(0.1, "HideWeapons") // only do this once, do it after a short time or it won't hide stuff somehow
		g_hidThisRound = true
	}

	if (g_randomWeapon && !g_randomizedThisRound) {
		g_randomizedThisRound = true
		randomize(0)
	}

	if (!g_initedGives) {
		InitGives()
		g_initedGives = true
	}

	// Give WA weapon, if id already doesn't have it.
	new idd[1]
	idd[0] = id

	new Float:delay = get_cvar_float("weaponarena_delay")

	if (delay <= 0.0) {
		delay = str_to_float(DEFAULTDELAY)
		set_cvar_float("weaponarena_delay", delay)
	}

	set_task(delay, "newround_event2", 3526735 + id, idd, 1)

	return PLUGIN_CONTINUE
}

public newround_event2(idd[]) {
	new id = idd[0]
	if (!is_user_connected(id)) return
	new CsTeams:lteam = cs_get_user_team(id)
	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) return

	if (giveIfHasnt(id)) {
		//client_print(id, print_chat, "DEBUG: Gave you wpn because of new round")
	}
	if (g_waWeapon[int:lteam] == CSW_KNIFE)
		set_task(0.0, "delayedholdknife", id)
	//else
		//client_print(id, print_chat, "DEBUG: Didn't give you wpn because of new round")
	switch (get_cvar_num("weaponarena_unlimitedammo")) {
		case 0: giveAmmo(id)
		case 2: giveAmmo(id)
	}

	new clip, ammo
	if (get_user_weapon(id,clip,ammo) != g_waWeapon[int:lteam]) {
		set_task(0.1, "holdwaweapon", id) //holdwaweapon(id)
	}
}

public delayedholdknife(id) {
	engclient_cmd(id, "weapon_knife") // Force to hold knife
}

public holdwaweapon(id) {

	if (!is_user_alive(id)) return

	new CsTeams:lteam = cs_get_user_team(id)
	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) return

	engclient_cmd(id, g_weaponString[int:lteam])
}

stock setweaponnoreload(index) {
	set_pdata_int(index, 49, 0)
}

changeWeaponRandomSpecific(newWeapon, const TEAM) {
	if (newWeapon < 1 || newWeapon > 30
	|| newWeapon == CSW_C4
	|| newWeapon == CSW_SMOKEGRENADE
	|| newWeapon == CSW_FLASHBANG) {
		// Bad weapon type, does not change.
		//console_print(ifd,"[AMXX] ERROR: Bad weapon type (%d is out of bounds)",newWeapon)
		return 0
	}
	else {
		g_waWeapon[TEAM] = newWeapon
		setWpnString(TEAM)

		return 1
	}

	return 0
}

randomize(giveNewWeapon) {
	new newWeapon
	// Count nr of random weapons enabled and put them into array
	new nrOfRandomWeapons, randomlist[30]

	for (new i = 1, j = 0; i <= 30; i++) {
		if (i == CSW_C4 || i == CSW_SHIELD || i == CSW_FLASHBANG || i == CSW_SMOKEGRENADE)
			continue

		if (g_randomflags & (1<<j))
			randomlist[nrOfRandomWeapons++] = i
		j++
	}

	for (new lteam = 1; lteam < 3; lteam++) {
		new previousWaWeapon = g_waWeapon[lteam]
		if (nrOfRandomWeapons == 0)
			newWeapon = CSW_KNIFE // error, set knife :-)
		else {
			do {
				newWeapon = randomlist[random_num(1, nrOfRandomWeapons) - 1]
			}
			while(nrOfRandomWeapons > 1 && newWeapon == previousWaWeapon) // never change to the one we previously had...
		}

		if (!changeWeaponRandomSpecific(newWeapon, lteam)) {
			client_print(0, print_chat, "WEAPON ARENA ERROR: Couldn't set new random weapon :-(")
			console_print(0, "WEAPON ARENA ERROR: Couldn't set new random weapon :-(  ")
		}
		if (newWeapon == CSW_HEGRENADE) {
			break
		}

		// Set same weapon for the other team if not team specific wpns...
		if (!get_cvar_num(CVAR_RANDOMTEAMSPECIFIC)) {
			if (!changeWeaponRandomSpecific(newWeapon, lteam + 1)) {
				client_print(0, print_chat, "WEAPON ARENA ERROR: Couldn't set new random weapon :-(")
				console_print(0, "WEAPON ARENA ERROR: Couldn't set new random weapon :-(  ")
			}
			break
		}
	}

	new parm[2]
	parm[0] = 0
	parm[1] = giveNewWeapon
	set_task(0.5,"RunChanged",235262,parm,2)
}

public RunChanged(parm[]) {
	changed(parm[0],parm[1])
}

new const g_ALLOWEDSHIELDWEAPONS[5] = {CSW_USP, CSW_GLOCK18, CSW_P228, CSW_FIVESEVEN, CSW_DEAGLE}

GiveShieldAndPistol(id)
{

	//Make them drop all weapons to make this easier

	new all_weapons[32], numweap
	get_user_weapons(id,all_weapons,numweap)
	for (new x = 0; x < numweap; x++) {
		if (all_weapons[x] == CSW_C4 || all_weapons[x] == CSW_KNIFE) continue
		engclient_cmd(id, "drop", g_weaponstrings[all_weapons[x]])
	}

	//This native has some issues
	//strip_user_weapons(id)

	set_task(0.2,"GiveShieldAndPistol2",id)
}

public GiveShieldAndPistol2(id)
{
	//Give him a random allowed weapon before we give shield.
	new randomAllowedWeapon = g_ALLOWEDSHIELDWEAPONS[random_num(0,4)] // Randomize a pistol

	give_item(id, g_weaponstrings[randomAllowedWeapon]) // Give it
	engclient_cmd(id, g_weaponstrings[randomAllowedWeapon]) // Make sure to hold it...

	new ua_var = get_cvar_num("weaponarena_unlimitedammo")

	if (ua_var == 0 || ua_var == 2) {
		cs_set_user_bpammo(id,randomAllowedWeapon,getMaxBPAmmo(randomAllowedWeapon))
	}

	give_item(id, g_weaponstrings[CSW_SHIELD]) // Give shield...

	//set_task(1.9, "DelayedGive", id)
}

public DelayedGive(id) {
	//client_print(0, print_chat, "(DGA)")
	giveIfHasnt(id)
}

public giveIfHasnt(id) {
	// DEBUG EXTRA SAFETY THING ADDED
	if (!is_user_alive(id)) return 0
	// DEBUG EXTRA SAFETY THING ADDED

	new CsTeams:lteam = cs_get_user_team(id)

	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) {
		return PLUGIN_CONTINUE
	}

	// Don't give a knife! (well, technically we *can* give a knife... but probably will not be needed ever)
	if (g_waWeapon[int:lteam] == CSW_KNIFE) {
		return 0
	}

	new gave = 0
	new wpnList[32]
	new number

	new tempName[33]
	get_user_name(id, tempName, 32)

	if (g_waWeapon[int:lteam] == CSW_SHIELD) {

		if (cs_get_user_shield(id)){

			new ua_var = get_cvar_num("weaponarena_unlimitedammo")
			new clip,ammo,wpnid = get_user_weapon(id,clip,ammo)

			if (ua_var == 0 || ua_var == 2) {
				cs_set_user_bpammo(id,wpnid,getMaxBPAmmo(wpnid))
			}

			return 0
		}
		else {
			GiveShieldAndPistol(id)
			gave = 1
		}
	}
	else {
		get_user_weapons(id, wpnList, number)
		for (new i = 0; i < number; i++) {
			if (wpnList[i] == g_waWeapon[int:lteam])
			{
				//client_print(0,print_chat,"%s already has the right weapon, won't give",tempName);
				return 0
			}
		}
	}

	if (g_hadThisRound[id] < MAXGIVEWEAPONS) {
		g_hadThisRound[id]++

		//Drop all other weapons first
		new all_weapons[32], numweap
		get_user_weapons(id,all_weapons,numweap)
		for (new x = 0; x < numweap; x++) {
			if (all_weapons[x] == CSW_C4 || all_weapons[x] == CSW_KNIFE || all_weapons[x] == g_waWeapon[int:lteam]) continue
			engclient_cmd(id, "drop", g_weaponstrings[all_weapons[x]])
		}

		give_item(id, g_weaponString[int:lteam])
		gave = 1
	}
	//else
		//client_print(0,print_chat,"Naaah %s already has received %d weapons this round... max is %d",tempName,g_hadThisRound[id],MAXGIVEWEAPONS)


	return gave
}

public setWpnString(const TEAM) {
	if (TEAM == 0) {
		for (new i = 1; i < 3; i++) {
			switch (g_waWeapon[i]) {
				case CSW_P228           : g_weaponString[i] = "weapon_p228"
				case CSW_SHIELD			: g_weaponString[i] = "weapon_shield"
				case CSW_SCOUT          : g_weaponString[i] = "weapon_scout"
				case CSW_HEGRENADE      : g_weaponString[i] = "weapon_hegrenade"
				case CSW_XM1014         : g_weaponString[i] = "weapon_xm1014"
				case CSW_MAC10          : g_weaponString[i] = "weapon_mac10"
				case CSW_AUG            : g_weaponString[i] = "weapon_aug"
				case CSW_ELITE			: g_weaponString[i] = "weapon_elite"
				case CSW_FIVESEVEN		: g_weaponString[i] = "weapon_fiveseven"
				case CSW_UMP45			: g_weaponString[i] = "weapon_ump45"
				case CSW_SG550			: g_weaponString[i] = "weapon_sg550"
				case CSW_GALIL			: g_weaponString[i] = "weapon_galil"
				case CSW_FAMAS			: g_weaponString[i] = "weapon_famas"
				case CSW_USP			: g_weaponString[i] = "weapon_usp"
				case CSW_GLOCK18		: g_weaponString[i] = "weapon_glock18"
				case CSW_AWP			: g_weaponString[i] = "weapon_awp"
				case CSW_MP5NAVY		: g_weaponString[i] = "weapon_mp5navy"
				case CSW_M249			: g_weaponString[i] = "weapon_m249"
				case CSW_M3				: g_weaponString[i] = "weapon_m3"
				case CSW_M4A1			: g_weaponString[i] = "weapon_m4a1"
				case CSW_TMP			: g_weaponString[i] = "weapon_tmp"
				case CSW_G3SG1			: g_weaponString[i] = "weapon_g3sg1"
				case CSW_DEAGLE			: g_weaponString[i] = "weapon_deagle"
				case CSW_SG552			: g_weaponString[i] = "weapon_sg552"
				case CSW_AK47			: g_weaponString[i] = "weapon_ak47"
				case CSW_KNIFE			: g_weaponString[i] = "weapon_knife"
				case CSW_P90			: g_weaponString[i] = "weapon_p90"
				default					: {
					// bad weapon type, mega error, quit quit!
				}
			}
			switch (g_waWeapon[i]) {
				case CSW_P228           : g_ammoString[i] = "ammo_357sig"
				case CSW_SCOUT          : g_ammoString[i] = "ammo_762nato"
				case CSW_HEGRENADE		: g_ammoString[i] = "NadesDontHaveAmmo?"
				case CSW_XM1014         : g_ammoString[i] = "ammo_buckshot"
				case CSW_MAC10          : g_ammoString[i] = "ammo_45acp"
				case CSW_AUG            : g_ammoString[i] = "ammo_556nato"
				case CSW_ELITE			: g_ammoString[i] = "ammo_9mm"
				case CSW_FIVESEVEN		: g_ammoString[i] = "ammo_57mm"
				case CSW_UMP45			: g_ammoString[i] = "ammo_45acp"
				case CSW_SG550			: g_ammoString[i] = "ammo_556nato"
				case CSW_GALIL			: g_ammoString[i] = "ammo_556nato"
				case CSW_FAMAS			: g_ammoString[i] = "ammo_556nato"
				case CSW_USP			: g_ammoString[i] = "ammo_45acp"
				case CSW_GLOCK18		: g_ammoString[i] = "ammo_9mm"
				case CSW_AWP			: g_ammoString[i] = "ammo_338magnum"
				case CSW_MP5NAVY		: g_ammoString[i] = "ammo_9mm"
				case CSW_M249			: g_ammoString[i] = "ammo_556natobox"
				case CSW_M3				: g_ammoString[i] = "ammo_buckshot"
				case CSW_M4A1			: g_ammoString[i] = "ammo_556nato"
				case CSW_TMP			: g_ammoString[i] = "ammo_9mm"
				case CSW_G3SG1			: g_ammoString[i] = "ammo_762nato"
				case CSW_DEAGLE			: g_ammoString[i] = "ammo_50ae"
				case CSW_SG552			: g_ammoString[i] = "ammo_556nato"
				case CSW_AK47			: g_ammoString[i] = "ammo_762nato"
				case CSW_P90			: g_ammoString[i] = "ammo_57mm"
				default					: {
					// bad weapon type, mega error, quit quit! (or it doesn't have ammo)
				}
			}
		}
		return // return after changing both teams' strings
	}
	switch (g_waWeapon[TEAM]) {
		case CSW_P228           : g_weaponString[TEAM] = "weapon_p228"
		case CSW_SHIELD			: g_weaponString[TEAM] = "weapon_shield"
		case CSW_SCOUT          : g_weaponString[TEAM] = "weapon_scout"
		case CSW_XM1014         : g_weaponString[TEAM] = "weapon_xm1014"
		case CSW_MAC10          : g_weaponString[TEAM] = "weapon_mac10"
		case CSW_AUG            : g_weaponString[TEAM] = "weapon_aug"
		case CSW_ELITE			: g_weaponString[TEAM] = "weapon_elite"
		case CSW_FIVESEVEN		: g_weaponString[TEAM] = "weapon_fiveseven"
		case CSW_UMP45			: g_weaponString[TEAM] = "weapon_ump45"
		case CSW_SG550			: g_weaponString[TEAM] = "weapon_sg550"
		case CSW_GALIL			: g_weaponString[TEAM] = "weapon_galil"
		case CSW_FAMAS			: g_weaponString[TEAM] = "weapon_famas"
		case CSW_USP			: g_weaponString[TEAM] = "weapon_usp"
		case CSW_GLOCK18		: g_weaponString[TEAM] = "weapon_glock18"
		case CSW_AWP			: g_weaponString[TEAM] = "weapon_awp"
		case CSW_MP5NAVY		: g_weaponString[TEAM] = "weapon_mp5navy"
		case CSW_M249			: g_weaponString[TEAM] = "weapon_m249"
		case CSW_M3				: g_weaponString[TEAM] = "weapon_m3"
		case CSW_M4A1			: g_weaponString[TEAM] = "weapon_m4a1"
		case CSW_TMP			: g_weaponString[TEAM] = "weapon_tmp"
		case CSW_G3SG1			: g_weaponString[TEAM] = "weapon_g3sg1"
		case CSW_DEAGLE			: g_weaponString[TEAM] = "weapon_deagle"
		case CSW_SG552			: g_weaponString[TEAM] = "weapon_sg552"
		case CSW_AK47			: g_weaponString[TEAM] = "weapon_ak47"
		case CSW_KNIFE			: g_weaponString[TEAM] = "weapon_knife"
		case CSW_P90			: g_weaponString[TEAM] = "weapon_p90"
		default					: {
			// bad weapon type, mega error, quit quit!
		}
	}
	switch (g_waWeapon[TEAM]) {
		case CSW_P228           : g_ammoString[TEAM] = "ammo_357sig"
		case CSW_SCOUT          : g_ammoString[TEAM] = "ammo_762nato"
		case CSW_XM1014         : g_ammoString[TEAM] = "ammo_buckshot"
		case CSW_MAC10          : g_ammoString[TEAM] = "ammo_45acp"
		case CSW_AUG            : g_ammoString[TEAM] = "ammo_556nato"
		case CSW_ELITE			: g_ammoString[TEAM] = "ammo_9mm"
		case CSW_FIVESEVEN		: g_ammoString[TEAM] = "ammo_57mm"
		case CSW_UMP45			: g_ammoString[TEAM] = "ammo_45acp"
		case CSW_SG550			: g_ammoString[TEAM] = "ammo_556nato"
		case CSW_GALIL			: g_ammoString[TEAM] = "ammo_556nato"
		case CSW_FAMAS			: g_ammoString[TEAM] = "ammo_556nato"
		case CSW_USP			: g_ammoString[TEAM] = "ammo_45acp"
		case CSW_GLOCK18		: g_ammoString[TEAM] = "ammo_9mm"
		case CSW_AWP			: g_ammoString[TEAM] = "ammo_338magnum"
		case CSW_MP5NAVY		: g_ammoString[TEAM] = "ammo_9mm"
		case CSW_M249			: g_ammoString[TEAM] = "ammo_556natobox"
		case CSW_M3				: g_ammoString[TEAM] = "ammo_buckshot"
		case CSW_M4A1			: g_ammoString[TEAM] = "ammo_556nato"
		case CSW_TMP			: g_ammoString[TEAM] = "ammo_9mm"
		case CSW_G3SG1			: g_ammoString[TEAM] = "ammo_762nato"
		case CSW_DEAGLE			: g_ammoString[TEAM] = "ammo_50ae"
		case CSW_SG552			: g_ammoString[TEAM] = "ammo_556nato"
		case CSW_AK47			: g_ammoString[TEAM] = "ammo_762nato"
		case CSW_P90			: g_ammoString[TEAM] = "ammo_57mm"
		default					: {
			// bad weapon type, mega error, quit quit! (or it doesn't have ammo)
		}
	}
}

stock printstringbyline(const STRING[]) {
	const SIZE = 78
	new tempstring[SIZE + 2], len = 0
	new const STRINGLEN = strlen(STRING)

	for (new i = 0; i <= STRINGLEN; i++) {
		if (STRING[i] != '^n' && len <= SIZE && i != STRINGLEN)
			tempstring[len++] = STRING[i]
		else {
			tempstring[len] = 0
			console_print(0, tempstring)
			tempstring = ""
			len = 0
			if (i == STRINGLEN)
				break
			else if (STRING[i] != '^n')
				i--
		}
	}
}

public toggle(id,level,cid) {
	if (!cmd_access(id,level,cid,2)) {
		return PLUGIN_HANDLED
	}

	new bool:originalState = g_weaponArena
	new oldWeapon = g_waWeapon[1] // TO DO: check this later :-)

	if (read_argc() != 2) {
		console_print(id,"[AMXX] ERROR: Use - amx_weaponarena <weaponnumber|list|off|random>")
		return PLUGIN_HANDLED
	}

	new argument[7]
	read_argv(1,argument,6)
	strtolower(argument)
	//console_print(id,"%s",argument)
	if (equal(argument,"off")) {
		if (!g_weaponArena) {
			console_print(id,"[AMXX] ERROR: Weapon Arena is already off.")
			g_randomWeapon = false
			return PLUGIN_HANDLED
		}
		else {
			g_randomWeapon = false
			g_weaponArena = false
		}
	}
	else if (equal(argument, "list")) {
		if (id >= 1 && id <= 32) {

				console_print(id, "Close your console, the list is being displayed in a MOTD Box")

				new len = 1024
				new buffer[1025]
				new n = 0

				#if !defined NO_STEAM
					n += format( buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
				#endif

				n += copy( buffer[n],len-n, g_WEAPONNUMBERS)

				#if !defined NO_STEAM
					n += copy( buffer[n],len-n,"</pre></body></html>")
				#endif

				show_motd(id, buffer, "Weapon Arena")
		}
		else {
			printstringbyline(g_WEAPONNUMBERS)
			//server_print(g_WEAPONNUMBERS)
		}
	}
	else if (equal(argument, "random")) {
		SwitchRandom(id)
	}
	else {
		new wpnNumber = str_to_num(argument)
		g_randomWeapon = false
		if (changeWeapon(id, wpnNumber)) // TO DO: check this later
			g_weaponArena = true
		else {
			console_print(id, "ERROR: Use - amx_weaponarena <weaponnumber|list|off|random>")
		}
	}

	if (originalState != g_weaponArena) {
		if (g_weaponArena) {
			// Activate
			activate(id)
		}
		else {
			disabled(id)
		}
	}
	else if (oldWeapon != g_waWeapon[1]) { // TO DO: Check this later
		changed(id,1)
	}

	return PLUGIN_HANDLED
}

activate(id) {

	new CsTeams:lteam
	if (id != 0)
		lteam = cs_get_user_team(id)
	else
		lteam = CS_TEAM_T

	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT)
		lteam = CS_TEAM_T

	set_hudmessage(0, 100, 0, -1.0, 0.65, 2, 0.02, 10.0, 0.01, 0.1, -1)
	ShowSyncHudMsg(0, g_MsgSync, "%c%s Arena is enabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
	client_print(id,print_console,"%c%s Arena was enabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
	console_print(0,"%c%s Arena was enabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])

	giveAllIfHavent()

	// Hide all other weapons
	if (get_cvar_num("weaponarena_invisibleweapons") == 1)
		HideWeapons()
}

public HideWeapons() {
	// Search weaponboxes and check their models. Real weaponmodelstring should be "models/w_fiveseven.mdl" if classname is weapon_fiveseven

	const SIZE = 63
	new matchmodelstring[2][SIZE + 1]

	new bool:teamspecific = get_cvar_num(CVAR_RANDOMTEAMSPECIFIC) ? true : false


	format(matchmodelstring[0], SIZE, "models/w_%s.mdl", g_weaponString[1][7])

	if (g_randomWeapon && teamspecific) {
		format(matchmodelstring[1], SIZE, "models/w_%s.mdl", g_weaponString[2][7])
		//client_print(0, print_chat, "HideWeapons() %s and %s", g_weaponString[1][7], g_weaponString[2][7])
	}
	/*
	else
		client_print(0, print_chat, "HideWeapons() %s", g_weaponString[1][7])
	*/

	new ent = 0, model[128], boxes = 0, armouries = 0


	if (g_randomWeapon && teamspecific) {
		// Hide weaponboxes here

		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "weaponbox"))) {
			pev(ent, pev_model, model, 127)
			if (equal(model, "models/w_backpack.mdl"))
				continue

			//server_print("weaponbox %d Read model: ^"%s^"", ent, model)
			if (!equal(matchmodelstring[0], model) && !equal(matchmodelstring[1], model)) {
				//server_print("%s doesn't equal what it should be: %s", model, matchmodelstring)
				set_pev(ent, pev_effects, pev(ent, pev_effects) | EF_NODRAW)
				//entity_set_int(ent, EV_INT_solid, SOLID_NOT) // not needed to unsolidify because of block is done in FM_Touch!
				boxes++
			}
		}

		// Hide armouries here

		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "armoury_entity"))) {
			pev(ent, pev_model, model, 127)
			//server_print("armoury_entity %d Read model: ^"%s^"", ent, model)
			if (!equal(matchmodelstring[0], model) && !equal(matchmodelstring[1], model)) {
				//server_print("%s doesn't equal what it should be: %s", model, matchmodelstring)
				set_pev(ent, pev_effects, pev(ent, pev_effects) | EF_NODRAW)
				//entity_set_int(ent, EV_INT_solid, SOLID_NOT)  // not needed to unsolidify because of block is done in FM_Touch!
				armouries++
			}
		}
	}
	else {
		// Hide weaponboxes here

		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "weaponbox"))) {
			pev(ent, pev_model, model, 127)
			if (equal(model, "models/w_backpack.mdl"))
				continue

			//server_print("weaponbox %d Read model: ^"%s^"", ent, model)
			if (!equal(matchmodelstring[0], model)) {
				//server_print("%s doesn't equal what it should be: %s", model, matchmodelstring)
				set_pev(ent, pev_effects, pev(ent, pev_effects) | EF_NODRAW)
				//entity_set_int(ent, EV_INT_solid, SOLID_NOT)  // not needed to unsolidify because of block is done in FM_Touch!
				boxes++
			}
		}

		// Hide armouries here
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "armoury_entity"))) {
			pev(ent, pev_model, model, 127)
			//server_print("armoury_entity %d Read model: ^"%s^"", ent, model)
			if (!equal(matchmodelstring[0], model)) {
				//server_print("%s doesn't equal what it should be: %s", model, matchmodelstring)
				set_pev(ent, pev_effects, pev(ent, pev_effects) | EF_NODRAW)
				//entity_set_int(ent, EV_INT_solid, SOLID_NOT) // not needed to unsolidify because of block is done in FM_Touch!
				armouries++
			}
		}
	}
}

public HideOneWeapon(ent[1]) {
	//new weaponString2[32]
	//get_weaponname(wti[0], weaponString2, 31)
	//return find_ent_by_owner(0, weaponString, ownerId)

	if (!pev_valid(ent[0]))
		return

	new owner = pev(ent[0], pev_owner)
	if ((owner >= 1 && owner <= g_maxclients) || owner == 0)
		set_task(0.1, "HideOneWeapon", ent[0], ent, 1) // loop until owner has become a weaponbox
	else {
		// this should be a weaponbox, double check this..?
		if (!pev_valid(owner))
			return

		new ownerclassname[64]
		pev(owner, pev_classname, ownerclassname, 63)
		if (!equal(ownerclassname, "weaponbox")) {
			//client_print(0, print_chat, "Error, the dropped weapon's owner is not a weaponbox (maybe someone picked it up) owner is a: %s", ownerclassname)
			return
		}
		// Now hide this weaponbox
		set_pev(owner, pev_effects, pev(owner, pev_effects) | EF_NODRAW)
		//entity_set_int(owner, EV_INT_solid, SOLID_NOT) // not needed to unsolidify because of block is done in FM_Touch!
	}
}

ShowWeapons() {
	new ent = 0
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "weaponbox"))) {
		set_pev(ent, pev_effects, pev(ent, pev_effects) & ~EF_NODRAW)
		//entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER) // not needed to unsolidify because of block is done in FM_Touch!
	}

	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "armoury_entity"))) {
		set_pev(ent, pev_effects, pev(ent, pev_effects) & ~EF_NODRAW)
		//entity_set_int(ent, EV_INT_solid, SOLID_TRIGGER) // not needed to unsolidify because of block is done in FM_Touch!
	}
}

InitGives()
{
	for (new i = 1;i <= 32;i++)
		g_hadThisRound[i] = 0

	//client_print(0,print_center,"inited gives")
}

public giveAllIfHavent() {

	if (g_waWeapon[1] == CSW_HEGRENADE) {
		// Collect all alive players and give'm a nade if they dont have one.
		new playersList[32]
		new playersFound
		get_players(playersList,playersFound,"a")

		for (new i = 0; i < playersFound; i++) {
			giveheifnothas(playersList[i])
		}
		return
	}

	// Init amount of weapons given to people this round...
	InitGives()

	// Collect all alive players and give'm a weapon if they
	// already not have one.
	new playersList[32]
	new playersFound
	get_players(playersList, playersFound, "a")
	//console_print(0,"Found %d players  ",playersFound)
	new clip, ammo
	new CsTeams:lteam
	for (new i = 0; i < playersFound; i++) {

		if (giveIfHasnt(playersList[i])) {
			switch (get_cvar_num("weaponarena_unlimitedammo")) {
				case 0: giveAmmo(playersList[i])
				case 2: giveAmmo(playersList[i])
			}
		}

		lteam = cs_get_user_team(playersList[i])

		if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) continue

		if (get_user_weapon(playersList[i], clip, ammo) != g_waWeapon[int:lteam])
			holdwaweapon(playersList[i])
	}
}

public changed(id, giveNewWeapon) {

	InitGives()

	set_hudmessage(0, 100, 0, -1.0, 0.65, 2, 0.02, 10.0, 0.01, 0.1, -1)


	/*new CsTeams:lteam
	lteam = cs_get_user_team(id)
	*/
	if (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC)) {
		ShowSyncHudMsg(id, g_MsgSync, "Changed to %c%s and %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
		client_print(id, print_console, "Changed to %c%s and %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
		console_print(0,"Changed to %c%s and %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
	}
	else {
		ShowSyncHudMsg(id, g_MsgSync, "Changed to %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8])
		client_print(id, print_console, "Changed to %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8])
		console_print(0,"Changed to %c%s Arena!  ", g_weaponString[1][7] - 32, g_weaponString[1][8])
	}

	if (get_cvar_num("weaponarena_invisibleweapons") == 1) {
		ShowWeapons() // First show all weapons
		HideWeapons() // Then hide all that aren't the new weapon
	}

	if (giveNewWeapon) {
		// Collect all alive players and give'm a weapon if they
		// already not have one.
		new playersList[32]
		new playersFound, clip, ammo
		new CsTeams:team
		get_players(playersList,playersFound,"a")
		for (new i = 0;i < playersFound;i++) {
			if (giveIfHasnt(playersList[i])) {
				switch (get_cvar_num("weaponarena_unlimitedammo")) {
					case 0: giveAmmo(playersList[i])
					case 2: giveAmmo(playersList[i])
				}
			}

			team = cs_get_user_team(playersList[i])

			if (team != CS_TEAM_T && team != CS_TEAM_CT) continue

			if (get_user_weapon(playersList[i],clip,ammo) != g_waWeapon[int:team])
				holdwaweapon(playersList[i])
		}
	}
}

disabled(id)
{
	set_hudmessage(0, 100, 0, -1.0, 0.65, 2, 0.02, 10.0, 0.01, 0.1, -1)

	new CsTeams:lteam
	if (is_user_connected(id)) {
		lteam = cs_get_user_team(id)
	}
	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) {
		lteam = CS_TEAM_T
	}

	if (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC)) {
		ShowSyncHudMsg(id, g_MsgSync, "%c%s and %c%s Arena is disabled!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
		client_print(id, print_console, "%c%s and %c%s Arena was disabled!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
		console_print(0,"%c%s and %c%s Arena was disabled!  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8])
	}
	else {
		ShowSyncHudMsg(id, g_MsgSync, "%c%s Arena is disabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
		client_print(id,print_console,"%c%s Arena was disabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
		console_print(0,"%c%s Arena was disabled!  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
	}

	ShowWeapons()
}

public giveAmmo(id) {
	// DEBUG EXTRA SAFETY THING ADDED
	if (!is_user_alive(id)) return
	// DEBUG EXTRA SAFETY THING ADDED

	new CsTeams:lteam = cs_get_user_team(id)

	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT) return

	new clips = 0
	switch (g_waWeapon[int:lteam]) {
		case CSW_P228           : clips = 4
		case CSW_SCOUT          : clips = 3
		case CSW_XM1014         : clips = 4
		case CSW_MAC10          : clips = 9
		case CSW_AUG            : clips = 3
		case CSW_ELITE			: clips = 4
		case CSW_FIVESEVEN		: clips = 2
		case CSW_UMP45			: clips = 9
		case CSW_SG550			: clips = 3
		case CSW_GALIL			: clips = 3
		case CSW_FAMAS			: clips = 3
		case CSW_USP			: clips = 9
		case CSW_GLOCK18		: clips = 4
		case CSW_AWP			: clips = 3
		case CSW_MP5NAVY		: clips = 4
		case CSW_M249			: clips = 7
		case CSW_M3			: clips = 4
		case CSW_M4A1			: clips = 3
		case CSW_TMP			: clips = 4
		case CSW_G3SG1			: clips = 3
		case CSW_DEAGLE		: clips = 5
		case CSW_SG552			: clips = 3
		case CSW_AK47			: clips = 3
		case CSW_P90			: clips = 2
	}

	for (new i = 0; i < clips; i++)
		give_item(id, g_ammoString[int:lteam])
}

public giveAmmoWTI(id, weaponTypeId) {
	// DEBUG EXTRA SAFETY THING ADDED
	if (!is_user_connected(id) || !is_user_alive(id))
		return
	// DEBUG EXTRA SAFETY THING ADDED

	new clips = 0
	switch (weaponTypeId) {
		case CSW_P228           : clips = 4
		case CSW_SCOUT          : clips = 3
		case CSW_XM1014         : clips = 4
		case CSW_MAC10          : clips = 9
		case CSW_AUG            : clips = 3
		case CSW_ELITE			: clips = 4
		case CSW_FIVESEVEN		: clips = 2
		case CSW_UMP45			: clips = 9
		case CSW_SG550			: clips = 3
		case CSW_GALIL			: clips = 3
		case CSW_FAMAS			: clips = 3
		case CSW_USP			: clips = 9
		case CSW_GLOCK18		: clips = 4
		case CSW_AWP			: clips = 3
		case CSW_MP5NAVY		: clips = 4
		case CSW_M249			: clips = 7
		case CSW_M3				: clips = 4
		case CSW_M4A1			: clips = 3
		case CSW_TMP			: clips = 4
		case CSW_G3SG1			: clips = 3
		case CSW_DEAGLE			: clips = 5
		case CSW_SG552			: clips = 3
		case CSW_AK47			: clips = 3
		case CSW_P90			: clips = 2
		default					: return
	}

	new ammostrings[64]

	switch (weaponTypeId) {
		case CSW_P228           : ammostrings = "ammo_357sig"
		case CSW_SCOUT          : ammostrings = "ammo_762nato"
		case CSW_XM1014         : ammostrings = "ammo_buckshot"
		case CSW_MAC10          : ammostrings = "ammo_45acp"
		case CSW_AUG            : ammostrings = "ammo_556nato"
		case CSW_ELITE			: ammostrings = "ammo_9mm"
		case CSW_FIVESEVEN		: ammostrings = "ammo_57mm"
		case CSW_UMP45			: ammostrings = "ammo_45acp"
		case CSW_SG550			: ammostrings = "ammo_556nato"
		case CSW_GALIL			: ammostrings = "ammo_556nato"
		case CSW_FAMAS			: ammostrings = "ammo_556nato"
		case CSW_USP			: ammostrings = "ammo_45acp"
		case CSW_GLOCK18		: ammostrings = "ammo_9mm"
		case CSW_AWP			: ammostrings = "ammo_338magnum"
		case CSW_MP5NAVY		: ammostrings = "ammo_9mm"
		case CSW_M249			: ammostrings = "ammo_556natobox"
		case CSW_M3				: ammostrings = "ammo_buckshot"
		case CSW_M4A1			: ammostrings = "ammo_556nato"
		case CSW_TMP			: ammostrings = "ammo_9mm"
		case CSW_G3SG1			: ammostrings = "ammo_762nato"
		case CSW_DEAGLE			: ammostrings = "ammo_50ae"
		case CSW_SG552			: ammostrings = "ammo_556nato"
		case CSW_AK47			: ammostrings = "ammo_762nato"
		case CSW_P90			: ammostrings = "ammo_57mm"
		default					: return
	}

	for (new i = 0;i < clips;i++)
		give_item(id, ammostrings)
}

public dropweapon(id) {
	if (is_user_connected(id) && is_user_alive(id)) {
		new idd[1]
		idd[0] = id

		set_task(0.1, "seconddropcheck", 0, idd, 1) // trying to do this directly instead
	}
}

public seconddropcheck(idd[]) {
	new id = idd[0], _clip, _ammo
	new weaponTypeId = get_user_weapon(id, _clip, _ammo)
	new CsTeams:lteam = cs_get_user_team(id)

	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT)
		return PLUGIN_CONTINUE

	if (weaponTypeId == g_waWeapon[int:lteam]) {
		//client_print(id, print_chat, "(sdc) You hold %s, which %s the current WA weapon. (no drop)", weapontypetemptext[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		switch (get_cvar_num("weaponarena_unlimitedammo")) {
			case 1:
			{
				new clip, ammo
				get_user_ammo(id,weaponTypeId,clip,ammo)
				if (clip < 1) {
					if (is_user_connected(id) && is_user_alive(id)) {
						give_item(id, g_weaponString[int:lteam])
						holdwaweapon(id)
					}
				}
			}
			case 2:
			{
				new clip, ammo
				get_user_ammo(id,weaponTypeId,clip,ammo)
				if (clip < 1 && ammo == 0) {
					if (is_user_connected(id) && is_user_alive(id)) {
						giveAmmo(id)
						holdwaweapon(id)
					}
				}
			}
		}
	}
	else if (weaponTypeId == CSW_HEGRENADE
	|| weaponTypeId == CSW_SMOKEGRENADE
	|| weaponTypeId == CSW_FLASHBANG
	|| weaponTypeId == CSW_KNIFE
	|| weaponTypeId == CSW_C4) {
		//client_print(id, print_chat, "You hold %s, which %s the current WA weapon. (no drop)", weapontypetemptext[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		return PLUGIN_CONTINUE
	}
	else if (g_waWeapon[int:lteam] == CSW_SHIELD
	&& (weaponTypeId == CSW_USP
	|| weaponTypeId == CSW_GLOCK18
	|| weaponTypeId == CSW_P228
	|| weaponTypeId == CSW_FIVESEVEN
	|| weaponTypeId == CSW_DEAGLE)) {
		// Ok to hold a pistol/knife if shield arena (except berettas).
		// Check if reload is needed.
		checkreload(id, weaponTypeId)
		return PLUGIN_CONTINUE
	}
	else {
		//client_print(id, print_chat, "(sdc) You hold %s, which %s the current WA weapon. (drop)", weapondescriptions[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		if (get_cvar_num("weaponarena_holdknife") == FORCEACTION_HOLDKNIFE) {
			client_print(id, print_chat, "Don't hold that weapon! It's currently %c%s Arena! (forcing you to hold the knife)  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
			engclient_cmd(id, "weapon_knife")
		}
		else {
			// FORCEACTION_DROP
			//handledrop(id)
			client_print(id, print_chat, "Don't hold that weapon! It's currently %c%s Arena! (forcing you to drop it)  ", g_weaponString[int:lteam][7] - 32, g_weaponString[int:lteam][8])
			engclient_cmd(id, "drop", g_weaponstrings[weaponTypeId])
			holdwaweapon(id)
		}
	}

	return PLUGIN_CONTINUE
}

// find_wpn_ent_fast() returns 0 if failed (that is, if no wpn ent could be found
// among all "weapontext" weapons in the game.
// Description: Returns the weapon entity number, where weapon type is weapontext[] and ownerId is the owner.
find_wpnent_fast(ownerId, weaponTypeId) {

	if (weaponTypeId <= 0) return 0

	new weaponString2[20]
	get_weaponname(weaponTypeId, weaponString2, 19)
	g_lastweaponentity[ownerId] = 0

	new iWPNidx = -1
	while ((iWPNidx = engfunc(EngFunc_FindEntityByString, iWPNidx, "classname", weaponString2)) != 0) {
		if (ownerId == pev(iWPNidx, pev_owner)) {
			g_lastweaponentity[ownerId] = iWPNidx
			break
		}
	}

	return g_lastweaponentity[ownerId]
}

get_weaponentity(ownerId, weaponTypeId) {
	// Is last used weapon entity valid?
	// Is the owner of last weapon entity the same as ownerId?
	// Is the weapontype of last used weapon the same as supplied weapontypeid
	// In that case, this should be safe, and FASTER :-)
	if (pev_valid(g_lastweaponentity[ownerId]) && pev(g_lastweaponentity[ownerId], pev_owner) == ownerId && get_pdata_int(g_lastweaponentity[ownerId], OFFSET_WEAPON_TYPEID) == weaponTypeId)
		return g_lastweaponentity[ownerId]
	//else
	//client_print(ownerId, print_chat, "Looking for a new %s (%d)", weapondescriptions[weaponTypeId], weaponTypeId)
	return find_wpnent_fast(ownerId, weaponTypeId)
}

/*
EV_SZ_viewmodel = models/v_mac10.mdl = with arms
EV_SZ_weaponmodel = models/p_mac10.mdl = when on ground
EV_SZ_classname = weapon_mac10
*/

public holdwpn_event(id) {
	if (!g_weaponArena || !authorized(id))
		return PLUGIN_CONTINUE

	if (!is_user_alive(id)) return PLUGIN_CONTINUE

	if ( g_waWeapon[1] == CSW_HEGRENADE ) {
		set_task(0.1,"giveheifnothas",id)
		return PLUGIN_CONTINUE
	}

	new weaponTypeId = read_data(2)

	// Only valid weapons to hold are waWeapon, C4, knife, and grenades.
	new CsTeams:lteam = cs_get_user_team(id)

	if (lteam != CS_TEAM_T && lteam != CS_TEAM_CT)
		return PLUGIN_CONTINUE

	new CsTeams:otherteam = lteam == CS_TEAM_T ? CS_TEAM_CT : CS_TEAM_T
	if (weaponTypeId == g_waWeapon[int:lteam] || (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC) && get_cvar_num(CVAR_STEALRANDOMWEAPON) && weaponTypeId == g_waWeapon[int:otherteam])) {
		//client_print(id, print_chat, "You hold %s, which %s the current WA weapon. (no drop)", weapontypetemptext[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		switch (get_cvar_num("weaponarena_unlimitedammo")) {
			case 1:
			{
				new clip, ammo
				get_user_ammo(id, weaponTypeId, clip, ammo)

				if (clip >= 2)
					return PLUGIN_CONTINUE

				new weaponEntity = get_weaponentity(id, weaponTypeId)
				//new weaponEntity = find_wpnent_fast(id, weaponTypeId) // TO DO: (likely) performance hog :-P
				setweaponnoreload(weaponEntity)
				//new weaponEntity = find_wpnent_fast(id, weaponTypeId)
				if (weaponEntity > 0 && is_user_alive(id)) {
					//if (!is_linux_server())
						//set_offset(weaponEntity, OFFSET_CLIPAMMO, MAXAMMOINCLIP[weaponTypeId])
					//else
					//server_print("Reload: ent=%d, offset=%d, maxammo=%d wti=%d", weaponEntity, OFFSET_CLIPAMMO_LINUX, MAXAMMOINCLIP[weaponTypeId], weaponTypeId)
					//client_print(id, print_chat, "Reload: ent=%d, offset=%d, maxammo=%d wti=%d", weaponEntity, OFFSET_CLIPAMMO_LINUX, MAXAMMOINCLIP[weaponTypeId], weaponTypeId)
					//set_offset(weaponEntity, OFFSET_CLIPAMMO_LINUX, MAXAMMOINCLIP[weaponTypeId])
					cs_set_weapon_ammo(weaponEntity, MAXAMMOINCLIP[weaponTypeId] + 1)

					//client_print(id, print_chat, "Restocked ammo in clip")
					return PLUGIN_CONTINUE
				}
			}
			case 2:
			{
				new clip, ammo
				get_user_ammo(id,weaponTypeId,clip,ammo)
				if (clip < 1 && ammo == 0) {
					if (is_user_connected(id) && is_user_alive(id)) {
						giveAmmo(id)
						holdwaweapon(id)
					}
				}
			}
		}
	}
	else if (g_blockforceweapon[id] // don't force this person to hold any weapon. This is set when player spawns, unset 0.5 or so seconds later
	|| weaponTypeId == CSW_HEGRENADE
	|| weaponTypeId == CSW_SMOKEGRENADE
	|| weaponTypeId == CSW_FLASHBANG
	|| weaponTypeId == CSW_KNIFE
	|| weaponTypeId == CSW_C4) {
		//client_print(id, print_chat, "You hold %s, which %s the current WA weapon. (no drop)", weapontypetemptext[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		return PLUGIN_CONTINUE
	}
	else if (g_waWeapon[int:lteam] == CSW_SHIELD
	&& (weaponTypeId == CSW_USP
	|| weaponTypeId == CSW_GLOCK18
	|| weaponTypeId == CSW_P228
	|| weaponTypeId == CSW_FIVESEVEN
	|| weaponTypeId == CSW_DEAGLE
	|| weaponTypeId == CSW_KNIFE)) {
		// Ok to hold a pistol/knife if shield arena (except berettas).
		// Check if reload is needed.
		checkreload(id, weaponTypeId)
		return PLUGIN_CONTINUE
	}
	else {
		//client_print(id, print_chat, "[AMXX] Don't hold that weapon! It's currently %c%s Arena!", weaponString[7] - 32,weaponString[8])
		//client_print(id, print_chat, "You hold %s, which %s the current WA weapon. (recheck in 0.5)", weapondescriptions[weaponTypeId], (weaponTypeId == waWeapon) ? "is" : "is not")
		dropweapon(id)
		holdwaweapon(id)
	}

	return PLUGIN_CONTINUE
}

stock checkreload(id, weaponTypeId) {
	switch (get_cvar_num("weaponarena_unlimitedammo")) {
		case 1:
		{
			new clip, ammo
			get_user_ammo(id,weaponTypeId,clip,ammo)
			if (clip < 1) {
				if (is_user_connected(id) && is_user_alive(id)) {
					give_item(id, g_weaponstrings[weaponTypeId])
					holdwaweapon(id)
				}
			}
		}
		case 2:
		{
			new clip, ammo
			get_user_ammo(id,weaponTypeId,clip,ammo)
			if (clip < 1 && ammo == 0) {
				if (is_user_connected(id) && is_user_alive(id)) {
					giveAmmoWTI(id, weaponTypeId)
					holdwaweapon(id)
				}
			}
		}
	}
}

// Returns 0 on failure, 1 on success
public changeWeapon(id, newWeapon) {
	if (newWeapon < 1 || newWeapon > 30
	|| newWeapon == CSW_C4
	|| newWeapon == CSW_SMOKEGRENADE
	|| newWeapon == CSW_FLASHBANG) {
		// Bad weapon type, does not change.
		//console_print(ifd,"[AMXX] ERROR: Bad weapon type (%d is out of bounds)",newWeapon)
		return 0
	}
	else {

		g_waWeapon[1] = newWeapon // TO DO: Check this later.
		g_waWeapon[2] = newWeapon // TO DO: Check this later.
		setWpnString(0)

		return 1
	}

	return 0
}

public endround_event() {
	g_randomizedThisRound = false
	g_hidThisRound = false
	g_initedGives = false
}

public SwitchRandom(id) {
	(g_randomWeapon = !g_randomWeapon)

	if (g_randomWeapon) {
		set_hudmessage(0, 100, 0, -1.0, 0.35, 2, 0.02, 10.0, 0.01, 0.1, -1)
		show_hudmessage(0,"Weapon Arena will select random weapon on every new round!")
		client_print(id,print_console,"[AMXX] Weapon Arena will select random weapon on every new round!")
		console_print(0,"[AMXX] Weapon Arena will select random weapon on every new round!  ")

		if (!g_weaponArena) {
			g_weaponArena = true
		}

		randomize(0)

		giveAllIfHavent()
	}
	else {
		set_hudmessage(0, 100, 0, -1.0, 0.35, 2, 0.02, 10.0, 0.01, 0.1, -1)
		show_hudmessage(0,"Disabled Weapon Arena.")
		client_print(id,print_console,"[AMXX] Disabled Weapon Arena.")
		console_print(0,"[AMXX] Disabled Weapon Arena.  ")
	}
}

public wamenu1(id, level, cid) {
	if (!cmd_access(id, level, cid, 1))
		return PLUGIN_HANDLED

	menustarter(id)

	return PLUGIN_HANDLED
}

menustarter(id) {
	new disableLine[64]
	if (g_weaponArena) {
		if (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC))
			format(disableLine, 63, "8. Disable %c%s and %c%s Arena^n  ", g_weaponString[1][7] - 32, g_weaponString[1][8], g_weaponString[2][7] - 32, g_weaponString[2][8]) // TO DO: Check this later.
		else
			format(disableLine, 63, "8. Disable %c%s Arena^n  ", g_weaponString[1][7] - 32, g_weaponString[1][8]) // TO DO: Check this later.
	}

	new menuBody[512]
	new len = format(menuBody, 511, "\yWeapon Arena\R1/4^n^n\w") // \y \R \w
	len += format(menuBody[len],511-len,"1. P228^n2. Scout^n3. XM1014^n4. Mac10^n5. Aug^n6. Elite^n^n7. Random menu...^n%s9. More weapons...^n0. Exit", g_weaponArena ? disableLine : "")
	new flags = MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON6|MENUBUTTON7|MENUBUTTON9|MENUBUTTON0

	if (g_weaponArena)
		flags |= MENUBUTTON8

	show_menu(id, flags, menuBody)
}

wamenu2(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\yWeapon Arena\R2/4^n^n\w")
	len += format(menuBody[len],511-len,"1. Fiveseven^n2. UMP45^n3. SG550^n4. Galil^n5. Famas^n6. USP^n7. Glock18^n8. AWM^n^n9. More weapons...^n0. Back")
	new flags = MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON6|MENUBUTTON7|MENUBUTTON8|MENUBUTTON9|MENUBUTTON0
	show_menu(id, flags, menuBody)

	return PLUGIN_HANDLED
}

wamenu3(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\yWeapon Arena\R3/4^n^n\w")
	len += format(menuBody[len],511-len,"1. MP5Navy^n2. M249^n3. M3^n4. M4A1^n5. TMP^n6. G3SG1^n7. Desert eagle^n8. SG552^n^n9. More weapons...^n0. Back")
	show_menu(id,((1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<7)|(1<<8)|(1<<9)),menuBody)

	return PLUGIN_HANDLED
}

wamenu4(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\yWeapon Arena\R4/4^n^n\w")

	len += format(menuBody[len],511-len,"1. AK47^n2. Combat Knife^n3. P90^n4. Shield^n5. HE Grenade^n^n0. Back")
	new flags = MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON0

	show_menu(id, flags, menuBody)

	return PLUGIN_HANDLED
}

public menu_wa1(id, key)
{
	new bool:chose = true
	switch(key) {
		case MENUSELECT1: changeWeapon(id,CSW_P228)
		case MENUSELECT2: changeWeapon(id,CSW_SCOUT)
		case MENUSELECT3: changeWeapon(id,CSW_XM1014)
		case MENUSELECT4: changeWeapon(id,CSW_MAC10)
		case MENUSELECT5: changeWeapon(id,CSW_AUG)
		case MENUSELECT6: changeWeapon(id,CSW_ELITE)
		case MENUSELECT7: {
			/*
			new bool:g_weaponArenaState = g_weaponArena
			SwitchRandom(id)
			if (g_weaponArena && !g_weaponArenaState) {
				activate(id)
			}
			chose = false
			*/
			chose = false
			randommain(id)
		}
		case MENUSELECT8: {
			g_weaponArena = false
			g_randomWeapon = false
			disabled(id)
			chose = false
		}
		case MENUSELECT9: {
			wamenu2(id)
			chose = false
		}
		case MENUSELECT0: chose = false // Exit, don't do anything
	}

	if (chose) {
		g_randomWeapon = false
		if (g_weaponArena)
			changed(id,1)
		else {
			g_weaponArena = true
			activate(id)
		}
	}

	return PLUGIN_HANDLED
}

public menu_wa2(id,key)
{
	new bool:chose = true
	switch(key) {
		case MENUSELECT1: changeWeapon(id,CSW_FIVESEVEN)
		case MENUSELECT2: changeWeapon(id,CSW_UMP45)
		case MENUSELECT3: changeWeapon(id,CSW_SG550)
		case MENUSELECT4: changeWeapon(id,CSW_GALIL)
		case MENUSELECT5: changeWeapon(id,CSW_FAMAS)
		case MENUSELECT6: changeWeapon(id,CSW_USP)
		case MENUSELECT7: changeWeapon(id,CSW_GLOCK18)
		case MENUSELECT8: changeWeapon(id,CSW_AWP)
		case MENUSELECT9: {
			wamenu3(id)
			chose = false
		}
		case MENUSELECT0: {
			menustarter(id)
			chose = false
		}
	}

	if (chose) {
		g_randomWeapon = false
		if (g_weaponArena)
			changed(id, 1)
		else {
			g_weaponArena = true
			activate(id)
		}
	}

	return PLUGIN_HANDLED
}

public menu_wa3(id,key)
{
	new bool:chose = true
	switch(key) {
		case 0: changeWeapon(id,CSW_MP5NAVY)
		case 1: changeWeapon(id,CSW_M249)
		case 2: changeWeapon(id,CSW_M3)
		case 3: changeWeapon(id,CSW_M4A1)
		case 4: changeWeapon(id,CSW_TMP)
		case 5: changeWeapon(id,CSW_G3SG1)
		case 6: changeWeapon(id,CSW_DEAGLE)
		case 7: changeWeapon(id,CSW_SG552)
		case 8: {
			wamenu4(id)
			chose = false
		}
		case 9: {
			wamenu2(id)
			chose = false
		}
	}

	if (chose) {
		g_randomWeapon = false
		if (g_weaponArena)
			changed(id,1)
		else {
			g_weaponArena = true
			activate(id)
		}
	}

	return PLUGIN_HANDLED
}

public menu_wa4(id,key)
{
	new bool:chose = true
	switch(key) {
		case MENUSELECT1: changeWeapon(id, CSW_AK47)
		case MENUSELECT2: changeWeapon(id, CSW_KNIFE)
		case MENUSELECT3: changeWeapon(id, CSW_P90)
		case MENUSELECT4: changeWeapon(id, CSW_SHIELD)
		case MENUSELECT5: changeWeapon(id, CSW_HEGRENADE)
		case MENUSELECT0: {
			wamenu3(id)
			chose = false
		}
	}

	if (chose) {
		g_randomWeapon = false
		if (g_weaponArena)
			changed(id,1)
		else {
			g_weaponArena = true
			activate(id)
		}


		if (g_waWeapon[1] == CSW_SHIELD) { // TO DO: Check this later.
			// Check each player. If he has any allowed weapon, make him hold that, else give him a random allowed weapon before we give shield.
			new players[32], playersFound
			get_players(players, playersFound, "a") // No deads
			//new clip, ammo, weaponTypeId, allowedShieldWeapons[5] = {CSW_USP, CSW_GLOCK18, CSW_P228, CSW_FIVESEVEN, CSW_DEAGLE}
			for (new i = 0;i < playersFound;i++) {
				GiveShieldAndPistol(players[i])
			}

			// Give in a little bit...
			//set_task(1.8, "DelayedGiveAll")
		}
	}

	return PLUGIN_HANDLED
}

getwpnflag(const WEAPON) {
	for (new i = 1, j = 0; i <= 30; i++) {
		if (i == CSW_C4 || i == CSW_SHIELD || i == CSW_FLASHBANG || i == CSW_SMOKEGRENADE/* || i == CSW_HEGRENADE*/)
			continue

		if (i == WEAPON)
			return (1<<j)
		j++
	}

	return -1
}

getactive(const WEAPON) {
	if (g_randomflags & getwpnflag(WEAPON))
		return 1

	return 0
}

public randommain(id) {
	new menuBody[512]
	new len = format(menuBody, 511, "\ySelect weapons to be enabled in random mode^n^n\w")

	new bool:saveneeded
	if (!vaultdata_exists(VAULTKEY_RANDOM) || g_randomflags != get_vaultdata(VAULTKEY_RANDOM))
		saveneeded = true
	else
		saveneeded = false

	new const SAVECHANGES[] = "7. Save changes to vault"

	len += format(menuBody[len], 511-len, "1. Pistols^n2. Shotguns and machine guns and knives and nades^n3. Sub machine guns^n4. Rifles^n5. Snipers^n^n6. Team specific\R%s^n%s^n8. Back to main menu...^n%s0. Exit", get_cvar_num(CVAR_RANDOMTEAMSPECIFIC) == 1 ? "on" : "off", saveneeded == true ? SAVECHANGES : "\d7. Save changes to vault (not needed)\w", !g_randomWeapon ? "9. Activate random mode^n" : "")

	new flags = MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON6|MENUBUTTON8|MENUBUTTON0

	if (!g_randomWeapon)
		flags |= MENUBUTTON9

	if (saveneeded)
		flags |= MENUBUTTON7

	show_menu(id, flags, menuBody)

	return PLUGIN_HANDLED
}

public menu_randommain(id, key) {
	new bool:stayInMenu = false
	switch(key) {
		case MENUSELECT1: menu_pistols(id)
		case MENUSELECT2: menu_shotmg(id)
		case MENUSELECT3: menu_smg(id)
		case MENUSELECT4: menu_rifles(id)
		case MENUSELECT5: menu_snipers(id)
		case MENUSELECT6: {
			new randomteamspecific = get_cvar_num(CVAR_RANDOMTEAMSPECIFIC)

			if (randomteamspecific == 0)
				randomteamspecific = 1
			else
				randomteamspecific = 0

			set_cvar_num(CVAR_RANDOMTEAMSPECIFIC, randomteamspecific)
			stayInMenu = true
		}
		case MENUSELECT7: {
			updatevault(id, true)
			stayInMenu = true
		}
		case MENUSELECT8: menustarter(id)
		case MENUSELECT9: {
			new bool:g_weaponArenaState = g_weaponArena
			SwitchRandom(id)
			if (g_weaponArena && !g_weaponArenaState) {
				activate(id)
			}
		}
	}
	if (stayInMenu)
		randommain(id)

	return PLUGIN_HANDLED
}

menu_pistols(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\ySelect pistols^n^n\w")
	len += format(menuBody[len],511-len,"	1. Sig Sauer P228\R%s^n	2. Dual Beretta 96G Elites\R%s^n	3. Fabrique Nationale Five-seven\R%s^n	4. Heckler & Koch USP45\R%s^n	5. Glock 18\R%s^n	6. IMI Desert Eagle\R%s^n	^n	0. Back to main menu", BLED[getactive(CSW_P228)], BLED[getactive(CSW_ELITE)], BLED[getactive(CSW_FIVESEVEN)], BLED[getactive(CSW_USP)], BLED[getactive(CSW_GLOCK18)], BLED[getactive(CSW_DEAGLE)])
	new flags = (MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON6|MENUBUTTON0)
//	0. Back to main menu", randomweapons[CSW_P228], randomweapons[CSW_ELITE], randomweapons[CSW_FIVESEVEN], randomweapons[CSW_USP], randomweapons[CSW_GLOCK18], randomweapons[CSW_DEAGLE])

	return show_menu(id, flags, menuBody) // Just odd, shouldn't need to return a value, but the #¤!#%@ compiler is complaining...
}

alterobject(id, const WEAPON) {
	id++ // not used
	new const WPNFLAG = getwpnflag(WEAPON)
	if (g_randomflags & WPNFLAG)
		g_randomflags &= ~WPNFLAG
	else
		g_randomflags |= WPNFLAG
}

updatevault(id, bool:fromMenu) {
	new message[96]

	new flagsstring[64]
	num_to_str(g_randomflags, flagsstring, 63)
	if (set_vaultdata(VAULTKEY_RANDOM, flagsstring))
		format(message, 95, "%s: Successfully saved current random list to vault.", PLUGINNAME)
	else
		format(message, 95, "%s: ERROR - Failed while trying to save current random list to vault!", PLUGINNAME)

	if (fromMenu)
		client_print(id, print_chat, message)
	else
		console_print(id, message)
}

public menu_ws_pistols(id,key)
{
	new bool:stayInMenu = true

	switch (key) {
		case MENUSELECT1: alterobject(id, CSW_P228)
		case MENUSELECT2: alterobject(id, CSW_ELITE)
		case MENUSELECT3: alterobject(id, CSW_FIVESEVEN)
		case MENUSELECT4: alterobject(id, CSW_USP)
		case MENUSELECT5: alterobject(id, CSW_GLOCK18)
		case MENUSELECT6: alterobject(id, CSW_DEAGLE)
		case MENUSELECT0: {
			stayInMenu = false
			randommain(id)
		}
	}

	if (stayInMenu)
		menu_pistols(id)

	return PLUGIN_HANDLED
}

menu_shotmg(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\ySelect shotguns and machine guns and knives^n^n\w")
	len += format(menuBody[len],511-len,"1. Benelli M3 Super 90\R%s^n2. Benelli XM1014\R%s^n3. FN M249 Para\R%s^n4. Knife\R%s^n5. Grenade\R%s^n^n0. Back to main menu", BLED[getactive(CSW_M3)], BLED[getactive(CSW_XM1014)], BLED[getactive(CSW_M249)], BLED[getactive(CSW_KNIFE)], BLED[getactive(CSW_HEGRENADE)])
	new flags = (MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON0)
	//0. Back to main menu", randomweapons[CSW_M3], randomweapons[CSW_XM1014], randomweapons[CSW_M249])

	show_menu(id, flags, menuBody)
}

public menu_ws_shotmg(id,key)
{
	new bool:stayInMenu = true

	switch(key) {
		case MENUSELECT1: alterobject(id, CSW_M3)
		case MENUSELECT2: alterobject(id, CSW_XM1014)
		case MENUSELECT3: alterobject(id, CSW_M249)
		case MENUSELECT4: alterobject(id, CSW_KNIFE)
		case MENUSELECT0: {
			stayInMenu = false
			randommain(id)
		}
	}

	if (stayInMenu)
		menu_shotmg(id)

	return PLUGIN_HANDLED
}

menu_smg(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\ySelect sub machine guns^n^n\w")
	len += format(menuBody[len],511-len,"	1. Heckler & Koch UMP45\R%s^n	2. Heckler & Koch MP5/Navy\R%s^n	3. Steyr Tactical Machine Pistol\R%s^n	4. Fabrique Nationale P90\R%s^n	5. Ingram Mac-10\R%s^n	^n	0. Back to main menu", BLED[getactive(CSW_UMP45)], BLED[getactive(CSW_MP5NAVY)], BLED[getactive(CSW_TMP)], BLED[getactive(CSW_P90)], BLED[getactive(CSW_MAC10)])
	//0. Back to main menu", randomweapons[CSW_UMP45], randomweapons[CSW_MP5NAVY], randomweapons[CSW_TMP], randomweapons[CSW_P90], randomweapons[CSW_MAC10])
	new flags = (MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON0)

	show_menu(id, flags, menuBody)
}

public menu_ws_smg(id,key)
{
	new bool:stayInMenu = true

	switch(key) {
		case MENUSELECT1: alterobject(id, CSW_UMP45)
		case MENUSELECT2: alterobject(id, CSW_MP5NAVY)
		case MENUSELECT3: alterobject(id, CSW_TMP)
		case MENUSELECT4: alterobject(id, CSW_P90)
		case MENUSELECT5: alterobject(id, CSW_MAC10)
		case MENUSELECT0: {
			stayInMenu = false
			randommain(id)
		}
	}

	if (stayInMenu)
		menu_smg(id)

	return PLUGIN_HANDLED
}

menu_rifles(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\ySelect rifles^n^n\w")

	len += format(menuBody[len],511-len,"	1. Galil\R%s^n	2. Famas\R%s^n	3. Colt M4A1\R%s^n	4. Avtomat Kalashnikov AK-47\R%s^n	5. Sig SG-552 Commando\R%s^n	6. Steyr Aug\R%s^n	^n	0. Back to main menu", BLED[getactive(CSW_GALIL)], BLED[getactive(CSW_FAMAS)], BLED[getactive(CSW_M4A1)], BLED[getactive(CSW_AK47)], BLED[getactive(CSW_SG552)], BLED[getactive(CSW_AUG)])
	//0. Back to main menu", randomweapons[CSW_GALIL], randomweapons[CSW_FAMAS], randomweapons[CSW_M4A1], randomweapons[CSW_AK47], randomweapons[CSW_SG552], randomweapons[CSW_AUG])

	new flags = (MENUBUTTON3|MENUBUTTON4|MENUBUTTON5|MENUBUTTON6|MENUBUTTON0)

	flags |= MENUBUTTON1|MENUBUTTON2

	show_menu(id, flags, menuBody)
}

public menu_ws_rifles(id,key)
{
	new bool:stayInMenu = true

	switch(key) {
		case MENUSELECT1: alterobject(id, CSW_GALIL)
		case MENUSELECT2: alterobject(id, CSW_FAMAS)
		case MENUSELECT3: alterobject(id, CSW_M4A1)
		case MENUSELECT4: alterobject(id, CSW_AK47)
		case MENUSELECT5: alterobject(id, CSW_SG552)
		case MENUSELECT6: alterobject(id, CSW_AUG)
		case MENUSELECT0: {
			stayInMenu = false
			randommain(id)
		}
	}

	if (stayInMenu)
		menu_rifles(id)

	return PLUGIN_HANDLED
}

menu_snipers(id) {
	new menuBody[512]
	new len = format(menuBody,511,"\ySelect snipers^n^n\w")
	len += format(menuBody[len],511-len,"	1. Steyr Scout\R%s^n	2. Accuracy Int. Arctic Warfare/Magnum (AW/M)\R%s^n	3. Heckler & Koch G3/SG-1\R%s^n	4. Sig SG-550 Commando\R%s^n	^n	0. Back to main menu", BLED[getactive(CSW_SCOUT)], BLED[getactive(CSW_AWP)], BLED[getactive(CSW_G3SG1)], BLED[getactive(CSW_SG550)])
	//0. Back to main menu", randomweapons[CSW_SCOUT], randomweapons[CSW_AWP], randomweapons[CSW_G3SG1], randomweapons[CSW_SG550])

	new flags = (MENUBUTTON1|MENUBUTTON2|MENUBUTTON3|MENUBUTTON4|MENUBUTTON0)

	show_menu(id, flags, menuBody)
}

public menu_ws_snipers(id,key)
{
	new bool:stayInMenu = true

	switch(key) {
		case MENUSELECT1: alterobject(id, CSW_SCOUT)
		case MENUSELECT2: alterobject(id, CSW_AWP)
		case MENUSELECT3: alterobject(id, CSW_G3SG1)
		case MENUSELECT4: alterobject(id, CSW_SG550)
		case MENUSELECT0: {
			stayInMenu = false
			randommain(id)
		}
	}

	if (stayInMenu)
		menu_snipers(id)

	return PLUGIN_HANDLED
}

public handledrop(id) {
	if (!g_weaponArena || get_cvar_num("weaponarena_invisibleweapons") == 0)
		return PLUGIN_CONTINUE

	new clip, ammo
	new droppingweapontype = get_user_weapon(id, clip, ammo)
	new CsTeams:team = cs_get_user_team(id)

	if (team != CS_TEAM_T && team != CS_TEAM_CT)
		return PLUGIN_CONTINUE

	// Block all weapons that really can't be dropped here.
	// C4 can be dropped, but we don't want to process anything for it since it can't level. :-)
	if (droppingweapontype != g_waWeapon[int:team]
	&& droppingweapontype != CSW_C4) {
		new CsTeams:otherteam = team == CS_TEAM_T ? CS_TEAM_CT : CS_TEAM_T
		if (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC) && g_waWeapon[int:otherteam] == droppingweapontype)
			return PLUGIN_CONTINUE

		new ent[1]
		ent[0] = get_weaponentity(id, droppingweapontype) //ent[0] = find_wpnent_fast(id, droppingweapontype)
		if (!ent[0]) {
			//client_print(id, print_chat, "Error, couldn't find the weapon (type %d) you dropped to hide it...", droppingweapontype)
			// This happens sometimes... too bad, nothing to hide... maybe the weapon doesn't exist or whatever...?
		}
		else
			set_task(0.1, "HideOneWeapon", ent[0], ent, 1)
	}

	return PLUGIN_CONTINUE
}

public death_event() {
	// Delay hide...
	if (g_weaponArena && get_cvar_num("weaponarena_invisibleweapons") == 1)
		set_task(0.1, "HideWeapons")

	return PLUGIN_CONTINUE
}

public listrandomweapons(id) {

	new len = 2500
	new buffer[2501]
	new n = 0

	#if !defined NO_STEAM
		n += copy( buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>")
	#endif

	if (id == 0) {
		console_print(id,"^n%14s   %10s   %10s","Weapon","Status","Letter")
		console_print(id,"----------------------------------------")
	}
	else {
		n += format( buffer[n],len-n,"%14s   %10s^n","Weapon","Status")
		n += copy( buffer[n],len-n,"--------------------------^n")
	}


	for (new i = 1, j = 0; i <= 30; i++) {
		if (i == CSW_C4 || i == CSW_SHIELD || i == CSW_FLASHBANG || i == CSW_SMOKEGRENADE) continue

		if (id == 0)
			console_print(id, "%14s   %10s   %10c ", g_weaponstrings[i][7], g_randomflags & 1<<j ? BLED[1] : BLED[0], j + 97)
		else
			n += format( buffer[n],len-n,"%14s   %10s^n", g_weaponstrings[i][7], g_randomflags & 1<<j ? BLED[1] : BLED[0])

		j++
	}

	#if !defined NO_STEAM
		n += copy( buffer[n],len-n,"</pre></body></html>")
	#endif

	if (id != 0) {
		console_print(id, "Close your console, the list is being displayed in a MOTD Box")
		show_motd(id, buffer, "Weapon Arena")
	}

	return PLUGIN_HANDLED
}

public setrandoms(id, level, cid) {
	if (!cmd_access(id, level, cid, 2)) {
		return PLUGIN_HANDLED
	}

	new randoms[128]
	read_argv(1, randoms, 127)
	g_randomflags = read_flags(randoms)
	console_print(id, "%s: Updated random list.", PLUGINNAME)
	//new gotflags[128]
	//get_flags(g_randomflags, gotflags, 127)

	//if (vaultdata_exists
	//server_print("randoms: %s", randoms)
	//server_print("gotflags: %s", gotflags)
	//server_print("Randomflags is: %d", g_randomflags)

	// Store this new value in vault if 2nd parameter is "save"
	new argcount = read_argc()
	if (argcount < 3)
		return PLUGIN_HANDLED

	new arg[5]
	read_argv(2, arg, 4)
	if (equali(arg, "save"))
		updatevault(id, false)

	return PLUGIN_HANDLED
}

new g_classnames[2][15]
new g_model[64]
public forward_touch(toucher, touched) {

	if (!g_weaponArena || toucher == 0 || touched == 0)
		return FMRES_IGNORED

	if (!pev_valid(toucher)  || !pev_valid(touched))
		return FMRES_IGNORED

	pev(toucher, pev_classname, g_classnames[0], 14)
	pev(touched, pev_classname, g_classnames[1], 14)

	if (!equal(g_classnames[1], "player") || (!equal(g_classnames[0], "weaponbox") && !equal(g_classnames[0], "armoury_entity")))
		return FMRES_IGNORED

	pev(toucher, pev_model, g_model, 63) // models/w_ak47.mdl, check from [9]

	// You can touch my C4 any time ;-)
	if (equal(g_model, "models/w_backpack.mdl"))
		return FMRES_IGNORED

	// weapon_ak47
	new CsTeams:team = cs_get_user_team(touched)

	if (team != CS_TEAM_T && team != CS_TEAM_CT)
		return FMRES_IGNORED

	if (equal(g_model[9], g_weaponString[int:team][7], strlen(g_weaponString[int:team][7]))) {
		// If touching own team's weapon, ignore this = let player touch weapon
		return FMRES_IGNORED
	}
	else if (g_randomWeapon && get_cvar_num(CVAR_RANDOMTEAMSPECIFIC) && get_cvar_num(CVAR_STEALRANDOMWEAPON)) {
		new CsTeams:otherteam
		if (team == CS_TEAM_T)
			otherteam = CS_TEAM_CT
		else
			otherteam = CS_TEAM_T

		// If touching other team's weaponbox, and random mode is on and team specific weapons is on and you can steal the other team's weapon, ignore this = let player touch weapon
		// This means you can't pick up other team's weapon if it's on ground on map from start (ie, a armoury_entity)
		if (equal(g_classnames[0], "weaponbox") && equal(g_model[9], g_weaponString[int:otherteam][7], strlen(g_weaponString[int:otherteam][7]))) {
			return FMRES_IGNORED
		}
	}

	//server_print("%s (%s/%d) BLOCKING touch of a %s (%d) strlen of current weapon from 7: %d", g_classnames[0], g_model, 	toucher, g_classnames[1], touched, 	strlen(g_weaponString[int:team][7]))

	// All else block touch!
	return FMRES_SUPERCEDE
}

public fn_autobuy(id) {
	if (!g_weaponArena)
		return PLUGIN_CONTINUE

	client_print(id, print_center, "Autobuying is disabled during Weapon Arena")

	return PLUGIN_HANDLED
}
public fn_rebuy(id) {
	if (!g_weaponArena)
		return PLUGIN_CONTINUE

	client_print(id, print_center, "Rebuying is disabled during Weapon Arena")

	return PLUGIN_HANDLED
}

public event_money(id) {
	if (!g_weaponArena || !is_user_bot(id))
		return PLUGIN_CONTINUE

	// Null bots' money during Weapon Arena, or else they buy stuff and get into trouble?
	cs_set_user_money(id, 0)

	return PLUGIN_HANDLED
}

public plugin_init() {
	register_plugin(PLUGINNAME, VERSION, AUTHOR)

	register_logevent("death_event", 5, "1=killed", "3=with")

	register_event("ResetHUD", "newround_event", "b")
	register_event("CurWeapon", "holdwpn_event", "be", "1=1")
	register_logevent("endround_event", 2, "1=Round_End")
	register_logevent("endround_event", 2, "1&Restart_Round_")
	register_event("Money", "event_money", "b")
	register_message(get_user_msgid("SendAudio"), "message_SendAudio")
	register_message(get_user_msgid("TextMsg"), "message_TextMsg")

	register_concmd("weaponarena","toggle", ACCESSNEEDED, "<weaponnumber|off|list|random>")
	register_concmd("weaponarena_random", "setrandoms", ACCESSNEEDED, "<abcd...> [save] - Set what weapons will be available in random mode (this will override any previous setting, add save as last parameter to optionally save this)")
	register_concmd("weaponarena_randomlist", "listrandomweapons", 0, "- lists all weapons enabled for random mode")

	register_clcmd("weaponarena_menu", "wamenu1", ACCESSNEEDED, "- displays Weapon Arena's menu")
	register_clcmd("drop", "handledrop")
	register_clcmd("cl_setautobuy", "fn_autobuy")
	register_clcmd("cl_autobuy", "fn_autobuy")
	register_clcmd("cl_setrebuy", "fn_rebuy")
	register_clcmd("cl_rebuy", "fn_rebuy")

	register_menucmd(register_menuid("Weapon Arena\R1/4"), 1023, "menu_wa1")
	register_menucmd(register_menuid("Weapon Arena\R2/4"), 1023, "menu_wa2")
	register_menucmd(register_menuid("Weapon Arena\R3/4"), 1023, "menu_wa3")
	register_menucmd(register_menuid("Weapon Arena\R4/4"), 1023, "menu_wa4")

	register_menucmd(register_menuid("Select weapons to be enabled in random mode"), 1023, "menu_randommain")
	register_menucmd(register_menuid("Select pistols"), 1023, "menu_ws_pistols")
	register_menucmd(register_menuid("Select shotguns and machine guns"), 1023, "menu_ws_shotmg")
	register_menucmd(register_menuid("Select sub machine guns"), 1023, "menu_ws_smg")
	register_menucmd(register_menuid("Select rifles"), 1023, "menu_ws_rifles")
	register_menucmd(register_menuid("Select snipers"), 1023, "menu_ws_snipers")

	register_cvar("weaponarena_version", VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	register_cvar("weaponarena_unlimitedammo", "1")
	register_cvar("weaponarena_invisibleweapons", "1")
	register_cvar("weaponarena_delay", DEFAULTDELAY)
	register_cvar("weaponarena_holdknife", "0")
	register_cvar(CVAR_RANDOMTEAMSPECIFIC, "1")
	register_cvar(CVAR_STEALRANDOMWEAPON, "1")

	register_forward(FM_Touch, "forward_touch")

	g_maxclients = global_get(glb_maxClients)
	g_weaponArena = false
	changeWeapon(0, CSW_FIVESEVEN) // Default weapon...

	if (vaultdata_exists(VAULTKEY_RANDOM)) {
		g_randomflags = get_vaultdata(VAULTKEY_RANDOM)
	}

	AddMenuItem(PLUGINNAME, "weaponarena_menu", ACCESSNEEDED, PLUGINNAME)

	g_MsgSync = CreateHudSyncObj()

	//Setup jtp10181 CVAR
	new cvarString[256], shortName[16]
	copy(shortName,15,"wa")

	register_cvar("jtp10181","",FCVAR_SERVER|FCVAR_SPONLY)
	get_cvar_string("jtp10181",cvarString,255)

	if (strlen(cvarString) == 0) {
		formatex(cvarString,255,shortName)
		set_cvar_string("jtp10181",cvarString)
	}
	else if (contain(cvarString,shortName) == -1) {
		format(cvarString,255,"%s,%s",cvarString, shortName)
		set_cvar_string("jtp10181",cvarString)
	}
}

stock getMaxBPAmmo(wpnid) {

	new bpammo = 0
	switch (wpnid) {
		case CSW_P228			: bpammo = 52
		case CSW_SCOUT			: bpammo = 90
		case CSW_HEGRENADE		: bpammo = 1
		case CSW_XM1014		: bpammo = 32
		case CSW_C4			: bpammo = 0
		case CSW_MAC10			: bpammo = 100
		case CSW_AUG			: bpammo = 90
		case CSW_SMOKEGRENADE	: bpammo = 1
		case CSW_ELITE			: bpammo = 120
		case CSW_FIVESEVEN		: bpammo = 100
		case CSW_UMP45			: bpammo = 100
		case CSW_SG550			: bpammo = 90
		case CSW_GALI			: bpammo = 90
		case CSW_FAMAS			: bpammo = 90
		case CSW_USP			: bpammo = 100
		case CSW_GLOCK18		: bpammo = 120
		case CSW_AWP			: bpammo = 30
		case CSW_MP5NAVY		: bpammo = 120
		case CSW_M249			: bpammo = 200
		case CSW_M3			: bpammo = 21
		case CSW_M4A1			: bpammo = 90
		case CSW_TMP			: bpammo = 120
		case CSW_G3SG1			: bpammo = 90
		case CSW_FLASHBANG		: bpammo = 2
		case CSW_DEAGLE		: bpammo = 35
		case CSW_SG552			: bpammo = 90
		case CSW_AK47			: bpammo = 90
		case CSW_KNIFE			: bpammo = 0
		case CSW_P90			: bpammo = 100
	}
	return bpammo
}

/* Block this
 {MessageBegin type=SendAudio(100), dest=MSG_ONE(1), classname=player netname=Johnny got his gun
 WriteByte byte=1
 WriteString string=%!MRAD_FIREINHOLE
 MessageEnd}
*/
public message_SendAudio(msg_id, msg_dest, entity)
{
	if (!g_weaponArena) return PLUGIN_CONTINUE

	if (g_waWeapon[1] != CSW_HEGRENADE) return PLUGIN_CONTINUE

	if (get_msg_args() != 2) return PLUGIN_CONTINUE

	new string[24]
	get_msg_arg_string(2, string, 23)
	if (equal(string, "%!MRAD_FIREINHOLE")) return PLUGIN_HANDLED

	return PLUGIN_CONTINUE
}

/*
 {MessageBegin type=TextMsg(77), dest=MSG_ONE(1), classname=player netname=Johnny got his gun
 WriteByte byte=5
 WriteString string=1
 WriteString string=#Game_radio
 WriteString string=Johnny got his gun
 WriteString string=#Fire_in_the_hole
 MessageEnd}
*/
public message_TextMsg(msg_id, msg_dest, entity)
{
	if (!g_weaponArena) return PLUGIN_CONTINUE

	if (g_waWeapon[1] != CSW_HEGRENADE) return PLUGIN_CONTINUE

	if (get_msg_args() != 5) return PLUGIN_CONTINUE

	new string[24]
	get_msg_arg_string(3, string, 23)
	if (!equal(string, "#Game_radio")) return PLUGIN_CONTINUE

	get_msg_arg_string(5, string, 23)
	if (!equal(string, "#Fire_in_the_hole")) return PLUGIN_CONTINUE

	get_msg_arg_string(2, string, 23)
	set_task(0.1, "giveheifnothas", str_to_num(string))

	// Possibly does not effect text when you throw nades yourself...
	return PLUGIN_HANDLED
}

public giveheifnothas(id)
{
	if (!g_weaponArena || !authorized(id)) return

	new nades = cs_get_user_bpammo(id, CSW_HEGRENADE)
	if (nades == 0) {
		give_item(id, "weapon_hegrenade")
		cs_set_user_bpammo(id, CSW_HEGRENADE, NADEAMOUNT)
	}
	else if (nades != NADEAMOUNT) {
		cs_set_user_bpammo(id, CSW_HEGRENADE, NADEAMOUNT)
	}

	new all_weapons[32], numweap
	get_user_weapons(id,all_weapons,numweap)
	for (new x = 0; x < numweap; x++) {
		if (all_weapons[x] == CSW_C4 || all_weapons[x] == CSW_KNIFE || all_weapons[x] == CSW_HEGRENADE) continue
		engclient_cmd(id, "drop", g_weaponstrings[all_weapons[x]])
	}

	engclient_cmd(id, "weapon_hegrenade")
}