////////////////////////////////////////////////////////////////////////////////////////////
//   uaio_admin.sma                    Version 1.51                       Date: AUG/01/2006
//
//   RS UAIO (Ultimate All-In-One) Admin Menu System (Multilingual)
//   File: UAIO Admin - Main Source File
//
//   Created By:    Rob Secord, B.Sc.
//   Alias: xeroblood (aka; Achilles; sufferer)
//   Email: xeroblood@msn.com
//
//   Updated By:    Dan Weeks
//   Alias: $uicid3
//   Email: suicid3m3@gmail.com
//
//   Developed using:  AMXX 1.50, 1.55, 1.60, 1.65, 1.70, 1.75
//   Modules:          Fun
//                     Engine
//                     CStrike
//
//   Tested On:        CS 1.6 (STEAM)
//                     Linux HLDS
//                     Windows HLDS/ListenServer
//
//   Current Internal Command Count: 81
//
////////////////////////////////////////////////////////////////////////////////////////////
//   Credits:
//
//     UAIO Admin Manager:                  $uicid3
//       -- Seperate Plugin; uaio_manager.sma   (Comes Packaged with UAIO)
//
//     HLDS Server Hosting & Debugging:     RAD Clan, Mad Dog (v3x), $uicid3, Abhishek,
//                                          GodLike
//
//     Ideas & Testing:                     Mad Dog (v3x), $uicid3, Abhishek, GodLike,
//                                          WillZ, FaDe, MattCook
//
//     Bug Fixes:                           jtp10181 , $uicid3
//
//     Code Samples From:
//       - Diving Kit                       AssKicR, Lazy
//       - Sunglasses, Poison               AssKicR
//       - Fire, Human-Rocket               f117bomb
//       - Buy Locker                       AssKicR, Scarzzurs
//       - Player Trails                    Lazy
//       - Grenade Trails                   AssKicR
//       - Drugs                            Twilight Suzuka
//       - Crazy Crosshair                  Mad Dog (v3x)
//       - Hostagize Player                 Nicholas Glistak
//       - Drop Nades                       VEN
//
//     Language Translations:
//       - Dutch:                           Proach
//       - Swedish:                         [ --<-@ ] Black Rose
//
//   Special Thanks to:
//       The AMX Mod X Development Team!     <-- Visit: http://www.amxmodx.org
//       The Original AMX Mod Developers!    <-- Visit: http://www.amxmod.net
//
////////////////////////////////////////////////////////////////////////////////////////////
//   Revision History:
//
//     -  DEC/20/2004 -- Project Started. Halted shortly after due to time restraints.
//     - JUNE/07/2005 -- Project Continued. Prerelease v1.0 in full test mode on several servers.
//     - JUNE/20/2005 -- 90% Complete. 3/4 Command Types Complete (51 Internal Commands so far).
//     - JUNE/24/2005 -- 95% Complete. Release Candidate 1.  (69 Internal Commands so far).
//     - JULY/06/2005 -- Updated CExec/SExec, Added Death Editor
//                    -- Fixed minor bugs as noted in AMXX Plugin Forum Thread
//     - JULY/08/2005 -- Release Candidate 2. (73 Internal Commands so far).
//                    -- Added Infinite Flash/Smoke Grenades (requested by: d3adlythegame)
//                    -- Added Recruit Info MOTD (requested by: Axyo)
//     - JULY/15/2005 -- Released as 1.0 -- All Release Candidates went well.
//                    -- Added Evil Poison Command (works like fire).
//     - JULY/24/2005 -- Updated Version to v1.1
//                    -- Fixed Major Bug: Auto-Exec Commands should now work flawlessly!
//     - SEPT/15/2005 -- Updated Version to v1.2
//                    -- Added IP Address Support for Admins!
//                    -- Added CVAR: sv_uaio_show_activity (mimics amx_show_activity)
//                    -- Updated Auto-Exec Commands for proper HUD Message Display.
//                    -- Fixed Bugs: Join/Leave Message, Seer Mode.
//                    -- Added 7 New Commands:
//                          - No-Buy, Player Trails, Grenade Trails, Drugs,
//                            Crazy Crosshairs, Weapon Tracers, Hostagizer
//     - SEPT/29/2005 -- Updated Version to v1.3
//                    -- Fixed several minor bugs (Thx jtp10181).
//                    -- Updated for AMXX 1.60
//     -  OCT/08/2005 -- Updated Version to v1.4
//                    -- Added Multilingual support.
//                    -- Fixed Listenserver Admin bug.
//                    -- Fixed Weapon Tracers.
//     -  OCT/18/2005 -- Updated Version to v1.41
//                    -- Fixed several bugs yet again!
//                          - Thx jtp10181, for pointing them out yet again!  :D
//     -  NOV/20/2005 -- Fixed problems with Multilingual not working properly.
//                          - First update by $uicid3.
//     -  DEC/20/2005 -- Updated Version to 1.50
//                    -- Fixed spawn bug
//                    -- Fixed Turbo bug
//                    -- Changed ban menu to not have Teams/Everyone
//                    -- Re-did Arena so its fully customizable (even down to the nades)
//                    -- Added Command 'uaio_motd'
//                    -- Fixed Security issue in uaio_manager.amxx
//                    -- Fixed changing model to VIP not working
//     - AUG/01/2006  -- Updated Version to 1.51
//                    -- Fixed bug in auto announce function
//                    -- Recompiled for use with AMXX 1.75
//
//   Check for the Latest Update at:
//      http://forums.alliedmods.net/forumdisplay.php?f=95
//
////////////////////////////////////////////////////////////////////////////////////////////
//
//   Future Release:
//     - G - Cluster Grenades                   (code: boomy)
//     - G - ESP Rings                          (code: Mad Dog [v3x])
//     - M - Map Lights Modifier
//     - M - Remove all player effects
//     - M - Custom Arena                       (idea: $uicid3)
//
////////////////////////////////////////////////////////////////////////////////////////////


#include "uaio_inc/config.inc"          // Pre-compilation Configurations
                                        // (Make Any Neccessary Changes To This File)

#include <amxmodx>
#include <engine>
#include <cstrike>
#include <amxmisc>
#include <fun>

// UAIO Custom Includes
#include "uaio_inc/const.inc"           // Constant Defines
#include "uaio_inc/global.inc"          // Global Variables
#include "uaio_inc/stocks_common.inc"   // Common Stock Functions
#include "uaio_inc/stocks_player.inc"   // Player Stock Functions
#include "uaio_inc/stocks_exec.inc"     // Execution Stock Functions
#include "uaio_inc/files.inc"           // File Access Functions
#include "uaio_inc/commands.inc"        // Client Commands
#include "uaio_inc/actions_vote.inc"    // Vote Command Actions
#include "uaio_inc/actions_good.inc"    // Good Command Actions
#include "uaio_inc/actions_evil.inc"    // Evil Command Actions
#include "uaio_inc/actions_misc.inc"    // Misc Command Actions
#include "uaio_inc/menus.inc"           // Client Menu System
#include "uaio_inc/events.inc"          // Hooked Events
#include "uaio_inc/effects.inc"         // Command Special Effects

//    _______________
//___/ plugin_init() \______________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public plugin_init()
{
    register_plugin( PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR )
    register_cvar( PLUGIN_NAME, PLUGIN_VERSION, FCVAR_SERVER )
    register_dictionary( "uaio_admin.txt" )

    // Super Admin Commands
    register_clcmd( "uaio_mode",   "ClCmd_UAIOMode",   UAIO_LVL_SUPER, "<on|off> - Toggles UAIO On/Off." )
    register_clcmd( "uaio_groups", "ClCmd_UAIOGroups", UAIO_LVL_SUPER, "- Displays All UAIO-Groups Information." )
    register_clcmd( "uaio_admins", "ClCmd_UAIOAdmins", UAIO_LVL_SUPER, "- Displays All UAIO-Admins Information." )

    // Regular Admin Commands
    register_clcmd( "uaio_group", "ClCmd_UAIOGroup", UAIO_LVL_ADMIN, "- Displays Your Group Information." )
    register_clcmd( "uaio_order", "ClCmd_UAIOOrder", UAIO_LVL_ADMIN, "- Toggles the Display Order of UAIO Menu." )
    
    // Regular Player Commands
    register_clcmd( "uaio_menu",  "ClCmd_UAIOMenu",  UAIO_LVL_USER,  "- Displays UAIO-Admin Command Menu." )
    register_clcmd( "uaio_help",  "ClCmd_UAIOHelp",  UAIO_LVL_USER,  "- Displays UAIO-Admin Help Information" )

    // Hooked Say Commands
    register_clcmd( "say",      "ClCmd_CheckSay" )
    register_clcmd( "say_team", "ClCmd_CheckSay" )

    // Hooked Buy Commands (For No-Buy)
    register_clcmd( "buyequip", "ClCmd_NoBuy" )
    register_clcmd( "buyammo1", "ClCmd_NoBuy" )
    register_clcmd( "buyammo2", "ClCmd_NoBuy" )

    register_clcmd( "uaio_debugarena" , "DebugArena")
    
    // Registered Events
    register_event( "DeathMsg",  "Event_DeathMsg",  "a" )
    register_event( "Money",     "Event_Money",     "b" )
    register_event( "ResetHUD",  "Event_ResetHUD",  "b" )
    register_event( "Damage",    "Event_Damage",    "b",  "2!0" )
    register_event( "CurWeapon", "Event_ChgWeapon", "be", "1=1" )
    register_event( "SendAudio", "Event_NadeThrow", "bc", "2=%!MRAD_FIREINHOLE" )
    register_event( "SetFOV",    "Event_SetFOV",    "be", "1<91" )
    register_event( "TextMsg",   "Event_TextMsg",   "be", "1=4", "2=#Weapon_Cannot_Be_Dropped")
    register_logevent( "Event_RoundStart", 2, "0=World triggered", "1=Round_Start" )
    register_logevent( "Event_RoundEnd",   2, "0=World triggered", "1=Round_End" )

    // Registered Menus
    register_menucmd( register_menuid("\yUAIO Player Menu"),   1023, "Menu_UAIONext" )
    register_menucmd( register_menuid("\yUAIO Command Menu"),  1023, "Menu_UAIONext" )
    register_menucmd( register_menuid("\yUAIO Command Types"), 1023, "Menu_UAIOType" )
    register_menucmd( register_menuid("\yUAIO Settings Menu"), 1023, "Menu_UAIOAction" )

    // Vote Menu
    register_menucmd( register_menuid("\yUAIO Vote Menu"), 1023, "Menu_UAIOVoting" )

    // Arena Weapon Menus
    register_menucmd( register_menuid("\yUAIO Arena Menu"),              1023, "Menu_UAIOArenaWeapon" )
    register_menucmd( register_menuid("\yUAIO Arena Pistols Menu"),      1023, "Menu_UAIOArenaReg" )
    register_menucmd( register_menuid("\yUAIO Arena Shotguns Menu"),     1023, "Menu_UAIOArenaReg" )
    register_menucmd( register_menuid("\yUAIO Arena SMGs Menu"),         1023, "Menu_UAIOArenaReg" )
    register_menucmd( register_menuid("\yUAIO Arena Rifles Menu"),       1023, "Menu_UAIOArenaRifle" )
    register_menucmd( register_menuid("\yUAIO Arena Machine Guns Menu"), 1023, "Menu_UAIOArenaReg" )
    register_menucmd( register_menuid("\yUAIO Arena Equipment Menu"),    1023, "Menu_UAIOArenaReg" )
    register_menucmd( register_menuid("\yUAIO Arena Sets Menu"),       1023, "Menu_UAIOArenaSets" )    

    // Weapon Menus
    register_menucmd( register_menuid("\yUAIO Weapons Menu"),      1023, "Menu_UAIOWeapon" )
    register_menucmd( register_menuid("\yUAIO Pistols Menu"),      1023, "Menu_UAIOReg" )
    register_menucmd( register_menuid("\yUAIO Shotguns Menu"),     1023, "Menu_UAIOReg" )
    register_menucmd( register_menuid("\yUAIO SMGs Menu"),         1023, "Menu_UAIOReg" )
    register_menucmd( register_menuid("\yUAIO Rifles Menu"),       1023, "Menu_UAIORifle" )
    register_menucmd( register_menuid("\yUAIO Machine Guns Menu"), 1023, "Menu_UAIOReg" )
    register_menucmd( register_menuid("\yUAIO Equipment Menu"),    1023, "Menu_UAIOReg" )
    register_menucmd( register_menuid("\yUAIO Extras Menu"),       1023, "Menu_UAIOExtra" )
    
    // Plugin-Specific CVARs
    register_cvar( "sv_uaio_show_activity",  "2" ) // Show admins activity
                                                   // 0 - disabled
                                                   // 1 - show without admin name
                                                   // 2 - show with admin name

    register_cvar( "sv_uaio_immunity_vote",  "1" ) // 1=Obey Immunity, 0=Disobey Immunity
    register_cvar( "sv_uaio_immunity_evil",  "1" ) // 1=Obey Immunity, 0=Disobey Immunity
    register_cvar( "sv_uaio_immunity_good",  "0" ) // 1=Obey Immunity, 0=Disobey Immunity
    register_cvar( "sv_uaio_immunity_misc",  "0" ) // 1=Obey Immunity, 0=Disobey Immunity
    register_cvar( "sv_uaio_menu_start",     "0" ) // 0=Command Menu,  1=Player Menu
    register_cvar( "sv_uaio_hud_color",      "255 255 255" ) // Default HUD Message Color
    
    // Vote-Specific Settings
    register_cvar( "sv_uaio_vote_time",      "10.0" ) // Time in Seconds Vote Lasts
    register_cvar( "sv_uaio_vote_delay",     "30.0" ) // Time in Seconds to Wait for Next Vote
    register_cvar( "sv_uaio_vote_ratio",     "0.40" ) // The success ratio for votes (1.0 = High Chance of Success, 0.0 = No Chance)
    register_cvar( "sv_uaio_vote_answers",   "1" )    // 1=Show Answers, 0=No Answers
    
    // Command-Specific CVARs
    register_cvar( "sv_uaio_ban_ip",         "0" )           // 1=Ban IP, 0=Ban STEAM ID
    register_cvar( "sv_uaio_bslap_dmg",      "1" )           // Damage Amount in HP for Each Bitch-Slap
    register_cvar( "sv_uaio_fire_dmg",       "5" )           // Fire Damage / Second
    register_cvar( "sv_uaio_poison_dmg",     "5" )           // Poison Damage / Second
    register_cvar( "sv_uaio_smoke_nades",    "1" )           // 1=Give Smoke Grenades, 0=Don't..
    register_cvar( "sv_uaio_turbo_speed",    "750" )         // Turbo Speed (Range 400 - 900)
    register_cvar( "sv_uaio_max_icash",      "16000" )       // Max Infinite Cash (100-16000)
    register_cvar( "sv_uaio_max_bcash",      "2000" )        // Max Bonus Cash For Kill (50-5000)
    register_cvar( "sv_uaio_shades_alpha",   "120" )         // Alpha transparency of Sun-Glasses
    register_cvar( "sv_uaio_blackout_color", "100 100 255" ) // RGB Color for Black-Out (ScreenFade)

    //    _______________________
    //___/ Commands & Menu CVARs \____________________________________________
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Console Commands & Menu-Specific CVARs [Max 9 Options/CVAR]
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    new i , szUsage[STR_M]
    
    // Vote Commands/Cvars
    for( i = 0; i < MAX_V_COMMANDS; i++ )
    {
        format(szUsage , STR_M-1 , "%L" , LANG_SERVER , g_szVCmdUsage[i])
        register_clcmd( g_szVCmdConsole[i], "ClCmd_VoteCmd", UAIO_LVL_ADMIN, szUsage )
        if( g_szVCmdCvar[i][0] != '_' )
            register_cvar( g_szVCmdCvar[i], g_szVCmdCvarFlags[i] )
    }
    // Good Commands/Cvars
    for( i = 0; i < MAX_G_COMMANDS; i++ )
    {
        format(szUsage , STR_M-1 , "%L" , LANG_SERVER , g_szGCmdUsage[i])
        register_clcmd( g_szGCmdConsole[i], "ClCmd_GoodCmd", UAIO_LVL_ADMIN, szUsage )
        if( g_szGCmdCvar[i][0] != '_' )
            register_cvar( g_szGCmdCvar[i], g_szGCmdCvarFlags[i] )
    }
    // Bad Commands/Cvars
    for( i = 0; i < MAX_E_COMMANDS; i++ )
    {
        format(szUsage , STR_M-1 , "%L" , LANG_SERVER , g_szECmdUsage[i])
        register_clcmd( g_szECmdConsole[i], "ClCmd_EvilCmd", UAIO_LVL_ADMIN, szUsage )
        if( g_szECmdCvar[i][0] != '_' )
            register_cvar( g_szECmdCvar[i], g_szECmdCvarFlags[i] )
    }
    // Misc Commands/Cvars
    for( i = 0; i < MAX_M_COMMANDS; i++ ) // Misc Commands/Cvars
    {
        format(szUsage , STR_M-1 , "%L" , LANG_SERVER , g_szMCmdUsage[i])
        register_clcmd( g_szMCmdConsole[i], "ClCmd_MiscCmd", UAIO_LVL_ADMIN, szUsage )
        if( g_szMCmdCvar[i][0] != '_' )
            register_cvar( g_szMCmdCvar[i], g_szMCmdCvarFlags[i] )
    }
    return
}

public DebugArena( id )
{
    console_print( id , "Arena enabled : %s^n# of Weapons : %d^n^nWepon #'s" , g_bArenaEnabled ? "yes" : "no" , g_iWepCount)
    for(new i = 0 ; i < AR_MAX_GUNS ; i++ )
        console_print( id , "%d. %d" , i+1 , g_iArenaCustom[i])
    return PLUGIN_HANDLED;
}
//    ______________
//___/ plugin_cfg() \_______________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public plugin_cfg()
{
    new szLogMsg[STR_M]

    // Set Maximum Player Speed
    server_cmd( "sv_maxspeed 900" )

    // Client Message Indexes
    g_iMsgDamage = get_user_msgid( "Damage" )
    g_iMsgDeath  = get_user_msgid( "DeathMsg" )
    g_iMsgSetFOV = get_user_msgid( "SetFOV" )
    g_iMsgScreenFade = get_user_msgid( "ScreenFade" )
    g_iMsgScreenShake = get_user_msgid( "ScreenShake" )

    // Initialize UAIO Admin System
    UAIO_NullAdmins()
    UAIO_BuildFileDir()
    g_bFileError[ERROR_MAPS]   = !UAIO_ReadMaps()
    g_bFileError[ERROR_CEXEC]  = !UAIO_ReadCExec()
    g_bFileError[ERROR_SEXEC]  = !UAIO_ReadSExec()
    g_bFileError[ERROR_AEXEC]  = !UAIO_ReadAExec()
    g_bFileError[ERROR_GROUPS] = !UAIO_ReadGroups()
    g_bFileError[ERROR_ADMINS] = !UAIO_ReadAdmins()

    // Check for Auto-Exec Commands Error
    if( g_bFileError[ERROR_AEXEC] )
    {
        format( szLogMsg, STR_M-1, "%L", LANG_SERVER, "ERR_CFG_AEXEC", PLUGIN_MOD, PLUGIN_NAME )
        UAIO_WriteLog( szLogMsg )
    }

    // Disable Plugin if Groups or Admins Fail to Load
    if( g_bFileError[ERROR_GROUPS] )
    {
        format( szLogMsg, STR_M-1, "%L", LANG_SERVER, "ERR_CFG_GROUPS", PLUGIN_MOD, PLUGIN_NAME, g_szFileGroups )
        UAIO_WriteLog( szLogMsg )
        UAIO_PluginEnabled( 0 )
        return
    }
    if( g_bFileError[ERROR_ADMINS] )
    {
        format( szLogMsg, STR_M-1, "%L", LANG_SERVER, "ERR_CFG_ADMINS", PLUGIN_MOD, PLUGIN_NAME, g_szFileAdmins )
        UAIO_WriteLog( szLogMsg )
        UAIO_PluginEnabled( 0 )
        return
    }
    return
}
//    ___________________
//___/ plugin_precache() \__________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public plugin_precache()
{
    g_sprBeam   = precache_model( "sprites/zbeam4.spr" )
    g_sprLaser  = precache_model( "sprites/laserbeam.spr" )
    g_sprWhite  = precache_model( "sprites/white.spr" )
    g_sprSmoke  = precache_model( "sprites/steam1.spr" )
    g_sprMFlash = precache_model( "sprites/muzzleflash.spr" )
    g_sprBFlare = precache_model( "sprites/blueflare2.spr" )
    
    precache_model( "models/scientist.mdl" )

    precache_sound( g_szSndFlames )
    precache_sound( g_szSndScream1 )
    precache_sound( g_szSndScream2 )
    precache_sound( g_szSndRocket1 )
    precache_sound( g_szSndRocket2 )
    precache_sound( g_szSndPoison )
    precache_sound( g_szSndBeep )
    precache_sound( g_szSndThunder )

    return
}
//    ______________________
//___/ client_authorized() \_______________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//public client_putinserver( id )
public client_authorized( id )
{
    if( !UAIO_PluginEnabled( UAIO_NULL ) )
        return

    // Flag User as Joining for ResetHUD
    g_bIsJoining[id-1] = true
    g_fAExecInterval[id-1] = 0.5

    // Check Groups
    if( !UAIO_AdminGroups( id ) )
    {
        new szLogMsg[STR_M], szUser[STR_T]
        get_user_name( id, szUser, STR_T-1 )
        format( szLogMsg, STR_M-1, "%L", LANG_SERVER, "ERR_NO_DEFAULT", PLUGIN_MOD, PLUGIN_NAME, szUser )
        UAIO_WriteLog( szLogMsg )
    }
    UAIO_RemoveAllFX( id )

    // Call Auto-Exec Instant Commands
    UAIO_UserAExec( id, AUTOEXEC_INSTANT )

    return
}
//    _____________________
//___/ client_disconnect() \________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public client_disconnect( id )
{
    if( !UAIO_PluginEnabled( UAIO_NULL ) )
        return

    // Call Auto-Exec Leave Commands
    UAIO_UserAExec( id, AUTOEXEC_LEAVE )
    g_fAExecInterval[id-1] = 0.5

    UAIO_ClearAdmin( id )
    UAIO_RemoveAllFX( id )
    return
}
//    ______________________
//___/ client_infochanged() \_______________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public client_infochanged( id )
{
    if ( !UAIO_PluginEnabled( UAIO_NULL ) || !UAIO_HasEffect( id, CMDTYPE_EVIL, UAIO_E_NLOCK ) || !is_user_connected( id ) )
        return PLUGIN_CONTINUE

    new szNewName[STR_S]
    new szOldName[STR_S]

    get_user_info( id, "name", szNewName, STR_S-1 )
    get_user_name( id, szOldName, STR_S-1 )

    if( !equal( szNewName, szOldName ) )
        set_user_info( id, "name", szOldName )

    return PLUGIN_CONTINUE
}
//    ___________________
//___/ client_prethink() \__________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public client_PreThink( id )
{
    if( !UAIO_PluginEnabled( UAIO_NULL ) )
        return PLUGIN_CONTINUE

    // Silent Footsteps
    if( UAIO_HasEffect( id, CMDTYPE_GOOD, UAIO_G_SILENT ) )
        entity_set_int( id, EV_INT_flTimeStepSound, 999 )

    // Diving Kit
    if( UAIO_HasEffect( id, CMDTYPE_GOOD, UAIO_G_DIVER ) )
        if( is_user_alive( id ) && entity_get_int( id, EV_INT_waterlevel ) == 3 )
            entity_set_float( id, EV_FL_air_finished, entity_get_float( id, EV_FL_air_finished ) + 1.0 )

    // Fire (Gets Extinguished When In Water)
    if( UAIO_HasEffect( id, CMDTYPE_EVIL, UAIO_E_FIRE ) )
    {
        if( is_user_alive( id ) && entity_get_int( id, EV_INT_waterlevel ) == 3 )
        {
            client_print( id, print_chat, "%L", LANG_PLAYER, "WATER_FLAMES", PLUGIN_MOD, PLUGIN_NAME )
            UAIO_RemoveEffect( id, CMDTYPE_EVIL, UAIO_E_FIRE )
        }
    }

    return PLUGIN_CONTINUE
}
//    __________________
//___/ client_command() \___________________________________________________________________
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
public client_command( id )
{
    if( UAIO_HasEffect( id, CMDTYPE_EVIL, UAIO_E_NOBUY ) )
    {
        /* Longest buy command has 11 chars so if command is longer then don't care. (AssKicR) */ 
        new szArg[13]
        if( read_argv( 0, szArg, 12 ) > 11 )
            return PLUGIN_CONTINUE 
    
        new i
        for( i = 0; i < MAX_ALIASES; i++ )
            if( equal( g_szWeaponAlias[i], szArg ) )
                return PLUGIN_HANDLED 
    }
    return PLUGIN_CONTINUE
}
