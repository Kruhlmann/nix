{ config, ... }: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.compactmode.show" = true;
        "browser.download.lastDir" = "${config.home.homeDirectory}/Downloads";
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.sidebar" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.chat.page.footerBadge" = false;
        "browser.ml.chat.page.menuBadge" = false;
        "browser.ml.chat.shortcuts" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.pageAssist.enabled" = false;
        "browser.ml.smartAssist.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.system.showWeatherOptIn" = false;
        "browser.search.region" = "DK";
        "browser.search.suggest.enabled.private" = true;
        "browser.startup.homepage" = "about:blank";
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.topsites.blockedSponsors" =
          [ "hotels.prf" "temuaffiliateprogram.pxf" "adidas" ];
        "devtools.cache.disabled" = true;
        "devtools.command-button-measure.enabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.everOpened" = true;
        "devtools.toolbox.splitconsole.open" = false;
        "gfx.webrender.all" = true;
        "layout.css.has-selector.enabled" = true;
        "sidebar.visibility" = "hide-sidebar";
        "svg.context-properties.content.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        @-moz-document url(chrome://browser/content/browser.xhtml) {
        	#main-window body { flex-direction: column-reverse !important; }
        	#navigator-toolbox { flex-direction: column-reverse !important; }
        	#urlbar-searchmode-switcher { position: static !important; }
        	#urlbar {
        		top: unset !important;
        		bottom: calc(var(--urlbar-container-height) + 2 * var(--urlbar-padding-block)) !important;
        		box-shadow: none !important;
        		display: flex !important;
        		flex-direction: column !important;
        	}
        		#urlbar > * {
        			flex: none;
        		}
        	#urlbar .urlbar-input-container {
        		order: 2;
        	}
        	#urlbar > .urlbarView {
        		order: 1;
        		border-bottom: 1px solid #666;
        	}
        	#urlbar-results {
        		display: flex;
        		flex-direction: column-reverse;
        	}
        	.search-one-offs { display: none !important; }
        	.tab-background { border-top: none !important; }
        	#navigator-toolbox::after { border: none; }
        	#TabsToolbar .tabbrowser-arrowscrollbox,
        	#tabbrowser-tabs, .tab-stack { min-height: 28px !important; }
        	.tabbrowser-tab { font-size: 100%; }
        	.tab-content { padding: 0 5px; }
        	.tab-close-button .toolbarbutton-icon { width: 12px !important; height: 12px !important; }
        	toolbox[inFullscreen=true] { display: none; }
        	#mainPopupSet panel.panel-no-padding { margin-top: calc(-50vh + 40px) !important; }
        	#mainPopupSet .panel-viewstack, #mainPopupSet popupnotification { max-height: 50vh !important; height: 50vh; }
        	#mainPopupSet panel.panel-no-padding.popup-notification-panel { margin-top: calc(-50vh - 35px) !important; }	
        	#navigator-toolbox .panel-viewstack { max-height: 75vh !important; }
        	panelview.cui-widget-panelview { flex: 1; }
        	panelview.cui-widget-panelview > vbox { flex: 1; min-height: 50vh; }
        }
      '';
    };
  };
}
