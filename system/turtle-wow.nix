{ ... }:
let
  wow = import ./pkg/turtle-wow/wow-types.nix { };
  servers = import ./pkg/turtle-wow/servers.nix { };
  addons = import ./pkg/turtle-wow/default.nix { };
in {
  config = {
    ver = "1171";
    gameConfig = {
      MusicVolume = "0.4";
      MasterVolume = "0.1";
      realmName = servers.turtleWow.realms.RP.Nordanaar;
      realmList = servers.turtleWow.realmList;
      patchlist = servers.turtleWow.patchlist;
      accountName = "ges";
      UnitNameOwn = wow.true;
      cameraPivot = wow.false;
      showGameTips = wow.false;
      cameraDistanceMaxFactor = "2";
    };

    accountConfigs = { ges = { AUTO_QUEST_WATCH = wow.false; }; };
    addons = [
      addons.balakethelock.twthreat
      addons.berranzan.modifiedpowerauras-continued
      addons.doorknob6.pfui-turtle
      addons.firenahzku.vgattackbar
      addons.hosq.bigwigs
      addons.isitlove.outfitter
      addons.jsb.gatherer
      addons.kakysha.honorspy
      addons.kxseven.vanillaratingbuster
      addons.lexiebean.atlasloot
      addons.mrrosh.healcomm
      addons.mrrosh.mcp
      addons.road-block.classicsnowfall
      addons.shagu.pfquest
      addons.shagu.pfquest-turtle
      addons.shagu.pfui
      addons.shagu.shagudps
      addons.shirsig.aux-addon-vanilla
      addons.shirsig.aux_merchant_prices
      addons.shirsig.unitscan
      addons.shirsig.wim
      addons.satan666.trinketmenu-fix
      addons.opcow.buffreminder
      addons.danieladolfsson.clevermacro
      addons.tercioo.details-damage-meter
      addons.wow-vanilla-addons.accountant
      addons.wow-vanilla-addons.postal
      addons.yogo1212.healbot-classic
      addons.fiskehatt.saysapped
      addons.proxicide.macroextender
    ];
    macros = {
      ges = [
        {
          name = "Faerie Fire";
          icon = "Ability_Marksmanship";
          body = "/cast Moonfire; /cast Wrath";
        }
        {
          name = "Another Macro";
          icon = "Spell_Nature_Polymorph";
          body = "/cast Polymorph";
        }
      ];
    };
  };
}
