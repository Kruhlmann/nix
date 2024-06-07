{ character-name, ... }:
let textures = import ../textures.nix { };
in {
  # Find icons at: http://wowwiki.wikia.com/Queriable_buff_effects
  # Actionbar Slot number
  # 1: 01 02 03 04 05 06 07 08 09 10 11 12
  # 2: 13 14 15 16 17 18 19 20 21 22 23 24
  # 3: 25 26 27 28 29 30 31 32 33 34 35 36
  # 4: 37 38 39 40 41 42 43 44 45 46 47 48
  # 5: 49 50 51 52 53 54 55 56 57 58 59 60
  # 6: 61 62 63 64 65 66 67 68 69 70 71 72 
  general = {
    print = {
      rested-xp = {
        name = "Print Rested XP";
        icon = textures.inv.misc.book;
        body = ''
          /script DEFAULT_CHAT_FRAME:AddMessage("Rested:".. GetXPExhaustion());'';
      };
      coordinates = {
        name = "Print Coordinates";
        icon = "";
        body = ''
          /script SetMapToCurrentZone() local x,y=GetPlayerMapPosition("player") DEFAULT_CHAT_FRAME:AddMessage(format("%s, %s: %.1f, %.1f",GetZoneText(),GetSubZoneText(),x*100,y*100))'';
      };
      avoidance = {
        name = "Print Avoidance";
        icon = "";
        body = ''
          /script DEFAULT_CHAT_FRAME:AddMessage("Need 102.4 combined avoidance. Currently at:"..GetDodgeChance() + GetBlockChance() + GetParryChance() + (GetParryChance() - 7));'';
      };
      buff-textures = {
        name = "Print All Buff Textures";
        icon = "";
        body = ''
          /script function m(s) DEFAULT_CHAT_FRAME:AddMessage(s); end for i=1,16 do s=UnitBuff("target", i); if(s) then m("B "..i..": "..s); end s=UnitDebuff("target", i); if(s) then m("D "..i..": "..s); end end'';
      };
      tracking-textures = {
        name = "Print Current Tracking Texture";
        icon = "";
        body = ''
          /script function m(s) DEFAULT_CHAT_FRAME:AddMessage(s); end for i=1,16 do s=UnitBuff("target", i); if(s) then m("B "..i..": "..s); end s=UnitDebuff("target", i); if(s) then m("D "..i..": "..s); end end'';
      };
      shape-shift-info = {
        name = "Print Shape Shift Info";
        icon = "";
        body = ''
          /run local t,n,a=GetShapeshiftFormInfo(1)DEFAULT_CHAT_FRAME:AddMessage(t..","..n..","..(a and "active" or ""))'';
      };
      server-time = {
        name = "Print Server Time";
        icon = "";
        body = ''
          /run hour,min=GetGameTime();/run DEFAULT_CHAT_FRAME:AddMessage(format("Server time is %s:%s",hour,min));'';
      };
      ui-element-name = {
        name = "Print UI Element Name";
        icon = "";
        body =
          "/script DEFAULT_CHAT_FRAME:AddMessage( GetMouseFocus():GetName() );";
      };
      skill-info = {
        name = "Print Skill Info";
        icon = "";
        body = ''
          /run local i=1;while true do local spellName,spellRank=GetSpellName(i,BOOKTYPE_SPELL);if not spellName then break;end;DEFAULT_CHAT_FRAME:AddMessage(i..": "..spellName..'('..spellRank..')');i=i+1;end'';
      };
    };
    open-game-menu = {
      name = "Open Game Menu";
      icon = "";
      body = "/run ToggleGameMenu();";
    };
    hide-gryphons = {
      name = "Hide Action Bar Gryphons";
      icon = "";
      body = "/run MainMenuBarLeftEndCap:Hide(); MainMenuBarRightEndCap:Hide()";
    };
    set-max-camera-distance = {
      name = "Set Maximum Camera Distance";
      icon = "";
      body = ''/script SetCVar ("cameraDistancemax" ,50)'';
    };
    bind-game-menu = {
      name = "Bind Esc To Game Menu";
      icon = "";
      body = ''/run SetBinding("ESCAPE","TOGGLEGAMEMENU")SaveBindings(1)'';
    };
    reset-instance = {
      name = "Reset Instance";
      icon = "";
      body = "/script ResetInstances()";
    };
    delete-poor-items = {
      name = "Delete Poor Items";
      icon = "";
      body = ''
        /run ClearCursor()local g,i,j,s,a,b=gsub;for i=0,4 do for j=1,GetContainerNumSlots(i)do s=GetContainerItemLink(i,j)if(s)then a,b,s=GetItemInfo(g(g(s,".*\124H",""),"\124h.*",""))if(s==0) then PickupContainerItem(i,j)DeleteCursorItem()end;end;end;end'';

    };
    mana-consumable = {
      name = "Mana Consumable";
      icon = "";
      body = ''
        /run for b=0,4 do for s=1,GetContainerNumSlots(b,s)do local n=GetContainerItemLink(b,s)if n and (strfind(n,"Mana Potion"))then UseContainerItem(b,s)end end end'';

    };
    health-consumable = {
      name = "Health Consumable";
      icon = "";
      body = ''
        /run for b=0,4 do for s=1,GetContainerNumSlots(b,s)do local n=GetContainerItemLink(b,s)if n and (strfind(n,"Healthstone") or strfind(n,"Healing Potion"))then UseContainerItem(b,s,1)end end end'';

    };
    dismount = {
      name = "Dismount";
      icon = "";
      body = ''
        /run local i=0 g=GetPlayerBuff while not(g(i) == -1)do if(strfind(GetPlayerBuffTexture(g(i)), "Ability_Mount"))then CancelPlayerBuff(g(i))end i=i+1 end'';
    };
    eat-drink-conjured = {
      name = "Eat Drink Conjured";
      icon = "";
      body = ''
        /run for b=0,4 do for s=1,GetContainerNumSlots(b,s)do local n=GetContainerItemLink(b,s)if n and (strfind(n,"Conjured"))then UseContainerItem(b,s,1)end end end'';
    };
    pickup-mail-attachments = {
      name = "Pick Up Mail Attachments";
      icon = "";
      body =
        "/script GetInboxText(1); TakeInboxItem(1); TakeInboxMoney(1); DeleteInboxItem(1);";
    };
    report-quest-progress = {
      name = "Report Quest Progress";
      icon = "";
      body = ''
        /run i = GetNumQuestLeaderBoards(); for j = 1, i, 1 do a1, a2, a3 = GetQuestLogLeaderBoard(j); SendChatMessage(a1, "PARTY"); end;'';
    };
    inspect-target = {
      name = "Inspect Target";
      icon = "";
      body = ''
        /run if (UnitPlayerControlled("target") and CheckInteractDistance("target", 1) and not UnitIsUnit("player", "target")) then InspectUnit("target")end'';
    };
    mass-learn-from-trainer = {

      name = "Mass Learn From Trainer";
      icon = "";
      body =
        "/script n=GetNumTrainerServices(); i = 1; while n >= i do BuyTrainerService(i); i=i+1; end;";
    };
    sell-poor-items = {
      name = "Sell Poor Items";
      icon = "";
      body = ''
        /run for bag = 0,4,1 do for slot = 1, GetContainerNumSlots(bag),1 do local name = GetContainerItemLink(bag,slot); if name and string.find(name,"ff9d9d9d") then DEFAULT_CHAT_FRAME:AddMessage("Selling "..name);UseContainerItem(bag,slot) end; end; end'';
    };
    abandon-all-quests = {
      name = "Abandon All Quests";
      icon = "";
      body =
        "/run for i=1,GetNumQuestLogEntries() do SelectQuestLogEntry(i); SetAbandonQuest(); AbandonQuest(); end";
    };
    trinket-1 = {
      name = "Trinket 1";
      icon = "";
      body = "/run UseInventoryItem(13)";
    };
    trinket-2 = {
      name = "Trinket 2";
      icon = "";
      body = "/run UseInventoryItem(14)";
    };
    save-gear-durability = {
      name = "Save Gear Durability";
      icon = "";
      body =
        "/run ClearCursor()local k;for i=1,4 do for j=1,GetContainerNumSlots(i)do if(not GetContainerItemLink(i,j))then repeat k,l=next({1,3,5,6,7,8,9,10,16,17,18},k)if(not k)then return;end;PickupInventoryItem(l)until(CursorHasItem())PutItemInBag(i+19)end;end;end";
    };
    assist-target = {
      name = "Assist Current Target";
      icon = "";
      body = "/assist %t; /run AttackTarget();";
    };
  };
  race = {
    night-elf = {
      shadowmeld = {
        name = "Shadowmeld";
        icon = "";
        body = ''
          /run local i,x=1,0 while UnitBuff("player",i) do if UnitBuff("player",i)=="Interface\\Icons\\Ability_Ambush" then x=1 end i=i+1 end if x==0 then CastSpellByName("Shadowmeld") else end'';
      };
    };
  };
  class = {
    druid = {
      kill-totem = {
        name = "Kill Totem";
        icon = "";
        body = "/target Totem;/cast Moonfire(Rank 1)";
      };
    };
    hunter = {
      distance-based-aspect = {
        name = "Distance-based Aspect";
        icon = "";
        body = ''
          /run if CheckInteractDistance("target", 3) then CastSpellByName("Aspect of the Monkey") else CastSpellByName("Aspect of the Hawk") end'';
      };
      distance-based-slow = {
        name = "Distance-based Slow";
        icon = "";
        body = ''
          /run if CheckInteractDistance("target", 3) then CastSpellByName("Wing Clip") else CastSpellByName("Concussive Shot") end'';
      };
      feign-trap = {
        name = "Feign Death Freezing Trap";
        icon = "";
        body = ''
          /cast Freezing Trap;/script PetFollow("${character-name}"); /script if UnitAffectingCombat("player") then CastSpellByName("Feign Death") end'';
      };
      nefarian-swap = {
        name = "Nefarian Weapon Swap";
        icon = "";
        body =
          "/script PickupInventoryItem(18) if ( CursorHasItem() ) then PickupContainerItem(0, 1); else PickupContainerItem(0, 1); PickupInventoryItem(18);end";
      };
      adaptive-movement-speed-aspect = {
        name = "Cheetah Solo, Pack In Group";
        icon = "";
        body = ''
          /run if GetNumPartyMembers()==0 and GetNumRaidMembers()==0 then CastSpellByName("Aspect of the Cheetah") else CastSpellByName("Aspect of the Pack") end'';
      };
      auto-show = {
        name = "Auto Shot";
        icon = "";
        body = ''
          /script if GetUnitName("target")==nil then TargetNearestEnemy() end;/run if CheckInteractDistance("target", 3) and (not PlayerFrame.inCombat) then AttackTarget() elseif not IsAutoRepeatAction(3) then CastSpellByName("Auto Shot") end'';
      };
      melee = {
        name = "Melee";
        icon = "";
        body =
          "/script if (not PlayerFrame.inCombat) then AttackTarget() end;/cast Raptor Strike;/cast Counterattack; /cast Mongoose Bite";
      };
      disengage-stop-attacking = {
        name = "Disengage Stop Attacking";
        icon = "";
        body =
          "/run SpellStopCasting('Auto Shot') SpellStopCasting('Attack') ClearTarget()";
      };
      spammable-feign-death = {
        name = "Spammable Feign Death";
        icon = "";
        body = ''
          /run local i,x,T=1,0,"player" while UnitBuff(T,i) do if string.find(UnitBuff(T,i), "Feign") then x=1 end i=i+1 end if x==0 then CastSpellByName("Feign Death") else end'';
      };
      pet-attack = {
        name = "Pet Attack";
        icon = "";
        body = ''
          /script if GetUnitName("target")==nil then TargetNearestEnemy() end; /script CastPetAction(2); /script CastPetAction(10); /script PetAttack(target); /cast Charge; /cast Dash;'';
      };
      pet-follow = {
        name = "Pet Follow";
        icon = "";
        body = ''
          /script PetFollow("${character-name}");/script CastPetAction(10);/cast Dash'';
      };
      pet-stay = {
        name = "Pet Stay";
        icon = "";
        body = "/script CastPetAction(3);/script CastPetAction(10);";
      };
      pet-growl = {
        name = "Pet Growl";
        icon = "";
        body = ''
          /cast Growl;/run local i,g=1,0 while GetSpellName(i,"pet") do if GetSpellName(i,"pet")=="Growl" then g=i end i=i+1 end local _,y = GetSpellAutocast(g,"pet") if not y then ToggleSpellAutocast(g,"pet") end'';
      };
      feign-in-combat = {
        name = "Feign In Combat";
        icon = "";
        body = ''
          /script if UnitAffectingCombat("player") then CastSpellByName("Feign Death") end'';
      };
      deterrence-and-monkey = {
        name = "Deterrence And Monkey";
        icon = "";
        body = ''
          /cast Deterrence;/run local i,x=1,0 while UnitBuff("player",i) do if UnitBuff("player",i)=="Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey" then x=1 end i=i+1 end if x==0 then CastSpellByName("Aspect of the Monkey") else end
        '';
      };
      scatter-pet-stop = {
        name = "Scatter Pet Stop";
        icon = "";
        body = ''
          /script if GetUnitName("target")==nil then TargetNearestEnemy() end;/script if UnitExists("pettarget") and UnitIsUnit("target", "pettarget") then PetPassiveMode() CastPetAction(3); else end;/cast Scatter Shot'';
      };
      feign-immolation-trap = {
        name = "Feign Immolation Trap";
        icon = "";
        body = ''
          /cast Immolation Trap;/script if UnitAffectingCombat("player") then CastSpellByName("Feign Death") end'';
      };
      pet-maintenance = {
        name = "Pet Maintenance";
        icon = "";
        body = ''
          /run local c=CastSpellByName if UnitExists("pet") then if UnitHealth("pet")==0 then c("Revive Pet") elseif GetPetHappiness()~=nil and GetPetHappiness()~=3 then c("Feed Pet") PickupContainerItem(0, 13) else c("Dismiss Pet") end else c("Call Pet") end'';
      };
    };
  };
}
