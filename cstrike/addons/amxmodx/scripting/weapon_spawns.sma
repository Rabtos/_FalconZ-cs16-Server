#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <fun>
#include <cstrike>

#define Plugin "Weapon Spawn"
#define Version "1.0"
#define Author "Doombringer"

#define BEHINDBASESIZE 750
#define MAX_SPAWNPOINTS 120
#define MIN_DISTANCE 250

new const g_MODELS[29][256] = {
	"models/w_mp5.mdl",			// 0
	"models/w_tmp.mdl",			// 1
	"models/w_p90.mdl",			// 2
	"models/w_mac10.mdl",			// 3
	"models/w_ak47.mdl",			// 4
	"models/w_sg552.mdl",			// 5
	"models/w_m4a1.mdl",			// 6
	"models/w_aug.mdl",			// 7
	"models/w_scout.mdl",			// 8
	"models/w_g3sg1.mdl",			// 9
	"models/w_awp.mdl",			// 10
	"models/w_m3.mdl",			// 11
	"models/w_xm1014.mdl",			// 12
	"models/w_m249.mdl",			// 13
	"models/w_flashbang.mdl",		// 14
	"models/w_hegrenade.mdl",		// 15
	"models/w_kevlar.mdl",			// 16
	"models/w_kevlar.mdl",			// 17
	"models/w_smokegrenade.mdl",		// 18
	"models/w_deagle.mdl",		        // 19
	"models/w_elite.mdl",			// 20
	"models/w_famas.mdl",			// 21
	"models/w_fiveseven.mdl",		// 22
	"models/w_galil.mdl",	                // 23
	"models/w_glock18.mdl",		        // 24
	"models/w_p228.mdl",		        // 25
	"models/w_sg550.mdl",		        // 26
	"models/w_ump45.mdl",		        // 27
	"models/w_usp.mdl"		        // 28
}

new const g_NAMES[29][256] = {
	"weapon_mp5navy",		// 0
	"weapon_tmp",			// 1
	"weapon_p90",			// 2
	"weapon_mac10",			// 3
	"weapon_ak47",			// 4
	"weapon_sg552",			// 5
	"weapon_m4a1",			// 6
	"weapon_aug",			// 7
	"weapon_scout",			// 8
	"weapon_g3sg1",			// 9
	"weapon_awp",			// 10
	"weapon_m3",			// 11
	"weapon_xm1014",		// 12
	"weapon_m249",			// 13
	"weapon_flashbang",		// 14
	"weapon_hegrenade",		// 15
	"item_assaultsuit",		// 16
	"item_kevlar",		        // 17
	"weapon_smokegrenade",		// 18
	"weapon_deagle",		// 19
	"weapon_elite",			// 20
	"weapon_famas",			// 21
	"weapon_fiveseven",		// 22 
	"weapon_galil",	                // 23
	"weapon_glock18",		// 24
	"weapon_p228",		        // 25
	"weapon_sg550",		        // 26
	"weapon_ump45",		        // 27
	"weapon_usp"		        // 28
}

new weapon_origin[MAX_SPAWNPOINTS][3], numofspawns
new cvar, max_spawns
public plugin_init()
{
	register_plugin(Plugin, Version, Author)
	
	register_logevent("hook_newround", 2, "1=Round_Start")
	register_touch("fakeweapon","player","hook_touch")
	
	cvar = register_cvar("RS_enabled", "1")
	max_spawns = register_cvar("RS_max_spawns", "50")
}

public hook_touch(touched, toucher)
{
	new weaponid = entity_get_int(touched, EV_INT_iuser1)
	
	if(equal(g_NAMES[weaponid], "weapon_", 7))
	{
		if(check_weapon_type(weaponid) == 1 && cs_get_user_hasprim(toucher))
		return PLUGIN_HANDLED
		
		else if(check_weapon_type(weaponid) == 2 && cs_get_user_hassecond(toucher))
		return PLUGIN_HANDLED
		
		else if(check_weapon_type(weaponid) == 3)
		{
			if(weaponid == 14)
			{
				if(check_ammo(toucher, g_NAMES[weaponid]) == 2)
				return PLUGIN_HANDLED
			}
			
			if(weaponid == 15 || weaponid == 18)
			{				
				if(check_ammo(toucher, g_NAMES[weaponid]) == 1)
				return PLUGIN_HANDLED	
			}
		}
	}
	
	else if(equal(g_NAMES[weaponid], "item_", 5))
	{
		if(get_user_armor(toucher) == 100)
		return PLUGIN_HANDLED
	}
	
	
	give_item(toucher, g_NAMES[weaponid])
	give_ammo(toucher, g_NAMES[weaponid])
	
	remove_entity(touched)
	
	return PLUGIN_CONTINUE
}

public plugin_end()
{
	remove_weapons()
}

stock check_weapon_type(weapon)
{
	new type = 0
	
	switch(weapon)
	{
		case 0 .. 13, 21, 23, 26, 27: type = 1
		case 19, 20, 22, 24, 25, 28: type = 2
		case 14, 15, 18: type = 3
	}
	
	return type
}

public plugin_precache()
{
	for(new i = 0; i < 29; i++)
	{
		precache_model(g_MODELS[i])
	}
}

stock cs_get_user_hassecond(id) //Stock from Random Weapons
{  
	   new weapons[32], num = 0     
	   
	   return get_user_weapons(id, weapons, num) & (1<<CSW_GLOCK18 | 1<<CSW_USP | 1<<CSW_P228 | 1<<CSW_DEAGLE | 1<<CSW_FIVESEVEN | 1<<CSW_ELITE) 
}

stock give_ammo(id, weapon[]) //Stock from Random Weapons
{
	new ammo[32]
	
	new w_id = get_weaponid(weapon)	
	switch(w_id)
	{
		case CSW_P228: ammo = "ammo_357sig"
		case CSW_SCOUT: ammo = "ammo_762nato"
		case CSW_XM1014: ammo = "ammo_buckshot"
		case CSW_MAC10: ammo = "ammo_45acp"
		case CSW_AUG: ammo = "ammo_556nato"
		case CSW_ELITE: ammo = "ammo_9mm"
		case CSW_FIVESEVEN: ammo = "ammo_57mm"
		case CSW_UMP45: ammo = "ammo_45acp"
		case CSW_SG550: ammo = "ammo_556nato"
		case CSW_GALIL: ammo = "ammo_556nato"
		case CSW_FAMAS: ammo = "ammo_556nato"
		case CSW_USP: ammo = "ammo_45acp"
		case CSW_GLOCK18: ammo = "ammo_9mm"
		case CSW_AWP: ammo = "ammo_338magnum"
		case CSW_MP5NAVY: ammo = "ammo_9mm"
		case CSW_M249: ammo = "ammo_556natobox"
		case CSW_M3: ammo = "ammo_buckshot"
		case CSW_M4A1: ammo = "ammo_556nato"
		case CSW_TMP: ammo = "ammo_9mm"
		case CSW_G3SG1: ammo = "ammo_762nato"
		case CSW_DEAGLE: ammo = "ammo_50ae"
		case CSW_SG552: ammo = "ammo_556nato"
		case CSW_AK47: ammo = "ammo_762nato"
		case CSW_P90: ammo = "ammo_57mm"
	}
	
	for(new i = 0; i < 7; i++)
	{
		give_item(id, ammo)
	}
}

stock check_ammo(id, weaponname[])
{
	if(is_user_connected(id) == 0 || get_user_team(id) > 2)
	return 0

	new weapons[32], num
	get_user_weapons(id, weapons, num)

	new foundweapon

	for(new i = 0; i < num; i++) 
	{
		new checkweaponname[32]
		get_weaponname(weapons[i], checkweaponname, 31)

		if(equal(weaponname, checkweaponname)) 
		{
			new clip, ammo
		
			get_user_ammo(id, weapons[i], clip, ammo)
			foundweapon = ammo
			
			break;
		}
	}

	return foundweapon
}

public remove_weapons()
{
	new i = find_ent_by_class(-1, "fakeweapon")
	
	while(i)
	{
		remove_entity(i)
		i = find_ent_by_class(i, "fakeweapon")
	}
}

public hook_newround()
{
	if(get_pcvar_num(cvar) < 1)
	return PLUGIN_CONTINUE
	
	remove_weapons()
	GenSpawns()
	
	return PLUGIN_CONTINUE
}

public GenWeapons()
{
	new weapon, weaponnum

	new Float:origin[3]
	new Float:angles[3]
	
	new Float:min[3] = { -10.0, -10.0, -10.0 }
	new Float:max[3] = { 10.0, 10.0, 10.0 }

	for(new i = 1; i < get_pcvar_num(max_spawns); i++)
	{
		weapon = create_entity("info_target")
		weaponnum = random_num(0, 28)
		
		origin[0] = float(weapon_origin[i][0])
		origin[1] = float(weapon_origin[i][1])
		origin[2] = float(weapon_origin[i][2])
		
		entity_set_origin(weapon, origin)
		
		angles[1] = float(random_num(0, 180))
		entity_set_vector(weapon, EV_VEC_angles, angles)
	
		entity_set_int(weapon, EV_INT_solid, SOLID_TRIGGER)
		entity_set_int(weapon, EV_INT_iuser1, weaponnum)
		
		entity_set_size(weapon, min, max)
		
		entity_set_string(weapon, EV_SZ_classname, "fakeweapon")
		entity_set_model(weapon, g_MODELS[weaponnum])
	
		drop_to_floor(weapon)
	}
	
	return PLUGIN_HANDLED
}

public GenSpawns() //taken from Bail's Root Plugin, generates random spawn points
{
	new ctbase_id
	new tbase_id
	new Float:base_origin_temp[3]
	new Float:ctbase_origin[3] = {0.0,...}
	new Float:tbase_origin[3] = {0.0,...}
	new Float:pspawncounter

	pspawncounter = 0.0
	ctbase_id = find_ent_by_class(-1,"info_player_start")
	while (ctbase_id != 0)
	{
		pspawncounter +=1.0
		entity_get_vector (ctbase_id,EV_VEC_origin,base_origin_temp)
		ctbase_origin[0] += base_origin_temp[0]
		ctbase_origin[1] += base_origin_temp[1]
		ctbase_origin[2] += base_origin_temp[2]
		ctbase_id = find_ent_by_class(ctbase_id,"info_player_start")
	}

	ctbase_origin[0] = ctbase_origin[0] / pspawncounter
	ctbase_origin[1] = ctbase_origin[1] / pspawncounter
	ctbase_origin[2] = ctbase_origin[2] / pspawncounter

	pspawncounter = 0.0
	tbase_id = find_ent_by_class(-1,"info_player_deathmatch")
	while (tbase_id != 0)
	{
		pspawncounter +=1.0
		entity_get_vector (tbase_id,EV_VEC_origin,base_origin_temp)
		tbase_origin[0] += base_origin_temp[0]
		tbase_origin[1] += base_origin_temp[1]
		tbase_origin[2] += base_origin_temp[2]
		tbase_id = find_ent_by_class(tbase_id,"info_player_deathmatch")
	}

	tbase_origin[0] = tbase_origin[0] / pspawncounter
	tbase_origin[1] = tbase_origin[1] / pspawncounter
	tbase_origin[2] = tbase_origin[2] / pspawncounter


	new Float:ia[3]
	new Float:square_o1[3]
	new Float:square_o2[3]
	if(tbase_origin[0]>ctbase_origin[0])
	{
		square_o1[0] = tbase_origin[0]+BEHINDBASESIZE
		square_o2[0] = ctbase_origin[0]-BEHINDBASESIZE
	} else {
		square_o1[0] = ctbase_origin[0]+BEHINDBASESIZE
		square_o2[0] = tbase_origin[0]-BEHINDBASESIZE
	}
	if(tbase_origin[1]>ctbase_origin[1])
	{
		square_o1[1] = tbase_origin[1]+BEHINDBASESIZE
		square_o2[1] = ctbase_origin[1]-BEHINDBASESIZE
	} else 	{
		square_o1[1] = ctbase_origin[1]+BEHINDBASESIZE
		square_o2[1] = tbase_origin[1]-BEHINDBASESIZE
	}		
	if(tbase_origin[2]>ctbase_origin[2])
	{
		square_o1[2] = tbase_origin[2]+1000
		square_o2[2] = ctbase_origin[2]-1000
	} else {
		square_o1[2] = ctbase_origin[2]+1000
		square_o2[2] = tbase_origin[2]-1000
	}
		

	new bool:xyused[11][11]
	new Float:xadd = (square_o1[0]-square_o2[0]) / 9.0
	new Float:yadd = (square_o1[1]-square_o2[1]) / 9.0		
	new Float:zadd = (square_o1[2]-square_o2[2]) / 9.0
	new IntOr[3]

	new bool:baseswitcher = true
	new countery = 0
	for(ia[1]=square_o2[1];ia[1] <=square_o1[1]&& numofspawns < MAX_SPAWNPOINTS && countery < 10;ia[1]+=yadd)
	{
		new counterx = 0
		countery++
		for(ia[0]=square_o2[0];ia[0] <=square_o1[0] && numofspawns < MAX_SPAWNPOINTS && counterx < 10;ia[0]+=xadd)
		{
			counterx++
			if(baseswitcher)
			{
				ia[2] = ctbase_origin[2]+16.0
				baseswitcher = false
			} else {
				ia[2] = tbase_origin[2]+16.0
				baseswitcher = true
			}
			ia[0] = float(floatround(ia[0]) + random(130)-65)
			ia[1] = float(floatround(ia[1]) + random(130)-65)
			ia[2] = float(floatround(ia[2]))

			IntOr[0] = floatround(ia[0])
			IntOr[1] = floatround(ia[1])
			IntOr[2] = floatround(ia[2])
						
			if( point_contents(ia) == CONTENTS_EMPTY && !xyused[counterx][countery] && CheckVectorContent(IntOr) == 1 && CheckSpawnPointDist(IntOr) == 1 && CheckDistDown(ia) == 1)
			{
				xyused[counterx][countery] = true
				numofspawns++
				
				weapon_origin[numofspawns][0] = IntOr[0]
				weapon_origin[numofspawns][1] = IntOr[1]
				weapon_origin[numofspawns][2] = IntOr[2]
			}
			
			
		}
	}
	for(ia[2]=(ctbase_origin[2] + tbase_origin[2] ) /2.0;ia[2] <=square_o1[2]&& numofspawns < MAX_SPAWNPOINTS ;ia[2]+=zadd)
	{
		countery = 0
		for(ia[1]=square_o2[1];ia[1] <=square_o1[1] && numofspawns < MAX_SPAWNPOINTS && countery < 10;ia[1]+=yadd)
		{
			new counterx = 0
			countery++
			for(ia[0]=square_o2[0];ia[0] <=square_o1[0] && numofspawns < MAX_SPAWNPOINTS && counterx < 10;ia[0]+=xadd)
			{
				counterx++
				ia[0] = float(floatround(ia[0]) + random(130)-65)
				ia[1] = float(floatround(ia[1]) + random(130)-65)
				ia[2] = float(floatround(ia[2]))

				IntOr[0] = floatround(ia[0])
				IntOr[1] = floatround(ia[1])
				IntOr[2] = floatround(ia[2])				
				
				if( point_contents(ia) == CONTENTS_EMPTY && !xyused[counterx][countery] && CheckVectorContent(IntOr) == 1 && CheckSpawnPointDist(IntOr) == 1 && CheckDistDown(ia) == 1)
				{
					xyused[counterx][countery] = true
					numofspawns++
					weapon_origin[numofspawns][0] = IntOr[0]
					weapon_origin[numofspawns][1] = IntOr[1]
					weapon_origin[numofspawns][2] = IntOr[2]
				}
			}
		}
	}

	for(ia[2]=(ctbase_origin[2] + tbase_origin[2] ) /2.0;ia[2] >=square_o2[1]&& numofspawns < MAX_SPAWNPOINTS;ia[2]-=zadd)
	{
		countery = 0
		for(ia[1]=square_o2[1];ia[1] <=square_o1[1]&& numofspawns < MAX_SPAWNPOINTS && countery < 10;ia[1]+=yadd)
		{
			new counterx = 0
			countery++
			for(ia[0]=square_o2[0];ia[0] <=square_o1[0] && numofspawns < MAX_SPAWNPOINTS && counterx < 10;ia[0]+=xadd)
			{
				counterx++
				ia[0] = float(floatround(ia[0]) + random(130)-65)
				ia[1] = float(floatround(ia[1]) + random(130)-65)
				ia[2] = float(floatround(ia[2]))
				
				IntOr[0] = floatround(ia[0])
				IntOr[1] = floatround(ia[1])
				IntOr[2] = floatround(ia[2])
					
				if( point_contents(ia) == CONTENTS_EMPTY && !xyused[counterx][countery] && CheckVectorContent(IntOr) == 1 && CheckSpawnPointDist(IntOr) == 1 && CheckDistDown(ia) == 1)
				{
					xyused[counterx][countery] = true
					numofspawns++
					weapon_origin[numofspawns][0] = IntOr[0]
					weapon_origin[numofspawns][1] = IntOr[1]
					weapon_origin[numofspawns][2] = IntOr[2]
				}
			}
		}
	}
	
	GenWeapons()
}

stock CheckVectorContent(IntO[3])	// This function check how close a rune spawnpoint is to other rune spawnpoints. And removes any that witin MIN_DISTANCE
{
	new Float:Origin[3]
	Origin[0] = float(IntO[0])
	Origin[1] = float(IntO[1])
	Origin[2] = float(IntO[2])

	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0
	
	Origin[0] += 5.0	
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0

	Origin[0] -= 10.0	
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0

	Origin[0] += 5.0
	Origin[1] += 5.0
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0

	Origin[1] -= 10.0
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0
		
	Origin[1] += 5.0
	Origin[2] += 5.0
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0

	Origin[2] -= 10.0
	if(point_contents(Origin) != CONTENTS_EMPTY)
		return 0		
	return 1
}

stock CheckSpawnPointDist(Org1[3])
{
	for(new i=1;i<=numofspawns;i++)
	{
		if(get_distance(Org1,weapon_origin[i]) <= MIN_DISTANCE)
		{
			return -1
		}
	}
	return 1
}

stock CheckDistDown(Float:Org1[3])	// This functions is used to check how far the rune location is from the round, this is done by doing a traceline directly down.
{
	new Float:Org2[3]
	new Float:HitOrg[3]

	Org2[0] = Org1[0]
	Org2[1] = Org1[1]
	Org2[2] = -4096.0
	
	trace_line(1,Org1,Org2, HitOrg)
	if(vector_distance(Org1,HitOrg) <= MIN_DISTANCE)
		return 1
	return 0
	
}