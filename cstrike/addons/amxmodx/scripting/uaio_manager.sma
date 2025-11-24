////////////////////////////////////////////////////////////////////////////////////////////
//   uaio_manager.sma                     Version 2.0                     Date: SEPTEMBER/29/2005
//
//   RS UAIO (Ultimate All-In-One) Admin Manager Addon (Multilingual)
//   File: UAIO Admin - Admin Manager Source File
//
//   By:    Dan
//   Alias: Suicid3
//   Email: dont@spam.here
//
//   For:   Rob Secord, B.Sc.  and his excellent plugin UAIO
//   Alias: xeroblood (aka; Achilles; sufferer)
//   Email: xeroblood@msn.com
//
//   Developed using:    AMXX 1.0, 1.50, 1.55, 1.60
//   Modules:         Fun
//                    Engine
//                    CStrike
//
//   Tested On:        CS 1.6 (STEAM)
//                     Linux HLDS
//                     Windows HLDS/ListenServer
//
////////////////////////////////////////////////////////////////////////////////////////////
//   Commands:
//
//    uaio_addadmin  -- Opens the add admin menu
//
////////////////////////////////////////////////////////////////////////////////////////////
//   Credits:
//
//   xeroblood:  For his plugin and some of his functions.
//
//
////////////////////////////////////////////////////////////////////////////////////////////
//   Revision History:
//	 -  JUNE/21/2005 -- Project Started.
//	 -  JUNE/22/2005 -- Project Finished
//	 -  SEPTEMBER/29/2005 -- Added IP support for plugin
//			      -- Replace uaio_addadmin with the functioning for uaio_addadmin_menu
//			      -- Took out all the back-coding for AMX so now its only AMXX
////////////////////////////////////////////////////////////////////////////////////////////

#include "uaio_inc/config.inc"

#include <amxmodx>
#include <amxmisc>

new const PLUGIN_MOD[] = "[AMXX]"

//Change to match uaio_inc/const.inc
// From Here
#define MAX_GROUPS	32
#define MAX_CMD_TYPES	5   //Has to be max group types + 1
//To Here are all in uaio_inc/const.inc

#define MENU_SIZE	256
#define MENU_PLAYERS	8	//Do Not Change
#define MENU_GROUPS	6	//Do Not Change

new g_nMenuPosition
new g_nMenuPlayers[32]
new g_nMenuTypePos

new g_szAdminFile[101]
new g_szGroupFile[101]

new g_szUsedGroups[MAX_CMD_TYPES][MAX_GROUPS][32]
new g_szAllGroups[MAX_CMD_TYPES][MAX_GROUPS][32]
new g_szGroupTypes[MAX_CMD_TYPES][32]
new g_iAllGroupCount = 0
new g_iGroupTypes = 0
new g_iUsedGroupCount = 0
new g_iTypeGroupCount[MAX_CMD_TYPES] = 0

new bool:g_boolTypeUsed[MAX_CMD_TYPES] = false

new g_szStore[46]
new bool:gb_StoreAuth;

public plugin_init()
{
	register_plugin("UAIO Manager","2.1","$uicid3")
	register_clcmd("uaio_addadmin","DisplaySaveType",UAIO_LVL_SUPER," Shows Menu to add an admin")

	register_menucmd( register_menuid("UAIO_ADD_PLAYER"), 1023, "SelectAdmin")
	register_menucmd( register_menuid("UAIO_SAVE_TYPE"), 1023 , "SelectType")
	register_menucmd( register_menuid("UAIO_CHOOSE_GROUP"), 1023, "SelectGroup")

	register_dictionary("uaio_manager.txt")

	ReadGroups()

	return
}

stock explode( p_szOutput[][], p_iMax, p_szInput[], p_iSize, p_szDelimiter )
{
	new iIdx = 0, l = strlen(p_szInput)
	new iLen = (1 + copyc( p_szOutput[iIdx], p_iSize, p_szInput, p_szDelimiter ))
	while( (iLen < l) && (++iIdx < p_iMax) )
		iLen += (1 + copyc( p_szOutput[iIdx], p_iSize, p_szInput[iLen], p_szDelimiter ))
	return iIdx
}

stock ClearVariables()
{
	g_iUsedGroupCount = 0
	g_nMenuTypePos = 0
	for(new i =0; i < MAX_CMD_TYPES; i++)
	{
		g_boolTypeUsed[i] = false
		for(new x = 0;x < g_iTypeGroupCount[i];x++)
			copy(g_szUsedGroups[i][x],31,"")
	}
	return
}

stock GetWriteLine(szAuthid[46])
{
	new pos = 0,szLine[32],l = 0,line = -1
	new szData[3][32]
	while( read_file( g_szAdminFile, pos++, szLine, 31, l ))
	{
		line++
		if( szLine[0] == ';' || !l ) continue

		parse( szLine, szData[0], 31, szData[1], 31, szData[2], 31 )

		if( equali( szData[0], "admin" ) )
		{
			if(equal(szAuthid,szData[1]))
				return line
		}
	}
	return -1
}

stock GetGroupType(szGroup[32])
{
	for(new x = 0; x < g_iGroupTypes; x++)
	{
		for(new i = 0; i < g_iAllGroupCount; i++)
		{
			if(equali(szGroup,g_szAllGroups[x][i]))
			return x
		}
	}
	return -1
}

stock bool:CheckGroup(szGroup[32])
{
	for(new x = 0; x < MAX_CMD_TYPES; x++)
	{
		for(new i = 0; i < MAX_GROUPS; i++)
		{
			if(equali(szGroup,g_szAllGroups[x][i]))
				return true
		}
	}
	return false
}
stock CountGroups(szGroups[][32])
{
	new count = 0
	for(new x = 0;x < MAX_GROUPS;x++)
	{
		if(strlen(szGroups[x]) != 0)
			++count
	}
	return count
}

stock bool:CheckGroupUsed(szGroup[32],iType)
{
	for(new x = 0; x < MAX_GROUPS;x++)
	{
		if( (strlen(g_szAllGroups[iType][x]) != 0) && (equali(g_szUsedGroups[iType][x],szGroup)) )
			return true
	}
	return false
}

stock WriteAdminFile(id)
{
	if(!file_exists(g_szAdminFile))
	{
		client_print(id,print_console,"%s %L",LANG_PLAYER,"FILE_NOT_FOUND",PLUGIN_MOD, g_szAdminFile)
		return PLUGIN_HANDLED
	}
	
	new szFileLine[256],szWriteGroups[236]
	new len , clen , line

	len = format(szFileLine,255,"admin	^"%s^"	",g_szStore)
	clen = format(szWriteGroups,235,"^"")
	for(new x = 0; x < g_iGroupTypes; x++)
	{
		for(new i = 0; i < g_iAllGroupCount; i++)
		{
			if(strlen(g_szUsedGroups[x][i]) != 0)
			{
				clen += format(szWriteGroups[clen],235-clen,"%s ",g_szUsedGroups[x][i])
			}
		}
	}
	--clen
	clen += format(szWriteGroups[clen],235-clen,"^"")
	len += format(szFileLine[len],255-len,"%s",szWriteGroups)

	line = GetWriteLine(g_szStore)

	write_file(g_szAdminFile,szFileLine,line)
	
	ClearVariables()

	client_print(id , print_chat , "%s %L", PLUGIN_MOD , LANG_PLAYER , "SAVE_SUCC")
	
	return PLUGIN_HANDLED
}

stock SetFileNames()
{
	new szBaseDir[76]
	get_configsdir(szBaseDir,75)

	format(g_szAdminFile,75,"%s/uaio/uaio_admins.ini",szBaseDir)
	format(g_szGroupFile,75,"%s/uaio/uaio_groups.ini",szBaseDir)
}

public ReadGroups()
{
	SetFileNames()

	if(!file_exists(g_szGroupFile))
		return PLUGIN_HANDLED

	new szData[4][56], line=0,k=0, szLine[256]

	while( read_file(g_szGroupFile,line++,szLine,255,k))
	{
		if((szLine[0] == ';') || !k) continue

		parse(szLine,szData[0],55,szData[1],55,szData[2],55,szData[3],55)
		if(equali(szData[0],"group"))
		{
			for(new x = 0;x < MAX_CMD_TYPES;++x)
			{
				if(equali(szData[2],g_szGroupTypes[x]))
				{
					copy(g_szAllGroups[x][g_iTypeGroupCount[x]],31,szData[1])	//Copy the group into the appropriate spot
					++g_iTypeGroupCount[x]
					break
				}
				else if( x == (MAX_CMD_TYPES - 1))   //If its set to 4 then it went through 0-3 = 4
				{
					copy(g_szGroupTypes[g_iGroupTypes],31,szData[2])	//Add as new group
					g_iGroupTypes++					//Tally a new group type has been added
					copy(g_szAllGroups[g_iGroupTypes - 1][g_iTypeGroupCount[g_iGroupTypes -1]],31,szData[1])	//Copy the group into the appropriate spot
					++g_iTypeGroupCount[g_iGroupTypes -1]				//Tally a new group in a type has been added
				}
			}
			g_iAllGroupCount++
		}
	}
	return PLUGIN_CONTINUE
}

public DisplaySaveType(id , level , cid)
{
	if(!cmd_access(id , level , cid , 0) )
		return PLUGIN_HANDLED;

	new szMessage[356] , len = 0;
	len = format(szMessage , 255 , "\y%L^n\w",LANG_PLAYER, "MENU_TITLE_TYPE");

	len += format(szMessage[len] , 355 - len , "%L^n",LANG_PLAYER,"FRONT_MENU_LINE_1");
	len += format(szMessage[len] , 355 - len , "%L^n",LANG_PLAYER,"FRONT_MENU_LINE_2");
	len += format(szMessage[len] , 355 - len , "%L^n",LANG_PLAYER,"FRONT_MENU_LINE_3");
	len += format(szMessage[len] , 355 - len , "%L^n^n",LANG_PLAYER,"FRONT_MENU_LINE_4");
	len += format(szMessage[len] , 355 - len , "\y3)\w STEAM ID^n\y5)\w IP^n^n")
	len += format(szMessage[len] , 355 - len , "\y0)\w %L",LANG_PLAYER,"EXIT")

	new Keys = (1<<2) | (1<<4) | (1<<9);

	show_menu(id ,  Keys , szMessage , -1, "UAIO_SAVE_TYPE");
	return PLUGIN_HANDLED;
}

public SelectType( id , key )
{
	switch( key )
	{
		case 2: gb_StoreAuth = true
		case 4: gb_StoreAuth = false
		default: return PLUGIN_HANDLED;
	}
	DisplayPlayers( id , g_nMenuPosition = 0)
	return PLUGIN_CONTINUE
}
public DisplayPlayers(id, pos)
{
	if( pos < 0 ) return
	
	new i, iPlayerID
	new szMenuBody[MENU_SIZE]
	new nCurrKey = 0
	new szUserName[32]
	new nStart = pos * MENU_PLAYERS
	new nNum
	
	get_players( g_nMenuPlayers, nNum )
	
	if( nStart >= nNum )
		nStart = pos = g_nMenuPosition = 0
	
	new nLen = format( szMenuBody, MENU_SIZE-1, "\y%L\R%d/%d^n\w^n", LANG_PLAYER, "MENU_TITLE_PLAYER", pos+1, (nNum / MENU_PLAYERS + ((nNum % MENU_PLAYERS) ? 1 : 0 )) )
	new nEnd = nStart + MENU_PLAYERS
	new nKeys = (1<<9)
	
	if( nEnd > nNum )
		nEnd = nNum
	
	for( i = nStart; i < nEnd; i++ )
	{
		iPlayerID = g_nMenuPlayers[i]

		get_user_name( iPlayerID, szUserName, 31 )

		nKeys |= (1<<nCurrKey++)
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "%d. %s\w^n", nCurrKey, szUserName)
	}
	
	if( nEnd != nNum )
	{
		format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "^n9. %L^n0. Ls",LANG_PLAYER,"MORE", LANG_PLAYER,pos ? "BACK" : "EXIT" )
		nKeys |= (1<<8)
	}
	else
		format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "^n0. %L",LANG_PLAYER, pos ? "BACK" : "EXIT" )
	
	show_menu( id, nKeys, szMenuBody, -1 ,"UAIO_ADD_PLAYER")
	
	return
}

public SelectAdmin( id , key )
{
	switch( key )
	{
		case 8: DisplayPlayers( id, ++g_nMenuPosition )
		case 9: DisplayPlayers( id, --g_nMenuPosition )
		default:
		{
			new targetid = g_nMenuPlayers[g_nMenuPosition * MENU_PLAYERS + key]
			new tempAuth[45]
			if(gb_StoreAuth)
			{
				get_user_authid(targetid , tempAuth , 45);
				if( equali(tempAuth , "STEAM_ID_LAN"))
					format(g_szStore , 45 , tempAuth);
				else
					format(g_szStore , 45 , tempAuth[10]);
			}
			else
				get_user_ip(targetid , g_szStore , 45);

			g_nMenuTypePos = 0
			DisplayGroups( id, g_nMenuPosition = 0 )
		}
	}
	return PLUGIN_HANDLED
}

public DisplayGroups(id, pos)
{
	if( pos < 0 )
	{
		ClearVariables()
		return
	}
	
	new i
	new szMenuBody[MENU_SIZE]
	new nCurrKey = 0
	new nStart = pos * MENU_GROUPS
	new nNum, iGroupType,count = 0

	if(g_nMenuTypePos >= (MAX_CMD_TYPES - 1))
		g_nMenuTypePos = 0

	iGroupType = g_nMenuTypePos
	nNum = CountGroups(g_szAllGroups[iGroupType])		//g_iAllGroupCount
	
	if( nStart >= nNum )
		nStart = pos = g_nMenuPosition = 0
	
	new nLen = format( szMenuBody, MENU_SIZE-1, "\y%L\R%d/%d^n\w^n", LANG_PLAYER, "MENU_TITLE_GROUP", pos+1, (nNum / MENU_GROUPS + ((nNum % MENU_GROUPS) ? 1 : 0 )) )
	new nEnd = nStart + MENU_GROUPS
	new nKeys = (1<<6)|(1<<7)|(1<<9)
	
	if( nEnd > nNum )
		nEnd = nNum

	for( i = nStart; i < MAX_GROUPS; i++ )
	{
		if(count >= nEnd) break

		if(strlen(g_szAllGroups[iGroupType][i]) != 0)
		{
			if( (g_boolTypeUsed[iGroupType] && (CheckGroupUsed(g_szAllGroups[iGroupType][i],iGroupType))) || (!g_boolTypeUsed[iGroupType]) )
			{
				nKeys |= (1<<nCurrKey++)
				nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "%d. %s\R\y%L\w^n", nCurrKey, g_szAllGroups[iGroupType][i], LANG_PLAYER, CheckGroupUsed(g_szAllGroups[iGroupType][i],iGroupType) ? "ON" : "OFF") 
			}
			else
			{
				++nCurrKey
				nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "\d%d. %s\R\y%L\w^n", nCurrKey, g_szAllGroups[iGroupType][i], LANG_PLAYER, CheckGroupUsed(g_szAllGroups[iGroupType][i],iGroupType) ? "ON" : "OFF") 
			}
			count++
		}
	}
	
	if( nEnd != nNum )
	{
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "^n7. %L^n^n" , LANG_PLAYER , "NEXT_GROUP")
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "8. %L^n^n", LANG_PLAYER , "SAVE_ADMIN")
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "9. %L^n" , LANG_PLAYER , "MORE")
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "0. %L",LANG_PLAYER, pos ? "BACK" : "EXIT" )
		nKeys |= (1<<8)
	}
	else
	{
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "^n7. %L^n^n" , LANG_PLAYER , "NEXT_GROUP")
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "8. %L^n^n", LANG_PLAYER , "SAVE_ADMIN")
		nLen += format( szMenuBody[nLen], (MENU_SIZE-1-nLen), "0. %L",LANG_PLAYER, pos ? "BACK" : "EXIT" )
	}
	
	show_menu( id, nKeys, szMenuBody, -1 , "UAIO_CHOOSE_GROUP")
	
	return
}

public SelectGroup( id, key )
{
	switch( key )
	{
		case 6:
		{
			g_nMenuTypePos++
			DisplayGroups( id, g_nMenuPosition = 0)
		}
		case 7:
		{
			WriteAdminFile(id)
		}
		case 8: DisplayGroups( id, ++g_nMenuPosition )
		case 9: DisplayGroups( id, --g_nMenuPosition )
		default:
		{
			if(equal(g_szUsedGroups[g_nMenuTypePos][(g_nMenuPosition * MENU_GROUPS) + key], g_szAllGroups[g_nMenuTypePos][(g_nMenuPosition * MENU_GROUPS) + key]))
			{
				copy(g_szUsedGroups[g_nMenuTypePos][(g_nMenuPosition * MENU_GROUPS) + key],31,"")
				g_boolTypeUsed[g_nMenuTypePos] = false
				g_iUsedGroupCount--
			}
			else
			{
				copy(g_szUsedGroups[g_nMenuTypePos][(g_nMenuPosition * MENU_GROUPS) + key],31, g_szAllGroups[g_nMenuTypePos][(g_nMenuPosition * MENU_GROUPS) + key])
				g_boolTypeUsed[g_nMenuTypePos] = true
				g_iUsedGroupCount++
			}
			DisplayGroups( id, g_nMenuPosition )
		}
	}
	return PLUGIN_HANDLED
}