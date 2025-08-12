

(common-lisp:in-package #:org.shirakumo.fraf.steamworks.cffi)

(common-lisp:defconstant app-proof-of-purchase-key-max
  (common-lisp:if (common-lisp:boundp 'app-proof-of-purchase-key-max)
                  (common-lisp:symbol-value 'app-proof-of-purchase-key-max)
                  240))

(common-lisp:defconstant steamapps-interface-version
  (common-lisp:if (common-lisp:boundp 'steamapps-interface-version)
                  (common-lisp:symbol-value 'steamapps-interface-version)
                  "STEAMAPPS_INTERFACE_VERSION008"))

(common-lisp:defconstant steamappticket-interface-version
  (common-lisp:if (common-lisp:boundp 'steamappticket-interface-version)
                  (common-lisp:symbol-value 'steamappticket-interface-version)
                  "STEAMAPPTICKET_INTERFACE_VERSION001"))

(common-lisp:defconstant steamclient-interface-version
  (common-lisp:if (common-lisp:boundp 'steamclient-interface-version)
                  (common-lisp:symbol-value 'steamclient-interface-version)
                  "SteamClient021"))

(common-lisp:defconstant steamcontroller-interface-version
  (common-lisp:if (common-lisp:boundp 'steamcontroller-interface-version)
                  (common-lisp:symbol-value 'steamcontroller-interface-version)
                  "SteamController008"))

(common-lisp:defconstant steam-controller-max-analog-action-data
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-analog-action-data)
                  (common-lisp:symbol-value
                   'steam-controller-max-analog-action-data)
                  1.0))

(common-lisp:defconstant steam-controller-handle-all-controllers
  (common-lisp:if (common-lisp:boundp 'steam-controller-handle-all-controllers)
                  (common-lisp:symbol-value
                   'steam-controller-handle-all-controllers)
                  18446744073709551615))

(common-lisp:defconstant steam-controller-max-active-layers
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-active-layers)
                  (common-lisp:symbol-value
                   'steam-controller-max-active-layers)
                  16))

(common-lisp:defconstant steam-controller-max-origins
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-origins)
                  (common-lisp:symbol-value 'steam-controller-max-origins)
                  8))

(common-lisp:defconstant steam-controller-max-digital-actions
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-digital-actions)
                  (common-lisp:symbol-value
                   'steam-controller-max-digital-actions)
                  256))

(common-lisp:defconstant steam-controller-max-analog-actions
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-analog-actions)
                  (common-lisp:symbol-value
                   'steam-controller-max-analog-actions)
                  24))

(common-lisp:defconstant steam-controller-max-count
  (common-lisp:if (common-lisp:boundp 'steam-controller-max-count)
                  (common-lisp:symbol-value 'steam-controller-max-count)
                  16))

(common-lisp:defconstant sce-pad-trigger-effect-control-point-num
  (common-lisp:if (common-lisp:boundp
                   'sce-pad-trigger-effect-control-point-num)
                  (common-lisp:symbol-value
                   'sce-pad-trigger-effect-control-point-num)
                  10))

(common-lisp:defconstant sce-pad-trigger-effect-trigger-num
  (common-lisp:if (common-lisp:boundp 'sce-pad-trigger-effect-trigger-num)
                  (common-lisp:symbol-value
                   'sce-pad-trigger-effect-trigger-num)
                  2))

(common-lisp:defconstant sce-pad-trigger-effect-param-index-for-r2
  (common-lisp:if (common-lisp:boundp
                   'sce-pad-trigger-effect-param-index-for-r2)
                  (common-lisp:symbol-value
                   'sce-pad-trigger-effect-param-index-for-r2)
                  1))

(common-lisp:defconstant sce-pad-trigger-effect-param-index-for-l2
  (common-lisp:if (common-lisp:boundp
                   'sce-pad-trigger-effect-param-index-for-l2)
                  (common-lisp:symbol-value
                   'sce-pad-trigger-effect-param-index-for-l2)
                  0))

(common-lisp:defconstant sce-pad-trigger-effect-trigger-mask-r2
  (common-lisp:if (common-lisp:boundp 'sce-pad-trigger-effect-trigger-mask-r2)
                  (common-lisp:symbol-value
                   'sce-pad-trigger-effect-trigger-mask-r2)
                  2))

(common-lisp:defconstant max-rich-presence-value-length
  (common-lisp:if (common-lisp:boundp 'max-rich-presence-value-length)
                  (common-lisp:symbol-value 'max-rich-presence-value-length)
                  256))

(common-lisp:defconstant max-rich-presence-key-length
  (common-lisp:if (common-lisp:boundp 'max-rich-presence-key-length)
                  (common-lisp:symbol-value 'max-rich-presence-key-length)
                  64))

(common-lisp:defconstant max-rich-presence-keys
  (common-lisp:if (common-lisp:boundp 'max-rich-presence-keys)
                  (common-lisp:symbol-value 'max-rich-presence-keys)
                  30))

(common-lisp:defconstant chat-metadata-max
  (common-lisp:if (common-lisp:boundp 'chat-metadata-max)
                  (common-lisp:symbol-value 'chat-metadata-max)
                  8192))

(common-lisp:defconstant s-friend-game-info-query-port-error
  (common-lisp:if (common-lisp:boundp 's-friend-game-info-query-port-error)
                  (common-lisp:symbol-value
                   's-friend-game-info-query-port-error)
                  65534))

(common-lisp:defconstant s-friend-game-info-query-port-not-initialized
  (common-lisp:if (common-lisp:boundp
                   's-friend-game-info-query-port-not-initialized)
                  (common-lisp:symbol-value
                   's-friend-game-info-query-port-not-initialized)
                  65535))

(common-lisp:defconstant enumerate-followers-max
  (common-lisp:if (common-lisp:boundp 'enumerate-followers-max)
                  (common-lisp:symbol-value 'enumerate-followers-max)
                  50))

(common-lisp:defconstant friends-group-limit
  (common-lisp:if (common-lisp:boundp 'friends-group-limit)
                  (common-lisp:symbol-value 'friends-group-limit)
                  100))

(common-lisp:defconstant max-friends-group-name
  (common-lisp:if (common-lisp:boundp 'max-friends-group-name)
                  (common-lisp:symbol-value 'max-friends-group-name)
                  64))

(common-lisp:defconstant steamfriends-interface-version
  (common-lisp:if (common-lisp:boundp 'steamfriends-interface-version)
                  (common-lisp:symbol-value 'steamfriends-interface-version)
                  "SteamFriends017"))

(common-lisp:defconstant steamgamecoordinator-interface-version
  (common-lisp:if (common-lisp:boundp 'steamgamecoordinator-interface-version)
                  (common-lisp:symbol-value
                   'steamgamecoordinator-interface-version)
                  "SteamGameCoordinator001"))

(common-lisp:defconstant steamgameserver-interface-version
  (common-lisp:if (common-lisp:boundp 'steamgameserver-interface-version)
                  (common-lisp:symbol-value 'steamgameserver-interface-version)
                  "SteamGameServer015"))

(common-lisp:defconstant steamgameserverstats-interface-version
  (common-lisp:if (common-lisp:boundp 'steamgameserverstats-interface-version)
                  (common-lisp:symbol-value
                   'steamgameserverstats-interface-version)
                  "SteamGameServerStats001"))

(common-lisp:defconstant steamhtmlsurface-interface-version
  (common-lisp:if (common-lisp:boundp 'steamhtmlsurface-interface-version)
                  (common-lisp:symbol-value
                   'steamhtmlsurface-interface-version)
                  "STEAMHTMLSURFACE_INTERFACE_VERSION_005"))

(common-lisp:defconstant steamhttp-interface-version
  (common-lisp:if (common-lisp:boundp 'steamhttp-interface-version)
                  (common-lisp:symbol-value 'steamhttp-interface-version)
                  "STEAMHTTP_INTERFACE_VERSION003"))

(common-lisp:defconstant invalid-httpcookie-handle
  (common-lisp:if (common-lisp:boundp 'invalid-httpcookie-handle)
                  (common-lisp:symbol-value 'invalid-httpcookie-handle)
                  0))

(common-lisp:defconstant invalid-httprequest-handle
  (common-lisp:if (common-lisp:boundp 'invalid-httprequest-handle)
                  (common-lisp:symbol-value 'invalid-httprequest-handle)
                  0))

(common-lisp:defconstant steaminput-interface-version
  (common-lisp:if (common-lisp:boundp 'steaminput-interface-version)
                  (common-lisp:symbol-value 'steaminput-interface-version)
                  "SteamInput006"))

(common-lisp:defconstant steam-input-max-analog-action-data
  (common-lisp:if (common-lisp:boundp 'steam-input-max-analog-action-data)
                  (common-lisp:symbol-value
                   'steam-input-max-analog-action-data)
                  1.0))

(common-lisp:defconstant steam-input-handle-all-controllers
  (common-lisp:if (common-lisp:boundp 'steam-input-handle-all-controllers)
                  (common-lisp:symbol-value
                   'steam-input-handle-all-controllers)
                  18446744073709551615))

(common-lisp:defconstant steam-input-max-active-layers
  (common-lisp:if (common-lisp:boundp 'steam-input-max-active-layers)
                  (common-lisp:symbol-value 'steam-input-max-active-layers)
                  16))

(common-lisp:defconstant steam-input-max-origins
  (common-lisp:if (common-lisp:boundp 'steam-input-max-origins)
                  (common-lisp:symbol-value 'steam-input-max-origins)
                  8))

(common-lisp:defconstant steam-input-max-digital-actions
  (common-lisp:if (common-lisp:boundp 'steam-input-max-digital-actions)
                  (common-lisp:symbol-value 'steam-input-max-digital-actions)
                  256))

(common-lisp:defconstant steam-input-max-analog-actions
  (common-lisp:if (common-lisp:boundp 'steam-input-max-analog-actions)
                  (common-lisp:symbol-value 'steam-input-max-analog-actions)
                  24))

(common-lisp:defconstant steam-input-max-count
  (common-lisp:if (common-lisp:boundp 'steam-input-max-count)
                  (common-lisp:symbol-value 'steam-input-max-count)
                  16))

(common-lisp:defconstant steam-inventory-update-handle-invalid
  (common-lisp:if (common-lisp:boundp 'steam-inventory-update-handle-invalid)
                  (common-lisp:symbol-value
                   'steam-inventory-update-handle-invalid)
                  18446744073709551615))

(common-lisp:defconstant steaminventory-interface-version
  (common-lisp:if (common-lisp:boundp 'steaminventory-interface-version)
                  (common-lisp:symbol-value 'steaminventory-interface-version)
                  "STEAMINVENTORY_INTERFACE_V003"))

(common-lisp:defconstant favorite-flag-history
  (common-lisp:if (common-lisp:boundp 'favorite-flag-history)
                  (common-lisp:symbol-value 'favorite-flag-history)
                  2))

(common-lisp:defconstant favorite-flag-favorite
  (common-lisp:if (common-lisp:boundp 'favorite-flag-favorite)
                  (common-lisp:symbol-value 'favorite-flag-favorite)
                  1))

(common-lisp:defconstant favorite-flag-none
  (common-lisp:if (common-lisp:boundp 'favorite-flag-none)
                  (common-lisp:symbol-value 'favorite-flag-none)
                  0))

(common-lisp:defconstant steamparties-interface-version
  (common-lisp:if (common-lisp:boundp 'steamparties-interface-version)
                  (common-lisp:symbol-value 'steamparties-interface-version)
                  "SteamParties002"))

(common-lisp:defconstant steamgamesearch-interface-version
  (common-lisp:if (common-lisp:boundp 'steamgamesearch-interface-version)
                  (common-lisp:symbol-value 'steamgamesearch-interface-version)
                  "SteamMatchGameSearch001"))

(common-lisp:defconstant steammatchmakingservers-interface-version
  (common-lisp:if (common-lisp:boundp
                   'steammatchmakingservers-interface-version)
                  (common-lisp:symbol-value
                   'steammatchmakingservers-interface-version)
                  "SteamMatchMakingServers002"))

(common-lisp:defconstant steammatchmaking-interface-version
  (common-lisp:if (common-lisp:boundp 'steammatchmaking-interface-version)
                  (common-lisp:symbol-value
                   'steammatchmaking-interface-version)
                  "SteamMatchMaking009"))

(common-lisp:defconstant max-lobby-key-length
  (common-lisp:if (common-lisp:boundp 'max-lobby-key-length)
                  (common-lisp:symbol-value 'max-lobby-key-length)
                  255))

(common-lisp:defconstant steammusic-interface-version
  (common-lisp:if (common-lisp:boundp 'steammusic-interface-version)
                  (common-lisp:symbol-value 'steammusic-interface-version)
                  "STEAMMUSIC_INTERFACE_VERSION001"))

(common-lisp:defconstant steammusicremote-interface-version
  (common-lisp:if (common-lisp:boundp 'steammusicremote-interface-version)
                  (common-lisp:symbol-value
                   'steammusicremote-interface-version)
                  "STEAMMUSICREMOTE_INTERFACE_VERSION001"))

(common-lisp:defconstant steam-music-pngmax-length
  (common-lisp:if (common-lisp:boundp 'steam-music-pngmax-length)
                  (common-lisp:symbol-value 'steam-music-pngmax-length)
                  65535))

(common-lisp:defconstant steam-music-name-max-length
  (common-lisp:if (common-lisp:boundp 'steam-music-name-max-length)
                  (common-lisp:symbol-value 'steam-music-name-max-length)
                  255))

(common-lisp:defconstant steamnetworking-interface-version
  (common-lisp:if (common-lisp:boundp 'steamnetworking-interface-version)
                  (common-lisp:symbol-value 'steamnetworking-interface-version)
                  "SteamNetworking006"))

(common-lisp:defconstant steamnetworkingmessages-interface-version
  (common-lisp:if (common-lisp:boundp
                   'steamnetworkingmessages-interface-version)
                  (common-lisp:symbol-value
                   'steamnetworkingmessages-interface-version)
                  "SteamNetworkingMessages002"))

(common-lisp:defconstant steamnetworkingsockets-interface-version
  (common-lisp:if (common-lisp:boundp
                   'steamnetworkingsockets-interface-version)
                  (common-lisp:symbol-value
                   'steamnetworkingsockets-interface-version)
                  "SteamNetworkingSockets012"))

(common-lisp:defconstant steamnetworkingutils-interface-version
  (common-lisp:if (common-lisp:boundp 'steamnetworkingutils-interface-version)
                  (common-lisp:symbol-value
                   'steamnetworkingutils-interface-version)
                  "SteamNetworkingUtils004"))

(common-lisp:defconstant steamparentalsettings-interface-version
  (common-lisp:if (common-lisp:boundp 'steamparentalsettings-interface-version)
                  (common-lisp:symbol-value
                   'steamparentalsettings-interface-version)
                  "STEAMPARENTALSETTINGS_INTERFACE_VERSION001"))

(common-lisp:defconstant steamremoteplay-interface-version
  (common-lisp:if (common-lisp:boundp 'steamremoteplay-interface-version)
                  (common-lisp:symbol-value 'steamremoteplay-interface-version)
                  "STEAMREMOTEPLAY_INTERFACE_VERSION002"))

(common-lisp:defconstant published-file-urlmax
  (common-lisp:if (common-lisp:boundp 'published-file-urlmax)
                  (common-lisp:symbol-value 'published-file-urlmax)
                  256))

(common-lisp:defconstant filename-max
  (common-lisp:if (common-lisp:boundp 'filename-max)
                  (common-lisp:symbol-value 'filename-max)
                  260))

(common-lisp:defconstant enumerate-published-files-max-results
  (common-lisp:if (common-lisp:boundp 'enumerate-published-files-max-results)
                  (common-lisp:symbol-value
                   'enumerate-published-files-max-results)
                  50))

(common-lisp:defconstant published-document-change-description-max
  (common-lisp:if (common-lisp:boundp
                   'published-document-change-description-max)
                  (common-lisp:symbol-value
                   'published-document-change-description-max)
                  8000))

(common-lisp:defconstant published-document-description-max
  (common-lisp:if (common-lisp:boundp 'published-document-description-max)
                  (common-lisp:symbol-value
                   'published-document-description-max)
                  8000))

(common-lisp:defconstant gcfile-stream-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcfile-stream-handle-invalid)
                  (common-lisp:symbol-value 'gcfile-stream-handle-invalid)
                  18446744073709551615))

(common-lisp:defconstant published-file-update-handle-invalid
  (common-lisp:if (common-lisp:boundp 'published-file-update-handle-invalid)
                  (common-lisp:symbol-value
                   'published-file-update-handle-invalid)
                  18446744073709551615))

(common-lisp:defconstant gchandle-invalid
  (common-lisp:if (common-lisp:boundp 'gchandle-invalid)
                  (common-lisp:symbol-value 'gchandle-invalid)
                  18446744073709551615))

(common-lisp:defconstant published-file-id-invalid
  (common-lisp:if (common-lisp:boundp 'published-file-id-invalid)
                  (common-lisp:symbol-value 'published-file-id-invalid)
                  0))

(common-lisp:defconstant steamremotestorage-interface-version
  (common-lisp:if (common-lisp:boundp 'steamremotestorage-interface-version)
                  (common-lisp:symbol-value
                   'steamremotestorage-interface-version)
                  "STEAMREMOTESTORAGE_INTERFACE_VERSION016"))

(common-lisp:defconstant screenshot-thumb-width
  (common-lisp:if (common-lisp:boundp 'screenshot-thumb-width)
                  (common-lisp:symbol-value 'screenshot-thumb-width)
                  200))

(common-lisp:defconstant ufstag-value-max
  (common-lisp:if (common-lisp:boundp 'ufstag-value-max)
                  (common-lisp:symbol-value 'ufstag-value-max)
                  255))

(common-lisp:defconstant ufstag-type-max
  (common-lisp:if (common-lisp:boundp 'ufstag-type-max)
                  (common-lisp:symbol-value 'ufstag-type-max)
                  255))

(common-lisp:defconstant screenshot-max-tagged-published-files
  (common-lisp:if (common-lisp:boundp 'screenshot-max-tagged-published-files)
                  (common-lisp:symbol-value
                   'screenshot-max-tagged-published-files)
                  32))

(common-lisp:defconstant screenshot-max-tagged-users
  (common-lisp:if (common-lisp:boundp 'screenshot-max-tagged-users)
                  (common-lisp:symbol-value 'screenshot-max-tagged-users)
                  32))

(common-lisp:defconstant steamscreenshots-interface-version
  (common-lisp:if (common-lisp:boundp 'steamscreenshots-interface-version)
                  (common-lisp:symbol-value
                   'steamscreenshots-interface-version)
                  "STEAMSCREENSHOTS_INTERFACE_VERSION003"))

(common-lisp:defconstant invalid-screenshot-handle
  (common-lisp:if (common-lisp:boundp 'invalid-screenshot-handle)
                  (common-lisp:symbol-value 'invalid-screenshot-handle)
                  0))

(common-lisp:defconstant max-phase-idlength
  (common-lisp:if (common-lisp:boundp 'max-phase-idlength)
                  (common-lisp:symbol-value 'max-phase-idlength)
                  64))

(common-lisp:defconstant timeline-priority-keep-current-value
  (common-lisp:if (common-lisp:boundp 'timeline-priority-keep-current-value)
                  (common-lisp:symbol-value
                   'timeline-priority-keep-current-value)
                  1000000))

(common-lisp:defconstant max-timeline-priority
  (common-lisp:if (common-lisp:boundp 'max-timeline-priority)
                  (common-lisp:symbol-value 'max-timeline-priority)
                  1000))

(common-lisp:defconstant steamtimeline-interface-version
  (common-lisp:if (common-lisp:boundp 'steamtimeline-interface-version)
                  (common-lisp:symbol-value 'steamtimeline-interface-version)
                  "STEAMTIMELINE_INTERFACE_V004"))

(common-lisp:defconstant developer-metadata-max
  (common-lisp:if (common-lisp:boundp 'developer-metadata-max)
                  (common-lisp:symbol-value 'developer-metadata-max)
                  5000))

(common-lisp:defconstant gcupdate-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcupdate-handle-invalid)
                  (common-lisp:symbol-value 'gcupdate-handle-invalid)
                  18446744073709551615))

(common-lisp:defconstant gcquery-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcquery-handle-invalid)
                  (common-lisp:symbol-value 'gcquery-handle-invalid)
                  18446744073709551615))

(common-lisp:defconstant steamugc-interface-version
  (common-lisp:if (common-lisp:boundp 'steamugc-interface-version)
                  (common-lisp:symbol-value 'steamugc-interface-version)
                  "STEAMUGC_INTERFACE_VERSION020"))

(common-lisp:defconstant cub-ticket-max-length
  (common-lisp:if (common-lisp:boundp 'cub-ticket-max-length)
                  (common-lisp:symbol-value 'cub-ticket-max-length)
                  2560))

(common-lisp:defconstant steamuser-interface-version
  (common-lisp:if (common-lisp:boundp 'steamuser-interface-version)
                  (common-lisp:symbol-value 'steamuser-interface-version)
                  "SteamUser023"))

(common-lisp:defconstant leaderboard-details-max
  (common-lisp:if (common-lisp:boundp 'leaderboard-details-max)
                  (common-lisp:symbol-value 'leaderboard-details-max)
                  64))

(common-lisp:defconstant leaderboard-name-max
  (common-lisp:if (common-lisp:boundp 'leaderboard-name-max)
                  (common-lisp:symbol-value 'leaderboard-name-max)
                  128))

(common-lisp:defconstant stat-name-max
  (common-lisp:if (common-lisp:boundp 'stat-name-max)
                  (common-lisp:symbol-value 'stat-name-max)
                  128))

(common-lisp:defconstant steamuserstats-interface-version
  (common-lisp:if (common-lisp:boundp 'steamuserstats-interface-version)
                  (common-lisp:symbol-value 'steamuserstats-interface-version)
                  "STEAMUSERSTATS_INTERFACE_VERSION013"))

(common-lisp:defconstant steamutils-interface-version
  (common-lisp:if (common-lisp:boundp 'steamutils-interface-version)
                  (common-lisp:symbol-value 'steamutils-interface-version)
                  "SteamUtils010"))

(common-lisp:defconstant steamvideo-interface-version
  (common-lisp:if (common-lisp:boundp 'steamvideo-interface-version)
                  (common-lisp:symbol-value 'steamvideo-interface-version)
                  "STEAMVIDEO_INTERFACE_V007"))

(common-lisp:defconstant max-game-server-game-data
  (common-lisp:if (common-lisp:boundp 'max-game-server-game-data)
                  (common-lisp:symbol-value 'max-game-server-game-data)
                  2048))

(common-lisp:defconstant max-game-server-tags
  (common-lisp:if (common-lisp:boundp 'max-game-server-tags)
                  (common-lisp:symbol-value 'max-game-server-tags)
                  128))

(common-lisp:defconstant max-game-server-name
  (common-lisp:if (common-lisp:boundp 'max-game-server-name)
                  (common-lisp:symbol-value 'max-game-server-name)
                  64))

(common-lisp:defconstant max-game-server-game-description
  (common-lisp:if (common-lisp:boundp 'max-game-server-game-description)
                  (common-lisp:symbol-value 'max-game-server-game-description)
                  64))

(common-lisp:defconstant max-game-server-map-name
  (common-lisp:if (common-lisp:boundp 'max-game-server-map-name)
                  (common-lisp:symbol-value 'max-game-server-map-name)
                  32))

(common-lisp:defconstant max-game-server-game-dir
  (common-lisp:if (common-lisp:boundp 'max-game-server-game-dir)
                  (common-lisp:symbol-value 'max-game-server-game-dir)
                  32))

(common-lisp:defconstant ecallback-flags-registered
  (common-lisp:if (common-lisp:boundp 'ecallback-flags-registered)
                  (common-lisp:symbol-value 'ecallback-flags-registered)
                  1))

(common-lisp:defconstant max-steam-err-msg
  (common-lisp:if (common-lisp:boundp 'max-steam-err-msg)
                  (common-lisp:symbol-value 'max-steam-err-msg)
                  1024))

(common-lisp:defconstant steam-timeline-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-timeline-callbacks)
                  (common-lisp:symbol-value 'steam-timeline-callbacks)
                  6000))

(common-lisp:defconstant steam-chat-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-chat-callbacks)
                  (common-lisp:symbol-value 'steam-chat-callbacks)
                  5900))

(common-lisp:defconstant steam-remote-play-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-remote-play-callbacks)
                  (common-lisp:symbol-value 'steam-remote-play-callbacks)
                  5700))

(common-lisp:defconstant steam-starcallbacks
  (common-lisp:if (common-lisp:boundp 'steam-starcallbacks)
                  (common-lisp:symbol-value 'steam-starcallbacks)
                  5500))

(common-lisp:defconstant steam-parties-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-parties-callbacks)
                  (common-lisp:symbol-value 'steam-parties-callbacks)
                  5300))

(common-lisp:defconstant steam-game-search-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-search-callbacks)
                  (common-lisp:symbol-value 'steam-game-search-callbacks)
                  5200))

(common-lisp:defconstant steam-parental-settings-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-parental-settings-callbacks)
                  (common-lisp:symbol-value 'steam-parental-settings-callbacks)
                  5000))

(common-lisp:defconstant steam-inventory-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-inventory-callbacks)
                  (common-lisp:symbol-value 'steam-inventory-callbacks)
                  4700))

(common-lisp:defconstant steam-video-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-video-callbacks)
                  (common-lisp:symbol-value 'steam-video-callbacks)
                  4600))

(common-lisp:defconstant steam-htmlsurface-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-htmlsurface-callbacks)
                  (common-lisp:symbol-value 'steam-htmlsurface-callbacks)
                  4500))

(common-lisp:defconstant steam-game-notification-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-notification-callbacks)
                  (common-lisp:symbol-value 'steam-game-notification-callbacks)
                  4400))

(common-lisp:defconstant steam-music-remote-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-music-remote-callbacks)
                  (common-lisp:symbol-value 'steam-music-remote-callbacks)
                  4100))

(common-lisp:defconstant steam-music-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-music-callbacks)
                  (common-lisp:symbol-value 'steam-music-callbacks)
                  4000))

(common-lisp:defconstant steam-stream-client-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-stream-client-callbacks)
                  (common-lisp:symbol-value 'steam-stream-client-callbacks)
                  3500))

(common-lisp:defconstant steam-ugccallbacks
  (common-lisp:if (common-lisp:boundp 'steam-ugccallbacks)
                  (common-lisp:symbol-value 'steam-ugccallbacks)
                  3400))

(common-lisp:defconstant steam-controller-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-controller-callbacks)
                  (common-lisp:symbol-value 'steam-controller-callbacks)
                  2800))

(common-lisp:defconstant steam-stream-launcher-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-stream-launcher-callbacks)
                  (common-lisp:symbol-value 'steam-stream-launcher-callbacks)
                  2600))

(common-lisp:defconstant steam-screenshots-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-screenshots-callbacks)
                  (common-lisp:symbol-value 'steam-screenshots-callbacks)
                  2300))

(common-lisp:defconstant steam-httpcallbacks
  (common-lisp:if (common-lisp:boundp 'steam-httpcallbacks)
                  (common-lisp:symbol-value 'steam-httpcallbacks)
                  2100))

(common-lisp:defconstant steam-game-stats-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-stats-callbacks)
                  (common-lisp:symbol-value 'steam-game-stats-callbacks)
                  2000))

(common-lisp:defconstant steam2async-callbacks
  (common-lisp:if (common-lisp:boundp 'steam2async-callbacks)
                  (common-lisp:symbol-value 'steam2async-callbacks)
                  1900))

(common-lisp:defconstant steam-game-server-stats-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-server-stats-callbacks)
                  (common-lisp:symbol-value 'steam-game-server-stats-callbacks)
                  1800))

(common-lisp:defconstant steam-game-coordinator-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-coordinator-callbacks)
                  (common-lisp:symbol-value 'steam-game-coordinator-callbacks)
                  1700))

(common-lisp:defconstant steam-game-server-items-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-server-items-callbacks)
                  (common-lisp:symbol-value 'steam-game-server-items-callbacks)
                  1500))

(common-lisp:defconstant steam-remote-storage-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-remote-storage-callbacks)
                  (common-lisp:symbol-value 'steam-remote-storage-callbacks)
                  1300))

(common-lisp:defconstant steam-networking-utils-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-networking-utils-callbacks)
                  (common-lisp:symbol-value 'steam-networking-utils-callbacks)
                  1280))

(common-lisp:defconstant steam-networking-messages-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-networking-messages-callbacks)
                  (common-lisp:symbol-value
                   'steam-networking-messages-callbacks)
                  1250))

(common-lisp:defconstant steam-networking-sockets-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-networking-sockets-callbacks)
                  (common-lisp:symbol-value
                   'steam-networking-sockets-callbacks)
                  1220))

(common-lisp:defconstant steam-networking-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-networking-callbacks)
                  (common-lisp:symbol-value 'steam-networking-callbacks)
                  1200))

(common-lisp:defconstant steam-user-stats-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-user-stats-callbacks)
                  (common-lisp:symbol-value 'steam-user-stats-callbacks)
                  1100))

(common-lisp:defconstant steam-apps-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-apps-callbacks)
                  (common-lisp:symbol-value 'steam-apps-callbacks)
                  1000))

(common-lisp:defconstant steam-utils-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-utils-callbacks)
                  (common-lisp:symbol-value 'steam-utils-callbacks)
                  700))

(common-lisp:defconstant steam-content-server-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-content-server-callbacks)
                  (common-lisp:symbol-value 'steam-content-server-callbacks)
                  600))

(common-lisp:defconstant steam-matchmaking-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-matchmaking-callbacks)
                  (common-lisp:symbol-value 'steam-matchmaking-callbacks)
                  500))

(common-lisp:defconstant steam-billing-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-billing-callbacks)
                  (common-lisp:symbol-value 'steam-billing-callbacks)
                  400))

(common-lisp:defconstant steam-friends-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-friends-callbacks)
                  (common-lisp:symbol-value 'steam-friends-callbacks)
                  300))

(common-lisp:defconstant steam-game-server-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-game-server-callbacks)
                  (common-lisp:symbol-value 'steam-game-server-callbacks)
                  200))

(common-lisp:defconstant steam-user-callbacks
  (common-lisp:if (common-lisp:boundp 'steam-user-callbacks)
                  (common-lisp:symbol-value 'steam-user-callbacks)
                  100))

(common-lisp:defconstant game-extra-info-max
  (common-lisp:if (common-lisp:boundp 'game-extra-info-max)
                  (common-lisp:symbol-value 'game-extra-info-max)
                  64))

(common-lisp:defconstant hauth-ticket-invalid
  (common-lisp:if (common-lisp:boundp 'hauth-ticket-invalid)
                  (common-lisp:symbol-value 'hauth-ticket-invalid)
                  0))

(common-lisp:defconstant steam-encrypted-app-ticket-symmetric-key-len
  (common-lisp:if (common-lisp:boundp
                   'steam-encrypted-app-ticket-symmetric-key-len)
                  (common-lisp:symbol-value
                   'steam-encrypted-app-ticket-symmetric-key-len)
                  32))

(common-lisp:defconstant max-return-ports
  (common-lisp:if (common-lisp:boundp 'max-return-ports)
                  (common-lisp:symbol-value 'max-return-ports)
                  8))

(common-lisp:defconstant max-string
  (common-lisp:if (common-lisp:boundp 'max-string)
                  (common-lisp:symbol-value 'max-string)
                  48))

(common-lisp:defconstant steam-networking-config-p2p-transport-ice-enable-all
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-all)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-all)
                  2147483647))

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-public
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-public)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-public)
                  4))

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-private
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-private)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-private)
                  2))

(common-lisp:defconstant steam-networking-config-p2p-transport-ice-enable-relay
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-relay)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-relay)
                  1))

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-disable
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-disable)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-disable)
                  0))

(common-lisp:defconstant max-steam-networking-ping-location-string
  (common-lisp:if (common-lisp:boundp
                   'max-steam-networking-ping-location-string)
                  (common-lisp:symbol-value
                   'max-steam-networking-ping-location-string)
                  1024))

(common-lisp:defconstant steam-networking-send-auto-restart-broken-session
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-send-auto-restart-broken-session)
                  (common-lisp:symbol-value
                   'steam-networking-send-auto-restart-broken-session)
                  32))

(common-lisp:defconstant steam-networking-send-use-current-thread
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-send-use-current-thread)
                  (common-lisp:symbol-value
                   'steam-networking-send-use-current-thread)
                  16))

(common-lisp:defconstant steam-networking-send-reliable
  (common-lisp:if (common-lisp:boundp 'steam-networking-send-reliable)
                  (common-lisp:symbol-value 'steam-networking-send-reliable)
                  8))

(common-lisp:defconstant steam-networking-send-no-delay
  (common-lisp:if (common-lisp:boundp 'steam-networking-send-no-delay)
                  (common-lisp:symbol-value 'steam-networking-send-no-delay)
                  4))

(common-lisp:defconstant steam-networking-send-no-nagle
  (common-lisp:if (common-lisp:boundp 'steam-networking-send-no-nagle)
                  (common-lisp:symbol-value 'steam-networking-send-no-nagle)
                  1))

(common-lisp:defconstant steam-networking-send-unreliable
  (common-lisp:if (common-lisp:boundp 'steam-networking-send-unreliable)
                  (common-lisp:symbol-value 'steam-networking-send-unreliable)
                  0))

(common-lisp:defconstant steam-network-connection-info-flags-dual-wifi
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-dual-wifi)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-dual-wifi)
                  32))

(common-lisp:defconstant steam-network-connection-info-flags-relayed
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-relayed)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-relayed)
                  16))

(common-lisp:defconstant steam-network-connection-info-flags-fast
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-fast)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-fast)
                  8))

(common-lisp:defconstant steam-network-connection-info-flags-loopback-buffers
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-loopback-buffers)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-loopback-buffers)
                  4))

(common-lisp:defconstant steam-network-connection-info-flags-unencrypted
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-unencrypted)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-unencrypted)
                  2))

(common-lisp:defconstant steam-network-connection-info-flags-unauthenticated
  (common-lisp:if (common-lisp:boundp
                   'steam-network-connection-info-flags-unauthenticated)
                  (common-lisp:symbol-value
                   'steam-network-connection-info-flags-unauthenticated)
                  1))

(common-lisp:defconstant steam-networking-max-connection-app-name
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-max-connection-app-name)
                  (common-lisp:symbol-value
                   'steam-networking-max-connection-app-name)
                  32))

(common-lisp:defconstant steam-networking-max-connection-description
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-max-connection-description)
                  (common-lisp:symbol-value
                   'steam-networking-max-connection-description)
                  128))

(common-lisp:defconstant steam-networking-max-connection-close-reason
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-max-connection-close-reason)
                  (common-lisp:symbol-value
                   'steam-networking-max-connection-close-reason)
                  128))

(common-lisp:defconstant max-steam-networking-err-msg
  (common-lisp:if (common-lisp:boundp 'max-steam-networking-err-msg)
                  (common-lisp:symbol-value 'max-steam-networking-err-msg)
                  1024))

(common-lisp:defconstant hsteam-net-poll-group-invalid
  (common-lisp:if (common-lisp:boundp 'hsteam-net-poll-group-invalid)
                  (common-lisp:symbol-value 'hsteam-net-poll-group-invalid)
                  0))

(common-lisp:defconstant hsteam-listen-socket-invalid
  (common-lisp:if (common-lisp:boundp 'hsteam-listen-socket-invalid)
                  (common-lisp:symbol-value 'hsteam-listen-socket-invalid)
                  0))

(common-lisp:defconstant hsteam-net-connection-invalid
  (common-lisp:if (common-lisp:boundp 'hsteam-net-connection-invalid)
                  (common-lisp:symbol-value 'hsteam-net-connection-invalid)
                  0))

(common-lisp:defconstant steamps3-malloc-ok
  (common-lisp:if (common-lisp:boundp 'steamps3-malloc-ok)
                  (common-lisp:symbol-value 'steamps3-malloc-ok)
                  4291840593))

(common-lisp:defconstant steamps3-malloc-system
  (common-lisp:if (common-lisp:boundp 'steamps3-malloc-system)
                  (common-lisp:symbol-value 'steamps3-malloc-system)
                  219163720))

(common-lisp:defconstant steamps3-malloc-inuse
  (common-lisp:if (common-lisp:boundp 'steamps3-malloc-inuse)
                  (common-lisp:symbol-value 'steamps3-malloc-inuse)
                  1406159441))

(common-lisp:defconstant steam-ps3-current-params-ver
  (common-lisp:if (common-lisp:boundp 'steam-ps3-current-params-ver)
                  (common-lisp:symbol-value 'steam-ps3-current-params-ver)
                  2))

(common-lisp:defconstant steam-ps3-region-code-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-region-code-max)
                  (common-lisp:symbol-value 'steam-ps3-region-code-max)
                  16))

(common-lisp:defconstant steam-ps3-language-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-language-max)
                  (common-lisp:symbol-value 'steam-ps3-language-max)
                  64))

(common-lisp:defconstant steam-ps3-communication-sig-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-communication-sig-max)
                  (common-lisp:symbol-value 'steam-ps3-communication-sig-max)
                  160))

(common-lisp:defconstant steam-ps3-communication-id-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-communication-id-max)
                  (common-lisp:symbol-value 'steam-ps3-communication-id-max)
                  10))

(common-lisp:defconstant steam-ps3-service-id-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-service-id-max)
                  (common-lisp:symbol-value 'steam-ps3-service-id-max)
                  32))

(common-lisp:defconstant steam-ps3-path-max
  (common-lisp:if (common-lisp:boundp 'steam-ps3-path-max)
                  (common-lisp:symbol-value 'steam-ps3-path-max)
                  1055))

(common-lisp:defconstant party-beacon-id-invalid
  (common-lisp:if (common-lisp:boundp 'party-beacon-id-invalid)
                  (common-lisp:symbol-value 'party-beacon-id-invalid)
                  0))

(common-lisp:defconstant account-id-invalid
  (common-lisp:if (common-lisp:boundp 'account-id-invalid)
                  (common-lisp:symbol-value 'account-id-invalid)
                  0))

(common-lisp:defconstant apicall-invalid
  (common-lisp:if (common-lisp:boundp 'apicall-invalid)
                  (common-lisp:symbol-value 'apicall-invalid)
                  0))

(common-lisp:defconstant depot-id-invalid
  (common-lisp:if (common-lisp:boundp 'depot-id-invalid)
                  (common-lisp:symbol-value 'depot-id-invalid)
                  0))

(common-lisp:defconstant app-id-invalid
  (common-lisp:if (common-lisp:boundp 'app-id-invalid)
                  (common-lisp:symbol-value 'app-id-invalid)
                  0))

(common-lisp:defconstant published-document-title-max 129)

(common-lisp:defconstant published-document-description-max 8000)

(common-lisp:defconstant app-id-invalid
  (common-lisp:if (common-lisp:boundp 'app-id-invalid)
                  (common-lisp:symbol-value 'app-id-invalid)
                  "0x0"))

(common-lisp:defconstant depot-id-invalid
  (common-lisp:if (common-lisp:boundp 'depot-id-invalid)
                  (common-lisp:symbol-value 'depot-id-invalid)
                  "0x0"))

(common-lisp:defconstant apicall-invalid
  (common-lisp:if (common-lisp:boundp 'apicall-invalid)
                  (common-lisp:symbol-value 'apicall-invalid)
                  "0x0"))

(common-lisp:defconstant account-id-invalid 0)

(common-lisp:defconstant party-beacon-id-invalid 0)

(common-lisp:defconstant hauth-ticket-invalid 0)

(common-lisp:defconstant steam-account-idmask
  (common-lisp:if (common-lisp:boundp 'steam-account-idmask)
                  (common-lisp:symbol-value 'steam-account-idmask)
                  "0xFFFFFFFF"))

(common-lisp:defconstant steam-account-instance-mask
  (common-lisp:if (common-lisp:boundp 'steam-account-instance-mask)
                  (common-lisp:symbol-value 'steam-account-instance-mask)
                  "0x000FFFFF"))

(common-lisp:defconstant steam-user-default-instance 1)

(common-lisp:defconstant game-extra-info-max 64)

(common-lisp:defconstant max-steam-err-msg 1024)

(common-lisp:defconstant max-friends-group-name 64)

(common-lisp:defconstant friends-group-limit 100)

(common-lisp:defconstant friends-group-id-invalid
  (common-lisp:if (common-lisp:boundp 'friends-group-id-invalid)
                  (common-lisp:symbol-value 'friends-group-id-invalid)
                  "- 1"))

(common-lisp:defconstant enumerate-followers-max 50)

(common-lisp:defconstant s-friend-game-info-query-port-not-initialized
  (common-lisp:if (common-lisp:boundp
                   's-friend-game-info-query-port-not-initialized)
                  (common-lisp:symbol-value
                   's-friend-game-info-query-port-not-initialized)
                  "0xFFFF"))

(common-lisp:defconstant s-friend-game-info-query-port-error
  (common-lisp:if (common-lisp:boundp 's-friend-game-info-query-port-error)
                  (common-lisp:symbol-value
                   's-friend-game-info-query-port-error)
                  "0xFFFE"))

(common-lisp:defconstant chat-metadata-max 8192)

(common-lisp:defconstant max-game-server-game-dir 32)

(common-lisp:defconstant max-game-server-map-name 32)

(common-lisp:defconstant max-game-server-game-description 64)

(common-lisp:defconstant max-game-server-name 64)

(common-lisp:defconstant max-game-server-tags 128)

(common-lisp:defconstant max-game-server-game-data 2048)

(common-lisp:defconstant hserverquery-invalid
  (common-lisp:if (common-lisp:boundp 'hserverquery-invalid)
                  (common-lisp:symbol-value 'hserverquery-invalid)
                  "0xffffffff"))

(common-lisp:defconstant favorite-flag-none
  (common-lisp:if (common-lisp:boundp 'favorite-flag-none)
                  (common-lisp:symbol-value 'favorite-flag-none)
                  "0x00"))

(common-lisp:defconstant favorite-flag-favorite
  (common-lisp:if (common-lisp:boundp 'favorite-flag-favorite)
                  (common-lisp:symbol-value 'favorite-flag-favorite)
                  "0x01"))

(common-lisp:defconstant favorite-flag-history
  (common-lisp:if (common-lisp:boundp 'favorite-flag-history)
                  (common-lisp:symbol-value 'favorite-flag-history)
                  "0x02"))

(common-lisp:defconstant max-cloud-file-chunk-size
  (common-lisp:if (common-lisp:boundp 'max-cloud-file-chunk-size)
                  (common-lisp:symbol-value 'max-cloud-file-chunk-size)
                  "100 * 1024 * 1024"))

(common-lisp:defconstant published-file-id-invalid 0)

(common-lisp:defconstant gchandle-invalid
  (common-lisp:if (common-lisp:boundp 'gchandle-invalid)
                  (common-lisp:symbol-value 'gchandle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant published-file-update-handle-invalid
  (common-lisp:if (common-lisp:boundp 'published-file-update-handle-invalid)
                  (common-lisp:symbol-value
                   'published-file-update-handle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant gcfile-stream-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcfile-stream-handle-invalid)
                  (common-lisp:symbol-value 'gcfile-stream-handle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant published-document-title-max
  (common-lisp:if (common-lisp:boundp 'published-document-title-max)
                  (common-lisp:symbol-value 'published-document-title-max)
                  "128 + 1"))

(common-lisp:defconstant published-document-description-max 8000)

(common-lisp:defconstant published-document-change-description-max 8000)

(common-lisp:defconstant enumerate-published-files-max-results 50)

(common-lisp:defconstant tag-list-max
  (common-lisp:if (common-lisp:boundp 'tag-list-max)
                  (common-lisp:symbol-value 'tag-list-max)
                  "1024 + 1"))

(common-lisp:defconstant filename-max 260)

(common-lisp:defconstant published-file-urlmax 256)

(common-lisp:defconstant app-proof-of-purchase-key-max 240)

(common-lisp:defconstant screenshot-max-tagged-users 32)

(common-lisp:defconstant screenshot-max-tagged-published-files 32)

(common-lisp:defconstant ufstag-type-max 255)

(common-lisp:defconstant ufstag-value-max 255)

(common-lisp:defconstant screenshot-thumb-width 200)

(common-lisp:defconstant gcquery-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcquery-handle-invalid)
                  (common-lisp:symbol-value 'gcquery-handle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant gcupdate-handle-invalid
  (common-lisp:if (common-lisp:boundp 'gcupdate-handle-invalid)
                  (common-lisp:symbol-value 'gcupdate-handle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant k-num-ugcresults-per-page 50)

(common-lisp:defconstant developer-metadata-max 5000)

(common-lisp:defconstant invalid-htmlbrowser 0)

(common-lisp:defconstant steam-item-instance-idinvalid
  (common-lisp:if (common-lisp:boundp 'steam-item-instance-idinvalid)
                  (common-lisp:symbol-value 'steam-item-instance-idinvalid)
                  "( SteamItemInstanceID_t ) ~ 0"))

(common-lisp:defconstant steam-inventory-result-invalid
  (common-lisp:if (common-lisp:boundp 'steam-inventory-result-invalid)
                  (common-lisp:symbol-value 'steam-inventory-result-invalid)
                  "- 1"))

(common-lisp:defconstant steam-inventory-update-handle-invalid
  (common-lisp:if (common-lisp:boundp 'steam-inventory-update-handle-invalid)
                  (common-lisp:symbol-value
                   'steam-inventory-update-handle-invalid)
                  "0xffffffffffffffffull"))

(common-lisp:defconstant max-timeline-priority 1000)

(common-lisp:defconstant timeline-priority-keep-current-value 1000000)

(common-lisp:defconstant fl-max-timeline-event-duration
  (common-lisp:if (common-lisp:boundp 'fl-max-timeline-event-duration)
                  (common-lisp:symbol-value 'fl-max-timeline-event-duration)
                  "600.f"))

(common-lisp:defconstant max-phase-idlength 64)

(common-lisp:defconstant hsteam-net-connection-invalid 0)

(common-lisp:defconstant hsteam-listen-socket-invalid 0)

(common-lisp:defconstant hsteam-net-poll-group-invalid 0)

(common-lisp:defconstant max-steam-networking-err-msg 1024)

(common-lisp:defconstant steam-networking-max-connection-close-reason 128)

(common-lisp:defconstant steam-networking-max-connection-description 128)

(common-lisp:defconstant steam-networking-max-connection-app-name 32)

(common-lisp:defconstant steam-network-connection-info-flags-unauthenticated 1)

(common-lisp:defconstant steam-network-connection-info-flags-unencrypted 2)

(common-lisp:defconstant steam-network-connection-info-flags-loopback-buffers 4)

(common-lisp:defconstant steam-network-connection-info-flags-fast 8)

(common-lisp:defconstant steam-network-connection-info-flags-relayed 16)

(common-lisp:defconstant steam-network-connection-info-flags-dual-wifi 32)

(common-lisp:defconstant max-steam-networking-sockets-message-size-send
  (common-lisp:if (common-lisp:boundp
                   'max-steam-networking-sockets-message-size-send)
                  (common-lisp:symbol-value
                   'max-steam-networking-sockets-message-size-send)
                  "512 * 1024"))

(common-lisp:defconstant steam-networking-send-unreliable 0)

(common-lisp:defconstant steam-networking-send-no-nagle 1)

(common-lisp:defconstant steam-networking-send-unreliable-no-nagle
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-send-unreliable-no-nagle)
                  (common-lisp:symbol-value
                   'steam-networking-send-unreliable-no-nagle)
                  "k_nSteamNetworkingSend_Unreliable | k_nSteamNetworkingSend_NoNagle"))

(common-lisp:defconstant steam-networking-send-no-delay 4)

(common-lisp:defconstant steam-networking-send-unreliable-no-delay
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-send-unreliable-no-delay)
                  (common-lisp:symbol-value
                   'steam-networking-send-unreliable-no-delay)
                  "k_nSteamNetworkingSend_Unreliable | k_nSteamNetworkingSend_NoDelay | k_nSteamNetworkingSend_NoNagle"))

(common-lisp:defconstant steam-networking-send-reliable 8)

(common-lisp:defconstant steam-networking-send-reliable-no-nagle
  (common-lisp:if (common-lisp:boundp 'steam-networking-send-reliable-no-nagle)
                  (common-lisp:symbol-value
                   'steam-networking-send-reliable-no-nagle)
                  "k_nSteamNetworkingSend_Reliable | k_nSteamNetworkingSend_NoNagle"))

(common-lisp:defconstant steam-networking-send-use-current-thread 16)

(common-lisp:defconstant steam-networking-send-auto-restart-broken-session 32)

(common-lisp:defconstant max-steam-networking-ping-location-string 1024)

(common-lisp:defconstant steam-networking-ping-failed
  (common-lisp:if (common-lisp:boundp 'steam-networking-ping-failed)
                  (common-lisp:symbol-value 'steam-networking-ping-failed)
                  "- 1"))

(common-lisp:defconstant steam-networking-ping-unknown
  (common-lisp:if (common-lisp:boundp 'steam-networking-ping-unknown)
                  (common-lisp:symbol-value 'steam-networking-ping-unknown)
                  "- 2"))

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-default
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-default)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-default)
                  "- 1"))

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-disable
  0)

(common-lisp:defconstant steam-networking-config-p2p-transport-ice-enable-relay
  1)

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-private
  2)

(common-lisp:defconstant
    steam-networking-config-p2p-transport-ice-enable-public
  4)

(common-lisp:defconstant steam-networking-config-p2p-transport-ice-enable-all
  (common-lisp:if (common-lisp:boundp
                   'steam-networking-config-p2p-transport-ice-enable-all)
                  (common-lisp:symbol-value
                   'steam-networking-config-p2p-transport-ice-enable-all)
                  "0x7fffffff"))

(common-lisp:defconstant steam-datagram-popid-dev
  (common-lisp:if (common-lisp:boundp 'steam-datagram-popid-dev)
                  (common-lisp:symbol-value 'steam-datagram-popid-dev)
                  "( ( uint32 ) 'd' << 16U ) | ( ( uint32 ) 'e' << 8U ) | ( uint32 ) 'v'"))

(common-lisp:defconstant steamgameserver-query-port-shared
  (common-lisp:if (common-lisp:boundp 'steamgameserver-query-port-shared)
                  (common-lisp:symbol-value 'steamgameserver-query-port-shared)
                  "0xffff"))

(common-lisp:defconstant masterserverupdaterport-usegamesocketshare
  (common-lisp:if (common-lisp:boundp
                   'masterserverupdaterport-usegamesocketshare)
                  (common-lisp:symbol-value
                   'masterserverupdaterport-usegamesocketshare)
                  "STEAMGAMESERVER_QUERY_PORT_SHARED"))

(common-lisp:defconstant steam-datagram-max-serialized-ticket 512)

(common-lisp:defconstant
    max-steam-datagram-game-coordinator-server-login-app-data
  2048)

(common-lisp:defconstant
    max-steam-datagram-game-coordinator-server-login-serialized
  4096)

(common-lisp:defconstant steam-networking-sockets-fake-udpport-recommended-mtu
  1200)

(common-lisp:defconstant steam-networking-sockets-fake-udpport-max-message-size
  4096)

(common-lisp:setf (common-lisp:gethash 'steam-servers-connected
                                       *callback-id-map*)
                    101)

(common-lisp:setf (common-lisp:gethash 'steam-server-connect-failure
                                       *callback-id-map*)
                    102)

(common-lisp:setf (common-lisp:gethash 'steam-servers-disconnected
                                       *callback-id-map*)
                    103)

(common-lisp:setf (common-lisp:gethash 'client-game-server-deny
                                       *callback-id-map*)
                    113)

(common-lisp:setf (common-lisp:gethash 'ipcfailure *callback-id-map*) 117)

(common-lisp:setf (common-lisp:gethash 'licenses-updated *callback-id-map*) 125)

(common-lisp:setf (common-lisp:gethash 'validate-auth-ticket *callback-id-map*)
                    143)

(common-lisp:setf (common-lisp:gethash 'micro-txn-authorization
                                       *callback-id-map*)
                    152)

(common-lisp:setf (common-lisp:gethash 'encrypted-app-ticket *callback-id-map*)
                    154)

(common-lisp:setf (common-lisp:gethash 'get-auth-session-ticket
                                       *callback-id-map*)
                    163)

(common-lisp:setf (common-lisp:gethash 'game-web-callback *callback-id-map*)
                    164)

(common-lisp:setf (common-lisp:gethash 'store-auth-url *callback-id-map*) 165)

(common-lisp:setf (common-lisp:gethash 'market-eligibility *callback-id-map*)
                    166)

(common-lisp:setf (common-lisp:gethash 'duration-control *callback-id-map*) 167)

(common-lisp:setf (common-lisp:gethash 'get-ticket-for-web-api
                                       *callback-id-map*)
                    168)

(common-lisp:setf (common-lisp:gethash 'persona-state-change *callback-id-map*)
                    304)

(common-lisp:setf (common-lisp:gethash 'game-overlay-activated
                                       *callback-id-map*)
                    331)

(common-lisp:setf (common-lisp:gethash 'game-server-change-requested
                                       *callback-id-map*)
                    332)

(common-lisp:setf (common-lisp:gethash 'game-lobby-join-requested
                                       *callback-id-map*)
                    333)

(common-lisp:setf (common-lisp:gethash 'avatar-image-loaded *callback-id-map*)
                    334)

(common-lisp:setf (common-lisp:gethash 'clan-officer-list *callback-id-map*)
                    335)

(common-lisp:setf (common-lisp:gethash 'friend-rich-presence-update
                                       *callback-id-map*)
                    336)

(common-lisp:setf (common-lisp:gethash 'game-rich-presence-join-requested
                                       *callback-id-map*)
                    337)

(common-lisp:setf (common-lisp:gethash 'game-connected-clan-chat-msg
                                       *callback-id-map*)
                    338)

(common-lisp:setf (common-lisp:gethash 'game-connected-chat-join
                                       *callback-id-map*)
                    339)

(common-lisp:setf (common-lisp:gethash 'game-connected-chat-leave
                                       *callback-id-map*)
                    340)

(common-lisp:setf (common-lisp:gethash 'download-clan-activity-counts
                                       *callback-id-map*)
                    341)

(common-lisp:setf (common-lisp:gethash 'join-clan-chat-room-completion
                                       *callback-id-map*)
                    342)

(common-lisp:setf (common-lisp:gethash 'game-connected-friend-chat-msg
                                       *callback-id-map*)
                    343)

(common-lisp:setf (common-lisp:gethash 'friends-get-follower-count
                                       *callback-id-map*)
                    344)

(common-lisp:setf (common-lisp:gethash 'friends-is-following *callback-id-map*)
                    345)

(common-lisp:setf (common-lisp:gethash 'friends-enumerate-following-list
                                       *callback-id-map*)
                    346)

(common-lisp:setf (common-lisp:gethash 'set-persona-name *callback-id-map*) 347)

(common-lisp:setf (common-lisp:gethash 'unread-chat-messages-changed
                                       *callback-id-map*)
                    348)

(common-lisp:setf (common-lisp:gethash 'overlay-browser-protocol-navigation
                                       *callback-id-map*)
                    349)

(common-lisp:setf (common-lisp:gethash 'equipped-profile-items-changed
                                       *callback-id-map*)
                    350)

(common-lisp:setf (common-lisp:gethash 'equipped-profile-items
                                       *callback-id-map*)
                    351)

(common-lisp:setf (common-lisp:gethash 'ipcountry *callback-id-map*) 701)

(common-lisp:setf (common-lisp:gethash 'low-battery-power *callback-id-map*)
                    702)

(common-lisp:setf (common-lisp:gethash 'steam-apicall-completed
                                       *callback-id-map*)
                    703)

(common-lisp:setf (common-lisp:gethash 'steam-shutdown *callback-id-map*) 704)

(common-lisp:setf (common-lisp:gethash 'check-file-signature *callback-id-map*)
                    705)

(common-lisp:setf (common-lisp:gethash 'gamepad-text-input-dismissed
                                       *callback-id-map*)
                    714)

(common-lisp:setf (common-lisp:gethash 'app-resuming-from-suspend
                                       *callback-id-map*)
                    736)

(common-lisp:setf (common-lisp:gethash 'floating-gamepad-text-input-dismissed
                                       *callback-id-map*)
                    738)

(common-lisp:setf (common-lisp:gethash 'filter-text-dictionary-changed
                                       *callback-id-map*)
                    739)

(common-lisp:setf (common-lisp:gethash 'favorites-list-changed
                                       *callback-id-map*)
                    502)

(common-lisp:setf (common-lisp:gethash 'lobby-invite *callback-id-map*) 503)

(common-lisp:setf (common-lisp:gethash 'lobby-enter *callback-id-map*) 504)

(common-lisp:setf (common-lisp:gethash 'lobby-data-update *callback-id-map*)
                    505)

(common-lisp:setf (common-lisp:gethash 'lobby-chat-update *callback-id-map*)
                    506)

(common-lisp:setf (common-lisp:gethash 'lobby-chat-msg *callback-id-map*) 507)

(common-lisp:setf (common-lisp:gethash 'lobby-game-created *callback-id-map*)
                    509)

(common-lisp:setf (common-lisp:gethash 'lobby-match-list *callback-id-map*) 510)

(common-lisp:setf (common-lisp:gethash 'lobby-kicked *callback-id-map*) 512)

(common-lisp:setf (common-lisp:gethash 'lobby-created *callback-id-map*) 513)

(common-lisp:setf (common-lisp:gethash 'psngame-boot-invite *callback-id-map*)
                    515)

(common-lisp:setf (common-lisp:gethash 'favorites-list-accounts-updated
                                       *callback-id-map*)
                    516)

(common-lisp:setf (common-lisp:gethash 'search-for-game-progress-callback
                                       *callback-id-map*)
                    5201)

(common-lisp:setf (common-lisp:gethash 'search-for-game-result-callback
                                       *callback-id-map*)
                    5202)

(common-lisp:setf (common-lisp:gethash
                   'request-players-for-game-progress-callback
                   *callback-id-map*)
                    5211)

(common-lisp:setf (common-lisp:gethash
                   'request-players-for-game-result-callback *callback-id-map*)
                    5212)

(common-lisp:setf (common-lisp:gethash
                   'request-players-for-game-final-result-callback
                   *callback-id-map*)
                    5213)

(common-lisp:setf (common-lisp:gethash 'submit-player-result-result-callback
                                       *callback-id-map*)
                    5214)

(common-lisp:setf (common-lisp:gethash 'end-game-result-callback
                                       *callback-id-map*)
                    5215)

(common-lisp:setf (common-lisp:gethash 'join-party-callback *callback-id-map*)
                    5301)

(common-lisp:setf (common-lisp:gethash 'create-beacon-callback
                                       *callback-id-map*)
                    5302)

(common-lisp:setf (common-lisp:gethash 'reservation-notification-callback
                                       *callback-id-map*)
                    5303)

(common-lisp:setf (common-lisp:gethash 'change-num-open-slots-callback
                                       *callback-id-map*)
                    5304)

(common-lisp:setf (common-lisp:gethash 'available-beacon-locations-updated
                                       *callback-id-map*)
                    5305)

(common-lisp:setf (common-lisp:gethash 'active-beacons-updated
                                       *callback-id-map*)
                    5306)

(common-lisp:setf (common-lisp:gethash 'remote-storage-file-share
                                       *callback-id-map*)
                    1307)

(common-lisp:setf (common-lisp:gethash 'remote-storage-publish-file
                                       *callback-id-map*)
                    1309)

(common-lisp:setf (common-lisp:gethash 'remote-storage-delete-published-file
                                       *callback-id-map*)
                    1311)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-published-files
                   *callback-id-map*)
                    1312)

(common-lisp:setf (common-lisp:gethash 'remote-storage-subscribe-published-file
                                       *callback-id-map*)
                    1313)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-subscribed-files
                   *callback-id-map*)
                    1314)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-unsubscribe-published-file
                   *callback-id-map*)
                    1315)

(common-lisp:setf (common-lisp:gethash 'remote-storage-update-published-file
                                       *callback-id-map*)
                    1316)

(common-lisp:setf (common-lisp:gethash 'remote-storage-download-ugc
                                       *callback-id-map*)
                    1317)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-get-published-file-details
                   *callback-id-map*)
                    1318)

(common-lisp:setf (common-lisp:gethash 'remote-storage-enumerate-workshop-files
                                       *callback-id-map*)
                    1319)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-get-published-item-vote-details
                   *callback-id-map*)
                    1320)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-published-file-subscribed *callback-id-map*)
                    1321)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-published-file-unsubscribed
                   *callback-id-map*)
                    1322)

(common-lisp:setf (common-lisp:gethash 'remote-storage-published-file-deleted
                                       *callback-id-map*)
                    1323)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-update-user-published-item-vote
                   *callback-id-map*)
                    1324)

(common-lisp:setf (common-lisp:gethash 'remote-storage-user-vote-details
                                       *callback-id-map*)
                    1325)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-shared-workshop-files
                   *callback-id-map*)
                    1326)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-set-user-published-file-action
                   *callback-id-map*)
                    1327)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-published-files-by-user-action
                   *callback-id-map*)
                    1328)

(common-lisp:setf (common-lisp:gethash 'remote-storage-publish-file-progress
                                       *callback-id-map*)
                    1329)

(common-lisp:setf (common-lisp:gethash 'remote-storage-published-file-updated
                                       *callback-id-map*)
                    1330)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-file-write-async-complete *callback-id-map*)
                    1331)

(common-lisp:setf (common-lisp:gethash 'remote-storage-file-read-async-complete
                                       *callback-id-map*)
                    1332)

(common-lisp:setf (common-lisp:gethash 'remote-storage-local-file-change
                                       *callback-id-map*)
                    1333)

(common-lisp:setf (common-lisp:gethash 'user-stats-received *callback-id-map*)
                    1101)

(common-lisp:setf (common-lisp:gethash 'user-stats-stored *callback-id-map*)
                    1102)

(common-lisp:setf (common-lisp:gethash 'user-achievement-stored
                                       *callback-id-map*)
                    1103)

(common-lisp:setf (common-lisp:gethash 'leaderboard-find *callback-id-map*)
                    1104)

(common-lisp:setf (common-lisp:gethash 'leaderboard-scores-downloaded
                                       *callback-id-map*)
                    1105)

(common-lisp:setf (common-lisp:gethash 'leaderboard-score-uploaded
                                       *callback-id-map*)
                    1106)

(common-lisp:setf (common-lisp:gethash 'number-of-current-players
                                       *callback-id-map*)
                    1107)

(common-lisp:setf (common-lisp:gethash 'user-stats-unloaded *callback-id-map*)
                    1108)

(common-lisp:setf (common-lisp:gethash 'user-achievement-icon-fetched
                                       *callback-id-map*)
                    1109)

(common-lisp:setf (common-lisp:gethash 'global-achievement-percentages-ready
                                       *callback-id-map*)
                    1110)

(common-lisp:setf (common-lisp:gethash 'leaderboard-ugcset *callback-id-map*)
                    1111)

(common-lisp:setf (common-lisp:gethash 'ps3trophies-installed
                                       *callback-id-map*)
                    1112)

(common-lisp:setf (common-lisp:gethash 'global-stats-received
                                       *callback-id-map*)
                    1112)

(common-lisp:setf (common-lisp:gethash 'dlc-installed *callback-id-map*) 1005)

(common-lisp:setf (common-lisp:gethash 'new-url-launch-parameters
                                       *callback-id-map*)
                    1014)

(common-lisp:setf (common-lisp:gethash 'app-proof-of-purchase-key
                                       *callback-id-map*)
                    1021)

(common-lisp:setf (common-lisp:gethash 'file-details *callback-id-map*) 1023)

(common-lisp:setf (common-lisp:gethash 'timed-trial-status *callback-id-map*)
                    1030)

(common-lisp:setf (common-lisp:gethash 'p2psession-request *callback-id-map*)
                    1202)

(common-lisp:setf (common-lisp:gethash 'p2psession-connect-fail
                                       *callback-id-map*)
                    1203)

(common-lisp:setf (common-lisp:gethash 'socket-status-callback
                                       *callback-id-map*)
                    1201)

(common-lisp:setf (common-lisp:gethash 'screenshot-ready *callback-id-map*)
                    2301)

(common-lisp:setf (common-lisp:gethash 'screenshot-requested *callback-id-map*)
                    2302)

(common-lisp:setf (common-lisp:gethash 'playback-status-has-changed
                                       *callback-id-map*)
                    4001)

(common-lisp:setf (common-lisp:gethash 'volume-has-changed *callback-id-map*)
                    4002)

(common-lisp:setf (common-lisp:gethash 'music-player-remote-will-activate
                                       *callback-id-map*)
                    4101)

(common-lisp:setf (common-lisp:gethash 'music-player-remote-will-deactivate
                                       *callback-id-map*)
                    4102)

(common-lisp:setf (common-lisp:gethash 'music-player-remote-to-front
                                       *callback-id-map*)
                    4103)

(common-lisp:setf (common-lisp:gethash 'music-player-will-quit
                                       *callback-id-map*)
                    4104)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-play
                                       *callback-id-map*)
                    4105)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-pause
                                       *callback-id-map*)
                    4106)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-play-previous
                                       *callback-id-map*)
                    4107)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-play-next
                                       *callback-id-map*)
                    4108)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-shuffled
                                       *callback-id-map*)
                    4109)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-looped
                                       *callback-id-map*)
                    4110)

(common-lisp:setf (common-lisp:gethash 'music-player-wants-volume
                                       *callback-id-map*)
                    4011)

(common-lisp:setf (common-lisp:gethash 'music-player-selects-queue-entry
                                       *callback-id-map*)
                    4012)

(common-lisp:setf (common-lisp:gethash 'music-player-selects-playlist-entry
                                       *callback-id-map*)
                    4013)

(common-lisp:setf (common-lisp:gethash
                   'music-player-wants-playing-repeat-status *callback-id-map*)
                    4114)

(common-lisp:setf (common-lisp:gethash 'httprequest-completed
                                       *callback-id-map*)
                    2101)

(common-lisp:setf (common-lisp:gethash 'httprequest-headers-received
                                       *callback-id-map*)
                    2102)

(common-lisp:setf (common-lisp:gethash 'httprequest-data-received
                                       *callback-id-map*)
                    2103)

(common-lisp:setf (common-lisp:gethash 'steam-input-device-connected
                                       *callback-id-map*)
                    2801)

(common-lisp:setf (common-lisp:gethash 'steam-input-device-disconnected
                                       *callback-id-map*)
                    2802)

(common-lisp:setf (common-lisp:gethash 'steam-input-configuration-loaded
                                       *callback-id-map*)
                    2803)

(common-lisp:setf (common-lisp:gethash 'steam-input-gamepad-slot-change
                                       *callback-id-map*)
                    2804)

(common-lisp:setf (common-lisp:gethash 'steam-ugcquery-completed
                                       *callback-id-map*)
                    3401)

(common-lisp:setf (common-lisp:gethash 'steam-ugcrequest-ugcdetails
                                       *callback-id-map*)
                    3402)

(common-lisp:setf (common-lisp:gethash 'create-item *callback-id-map*) 3403)

(common-lisp:setf (common-lisp:gethash 'submit-item-update *callback-id-map*)
                    3404)

(common-lisp:setf (common-lisp:gethash 'item-installed *callback-id-map*) 3405)

(common-lisp:setf (common-lisp:gethash 'download-item *callback-id-map*) 3406)

(common-lisp:setf (common-lisp:gethash 'user-favorite-items-list-changed
                                       *callback-id-map*)
                    3407)

(common-lisp:setf (common-lisp:gethash 'set-user-item-vote *callback-id-map*)
                    3408)

(common-lisp:setf (common-lisp:gethash 'get-user-item-vote *callback-id-map*)
                    3409)

(common-lisp:setf (common-lisp:gethash 'start-playtime-tracking
                                       *callback-id-map*)
                    3410)

(common-lisp:setf (common-lisp:gethash 'stop-playtime-tracking
                                       *callback-id-map*)
                    3411)

(common-lisp:setf (common-lisp:gethash 'add-ugcdependency *callback-id-map*)
                    3412)

(common-lisp:setf (common-lisp:gethash 'remove-ugcdependency *callback-id-map*)
                    3413)

(common-lisp:setf (common-lisp:gethash 'add-app-dependency *callback-id-map*)
                    3414)

(common-lisp:setf (common-lisp:gethash 'remove-app-dependency
                                       *callback-id-map*)
                    3415)

(common-lisp:setf (common-lisp:gethash 'get-app-dependencies *callback-id-map*)
                    3416)

(common-lisp:setf (common-lisp:gethash 'delete-item *callback-id-map*) 3417)

(common-lisp:setf (common-lisp:gethash 'user-subscribed-items-list-changed
                                       *callback-id-map*)
                    3418)

(common-lisp:setf (common-lisp:gethash 'workshop-eulastatus *callback-id-map*)
                    3420)

(common-lisp:setf (common-lisp:gethash 'html-browser-ready *callback-id-map*)
                    4501)

(common-lisp:setf (common-lisp:gethash 'html-needs-paint *callback-id-map*)
                    4502)

(common-lisp:setf (common-lisp:gethash 'html-start-request *callback-id-map*)
                    4503)

(common-lisp:setf (common-lisp:gethash 'html-close-browser *callback-id-map*)
                    4504)

(common-lisp:setf (common-lisp:gethash 'html-urlchanged *callback-id-map*) 4505)

(common-lisp:setf (common-lisp:gethash 'html-finished-request
                                       *callback-id-map*)
                    4506)

(common-lisp:setf (common-lisp:gethash 'html-open-link-in-new-tab
                                       *callback-id-map*)
                    4507)

(common-lisp:setf (common-lisp:gethash 'html-changed-title *callback-id-map*)
                    4508)

(common-lisp:setf (common-lisp:gethash 'html-search-results *callback-id-map*)
                    4509)

(common-lisp:setf (common-lisp:gethash 'html-can-go-back-and-forward
                                       *callback-id-map*)
                    4510)

(common-lisp:setf (common-lisp:gethash 'html-horizontal-scroll
                                       *callback-id-map*)
                    4511)

(common-lisp:setf (common-lisp:gethash 'html-vertical-scroll *callback-id-map*)
                    4512)

(common-lisp:setf (common-lisp:gethash 'html-link-at-position
                                       *callback-id-map*)
                    4513)

(common-lisp:setf (common-lisp:gethash 'html-jsalert *callback-id-map*) 4514)

(common-lisp:setf (common-lisp:gethash 'html-jsconfirm *callback-id-map*) 4515)

(common-lisp:setf (common-lisp:gethash 'html-file-open-dialog
                                       *callback-id-map*)
                    4516)

(common-lisp:setf (common-lisp:gethash 'html-new-window *callback-id-map*) 4521)

(common-lisp:setf (common-lisp:gethash 'html-set-cursor *callback-id-map*) 4522)

(common-lisp:setf (common-lisp:gethash 'html-status-text *callback-id-map*)
                    4523)

(common-lisp:setf (common-lisp:gethash 'html-show-tool-tip *callback-id-map*)
                    4524)

(common-lisp:setf (common-lisp:gethash 'html-update-tool-tip *callback-id-map*)
                    4525)

(common-lisp:setf (common-lisp:gethash 'html-hide-tool-tip *callback-id-map*)
                    4526)

(common-lisp:setf (common-lisp:gethash 'html-browser-restarted
                                       *callback-id-map*)
                    4527)

(common-lisp:setf (common-lisp:gethash 'steam-inventory-result-ready
                                       *callback-id-map*)
                    4700)

(common-lisp:setf (common-lisp:gethash 'steam-inventory-full-update
                                       *callback-id-map*)
                    4701)

(common-lisp:setf (common-lisp:gethash 'steam-inventory-definition-update
                                       *callback-id-map*)
                    4702)

(common-lisp:setf (common-lisp:gethash
                   'steam-inventory-eligible-promo-item-def-ids
                   *callback-id-map*)
                    4703)

(common-lisp:setf (common-lisp:gethash 'steam-inventory-start-purchase
                                       *callback-id-map*)
                    4704)

(common-lisp:setf (common-lisp:gethash 'steam-inventory-request-prices
                                       *callback-id-map*)
                    4705)

(common-lisp:setf (common-lisp:gethash
                   'steam-timeline-game-phase-recording-exists
                   *callback-id-map*)
                    6001)

(common-lisp:setf (common-lisp:gethash 'steam-timeline-event-recording-exists
                                       *callback-id-map*)
                    6002)

(common-lisp:setf (common-lisp:gethash 'get-video-url *callback-id-map*) 4611)

(common-lisp:setf (common-lisp:gethash 'get-opfsettings *callback-id-map*) 4624)

(common-lisp:setf (common-lisp:gethash 'broadcast-upload-start
                                       *callback-id-map*)
                    4604)

(common-lisp:setf (common-lisp:gethash 'broadcast-upload-stop
                                       *callback-id-map*)
                    4605)

(common-lisp:setf (common-lisp:gethash 'steam-parental-settings-changed
                                       *callback-id-map*)
                    5001)

(common-lisp:setf (common-lisp:gethash 'steam-remote-play-session-connected
                                       *callback-id-map*)
                    5701)

(common-lisp:setf (common-lisp:gethash 'steam-remote-play-session-disconnected
                                       *callback-id-map*)
                    5702)

(common-lisp:setf (common-lisp:gethash 'steam-remote-play-together-guest-invite
                                       *callback-id-map*)
                    5703)

(common-lisp:setf (common-lisp:gethash
                   'steam-networking-messages-session-request
                   *callback-id-map*)
                    1251)

(common-lisp:setf (common-lisp:gethash
                   'steam-networking-messages-session-failed *callback-id-map*)
                    1252)

(common-lisp:setf (common-lisp:gethash
                   'steam-net-connection-status-changed-callback
                   *callback-id-map*)
                    1221)

(common-lisp:setf (common-lisp:gethash 'steam-net-authentication-status
                                       *callback-id-map*)
                    1222)

(common-lisp:setf (common-lisp:gethash 'steam-relay-network-status
                                       *callback-id-map*)
                    1281)

(common-lisp:setf (common-lisp:gethash 'gsclient-approve *callback-id-map*) 201)

(common-lisp:setf (common-lisp:gethash 'gsclient-deny *callback-id-map*) 202)

(common-lisp:setf (common-lisp:gethash 'gsclient-kick *callback-id-map*) 203)

(common-lisp:setf (common-lisp:gethash 'gsclient-achievement-status
                                       *callback-id-map*)
                    206)

(common-lisp:setf (common-lisp:gethash 'gspolicy *callback-id-map*) 115)

(common-lisp:setf (common-lisp:gethash 'gsgameplay-stats *callback-id-map*) 207)

(common-lisp:setf (common-lisp:gethash 'gsclient-group-status
                                       *callback-id-map*)
                    208)

(common-lisp:setf (common-lisp:gethash 'gsreputation *callback-id-map*) 209)

(common-lisp:setf (common-lisp:gethash 'associate-with-clan *callback-id-map*)
                    210)

(common-lisp:setf (common-lisp:gethash 'compute-new-player-compatibility
                                       *callback-id-map*)
                    211)

(common-lisp:setf (common-lisp:gethash 'gsstats-received *callback-id-map*)
                    1800)

(common-lisp:setf (common-lisp:gethash 'gsstats-stored *callback-id-map*) 1801)

(common-lisp:setf (common-lisp:gethash 'gsstats-unloaded *callback-id-map*)
                    1108)

(common-lisp:setf (common-lisp:gethash 'steam-networking-fake-ip
                                       *callback-id-map*)
                    1223)

(cffi:defcenum eserver-mode
  (:invalid 0)
  (:no-authentication 1)
  (:authentication 2)
  (:authentication-and-secure 3))

(cffi:defcenum esteam-iptype
  (:ipv4 0)
  (:ipv6 1))

(cffi:defcenum euniverse
  (:invalid 0)
  (:public 1)
  (:beta 2)
  (:internal 3)
  (:dev 4)
  (:max 5))

(cffi:defcenum eresult
  (:none 0)
  (:ok 1)
  (:fail 2)
  (:no-connection 3)
  (:invalid-password 5)
  (:logged-in-elsewhere 6)
  (:invalid-protocol-ver 7)
  (:invalid-param 8)
  (:file-not-found 9)
  (:busy 10)
  (:invalid-state 11)
  (:invalid-name 12)
  (:invalid-email 13)
  (:duplicate-name 14)
  (:access-denied 15)
  (:timeout 16)
  (:banned 17)
  (:account-not-found 18)
  (:invalid-steam-id 19)
  (:service-unavailable 20)
  (:not-logged-on 21)
  (:pending 22)
  (:encryption-failure 23)
  (:insufficient-privilege 24)
  (:limit-exceeded 25)
  (:revoked 26)
  (:expired 27)
  (:already-redeemed 28)
  (:duplicate-request 29)
  (:already-owned 30)
  (:ipnot-found 31)
  (:persist-failed 32)
  (:locking-failed 33)
  (:logon-session-replaced 34)
  (:connect-failed 35)
  (:handshake-failed 36)
  (:iofailure 37)
  (:remote-disconnect 38)
  (:shopping-cart-not-found 39)
  (:blocked 40)
  (:ignored 41)
  (:no-match 42)
  (:account-disabled 43)
  (:service-read-only 44)
  (:account-not-featured 45)
  (:administrator-ok 46)
  (:content-version 47)
  (:try-another-cm 48)
  (:password-required-to-kick-session 49)
  (:already-logged-in-elsewhere 50)
  (:suspended 51)
  (:cancelled 52)
  (:data-corruption 53)
  (:disk-full 54)
  (:remote-call-failed 55)
  (:password-unset 56)
  (:external-account-unlinked 57)
  (:psnticket-invalid 58)
  (:external-account-already-linked 59)
  (:remote-file-conflict 60)
  (:illegal-password 61)
  (:same-as-previous-value 62)
  (:account-logon-denied 63)
  (:cannot-use-old-password 64)
  (:invalid-login-auth-code 65)
  (:account-logon-denied-no-mail 66)
  (:hardware-not-capable-of-ipt 67)
  (:iptinit-error 68)
  (:parental-control-restricted 69)
  (:facebook-query-error 70)
  (:expired-login-auth-code 71)
  (:iplogin-restriction-failed 72)
  (:account-locked-down 73)
  (:account-logon-denied-verified-email-required 74)
  (:no-matching-url 75)
  (:bad-response 76)
  (:require-password-re-entry 77)
  (:value-out-of-range 78)
  (:unexpected-error 79)
  (:disabled 80)
  (:invalid-cegsubmission 81)
  (:restricted-device 82)
  (:region-locked 83)
  (:rate-limit-exceeded 84)
  (:account-login-denied-need-two-factor 85)
  (:item-deleted 86)
  (:account-login-denied-throttle 87)
  (:two-factor-code-mismatch 88)
  (:two-factor-activation-code-mismatch 89)
  (:account-associated-to-multiple-partners 90)
  (:not-modified 91)
  (:no-mobile-device 92)
  (:time-not-synced 93)
  (:sms-code-failed 94)
  (:account-limit-exceeded 95)
  (:account-activity-limit-exceeded 96)
  (:phone-activity-limit-exceeded 97)
  (:refund-to-wallet 98)
  (:email-send-failure 99)
  (:not-settled 100)
  (:need-captcha 101)
  (:gsltdenied 102)
  (:gsowner-denied 103)
  (:invalid-item-type 104)
  (:ipbanned 105)
  (:gsltexpired 106)
  (:insufficient-funds 107)
  (:too-many-pending 108)
  (:no-site-licenses-found 109)
  (:wgnetwork-send-exceeded 110)
  (:account-not-friends 111)
  (:limited-user-account 112)
  (:cant-remove-item 113)
  (:account-deleted 114)
  (:existing-user-cancelled-license 115)
  (:community-cooldown 116)
  (:no-launcher-specified 117)
  (:must-agree-to-ssa 118)
  (:launcher-migrated 119)
  (:steam-realm-mismatch 120)
  (:invalid-signature 121)
  (:parse-failure 122)
  (:no-verified-phone 123)
  (:insufficient-battery 124)
  (:charger-required 125)
  (:cached-credential-invalid 126)
  (:phone-number-is-voip 127)
  (:not-supported 128)
  (:family-size-limit-exceeded 129)
  (:offline-app-cache-invalid 130))

(cffi:defcenum evoice-result
  (:ok 0)
  (:not-initialized 1)
  (:not-recording 2)
  (:no-data 3)
  (:buffer-too-small 4)
  (:data-corrupted 5)
  (:restricted 6)
  (:unsupported-codec 7)
  (:receiver-out-of-date 8)
  (:receiver-did-not-answer 9))

(cffi:defcenum edeny-reason
  (:deny-invalid 0)
  (:deny-invalid-version 1)
  (:deny-generic 2)
  (:deny-not-logged-on 3)
  (:deny-no-license 4)
  (:deny-cheater 5)
  (:deny-logged-in-else-where 6)
  (:deny-unknown-text 7)
  (:deny-incompatible-anticheat 8)
  (:deny-memory-corruption 9)
  (:deny-incompatible-software 10)
  (:deny-steam-connection-lost 11)
  (:deny-steam-connection-error 12)
  (:deny-steam-response-timed-out 13)
  (:deny-steam-validation-stalled 14)
  (:deny-steam-owner-left-guest-user 15))

(cffi:defcenum ebegin-auth-session-result
  (:ok 0)
  (:invalid-ticket 1)
  (:duplicate-request 2)
  (:invalid-version 3)
  (:game-mismatch 4)
  (:expired-ticket 5))

(cffi:defcenum eauth-session-response
  (:ok 0)
  (:user-not-connected-to-steam 1)
  (:no-license-or-expired 2)
  (:vacbanned 3)
  (:logged-in-else-where 4)
  (:vaccheck-timed-out 5)
  (:auth-ticket-canceled 6)
  (:auth-ticket-invalid-already-used 7)
  (:auth-ticket-invalid 8)
  (:publisher-issued-ban 9)
  (:auth-ticket-network-identity-failure 10))

(cffi:defcenum euser-has-license-for-app-result
  (:user-has-license-result-has-license 0)
  (:user-has-license-result-does-not-have-license 1)
  (:user-has-license-result-no-auth 2))

(cffi:defcenum eaccount-type
  (:invalid 0)
  (:individual 1)
  (:multiseat 2)
  (:game-server 3)
  (:anon-game-server 4)
  (:pending 5)
  (:content-server 6)
  (:clan 7)
  (:chat 8)
  (:console-user 9)
  (:anon-user 10)
  (:max 11))

(cffi:defcenum echat-entry-type
  (:invalid 0)
  (:chat-msg 1)
  (:typing 2)
  (:invite-game 3)
  (:emote 4)
  (:left-conversation 6)
  (:entered 7)
  (:was-kicked 8)
  (:was-banned 9)
  (:disconnected 10)
  (:historical-chat 11)
  (:link-blocked 14))

(cffi:defcenum echat-room-enter-response
  (:success 1)
  (:doesnt-exist 2)
  (:not-allowed 3)
  (:full 4)
  (:error 5)
  (:banned 6)
  (:limited 7)
  (:clan-disabled 8)
  (:community-ban 9)
  (:member-blocked-you 10)
  (:you-blocked-member 11)
  (:ratelimit-exceeded 15))

(cffi:defcenum echat-steam-idinstance-flags
  (:chat-account-instance-mask 4095)
  (:chat-instance-flag-clan 524288)
  (:chat-instance-flag-lobby 262144)
  (:chat-instance-flag-mmslobby 131072))

(cffi:defcenum enotification-position
  (:position-invalid -1)
  (:position-top-left 0)
  (:position-top-right 1)
  (:position-bottom-left 2)
  (:position-bottom-right 3))

(cffi:defcenum ebroadcast-upload-result
  (:none 0)
  (:ok 1)
  (:init-failed 2)
  (:frame-failed 3)
  (:timeout 4)
  (:bandwidth-exceeded 5)
  (:low-fps 6)
  (:missing-key-frames 7)
  (:no-connection 8)
  (:relay-failed 9)
  (:settings-changed 10)
  (:missing-audio 11)
  (:too-far-behind 12)
  (:transcode-behind 13)
  (:not-allowed-to-play 14)
  (:busy 15)
  (:banned 16)
  (:already-active 17)
  (:forced-off 18)
  (:audio-behind 19)
  (:shutdown 20)
  (:disconnect 21)
  (:video-init-failed 22)
  (:audio-init-failed 23))

(cffi:defcenum emarket-not-allowed-reason-flags
  (:market-not-allowed-reason-none 0)
  (:market-not-allowed-reason-temporary-failure 1)
  (:market-not-allowed-reason-account-disabled 2)
  (:market-not-allowed-reason-account-locked-down 4)
  (:market-not-allowed-reason-account-limited 8)
  (:market-not-allowed-reason-trade-banned 16)
  (:market-not-allowed-reason-account-not-trusted 32)
  (:market-not-allowed-reason-steam-guard-not-enabled 64)
  (:market-not-allowed-reason-steam-guard-only-recently-enabled 128)
  (:market-not-allowed-reason-recent-password-reset 256)
  (:market-not-allowed-reason-new-payment-method 512)
  (:market-not-allowed-reason-invalid-cookie 1024)
  (:market-not-allowed-reason-using-new-device 2048)
  (:market-not-allowed-reason-recent-self-refund 4096)
  (:market-not-allowed-reason-new-payment-method-cannot-be-verified 8192)
  (:market-not-allowed-reason-no-recent-purchases 16384)
  (:market-not-allowed-reason-accepted-wallet-gift 32768))

(cffi:defcenum eduration-control-progress
  (:full 0)
  (:half 1)
  (:none 2)
  (:duration-control-exit-soon-3h 3)
  (:duration-control-exit-soon-5h 4)
  (:duration-control-exit-soon-night 5))

(cffi:defcenum eduration-control-notification
  (:none 0)
  (:1hour 1)
  (:3hours 2)
  (:half-progress 3)
  (:no-progress 4)
  (:exit-soon-3h 5)
  (:exit-soon-5h 6)
  (:exit-soon-night 7))

(cffi:defcenum eduration-control-online-state
  (:invalid 0)
  (:offline 1)
  (:online 2)
  (:online-high-pri 3))

(cffi:defcenum ebeta-branch-flags
  (:beta-branch-none 0)
  (:beta-branch-default 1)
  (:beta-branch-available 2)
  (:beta-branch-private 4)
  (:beta-branch-selected 8)
  (:beta-branch-installed 16))

(cffi:defcenum egame-search-error-code
  (:ok 1)
  (:failed-search-already-in-progress 2)
  (:failed-no-search-in-progress 3)
  (:failed-not-lobby-leader 4)
  (:failed-no-host-available 5)
  (:failed-search-params-invalid 6)
  (:failed-offline 7)
  (:failed-not-authorized 8)
  (:failed-unknown-error 9))

(cffi:defcenum eplayer-result
  (:player-result-failed-to-connect 1)
  (:player-result-abandoned 2)
  (:player-result-kicked 3)
  (:player-result-incomplete 4)
  (:player-result-completed 5))

(cffi:defcenum esteam-ipv6connectivity-protocol
  (:invalid 0)
  (:http 1)
  (:udp 2))

(cffi:defcenum esteam-ipv6connectivity-state
  (:unknown 0)
  (:good 1)
  (:bad 2))

(cffi:defcenum efriend-relationship
  (:none 0)
  (:blocked 1)
  (:request-recipient 2)
  (:friend 3)
  (:request-initiator 4)
  (:ignored 5)
  (:ignored-friend 6)
  (:suggested-deprecated 7)
  (:max 8))

(cffi:defcenum epersona-state
  (:offline 0)
  (:online 1)
  (:busy 2)
  (:away 3)
  (:snooze 4)
  (:looking-to-trade 5)
  (:looking-to-play 6)
  (:invisible 7)
  (:max 8))

(cffi:defcenum efriend-flags
  (:none 0)
  (:blocked 1)
  (:friendship-requested 2)
  (:immediate 4)
  (:clan-member 8)
  (:on-game-server 16)
  (:requesting-friendship 128)
  (:requesting-info 256)
  (:ignored 512)
  (:ignored-friend 1024)
  (:chat-member 4096)
  (:all 65535))

(cffi:defcenum euser-restriction
  (:none 0)
  (:unknown 1)
  (:any-chat 2)
  (:voice-chat 4)
  (:group-chat 8)
  (:rating 16)
  (:game-invites 32)
  (:trading 64))

(cffi:defcenum eoverlay-to-store-flag
  (:none 0)
  (:add-to-cart 1)
  (:add-to-cart-and-show 2))

(cffi:defcenum eactivate-game-overlay-to-web-page-mode
  (:default 0)
  (:modal 1))

(cffi:defcenum ecommunity-profile-item-type
  (:animated-avatar 0)
  (:avatar-frame 1)
  (:profile-modifier 2)
  (:profile-background 3)
  (:mini-profile-background 4))

(cffi:defcenum ecommunity-profile-item-property
  (:image-small 0)
  (:image-large 1)
  (:internal-name 2)
  (:title 3)
  (:description 4)
  (:app-id 5)
  (:type-id 6)
  (:class 7)
  (:movie-web-m 8)
  (:movie-mp4 9)
  (:movie-web-msmall 10)
  (:movie-mp4small 11))

(cffi:defcenum epersona-change
  (:name 1)
  (:status 2)
  (:come-online 4)
  (:gone-offline 8)
  (:game-played 16)
  (:game-server 32)
  (:avatar 64)
  (:joined-source 128)
  (:left-source 256)
  (:relationship-changed 512)
  (:name-first-set 1024)
  (:broadcast 2048)
  (:nickname 4096)
  (:steam-level 8192)
  (:rich-presence 16384))

(cffi:defcenum esteam-apicall-failure
  (:none -1)
  (:steam-gone 0)
  (:network-failure 1)
  (:invalid-handle 2)
  (:mismatched-callback 3))

(cffi:defcenum egamepad-text-input-mode
  (:normal 0)
  (:password 1))

(cffi:defcenum egamepad-text-input-line-mode
  (:single-line 0)
  (:multiple-lines 1))

(cffi:defcenum efloating-gamepad-text-input-mode
  (:mode-single-line 0)
  (:mode-multiple-lines 1)
  (:mode-email 2)
  (:mode-numeric 3))

(cffi:defcenum etext-filtering-context
  (:unknown 0)
  (:game-content 1)
  (:chat 2)
  (:name 3))

(cffi:defcenum echeck-file-signature
  (:invalid-signature 0)
  (:valid-signature 1)
  (:file-not-found 2)
  (:no-signatures-found-for-this-app 3)
  (:no-signatures-found-for-this-file 4))

(cffi:defcenum ematch-making-server-response
  (:e-server-responded 0)
  (:e-server-failed-to-respond 1)
  (:e-no-servers-listed-on-master-server 2))

(cffi:defcenum elobby-type
  (:private 0)
  (:friends-only 1)
  (:public 2)
  (:invisible 3)
  (:private-unique 4))

(cffi:defcenum elobby-comparison
  (:equal-to-or-less-than -2)
  (:less-than -1)
  (:equal 0)
  (:greater-than 1)
  (:equal-to-or-greater-than 2)
  (:not-equal 3))

(cffi:defcenum elobby-distance-filter
  (:close 0)
  (:default 1)
  (:far 2)
  (:worldwide 3))

(cffi:defcenum echat-member-state-change
  (:entered 1)
  (:left 2)
  (:disconnected 4)
  (:kicked 8)
  (:banned 16))

(cffi:defcenum esteam-party-beacon-location-type
  (:invalid 0)
  (:chat-group 1)
  (:max 2))

(cffi:defcenum esteam-party-beacon-location-data
  (:invalid 0)
  (:name 1)
  (:icon-urlsmall 2)
  (:icon-urlmedium 3)
  (:icon-urllarge 4))

(cffi:defcenum eremote-storage-platform
  (:none 0)
  (:windows 1)
  (:osx 2)
  (:ps3 4)
  (:linux 8)
  (:switch 16)
  (:android 32)
  (:ios 64)
  (:all -1))

(cffi:defcenum eremote-storage-published-file-visibility
  (:public 0)
  (:friends-only 1)
  (:private 2)
  (:unlisted 3))

(cffi:defcenum eworkshop-file-type
  (:first 0)
  (:community 0)
  (:microtransaction 1)
  (:collection 2)
  (:art 3)
  (:video 4)
  (:screenshot 5)
  (:game 6)
  (:software 7)
  (:concept 8)
  (:web-guide 9)
  (:integrated-guide 10)
  (:merch 11)
  (:controller-binding 12)
  (:steamworks-access-invite 13)
  (:steam-video 14)
  (:game-managed-item 15)
  (:clip 16)
  (:max 17))

(cffi:defcenum eworkshop-vote
  (:unvoted 0)
  (:for 1)
  (:against 2)
  (:later 3))

(cffi:defcenum eworkshop-file-action
  (:played 0)
  (:completed 1))

(cffi:defcenum eworkshop-enumeration-type
  (:ranked-by-vote 0)
  (:recent 1)
  (:trending 2)
  (:favorites-of-friends 3)
  (:voted-by-friends 4)
  (:content-by-friends 5)
  (:recent-from-followed-users 6))

(cffi:defcenum eworkshop-video-provider
  (:none 0)
  (:youtube 1))

(cffi:defcenum eugcread-action
  (:ugcread-continue-reading-until-finished 0)
  (:ugcread-continue-reading 1)
  (:ugcread-close 2))

(cffi:defcenum eremote-storage-local-file-change
  (:invalid 0)
  (:file-updated 1)
  (:file-deleted 2))

(cffi:defcenum eremote-storage-file-path-type
  (:invalid 0)
  (:absolute 1)
  (:apifilename 2))

(cffi:defcenum eleaderboard-data-request
  (:global 0)
  (:global-around-user 1)
  (:friends 2)
  (:users 3))

(cffi:defcenum eleaderboard-sort-method
  (:none 0)
  (:ascending 1)
  (:descending 2))

(cffi:defcenum eleaderboard-display-type
  (:none 0)
  (:numeric 1)
  (:time-seconds 2)
  (:time-milli-seconds 3))

(cffi:defcenum eleaderboard-upload-score-method
  (:none 0)
  (:keep-best 1)
  (:force-update 2))

(cffi:defcenum ep2psession-error
  (:none 0)
  (:no-rights-to-app 2)
  (:timeout 4)
  (:not-running-app-deleted 1)
  (:destination-not-logged-in-deleted 3)
  (:max 5))

(cffi:defcenum ep2psend
  (:unreliable 0)
  (:unreliable-no-delay 1)
  (:reliable 2)
  (:reliable-with-buffering 3))

(cffi:defcenum esnet-socket-state
  (:invalid 0)
  (:connected 1)
  (:initiated 10)
  (:local-candidates-found 11)
  (:received-remote-candidates 12)
  (:challenge-handshake 15)
  (:disconnecting 21)
  (:local-disconnect 22)
  (:timeout-during-connect 23)
  (:remote-end-disconnected 24)
  (:connection-broken 25))

(cffi:defcenum esnet-socket-connection-type
  (:not-connected 0)
  (:udp 1)
  (:udprelay 2))

(cffi:defcenum evrscreenshot-type
  (:none 0)
  (:mono 1)
  (:stereo 2)
  (:mono-cubemap 3)
  (:mono-panorama 4)
  (:stereo-panorama 5))

(cffi:defcenum audio-playback-status
  (:audio-playback-undefined 0)
  (:audio-playback-playing 1)
  (:audio-playback-paused 2)
  (:audio-playback-idle 3))

(cffi:defcenum ehttpmethod
  (:invalid 0)
  (:get 1)
  (:head 2)
  (:post 3)
  (:put 4)
  (:delete 5)
  (:options 6)
  (:patch 7))

(cffi:defcenum ehttpstatus-code
  (:invalid 0)
  (:100continue 100)
  (:101switching-protocols 101)
  (:200ok 200)
  (:201created 201)
  (:202accepted 202)
  (:203non-authoritative 203)
  (:204no-content 204)
  (:205reset-content 205)
  (:206partial-content 206)
  (:300multiple-choices 300)
  (:301moved-permanently 301)
  (:302found 302)
  (:303see-other 303)
  (:304not-modified 304)
  (:305use-proxy 305)
  (:307temporary-redirect 307)
  (:308permanent-redirect 308)
  (:400bad-request 400)
  (:401unauthorized 401)
  (:402payment-required 402)
  (:403forbidden 403)
  (:404not-found 404)
  (:405method-not-allowed 405)
  (:406not-acceptable 406)
  (:407proxy-auth-required 407)
  (:408request-timeout 408)
  (:409conflict 409)
  (:410gone 410)
  (:411length-required 411)
  (:412precondition-failed 412)
  (:413request-entity-too-large 413)
  (:414request-uritoo-long 414)
  (:415unsupported-media-type 415)
  (:416requested-range-not-satisfiable 416)
  (:417expectation-failed 417)
  (:4xx-unknown 418)
  (:429too-many-requests 429)
  (:444connection-closed 444)
  (:500internal-server-error 500)
  (:501not-implemented 501)
  (:502bad-gateway 502)
  (:503service-unavailable 503)
  (:504gateway-timeout 504)
  (:505httpversion-not-supported 505)
  (:5xx-unknown 599))

(cffi:defcenum einput-source-mode
  (:none 0)
  (:dpad 1)
  (:buttons 2)
  (:four-buttons 3)
  (:absolute-mouse 4)
  (:relative-mouse 5)
  (:joystick-move 6)
  (:joystick-mouse 7)
  (:joystick-camera 8)
  (:scroll-wheel 9)
  (:trigger 10)
  (:touch-menu 11)
  (:mouse-joystick 12)
  (:mouse-region 13)
  (:radial-menu 14)
  (:single-button 15)
  (:switches 16))

(cffi:defcenum einput-action-origin
  (:none 0)
  (:steam-controller-a 1)
  (:steam-controller-b 2)
  (:steam-controller-x 3)
  (:steam-controller-y 4)
  (:steam-controller-left-bumper 5)
  (:steam-controller-right-bumper 6)
  (:steam-controller-left-grip 7)
  (:steam-controller-right-grip 8)
  (:steam-controller-start 9)
  (:steam-controller-back 10)
  (:steam-controller-left-pad-touch 11)
  (:steam-controller-left-pad-swipe 12)
  (:steam-controller-left-pad-click 13)
  (:steam-controller-left-pad-dpad-north 14)
  (:steam-controller-left-pad-dpad-south 15)
  (:steam-controller-left-pad-dpad-west 16)
  (:steam-controller-left-pad-dpad-east 17)
  (:steam-controller-right-pad-touch 18)
  (:steam-controller-right-pad-swipe 19)
  (:steam-controller-right-pad-click 20)
  (:steam-controller-right-pad-dpad-north 21)
  (:steam-controller-right-pad-dpad-south 22)
  (:steam-controller-right-pad-dpad-west 23)
  (:steam-controller-right-pad-dpad-east 24)
  (:steam-controller-left-trigger-pull 25)
  (:steam-controller-left-trigger-click 26)
  (:steam-controller-right-trigger-pull 27)
  (:steam-controller-right-trigger-click 28)
  (:steam-controller-left-stick-move 29)
  (:steam-controller-left-stick-click 30)
  (:steam-controller-left-stick-dpad-north 31)
  (:steam-controller-left-stick-dpad-south 32)
  (:steam-controller-left-stick-dpad-west 33)
  (:steam-controller-left-stick-dpad-east 34)
  (:steam-controller-gyro-move 35)
  (:steam-controller-gyro-pitch 36)
  (:steam-controller-gyro-yaw 37)
  (:steam-controller-gyro-roll 38)
  (:steam-controller-reserved0 39)
  (:steam-controller-reserved1 40)
  (:steam-controller-reserved2 41)
  (:steam-controller-reserved3 42)
  (:steam-controller-reserved4 43)
  (:steam-controller-reserved5 44)
  (:steam-controller-reserved6 45)
  (:steam-controller-reserved7 46)
  (:steam-controller-reserved8 47)
  (:steam-controller-reserved9 48)
  (:steam-controller-reserved10 49)
  (:ps4-x 50)
  (:ps4-circle 51)
  (:ps4-triangle 52)
  (:ps4-square 53)
  (:ps4-left-bumper 54)
  (:ps4-right-bumper 55)
  (:ps4-options 56)
  (:ps4-share 57)
  (:ps4-left-pad-touch 58)
  (:ps4-left-pad-swipe 59)
  (:ps4-left-pad-click 60)
  (:ps4-left-pad-dpad-north 61)
  (:ps4-left-pad-dpad-south 62)
  (:ps4-left-pad-dpad-west 63)
  (:ps4-left-pad-dpad-east 64)
  (:ps4-right-pad-touch 65)
  (:ps4-right-pad-swipe 66)
  (:ps4-right-pad-click 67)
  (:ps4-right-pad-dpad-north 68)
  (:ps4-right-pad-dpad-south 69)
  (:ps4-right-pad-dpad-west 70)
  (:ps4-right-pad-dpad-east 71)
  (:ps4-center-pad-touch 72)
  (:ps4-center-pad-swipe 73)
  (:ps4-center-pad-click 74)
  (:ps4-center-pad-dpad-north 75)
  (:ps4-center-pad-dpad-south 76)
  (:ps4-center-pad-dpad-west 77)
  (:ps4-center-pad-dpad-east 78)
  (:ps4-left-trigger-pull 79)
  (:ps4-left-trigger-click 80)
  (:ps4-right-trigger-pull 81)
  (:ps4-right-trigger-click 82)
  (:ps4-left-stick-move 83)
  (:ps4-left-stick-click 84)
  (:ps4-left-stick-dpad-north 85)
  (:ps4-left-stick-dpad-south 86)
  (:ps4-left-stick-dpad-west 87)
  (:ps4-left-stick-dpad-east 88)
  (:ps4-right-stick-move 89)
  (:ps4-right-stick-click 90)
  (:ps4-right-stick-dpad-north 91)
  (:ps4-right-stick-dpad-south 92)
  (:ps4-right-stick-dpad-west 93)
  (:ps4-right-stick-dpad-east 94)
  (:ps4-dpad-north 95)
  (:ps4-dpad-south 96)
  (:ps4-dpad-west 97)
  (:ps4-dpad-east 98)
  (:ps4-gyro-move 99)
  (:ps4-gyro-pitch 100)
  (:ps4-gyro-yaw 101)
  (:ps4-gyro-roll 102)
  (:ps4-dpad-move 103)
  (:ps4-reserved1 104)
  (:ps4-reserved2 105)
  (:ps4-reserved3 106)
  (:ps4-reserved4 107)
  (:ps4-reserved5 108)
  (:ps4-reserved6 109)
  (:ps4-reserved7 110)
  (:ps4-reserved8 111)
  (:ps4-reserved9 112)
  (:ps4-reserved10 113)
  (:xbox-one-a 114)
  (:xbox-one-b 115)
  (:xbox-one-x 116)
  (:xbox-one-y 117)
  (:xbox-one-left-bumper 118)
  (:xbox-one-right-bumper 119)
  (:xbox-one-menu 120)
  (:xbox-one-view 121)
  (:xbox-one-left-trigger-pull 122)
  (:xbox-one-left-trigger-click 123)
  (:xbox-one-right-trigger-pull 124)
  (:xbox-one-right-trigger-click 125)
  (:xbox-one-left-stick-move 126)
  (:xbox-one-left-stick-click 127)
  (:xbox-one-left-stick-dpad-north 128)
  (:xbox-one-left-stick-dpad-south 129)
  (:xbox-one-left-stick-dpad-west 130)
  (:xbox-one-left-stick-dpad-east 131)
  (:xbox-one-right-stick-move 132)
  (:xbox-one-right-stick-click 133)
  (:xbox-one-right-stick-dpad-north 134)
  (:xbox-one-right-stick-dpad-south 135)
  (:xbox-one-right-stick-dpad-west 136)
  (:xbox-one-right-stick-dpad-east 137)
  (:xbox-one-dpad-north 138)
  (:xbox-one-dpad-south 139)
  (:xbox-one-dpad-west 140)
  (:xbox-one-dpad-east 141)
  (:xbox-one-dpad-move 142)
  (:xbox-one-left-grip-lower 143)
  (:xbox-one-left-grip-upper 144)
  (:xbox-one-right-grip-lower 145)
  (:xbox-one-right-grip-upper 146)
  (:xbox-one-share 147)
  (:xbox-one-reserved6 148)
  (:xbox-one-reserved7 149)
  (:xbox-one-reserved8 150)
  (:xbox-one-reserved9 151)
  (:xbox-one-reserved10 152)
  (:xbox360-a 153)
  (:xbox360-b 154)
  (:xbox360-x 155)
  (:xbox360-y 156)
  (:xbox360-left-bumper 157)
  (:xbox360-right-bumper 158)
  (:xbox360-start 159)
  (:xbox360-back 160)
  (:xbox360-left-trigger-pull 161)
  (:xbox360-left-trigger-click 162)
  (:xbox360-right-trigger-pull 163)
  (:xbox360-right-trigger-click 164)
  (:xbox360-left-stick-move 165)
  (:xbox360-left-stick-click 166)
  (:xbox360-left-stick-dpad-north 167)
  (:xbox360-left-stick-dpad-south 168)
  (:xbox360-left-stick-dpad-west 169)
  (:xbox360-left-stick-dpad-east 170)
  (:xbox360-right-stick-move 171)
  (:xbox360-right-stick-click 172)
  (:xbox360-right-stick-dpad-north 173)
  (:xbox360-right-stick-dpad-south 174)
  (:xbox360-right-stick-dpad-west 175)
  (:xbox360-right-stick-dpad-east 176)
  (:xbox360-dpad-north 177)
  (:xbox360-dpad-south 178)
  (:xbox360-dpad-west 179)
  (:xbox360-dpad-east 180)
  (:xbox360-dpad-move 181)
  (:xbox360-reserved1 182)
  (:xbox360-reserved2 183)
  (:xbox360-reserved3 184)
  (:xbox360-reserved4 185)
  (:xbox360-reserved5 186)
  (:xbox360-reserved6 187)
  (:xbox360-reserved7 188)
  (:xbox360-reserved8 189)
  (:xbox360-reserved9 190)
  (:xbox360-reserved10 191)
  (:switch-a 192)
  (:switch-b 193)
  (:switch-x 194)
  (:switch-y 195)
  (:switch-left-bumper 196)
  (:switch-right-bumper 197)
  (:switch-plus 198)
  (:switch-minus 199)
  (:switch-capture 200)
  (:switch-left-trigger-pull 201)
  (:switch-left-trigger-click 202)
  (:switch-right-trigger-pull 203)
  (:switch-right-trigger-click 204)
  (:switch-left-stick-move 205)
  (:switch-left-stick-click 206)
  (:switch-left-stick-dpad-north 207)
  (:switch-left-stick-dpad-south 208)
  (:switch-left-stick-dpad-west 209)
  (:switch-left-stick-dpad-east 210)
  (:switch-right-stick-move 211)
  (:switch-right-stick-click 212)
  (:switch-right-stick-dpad-north 213)
  (:switch-right-stick-dpad-south 214)
  (:switch-right-stick-dpad-west 215)
  (:switch-right-stick-dpad-east 216)
  (:switch-dpad-north 217)
  (:switch-dpad-south 218)
  (:switch-dpad-west 219)
  (:switch-dpad-east 220)
  (:switch-pro-gyro-move 221)
  (:switch-pro-gyro-pitch 222)
  (:switch-pro-gyro-yaw 223)
  (:switch-pro-gyro-roll 224)
  (:switch-dpad-move 225)
  (:switch-reserved1 226)
  (:switch-reserved2 227)
  (:switch-reserved3 228)
  (:switch-reserved4 229)
  (:switch-reserved5 230)
  (:switch-reserved6 231)
  (:switch-reserved7 232)
  (:switch-reserved8 233)
  (:switch-reserved9 234)
  (:switch-reserved10 235)
  (:switch-right-gyro-move 236)
  (:switch-right-gyro-pitch 237)
  (:switch-right-gyro-yaw 238)
  (:switch-right-gyro-roll 239)
  (:switch-left-gyro-move 240)
  (:switch-left-gyro-pitch 241)
  (:switch-left-gyro-yaw 242)
  (:switch-left-gyro-roll 243)
  (:switch-left-grip-lower 244)
  (:switch-left-grip-upper 245)
  (:switch-right-grip-lower 246)
  (:switch-right-grip-upper 247)
  (:switch-joy-con-button-n 248)
  (:switch-joy-con-button-e 249)
  (:switch-joy-con-button-s 250)
  (:switch-joy-con-button-w 251)
  (:switch-reserved15 252)
  (:switch-reserved16 253)
  (:switch-reserved17 254)
  (:switch-reserved18 255)
  (:switch-reserved19 256)
  (:switch-reserved20 257)
  (:ps5-x 258)
  (:ps5-circle 259)
  (:ps5-triangle 260)
  (:ps5-square 261)
  (:ps5-left-bumper 262)
  (:ps5-right-bumper 263)
  (:ps5-option 264)
  (:ps5-create 265)
  (:ps5-mute 266)
  (:ps5-left-pad-touch 267)
  (:ps5-left-pad-swipe 268)
  (:ps5-left-pad-click 269)
  (:ps5-left-pad-dpad-north 270)
  (:ps5-left-pad-dpad-south 271)
  (:ps5-left-pad-dpad-west 272)
  (:ps5-left-pad-dpad-east 273)
  (:ps5-right-pad-touch 274)
  (:ps5-right-pad-swipe 275)
  (:ps5-right-pad-click 276)
  (:ps5-right-pad-dpad-north 277)
  (:ps5-right-pad-dpad-south 278)
  (:ps5-right-pad-dpad-west 279)
  (:ps5-right-pad-dpad-east 280)
  (:ps5-center-pad-touch 281)
  (:ps5-center-pad-swipe 282)
  (:ps5-center-pad-click 283)
  (:ps5-center-pad-dpad-north 284)
  (:ps5-center-pad-dpad-south 285)
  (:ps5-center-pad-dpad-west 286)
  (:ps5-center-pad-dpad-east 287)
  (:ps5-left-trigger-pull 288)
  (:ps5-left-trigger-click 289)
  (:ps5-right-trigger-pull 290)
  (:ps5-right-trigger-click 291)
  (:ps5-left-stick-move 292)
  (:ps5-left-stick-click 293)
  (:ps5-left-stick-dpad-north 294)
  (:ps5-left-stick-dpad-south 295)
  (:ps5-left-stick-dpad-west 296)
  (:ps5-left-stick-dpad-east 297)
  (:ps5-right-stick-move 298)
  (:ps5-right-stick-click 299)
  (:ps5-right-stick-dpad-north 300)
  (:ps5-right-stick-dpad-south 301)
  (:ps5-right-stick-dpad-west 302)
  (:ps5-right-stick-dpad-east 303)
  (:ps5-dpad-north 304)
  (:ps5-dpad-south 305)
  (:ps5-dpad-west 306)
  (:ps5-dpad-east 307)
  (:ps5-gyro-move 308)
  (:ps5-gyro-pitch 309)
  (:ps5-gyro-yaw 310)
  (:ps5-gyro-roll 311)
  (:ps5-dpad-move 312)
  (:ps5-left-grip 313)
  (:ps5-right-grip 314)
  (:ps5-left-fn 315)
  (:ps5-right-fn 316)
  (:ps5-reserved5 317)
  (:ps5-reserved6 318)
  (:ps5-reserved7 319)
  (:ps5-reserved8 320)
  (:ps5-reserved9 321)
  (:ps5-reserved10 322)
  (:ps5-reserved11 323)
  (:ps5-reserved12 324)
  (:ps5-reserved13 325)
  (:ps5-reserved14 326)
  (:ps5-reserved15 327)
  (:ps5-reserved16 328)
  (:ps5-reserved17 329)
  (:ps5-reserved18 330)
  (:ps5-reserved19 331)
  (:ps5-reserved20 332)
  (:steam-deck-a 333)
  (:steam-deck-b 334)
  (:steam-deck-x 335)
  (:steam-deck-y 336)
  (:steam-deck-l1 337)
  (:steam-deck-r1 338)
  (:steam-deck-menu 339)
  (:steam-deck-view 340)
  (:steam-deck-left-pad-touch 341)
  (:steam-deck-left-pad-swipe 342)
  (:steam-deck-left-pad-click 343)
  (:steam-deck-left-pad-dpad-north 344)
  (:steam-deck-left-pad-dpad-south 345)
  (:steam-deck-left-pad-dpad-west 346)
  (:steam-deck-left-pad-dpad-east 347)
  (:steam-deck-right-pad-touch 348)
  (:steam-deck-right-pad-swipe 349)
  (:steam-deck-right-pad-click 350)
  (:steam-deck-right-pad-dpad-north 351)
  (:steam-deck-right-pad-dpad-south 352)
  (:steam-deck-right-pad-dpad-west 353)
  (:steam-deck-right-pad-dpad-east 354)
  (:steam-deck-l2-soft-pull 355)
  (:steam-deck-l2 356)
  (:steam-deck-r2-soft-pull 357)
  (:steam-deck-r2 358)
  (:steam-deck-left-stick-move 359)
  (:steam-deck-l3 360)
  (:steam-deck-left-stick-dpad-north 361)
  (:steam-deck-left-stick-dpad-south 362)
  (:steam-deck-left-stick-dpad-west 363)
  (:steam-deck-left-stick-dpad-east 364)
  (:steam-deck-left-stick-touch 365)
  (:steam-deck-right-stick-move 366)
  (:steam-deck-r3 367)
  (:steam-deck-right-stick-dpad-north 368)
  (:steam-deck-right-stick-dpad-south 369)
  (:steam-deck-right-stick-dpad-west 370)
  (:steam-deck-right-stick-dpad-east 371)
  (:steam-deck-right-stick-touch 372)
  (:steam-deck-l4 373)
  (:steam-deck-r4 374)
  (:steam-deck-l5 375)
  (:steam-deck-r5 376)
  (:steam-deck-dpad-move 377)
  (:steam-deck-dpad-north 378)
  (:steam-deck-dpad-south 379)
  (:steam-deck-dpad-west 380)
  (:steam-deck-dpad-east 381)
  (:steam-deck-gyro-move 382)
  (:steam-deck-gyro-pitch 383)
  (:steam-deck-gyro-yaw 384)
  (:steam-deck-gyro-roll 385)
  (:steam-deck-reserved1 386)
  (:steam-deck-reserved2 387)
  (:steam-deck-reserved3 388)
  (:steam-deck-reserved4 389)
  (:steam-deck-reserved5 390)
  (:steam-deck-reserved6 391)
  (:steam-deck-reserved7 392)
  (:steam-deck-reserved8 393)
  (:steam-deck-reserved9 394)
  (:steam-deck-reserved10 395)
  (:steam-deck-reserved11 396)
  (:steam-deck-reserved12 397)
  (:steam-deck-reserved13 398)
  (:steam-deck-reserved14 399)
  (:steam-deck-reserved15 400)
  (:steam-deck-reserved16 401)
  (:steam-deck-reserved17 402)
  (:steam-deck-reserved18 403)
  (:steam-deck-reserved19 404)
  (:steam-deck-reserved20 405)
  (:horipad-m1 406)
  (:horipad-m2 407)
  (:horipad-l4 408)
  (:horipad-r4 409)
  (:count 410)
  (:maximum-possible-value 32767))

(cffi:defcenum exbox-origin
  (:a 0)
  (:b 1)
  (:x 2)
  (:y 3)
  (:left-bumper 4)
  (:right-bumper 5)
  (:menu 6)
  (:view 7)
  (:left-trigger-pull 8)
  (:left-trigger-click 9)
  (:right-trigger-pull 10)
  (:right-trigger-click 11)
  (:left-stick-move 12)
  (:left-stick-click 13)
  (:left-stick-dpad-north 14)
  (:left-stick-dpad-south 15)
  (:left-stick-dpad-west 16)
  (:left-stick-dpad-east 17)
  (:right-stick-move 18)
  (:right-stick-click 19)
  (:right-stick-dpad-north 20)
  (:right-stick-dpad-south 21)
  (:right-stick-dpad-west 22)
  (:right-stick-dpad-east 23)
  (:dpad-north 24)
  (:dpad-south 25)
  (:dpad-west 26)
  (:dpad-east 27)
  (:count 28))

(cffi:defcenum esteam-controller-pad
  (:left 0)
  (:right 1))

(cffi:defcenum econtroller-haptic-location
  (:left 1)
  (:right 2)
  (:both 3))

(cffi:defcenum econtroller-haptic-type
  (:off 0)
  (:tick 1)
  (:click 2))

(cffi:defcenum esteam-input-type
  (:unknown 0)
  (:steam-controller 1)
  (:xbox360controller 2)
  (:xbox-one-controller 3)
  (:generic-gamepad 4)
  (:ps4controller 5)
  (:apple-mfi-controller 6)
  (:android-controller 7)
  (:switch-joy-con-pair 8)
  (:switch-joy-con-single 9)
  (:switch-pro-controller 10)
  (:mobile-touch 11)
  (:ps3controller 12)
  (:ps5controller 13)
  (:steam-deck-controller 14)
  (:count 15)
  (:maximum-possible-value 255))

(cffi:defcenum esteam-input-configuration-enable-type
  (:none 0)
  (:playstation 1)
  (:xbox 2)
  (:generic 4)
  (:switch 8))

(cffi:defcenum esteam-input-ledflag
  (:set-color 0)
  (:restore-user-default 1))

(cffi:defcenum esteam-input-glyph-size
  (:small 0)
  (:medium 1)
  (:large 2)
  (:count 3))

(cffi:defcenum esteam-input-glyph-style
  (:esteam-input-glyph-style-knockout 0)
  (:esteam-input-glyph-style-light 1)
  (:esteam-input-glyph-style-dark 2)
  (:esteam-input-glyph-style-neutral-color-abxy 16)
  (:esteam-input-glyph-style-solid-abxy 32))

(cffi:defcenum esteam-input-action-event-type
  (:esteam-input-action-event-type-digital-action 0)
  (:esteam-input-action-event-type-analog-action 1))

(cffi:defcenum econtroller-action-origin
  (:none 0)
  (:a 1)
  (:b 2)
  (:x 3)
  (:y 4)
  (:left-bumper 5)
  (:right-bumper 6)
  (:left-grip 7)
  (:right-grip 8)
  (:start 9)
  (:back 10)
  (:left-pad-touch 11)
  (:left-pad-swipe 12)
  (:left-pad-click 13)
  (:left-pad-dpad-north 14)
  (:left-pad-dpad-south 15)
  (:left-pad-dpad-west 16)
  (:left-pad-dpad-east 17)
  (:right-pad-touch 18)
  (:right-pad-swipe 19)
  (:right-pad-click 20)
  (:right-pad-dpad-north 21)
  (:right-pad-dpad-south 22)
  (:right-pad-dpad-west 23)
  (:right-pad-dpad-east 24)
  (:left-trigger-pull 25)
  (:left-trigger-click 26)
  (:right-trigger-pull 27)
  (:right-trigger-click 28)
  (:left-stick-move 29)
  (:left-stick-click 30)
  (:left-stick-dpad-north 31)
  (:left-stick-dpad-south 32)
  (:left-stick-dpad-west 33)
  (:left-stick-dpad-east 34)
  (:gyro-move 35)
  (:gyro-pitch 36)
  (:gyro-yaw 37)
  (:gyro-roll 38)
  (:ps4-x 39)
  (:ps4-circle 40)
  (:ps4-triangle 41)
  (:ps4-square 42)
  (:ps4-left-bumper 43)
  (:ps4-right-bumper 44)
  (:ps4-options 45)
  (:ps4-share 46)
  (:ps4-left-pad-touch 47)
  (:ps4-left-pad-swipe 48)
  (:ps4-left-pad-click 49)
  (:ps4-left-pad-dpad-north 50)
  (:ps4-left-pad-dpad-south 51)
  (:ps4-left-pad-dpad-west 52)
  (:ps4-left-pad-dpad-east 53)
  (:ps4-right-pad-touch 54)
  (:ps4-right-pad-swipe 55)
  (:ps4-right-pad-click 56)
  (:ps4-right-pad-dpad-north 57)
  (:ps4-right-pad-dpad-south 58)
  (:ps4-right-pad-dpad-west 59)
  (:ps4-right-pad-dpad-east 60)
  (:ps4-center-pad-touch 61)
  (:ps4-center-pad-swipe 62)
  (:ps4-center-pad-click 63)
  (:ps4-center-pad-dpad-north 64)
  (:ps4-center-pad-dpad-south 65)
  (:ps4-center-pad-dpad-west 66)
  (:ps4-center-pad-dpad-east 67)
  (:ps4-left-trigger-pull 68)
  (:ps4-left-trigger-click 69)
  (:ps4-right-trigger-pull 70)
  (:ps4-right-trigger-click 71)
  (:ps4-left-stick-move 72)
  (:ps4-left-stick-click 73)
  (:ps4-left-stick-dpad-north 74)
  (:ps4-left-stick-dpad-south 75)
  (:ps4-left-stick-dpad-west 76)
  (:ps4-left-stick-dpad-east 77)
  (:ps4-right-stick-move 78)
  (:ps4-right-stick-click 79)
  (:ps4-right-stick-dpad-north 80)
  (:ps4-right-stick-dpad-south 81)
  (:ps4-right-stick-dpad-west 82)
  (:ps4-right-stick-dpad-east 83)
  (:ps4-dpad-north 84)
  (:ps4-dpad-south 85)
  (:ps4-dpad-west 86)
  (:ps4-dpad-east 87)
  (:ps4-gyro-move 88)
  (:ps4-gyro-pitch 89)
  (:ps4-gyro-yaw 90)
  (:ps4-gyro-roll 91)
  (:xbox-one-a 92)
  (:xbox-one-b 93)
  (:xbox-one-x 94)
  (:xbox-one-y 95)
  (:xbox-one-left-bumper 96)
  (:xbox-one-right-bumper 97)
  (:xbox-one-menu 98)
  (:xbox-one-view 99)
  (:xbox-one-left-trigger-pull 100)
  (:xbox-one-left-trigger-click 101)
  (:xbox-one-right-trigger-pull 102)
  (:xbox-one-right-trigger-click 103)
  (:xbox-one-left-stick-move 104)
  (:xbox-one-left-stick-click 105)
  (:xbox-one-left-stick-dpad-north 106)
  (:xbox-one-left-stick-dpad-south 107)
  (:xbox-one-left-stick-dpad-west 108)
  (:xbox-one-left-stick-dpad-east 109)
  (:xbox-one-right-stick-move 110)
  (:xbox-one-right-stick-click 111)
  (:xbox-one-right-stick-dpad-north 112)
  (:xbox-one-right-stick-dpad-south 113)
  (:xbox-one-right-stick-dpad-west 114)
  (:xbox-one-right-stick-dpad-east 115)
  (:xbox-one-dpad-north 116)
  (:xbox-one-dpad-south 117)
  (:xbox-one-dpad-west 118)
  (:xbox-one-dpad-east 119)
  (:xbox360-a 120)
  (:xbox360-b 121)
  (:xbox360-x 122)
  (:xbox360-y 123)
  (:xbox360-left-bumper 124)
  (:xbox360-right-bumper 125)
  (:xbox360-start 126)
  (:xbox360-back 127)
  (:xbox360-left-trigger-pull 128)
  (:xbox360-left-trigger-click 129)
  (:xbox360-right-trigger-pull 130)
  (:xbox360-right-trigger-click 131)
  (:xbox360-left-stick-move 132)
  (:xbox360-left-stick-click 133)
  (:xbox360-left-stick-dpad-north 134)
  (:xbox360-left-stick-dpad-south 135)
  (:xbox360-left-stick-dpad-west 136)
  (:xbox360-left-stick-dpad-east 137)
  (:xbox360-right-stick-move 138)
  (:xbox360-right-stick-click 139)
  (:xbox360-right-stick-dpad-north 140)
  (:xbox360-right-stick-dpad-south 141)
  (:xbox360-right-stick-dpad-west 142)
  (:xbox360-right-stick-dpad-east 143)
  (:xbox360-dpad-north 144)
  (:xbox360-dpad-south 145)
  (:xbox360-dpad-west 146)
  (:xbox360-dpad-east 147)
  (:steam-v2-a 148)
  (:steam-v2-b 149)
  (:steam-v2-x 150)
  (:steam-v2-y 151)
  (:steam-v2-left-bumper 152)
  (:steam-v2-right-bumper 153)
  (:steam-v2-left-grip-lower 154)
  (:steam-v2-left-grip-upper 155)
  (:steam-v2-right-grip-lower 156)
  (:steam-v2-right-grip-upper 157)
  (:steam-v2-left-bumper-pressure 158)
  (:steam-v2-right-bumper-pressure 159)
  (:steam-v2-left-grip-pressure 160)
  (:steam-v2-right-grip-pressure 161)
  (:steam-v2-left-grip-upper-pressure 162)
  (:steam-v2-right-grip-upper-pressure 163)
  (:steam-v2-start 164)
  (:steam-v2-back 165)
  (:steam-v2-left-pad-touch 166)
  (:steam-v2-left-pad-swipe 167)
  (:steam-v2-left-pad-click 168)
  (:steam-v2-left-pad-pressure 169)
  (:steam-v2-left-pad-dpad-north 170)
  (:steam-v2-left-pad-dpad-south 171)
  (:steam-v2-left-pad-dpad-west 172)
  (:steam-v2-left-pad-dpad-east 173)
  (:steam-v2-right-pad-touch 174)
  (:steam-v2-right-pad-swipe 175)
  (:steam-v2-right-pad-click 176)
  (:steam-v2-right-pad-pressure 177)
  (:steam-v2-right-pad-dpad-north 178)
  (:steam-v2-right-pad-dpad-south 179)
  (:steam-v2-right-pad-dpad-west 180)
  (:steam-v2-right-pad-dpad-east 181)
  (:steam-v2-left-trigger-pull 182)
  (:steam-v2-left-trigger-click 183)
  (:steam-v2-right-trigger-pull 184)
  (:steam-v2-right-trigger-click 185)
  (:steam-v2-left-stick-move 186)
  (:steam-v2-left-stick-click 187)
  (:steam-v2-left-stick-dpad-north 188)
  (:steam-v2-left-stick-dpad-south 189)
  (:steam-v2-left-stick-dpad-west 190)
  (:steam-v2-left-stick-dpad-east 191)
  (:steam-v2-gyro-move 192)
  (:steam-v2-gyro-pitch 193)
  (:steam-v2-gyro-yaw 194)
  (:steam-v2-gyro-roll 195)
  (:switch-a 196)
  (:switch-b 197)
  (:switch-x 198)
  (:switch-y 199)
  (:switch-left-bumper 200)
  (:switch-right-bumper 201)
  (:switch-plus 202)
  (:switch-minus 203)
  (:switch-capture 204)
  (:switch-left-trigger-pull 205)
  (:switch-left-trigger-click 206)
  (:switch-right-trigger-pull 207)
  (:switch-right-trigger-click 208)
  (:switch-left-stick-move 209)
  (:switch-left-stick-click 210)
  (:switch-left-stick-dpad-north 211)
  (:switch-left-stick-dpad-south 212)
  (:switch-left-stick-dpad-west 213)
  (:switch-left-stick-dpad-east 214)
  (:switch-right-stick-move 215)
  (:switch-right-stick-click 216)
  (:switch-right-stick-dpad-north 217)
  (:switch-right-stick-dpad-south 218)
  (:switch-right-stick-dpad-west 219)
  (:switch-right-stick-dpad-east 220)
  (:switch-dpad-north 221)
  (:switch-dpad-south 222)
  (:switch-dpad-west 223)
  (:switch-dpad-east 224)
  (:switch-pro-gyro-move 225)
  (:switch-pro-gyro-pitch 226)
  (:switch-pro-gyro-yaw 227)
  (:switch-pro-gyro-roll 228)
  (:switch-right-gyro-move 229)
  (:switch-right-gyro-pitch 230)
  (:switch-right-gyro-yaw 231)
  (:switch-right-gyro-roll 232)
  (:switch-left-gyro-move 233)
  (:switch-left-gyro-pitch 234)
  (:switch-left-gyro-yaw 235)
  (:switch-left-gyro-roll 236)
  (:switch-left-grip-lower 237)
  (:switch-left-grip-upper 238)
  (:switch-right-grip-lower 239)
  (:switch-right-grip-upper 240)
  (:ps4-dpad-move 241)
  (:xbox-one-dpad-move 242)
  (:xbox360-dpad-move 243)
  (:switch-dpad-move 244)
  (:ps5-x 245)
  (:ps5-circle 246)
  (:ps5-triangle 247)
  (:ps5-square 248)
  (:ps5-left-bumper 249)
  (:ps5-right-bumper 250)
  (:ps5-option 251)
  (:ps5-create 252)
  (:ps5-mute 253)
  (:ps5-left-pad-touch 254)
  (:ps5-left-pad-swipe 255)
  (:ps5-left-pad-click 256)
  (:ps5-left-pad-dpad-north 257)
  (:ps5-left-pad-dpad-south 258)
  (:ps5-left-pad-dpad-west 259)
  (:ps5-left-pad-dpad-east 260)
  (:ps5-right-pad-touch 261)
  (:ps5-right-pad-swipe 262)
  (:ps5-right-pad-click 263)
  (:ps5-right-pad-dpad-north 264)
  (:ps5-right-pad-dpad-south 265)
  (:ps5-right-pad-dpad-west 266)
  (:ps5-right-pad-dpad-east 267)
  (:ps5-center-pad-touch 268)
  (:ps5-center-pad-swipe 269)
  (:ps5-center-pad-click 270)
  (:ps5-center-pad-dpad-north 271)
  (:ps5-center-pad-dpad-south 272)
  (:ps5-center-pad-dpad-west 273)
  (:ps5-center-pad-dpad-east 274)
  (:ps5-left-trigger-pull 275)
  (:ps5-left-trigger-click 276)
  (:ps5-right-trigger-pull 277)
  (:ps5-right-trigger-click 278)
  (:ps5-left-stick-move 279)
  (:ps5-left-stick-click 280)
  (:ps5-left-stick-dpad-north 281)
  (:ps5-left-stick-dpad-south 282)
  (:ps5-left-stick-dpad-west 283)
  (:ps5-left-stick-dpad-east 284)
  (:ps5-right-stick-move 285)
  (:ps5-right-stick-click 286)
  (:ps5-right-stick-dpad-north 287)
  (:ps5-right-stick-dpad-south 288)
  (:ps5-right-stick-dpad-west 289)
  (:ps5-right-stick-dpad-east 290)
  (:ps5-dpad-move 291)
  (:ps5-dpad-north 292)
  (:ps5-dpad-south 293)
  (:ps5-dpad-west 294)
  (:ps5-dpad-east 295)
  (:ps5-gyro-move 296)
  (:ps5-gyro-pitch 297)
  (:ps5-gyro-yaw 298)
  (:ps5-gyro-roll 299)
  (:xbox-one-left-grip-lower 300)
  (:xbox-one-left-grip-upper 301)
  (:xbox-one-right-grip-lower 302)
  (:xbox-one-right-grip-upper 303)
  (:xbox-one-share 304)
  (:steam-deck-a 305)
  (:steam-deck-b 306)
  (:steam-deck-x 307)
  (:steam-deck-y 308)
  (:steam-deck-l1 309)
  (:steam-deck-r1 310)
  (:steam-deck-menu 311)
  (:steam-deck-view 312)
  (:steam-deck-left-pad-touch 313)
  (:steam-deck-left-pad-swipe 314)
  (:steam-deck-left-pad-click 315)
  (:steam-deck-left-pad-dpad-north 316)
  (:steam-deck-left-pad-dpad-south 317)
  (:steam-deck-left-pad-dpad-west 318)
  (:steam-deck-left-pad-dpad-east 319)
  (:steam-deck-right-pad-touch 320)
  (:steam-deck-right-pad-swipe 321)
  (:steam-deck-right-pad-click 322)
  (:steam-deck-right-pad-dpad-north 323)
  (:steam-deck-right-pad-dpad-south 324)
  (:steam-deck-right-pad-dpad-west 325)
  (:steam-deck-right-pad-dpad-east 326)
  (:steam-deck-l2-soft-pull 327)
  (:steam-deck-l2 328)
  (:steam-deck-r2-soft-pull 329)
  (:steam-deck-r2 330)
  (:steam-deck-left-stick-move 331)
  (:steam-deck-l3 332)
  (:steam-deck-left-stick-dpad-north 333)
  (:steam-deck-left-stick-dpad-south 334)
  (:steam-deck-left-stick-dpad-west 335)
  (:steam-deck-left-stick-dpad-east 336)
  (:steam-deck-left-stick-touch 337)
  (:steam-deck-right-stick-move 338)
  (:steam-deck-r3 339)
  (:steam-deck-right-stick-dpad-north 340)
  (:steam-deck-right-stick-dpad-south 341)
  (:steam-deck-right-stick-dpad-west 342)
  (:steam-deck-right-stick-dpad-east 343)
  (:steam-deck-right-stick-touch 344)
  (:steam-deck-l4 345)
  (:steam-deck-r4 346)
  (:steam-deck-l5 347)
  (:steam-deck-r5 348)
  (:steam-deck-dpad-move 349)
  (:steam-deck-dpad-north 350)
  (:steam-deck-dpad-south 351)
  (:steam-deck-dpad-west 352)
  (:steam-deck-dpad-east 353)
  (:steam-deck-gyro-move 354)
  (:steam-deck-gyro-pitch 355)
  (:steam-deck-gyro-yaw 356)
  (:steam-deck-gyro-roll 357)
  (:steam-deck-reserved1 358)
  (:steam-deck-reserved2 359)
  (:steam-deck-reserved3 360)
  (:steam-deck-reserved4 361)
  (:steam-deck-reserved5 362)
  (:steam-deck-reserved6 363)
  (:steam-deck-reserved7 364)
  (:steam-deck-reserved8 365)
  (:steam-deck-reserved9 366)
  (:steam-deck-reserved10 367)
  (:steam-deck-reserved11 368)
  (:steam-deck-reserved12 369)
  (:steam-deck-reserved13 370)
  (:steam-deck-reserved14 371)
  (:steam-deck-reserved15 372)
  (:steam-deck-reserved16 373)
  (:steam-deck-reserved17 374)
  (:steam-deck-reserved18 375)
  (:steam-deck-reserved19 376)
  (:steam-deck-reserved20 377)
  (:switch-joy-con-button-n 378)
  (:switch-joy-con-button-e 379)
  (:switch-joy-con-button-s 380)
  (:switch-joy-con-button-w 381)
  (:ps5-left-grip 382)
  (:ps5-right-grip 383)
  (:ps5-left-fn 384)
  (:ps5-right-fn 385)
  (:horipad-m1 386)
  (:horipad-m2 387)
  (:horipad-l4 388)
  (:horipad-r4 389)
  (:count 390)
  (:maximum-possible-value 32767))

(cffi:defcenum esteam-controller-ledflag
  (:set-color 0)
  (:restore-user-default 1))

(cffi:defcenum eugcmatching-ugctype
  (:items 0)
  (:items-mtx 1)
  (:items-ready-to-use 2)
  (:collections 3)
  (:artwork 4)
  (:videos 5)
  (:screenshots 6)
  (:all-guides 7)
  (:web-guides 8)
  (:integrated-guides 9)
  (:usable-in-game 10)
  (:controller-bindings 11)
  (:game-managed-items 12)
  (:all -1))

(cffi:defcenum euser-ugclist
  (:published 0)
  (:voted-on 1)
  (:voted-up 2)
  (:voted-down 3)
  (:will-vote-later 4)
  (:favorited 5)
  (:subscribed 6)
  (:used-or-played 7)
  (:followed 8))

(cffi:defcenum euser-ugclist-sort-order
  (:creation-order-desc 0)
  (:creation-order-asc 1)
  (:title-asc 2)
  (:last-updated-desc 3)
  (:subscription-date-desc 4)
  (:vote-score-desc 5)
  (:for-moderation 6))

(cffi:defcenum eugcquery
  (:ranked-by-vote 0)
  (:ranked-by-publication-date 1)
  (:accepted-for-game-ranked-by-acceptance-date 2)
  (:ranked-by-trend 3)
  (:favorited-by-friends-ranked-by-publication-date 4)
  (:created-by-friends-ranked-by-publication-date 5)
  (:ranked-by-num-times-reported 6)
  (:created-by-followed-users-ranked-by-publication-date 7)
  (:not-yet-rated 8)
  (:ranked-by-total-votes-asc 9)
  (:ranked-by-votes-up 10)
  (:ranked-by-text-search 11)
  (:ranked-by-total-unique-subscriptions 12)
  (:ranked-by-playtime-trend 13)
  (:ranked-by-total-playtime 14)
  (:ranked-by-average-playtime-trend 15)
  (:ranked-by-lifetime-average-playtime 16)
  (:ranked-by-playtime-sessions-trend 17)
  (:ranked-by-lifetime-playtime-sessions 18)
  (:ranked-by-last-updated-date 19))

(cffi:defcenum eitem-update-status
  (:invalid 0)
  (:preparing-config 1)
  (:preparing-content 2)
  (:uploading-content 3)
  (:uploading-preview-file 4)
  (:committing-changes 5))

(cffi:defcenum eitem-state
  (:none 0)
  (:subscribed 1)
  (:legacy-item 2)
  (:installed 4)
  (:needs-update 8)
  (:downloading 16)
  (:download-pending 32)
  (:disabled-locally 64))

(cffi:defcenum eitem-statistic
  (:num-subscriptions 0)
  (:num-favorites 1)
  (:num-followers 2)
  (:num-unique-subscriptions 3)
  (:num-unique-favorites 4)
  (:num-unique-followers 5)
  (:num-unique-website-views 6)
  (:report-score 7)
  (:num-seconds-played 8)
  (:num-playtime-sessions 9)
  (:num-comments 10)
  (:num-seconds-played-during-time-period 11)
  (:num-playtime-sessions-during-time-period 12))

(cffi:defcenum eitem-preview-type
  (:image 0)
  (:you-tube-video 1)
  (:sketchfab 2)
  (:environment-map-horizontal-cross 3)
  (:environment-map-lat-long 4)
  (:clip 5)
  (:reserved-max 255))

(cffi:defcenum eugccontent-descriptor-id
  (:ugccontent-descriptor-nudity-or-sexual-content 1)
  (:ugccontent-descriptor-frequent-violence-or-gore 2)
  (:ugccontent-descriptor-adult-only-sexual-content 3)
  (:ugccontent-descriptor-gratuitous-sexual-content 4)
  (:ugccontent-descriptor-any-mature-content 5))

(cffi:defcenum esteam-item-flags
  (:steam-item-no-trade 1)
  (:steam-item-removed 256)
  (:steam-item-consumed 512))

(cffi:defcenum etimeline-game-mode
  (:invalid 0)
  (:playing 1)
  (:staging 2)
  (:menus 3)
  (:loading-screen 4)
  (:max 5))

(cffi:defcenum etimeline-event-clip-priority
  (:invalid 0)
  (:none 1)
  (:standard 2)
  (:featured 3))

(cffi:defcenum eparental-feature
  (:feature-invalid 0)
  (:feature-store 1)
  (:feature-community 2)
  (:feature-profile 3)
  (:feature-friends 4)
  (:feature-news 5)
  (:feature-trading 6)
  (:feature-settings 7)
  (:feature-console 8)
  (:feature-browser 9)
  (:feature-parental-setup 10)
  (:feature-library 11)
  (:feature-test 12)
  (:feature-site-license 13)
  (:feature-kiosk-mode-deprecated 14)
  (:feature-block-always 15)
  (:feature-max 16))

(cffi:defcenum esteam-device-form-factor
  (:unknown 0)
  (:phone 1)
  (:tablet 2)
  (:computer 3)
  (:tv 4)
  (:vrheadset 5))

(cffi:defcenum esteam-networking-availability
  (:cannot-try -102)
  (:failed -101)
  (:previously -100)
  (:retrying -10)
  (:never-tried 1)
  (:waiting 2)
  (:attempting 3)
  (:current 100)
  (:unknown 0)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-identity-type
  (:invalid 0)
  (:steam-id 16)
  (:xbox-pairwise-id 17)
  (:sony-psn 18)
  (:ipaddress 1)
  (:generic-string 2)
  (:generic-bytes 3)
  (:unknown-type 4)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-fake-iptype
  (:invalid 0)
  (:not-fake 1)
  (:global-ipv4 2)
  (:local-ipv4 3)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-connection-state
  (:none 0)
  (:connecting 1)
  (:finding-route 2)
  (:connected 3)
  (:closed-by-peer 4)
  (:problem-detected-locally 5)
  (:fin-wait -1)
  (:linger -2)
  (:dead -3)
  (:force32bit 2147483647))

(cffi:defcenum esteam-net-connection-end
  (:invalid 0)
  (:app-min 1000)
  (:app-generic 1000)
  (:app-max 1999)
  (:app-exception-min 2000)
  (:app-exception-generic 2000)
  (:app-exception-max 2999)
  (:local-min 3000)
  (:local-offline-mode 3001)
  (:local-many-relay-connectivity 3002)
  (:local-hosted-server-primary-relay 3003)
  (:local-network-config 3004)
  (:local-rights 3005)
  (:local-p2p-ice-no-public-addresses 3006)
  (:local-max 3999)
  (:remote-min 4000)
  (:remote-timeout 4001)
  (:remote-bad-crypt 4002)
  (:remote-bad-cert 4003)
  (:remote-bad-protocol-version 4006)
  (:remote-p2p-ice-no-public-addresses 4007)
  (:remote-max 4999)
  (:misc-min 5000)
  (:misc-generic 5001)
  (:misc-internal-error 5002)
  (:misc-timeout 5003)
  (:misc-steam-connectivity 5005)
  (:misc-no-relay-sessions-to-client 5006)
  (:misc-p2p-rendezvous 5008)
  (:misc-p2p-nat-firewall 5009)
  (:misc-peer-sent-no-connection 5010)
  (:misc-max 5999)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-config-scope
  (:steam-networking-config-global 1)
  (:steam-networking-config-sockets-interface 2)
  (:steam-networking-config-listen-socket 3)
  (:steam-networking-config-connection 4)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-config-data-type
  (:steam-networking-config-int32 1)
  (:steam-networking-config-int64 2)
  (:steam-networking-config-float 3)
  (:steam-networking-config-string 4)
  (:steam-networking-config-ptr 5)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-config-value
  (:steam-networking-config-invalid 0)
  (:steam-networking-config-timeout-initial 24)
  (:steam-networking-config-timeout-connected 25)
  (:steam-networking-config-send-buffer-size 9)
  (:steam-networking-config-recv-buffer-size 47)
  (:steam-networking-config-recv-buffer-messages 48)
  (:steam-networking-config-recv-max-message-size 49)
  (:steam-networking-config-recv-max-segments-per-packet 50)
  (:steam-networking-config-connection-user-data 40)
  (:steam-networking-config-send-rate-min 10)
  (:steam-networking-config-send-rate-max 11)
  (:steam-networking-config-nagle-time 12)
  (:steam-networking-config-ip-allow-without-auth 23)
  (:steam-networking-config-iplocal-host-allow-without-auth 52)
  (:steam-networking-config-mtu-packet-size 32)
  (:steam-networking-config-mtu-data-size 33)
  (:steam-networking-config-unencrypted 34)
  (:steam-networking-config-symmetric-connect 37)
  (:steam-networking-config-local-virtual-port 38)
  (:steam-networking-config-dual-wifi-enable 39)
  (:steam-networking-config-enable-diagnostics-ui 46)
  (:steam-networking-config-send-time-since-previous-packet 59)
  (:steam-networking-config-fake-packet-loss-send 2)
  (:steam-networking-config-fake-packet-loss-recv 3)
  (:steam-networking-config-fake-packet-lag-send 4)
  (:steam-networking-config-fake-packet-lag-recv 5)
  (:steam-networking-config-fake-packet-jitter-send-avg 53)
  (:steam-networking-config-fake-packet-jitter-send-max 54)
  (:steam-networking-config-fake-packet-jitter-send-pct 55)
  (:steam-networking-config-fake-packet-jitter-recv-avg 56)
  (:steam-networking-config-fake-packet-jitter-recv-max 57)
  (:steam-networking-config-fake-packet-jitter-recv-pct 58)
  (:steam-networking-config-fake-packet-reorder-send 6)
  (:steam-networking-config-fake-packet-reorder-recv 7)
  (:steam-networking-config-fake-packet-reorder-time 8)
  (:steam-networking-config-fake-packet-dup-send 26)
  (:steam-networking-config-fake-packet-dup-recv 27)
  (:steam-networking-config-fake-packet-dup-time-max 28)
  (:steam-networking-config-packet-trace-max-bytes 41)
  (:steam-networking-config-fake-rate-limit-send-rate 42)
  (:steam-networking-config-fake-rate-limit-send-burst 43)
  (:steam-networking-config-fake-rate-limit-recv-rate 44)
  (:steam-networking-config-fake-rate-limit-recv-burst 45)
  (:steam-networking-config-out-of-order-correction-window-microseconds 51)
  (:steam-networking-config-callback-connection-status-changed 201)
  (:steam-networking-config-callback-auth-status-changed 202)
  (:steam-networking-config-callback-relay-network-status-changed 203)
  (:steam-networking-config-callback-messages-session-request 204)
  (:steam-networking-config-callback-messages-session-failed 205)
  (:steam-networking-config-callback-create-connection-signaling 206)
  (:steam-networking-config-callback-fake-ipresult 207)
  (:steam-networking-config-p2p-stun-server-list 103)
  (:steam-networking-config-p2p-transport-ice-enable 104)
  (:steam-networking-config-p2p-transport-ice-penalty 105)
  (:steam-networking-config-p2p-transport-sdr-penalty 106)
  (:steam-networking-config-p2p-turn-server-list 107)
  (:steam-networking-config-p2p-turn-user-list 108)
  (:steam-networking-config-p2p-turn-pass-list 109)
  (:steam-networking-config-p2p-transport-ice-implementation 110)
  (:steam-networking-config-sdrclient-consecutitive-ping-timeouts-fail-initial
   19)
  (:steam-networking-config-sdrclient-consecutitive-ping-timeouts-fail 20)
  (:steam-networking-config-sdrclient-min-pings-before-ping-accurate 21)
  (:steam-networking-config-sdrclient-single-socket 22)
  (:steam-networking-config-sdrclient-force-relay-cluster 29)
  (:steam-networking-config-sdrclient-dev-ticket 30)
  (:steam-networking-config-sdrclient-force-proxy-addr 31)
  (:steam-networking-config-sdrclient-fake-cluster-ping 36)
  (:steam-networking-config-sdrclient-limit-ping-probes-to-nearest-n 60)
  (:steam-networking-config-log-level-ack-rtt 13)
  (:steam-networking-config-log-level-packet-decode 14)
  (:steam-networking-config-log-level-message 15)
  (:steam-networking-config-log-level-packet-gaps 16)
  (:steam-networking-config-log-level-p2prendezvous 17)
  (:steam-networking-config-log-level-sdrrelay-pings 18)
  (:steam-networking-config-ecn 999)
  (:steam-networking-config-deleted-enumerate-dev-vars 35)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-get-config-value-result
  (:steam-networking-get-config-value-bad-value -1)
  (:steam-networking-get-config-value-bad-scope-obj -2)
  (:steam-networking-get-config-value-buffer-too-small -3)
  (:steam-networking-get-config-value-ok 1)
  (:steam-networking-get-config-value-okinherited 2)
  (:force32bit 2147483647))

(cffi:defcenum esteam-networking-sockets-debug-output-type
  (:none 0)
  (:bug 1)
  (:error 2)
  (:important 3)
  (:warning 4)
  (:msg 5)
  (:verbose 6)
  (:debug 7)
  (:everything 8)
  (:force32bit 2147483647))

(cffi:defcenum esteam-apiinit-result
  (:ok 0)
  (:failed-generic 1)
  (:no-steam-client 2)
  (:version-mismatch 3))

(cffi:defcenum eserver-mode
  (:e-server-mode-invalid 0)
  (:e-server-mode-no-authentication 1)
  (:e-server-mode-authentication 2)
  (:e-server-mode-authentication-and-secure 3))

(cffi:defcenum isteam-htmlsurface-ehtmlmouse-button
  (:e-htmlmouse-button-left 0)
  (:e-htmlmouse-button-right 1)
  (:e-htmlmouse-button-middle 2))

(cffi:defcenum isteam-htmlsurface-emouse-cursor
  (:user 0)
  (:none 1)
  (:arrow 2)
  (:ibeam 3)
  (:hourglass 4)
  (:waitarrow 5)
  (:crosshair 6)
  (:up 7)
  (:sizenw 8)
  (:sizese 9)
  (:sizene 10)
  (:sizesw 11)
  (:sizew 12)
  (:sizee 13)
  (:sizen 14)
  (:sizes 15)
  (:sizewe 16)
  (:sizens 17)
  (:sizeall 18)
  (:no 19)
  (:hand 20)
  (:blank 21)
  (:middle-pan 22)
  (:north-pan 23)
  (:north-east-pan 24)
  (:east-pan 25)
  (:south-east-pan 26)
  (:south-pan 27)
  (:south-west-pan 28)
  (:west-pan 29)
  (:north-west-pan 30)
  (:alias 31)
  (:cell 32)
  (:colresize 33)
  (:copycur 34)
  (:verticaltext 35)
  (:rowresize 36)
  (:zoomin 37)
  (:zoomout 38)
  (:help 39)
  (:custom 40)
  (:last 41))

(cffi:defcenum isteam-htmlsurface-ehtmlkey-modifiers
  (:htmlkey-modifier-none 0)
  (:htmlkey-modifier-alt-down 1)
  (:htmlkey-modifier-ctrl-down 2)
  (:htmlkey-modifier-shift-down 4))

(cffi:defcenum ipcfailure-t-efailure-type
  (:failure-flushed-callback-queue 0)
  (:failure-pipe-fail 1))

(cffi:defcenum request-players-for-game-result-callback-t-player-accept-state
  (:state-unknown 0)
  (:state-player-accepted 1)
  (:state-player-declined 2))

(cffi:defctype uintptr :pointer)

(cffi:defctype intptr :pointer)

(cffi:defctype uint8 :unsigned-char)

(cffi:defctype int8 :char)

(cffi:defctype int16 :short)

(cffi:defctype uint16 :unsigned-short)

(cffi:defctype int32 :int)

(cffi:defctype uint32 :unsigned-int)

(cffi:defctype int64 :long-long)

(cffi:defctype uint64 :unsigned-long-long)

(cffi:defctype lint64 :long-long)

(cffi:defctype ulint64 :unsigned-long-long)

(cffi:defctype intp :long-long)

(cffi:defctype uintp :unsigned-long-long)

(cffi:defctype app-id :unsigned-int)

(cffi:defctype depot-id :unsigned-int)

(cffi:defctype rtime32 :unsigned-int)

(cffi:defctype steam-apicall :unsigned-long-long)

(cffi:defctype account-id :unsigned-int)

(cffi:defctype party-beacon-id :unsigned-long-long)

(cffi:defctype hauth-ticket :unsigned-int)

(cffi:defctype pfnpre-minidump-callback :pointer)

(cffi:defctype hsteam-pipe :int)

(cffi:defctype hsteam-user :int)

(cffi:defctype steam-err-msg :char)

(cffi:defctype friends-group-id :short)

(cffi:defctype hserver-list-request :pointer)

(cffi:defctype hserver-query :int)

(cffi:defctype ugchandle :unsigned-long-long)

(cffi:defctype published-file-update-handle :unsigned-long-long)

(cffi:defctype published-file-id :unsigned-long-long)

(cffi:defctype ugcfile-write-stream-handle :unsigned-long-long)

(cffi:defctype steam-leaderboard :unsigned-long-long)

(cffi:defctype steam-leaderboard-entries :unsigned-long-long)

(cffi:defctype snet-socket :unsigned-int)

(cffi:defctype snet-listen-socket :unsigned-int)

(cffi:defctype screenshot-handle :unsigned-int)

(cffi:defctype httprequest-handle :unsigned-int)

(cffi:defctype httpcookie-container-handle :unsigned-int)

(cffi:defctype input-handle :unsigned-long-long)

(cffi:defctype input-action-set-handle :unsigned-long-long)

(cffi:defctype input-digital-action-handle :unsigned-long-long)

(cffi:defctype input-analog-action-handle :unsigned-long-long)

(cffi:defctype steam-input-action-event-callback-pointer :pointer)

(cffi:defctype controller-handle :unsigned-long-long)

(cffi:defctype controller-action-set-handle :unsigned-long-long)

(cffi:defctype controller-digital-action-handle :unsigned-long-long)

(cffi:defctype controller-analog-action-handle :unsigned-long-long)

(cffi:defctype ugcquery-handle :unsigned-long-long)

(cffi:defctype ugcupdate-handle :unsigned-long-long)

(cffi:defctype hhtmlbrowser :unsigned-int)

(cffi:defctype steam-item-instance-id :unsigned-long-long)

(cffi:defctype steam-item-def :int)

(cffi:defctype steam-inventory-result :int)

(cffi:defctype steam-inventory-update-handle :unsigned-long-long)

(cffi:defctype timeline-event-handle :unsigned-long-long)

(cffi:defctype remote-play-session-id :unsigned-int)

(cffi:defctype fn-steam-net-connection-status-changed :pointer)

(cffi:defctype fn-steam-net-authentication-status-changed :pointer)

(cffi:defctype fn-steam-relay-network-status-changed :pointer)

(cffi:defctype fn-steam-networking-messages-session-request :pointer)

(cffi:defctype fn-steam-networking-messages-session-failed :pointer)

(cffi:defctype fn-steam-networking-fake-ipresult :pointer)

(cffi:defctype hsteam-net-connection :unsigned-int)

(cffi:defctype hsteam-listen-socket :unsigned-int)

(cffi:defctype hsteam-net-poll-group :unsigned-int)

(cffi:defctype steam-networking-err-msg :char)

(cffi:defctype steam-networking-popid :unsigned-int)

(cffi:defctype steam-networking-microseconds :long-long)

(cffi:defctype fsteam-networking-sockets-debug-output :pointer)

(defcstruct* steam-input-action-event-t-analog-action
  (handle input-analog-action-handle :count 1 :offset 0)
  (mode einput-source-mode :count 1 :offset 8)
  (x :float :count 1 :offset 12)
  (y :float :count 1 :offset 16)
  (active :bool :count 1 :offset 20))

(defcstruct* steam-input-action-event-t-digital-action
  (handle input-digital-action-handle :count 1 :offset 0)
  (quat-x :float :count 1 :offset 8)
  (quat-y :float :count 1 :offset 12)
  (quat-z :float :count 1 :offset 16)
  (quat-w :float :count 1 :offset 20)
  (accel-x :float :count 1 :offset 24)
  (accel-y :float :count 1 :offset 28)
  (accel-z :float :count 1 :offset 32)
  (vel-x :float :count 1 :offset 36)
  (vel-y :float :count 1 :offset 40)
  (vel-z :float :count 1 :offset 44))

(defcstruct* steam-ipaddress
  (ipv6 :uint8 :count 16 :offset 0)
  (type esteam-iptype :count 1 :offset 16))

(defcstruct* friend-game-info
  (id :unsigned-long :count 1 :offset 0)
  (game-ip :uint32 :count 1 :offset 8)
  (game-port :uint16 :count 1 :offset 12)
  (query-port :uint16 :count 1 :offset 16)
  (idlobby :unsigned-long :count 1 :offset 20))

(defcstruct* match-making-key-value-pair
  (key :char :count 256 :offset 0)
  (value :char :count 256 :offset 256))

(defcstruct* gameserveritem
  (net-adr :uint64 :count 1 :offset 0)
  (ping :int :count 1 :offset 8)
  (had-successful-response :bool :count 1 :offset 12)
  (do-not-refresh :bool :count 1 :offset 16)
  (game-dir :char :count 32 :offset 20)
  (map :char :count 32 :offset 52)
  (game-description :char :count 64 :offset 84)
  (app-id :uint32 :count 1 :offset 148)
  (players :int :count 1 :offset 152)
  (max-players :int :count 1 :offset 156)
  (bot-players :int :count 1 :offset 160)
  (password :bool :count 1 :offset 164)
  (secure :bool :count 1 :offset 168)
  (time-last-played :uint32 :count 1 :offset 172)
  (server-version :int :count 1 :offset 176)
  (server-name :char :count 64 :offset 180)
  (game-tags :char :count 128 :offset 244)
  (id :unsigned-long :count 1 :offset 372))

(defcstruct* steam-party-beacon-location
  (type esteam-party-beacon-location-type :count 1 :offset 0)
  (location-id :uint64 :count 1 :offset 4))

(defcstruct* steam-param-string-array
  (strings :string :count 1 :offset 0)
  (num-strings :int32 :count 1 :offset 8))

(defcstruct* leaderboard-entry
  (iduser :unsigned-long :count 1 :offset 0)
  (global-rank :int32 :count 1 :offset 8)
  (score :int32 :count 1 :offset 12)
  (details :int32 :count 1 :offset 16)
  (ugc ugchandle :count 1 :offset 20))

(defcstruct* p2psession-state
  (connection-active :uint8 :count 1 :offset 0)
  (connecting :uint8 :count 1 :offset 4)
  (p2psession-error :uint8 :count 1 :offset 8)
  (using-relay :uint8 :count 1 :offset 12)
  (bytes-queued-for-send :int32 :count 1 :offset 16)
  (packets-queued-for-send :int32 :count 1 :offset 20)
  (remote-ip :uint32 :count 1 :offset 24)
  (remote-port :uint16 :count 1 :offset 28))

(defcstruct* input-analog-action-data
  (mode einput-source-mode :count 1 :offset 0)
  (x :float :count 1 :offset 4)
  (y :float :count 1 :offset 8)
  (active :bool :count 1 :offset 12))

(defcstruct* input-digital-action-data
  (state :bool :count 1 :offset 0)
  (active :bool :count 1 :offset 4))

(defcstruct* input-motion-data
  (quat-x :float :count 1 :offset 0)
  (quat-y :float :count 1 :offset 4)
  (quat-z :float :count 1 :offset 8)
  (quat-w :float :count 1 :offset 12)
  (accel-x :float :count 1 :offset 16)
  (accel-y :float :count 1 :offset 20)
  (accel-z :float :count 1 :offset 24)
  (vel-x :float :count 1 :offset 28)
  (vel-y :float :count 1 :offset 32)
  (vel-z :float :count 1 :offset 36))

(defcstruct* steam-input-action-event
  (handle input-handle :count 1 :offset 0)
  (event-type esteam-input-action-event-type :count 1 :offset 8)
  (action (:struct steam-input-action-event-t-analog-action) :count 1 :offset
   12))

(defcstruct* steam-ugcdetails
  (published-file-id published-file-id :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (file-type eworkshop-file-type :count 1 :offset 12)
  (creator-app-id app-id :count 1 :offset 16)
  (consumer-app-id app-id :count 1 :offset 20)
  (title :char :count 129 :offset 24)
  (description :char :count 8000 :offset 156)
  (steam-idowner :uint64 :count 1 :offset 8156)
  (created :uint32 :count 1 :offset 8164)
  (updated :uint32 :count 1 :offset 8168)
  (added-to-user-list :uint32 :count 1 :offset 8172)
  (visibility eremote-storage-published-file-visibility :count 1 :offset 8176)
  (banned :bool :count 1 :offset 8180)
  (accepted-for-use :bool :count 1 :offset 8184)
  (tags-truncated :bool :count 1 :offset 8188)
  (tags :char :count 1025 :offset 8192)
  (file ugchandle :count 1 :offset 9220)
  (preview-file ugchandle :count 1 :offset 9228)
  (file-name :char :count 260 :offset 9236)
  (file-size :int32 :count 1 :offset 9496)
  (preview-file-size :int32 :count 1 :offset 9500)
  (url :char :count 256 :offset 9504)
  (votes-up :uint32 :count 1 :offset 9760)
  (votes-down :uint32 :count 1 :offset 9764)
  (score :float :count 1 :offset 9768)
  (num-children :uint32 :count 1 :offset 9772)
  (total-files-size :uint64 :count 1 :offset 9776))

(defcstruct* steam-item-details
  (id steam-item-instance-id :count 1 :offset 0)
  (definition steam-item-def :count 1 :offset 8)
  (quantity :uint16 :count 1 :offset 12)
  (flags :uint16 :count 1 :offset 16))

(defcstruct* steam-networking-ipaddr
  (|6| :uint8 :count 16 :offset 0)
  (port :uint16 :count 1 :offset 16))

(defcstruct* steam-networking-identity
  (type esteam-networking-identity-type :count 1 :offset 0)
  (size :int :count 1 :offset 4)
  (unknown-raw-string :char :count 128 :offset 8))

(defcstruct* steam-net-connection-info
  (remote (:struct steam-networking-identity) :count 1 :offset 0)
  (user-data :int64 :count 1 :offset 136)
  (listen-socket hsteam-listen-socket :count 1 :offset 144)
  (remote1 (:struct steam-networking-ipaddr) :count 1 :offset 148)
  (|1| :uint16 :count 1 :offset 168)
  (popremote steam-networking-popid :count 1 :offset 172)
  (poprelay steam-networking-popid :count 1 :offset 176)
  (state esteam-networking-connection-state :count 1 :offset 180)
  (end-reason :int :count 1 :offset 184)
  (end-debug :char :count 128 :offset 188)
  (connection-description :char :count 128 :offset 316)
  (flags :int :count 1 :offset 444)
  (reserved :uint32 :count 63 :offset 448))

(defcstruct* steam-net-connection-real-time-status
  (state esteam-networking-connection-state :count 1 :offset 0)
  (ping :int :count 1 :offset 4)
  (connection-quality-local :float :count 1 :offset 8)
  (connection-quality-remote :float :count 1 :offset 12)
  (out-packets-per-sec :float :count 1 :offset 16)
  (out-bytes-per-sec :float :count 1 :offset 20)
  (in-packets-per-sec :float :count 1 :offset 24)
  (in-bytes-per-sec :float :count 1 :offset 28)
  (send-rate-bytes-per-second :int :count 1 :offset 32)
  (pending-unreliable :int :count 1 :offset 36)
  (pending-reliable :int :count 1 :offset 40)
  (sent-unacked-reliable :int :count 1 :offset 44)
  (queue-time steam-networking-microseconds :count 1 :offset 48)
  (reserved :uint32 :count 16 :offset 56))

(defcstruct* steam-net-connection-real-time-lane-status
  (pending-unreliable :int :count 1 :offset 0)
  (pending-reliable :int :count 1 :offset 4)
  (sent-unacked-reliable :int :count 1 :offset 8)
  (pad1 :int :count 1 :offset 12)
  (queue-time steam-networking-microseconds :count 1 :offset 16)
  (reserved :uint32 :count 10 :offset 24))

(defcstruct* steam-networking-message
  (data :pointer :count 1 :offset 0)
  (size :int :count 1 :offset 8)
  (conn hsteam-net-connection :count 1 :offset 12)
  (peer (:struct steam-networking-identity) :count 1 :offset 16)
  (conn-user-data :int64 :count 1 :offset 152)
  (time-received steam-networking-microseconds :count 1 :offset 160)
  (message-number :int64 :count 1 :offset 168)
  (free-data :pointer :count 1 :offset 176)
  (release :pointer :count 1 :offset 184)
  (channel :int :count 1 :offset 192)
  (flags :int :count 1 :offset 196)
  (user-data :int64 :count 1 :offset 200)
  (lane :uint16 :count 1 :offset 208)
  (1- :uint16 :count 1 :offset 212))

(defcstruct* steam-network-ping-location
  (data :uint8 :count 512 :offset 0))

(defcstruct* steam-networking-config-value
  (value esteam-networking-config-value :count 1 :offset 0)
  (data-type esteam-networking-config-data-type :count 1 :offset 4)
  (|64| :int64 :count 1 :offset 8))

(defcstruct* steam-datagram-hosted-address
  (size :int :count 1 :offset 0)
  (data :char :count 128 :offset 4))

(defcstruct* steam-datagram-game-coordinator-server-login
  (identity (:struct steam-networking-identity) :count 1 :offset 0)
  (routing (:struct steam-datagram-hosted-address) :count 1 :offset 136)
  (app-id app-id :count 1 :offset 268)
  (rtime rtime32 :count 1 :offset 272)
  (app-data :int :count 1 :offset 276)
  (data :char :count 2048 :offset 280))

(defcstruct* steam-servers-connected)

(defcstruct* steam-server-connect-failure
  (result eresult :count 1 :offset 0)
  (still-retrying :bool :count 1 :offset 4))

(defcstruct* steam-servers-disconnected
  (result eresult :count 1 :offset 0))

(defcstruct* client-game-server-deny
  (app-id :uint32 :count 1 :offset 0)
  (game-server-ip :uint32 :count 1 :offset 4)
  (game-server-port :uint16 :count 1 :offset 8)
  (secure :uint16 :count 1 :offset 12)
  (reason :uint32 :count 1 :offset 16))

(defcstruct* ipcfailure
  (failure-type :uint8 :count 1 :offset 0))

(defcstruct* licenses-updated)

(defcstruct* validate-auth-ticket
  (steam-id :unsigned-long :count 1 :offset 0)
  (auth-session-response eauth-session-response :count 1 :offset 8)
  (owner-steam-id :unsigned-long :count 1 :offset 12))

(defcstruct* micro-txn-authorization
  (app-id :uint32 :count 1 :offset 0)
  (order-id :uint64 :count 1 :offset 4)
  (authorized :uint8 :count 1 :offset 12))

(defcstruct* encrypted-app-ticket
  (result eresult :count 1 :offset 0))

(defcstruct* get-auth-session-ticket
  (auth-ticket hauth-ticket :count 1 :offset 0)
  (result eresult :count 1 :offset 4))

(defcstruct* game-web-callback
  (url :char :count 256 :offset 0))

(defcstruct* store-auth-url
  (url :char :count 512 :offset 0))

(defcstruct* market-eligibility
  (allowed :bool :count 1 :offset 0)
  (not-allowed-reason emarket-not-allowed-reason-flags :count 1 :offset 4)
  (allowed-at-time rtime32 :count 1 :offset 8)
  (steam-guard-required-days :int :count 1 :offset 12)
  (new-device-cooldown :int :count 1 :offset 16))

(defcstruct* duration-control
  (result eresult :count 1 :offset 0)
  (appid app-id :count 1 :offset 4)
  (applicable :bool :count 1 :offset 8)
  (last5h :int32 :count 1 :offset 12)
  (progress eduration-control-progress :count 1 :offset 16)
  (notification eduration-control-notification :count 1 :offset 20)
  (today :int32 :count 1 :offset 24)
  (remaining :int32 :count 1 :offset 28))

(defcstruct* get-ticket-for-web-api
  (auth-ticket hauth-ticket :count 1 :offset 0)
  (result eresult :count 1 :offset 4)
  (ticket :int :count 1 :offset 8)
  (ticket1 :uint8 :count 2560 :offset 12))

(defcstruct* persona-state-change
  (steam-id :uint64 :count 1 :offset 0)
  (change-flags :int :count 1 :offset 8))

(defcstruct* game-overlay-activated
  (active :uint8 :count 1 :offset 0)
  (user-initiated :bool :count 1 :offset 4)
  (app-id app-id :count 1 :offset 8)
  (overlay-pid :uint32 :count 1 :offset 12))

(defcstruct* game-server-change-requested
  (server :char :count 64 :offset 0)
  (password :char :count 64 :offset 64))

(defcstruct* game-lobby-join-requested
  (idlobby :unsigned-long :count 1 :offset 0)
  (idfriend :unsigned-long :count 1 :offset 8))

(defcstruct* avatar-image-loaded
  (id :unsigned-long :count 1 :offset 0)
  (image :int :count 1 :offset 8)
  (wide :int :count 1 :offset 12)
  (tall :int :count 1 :offset 16))

(defcstruct* clan-officer-list
  (idclan :unsigned-long :count 1 :offset 0)
  (officers :int :count 1 :offset 8)
  (success :uint8 :count 1 :offset 12))

(defcstruct* friend-rich-presence-update
  (idfriend :unsigned-long :count 1 :offset 0)
  (app-id app-id :count 1 :offset 8))

(defcstruct* game-rich-presence-join-requested
  (idfriend :unsigned-long :count 1 :offset 0)
  (connect :char :count 256 :offset 8))

(defcstruct* game-connected-clan-chat-msg
  (idclan-chat :unsigned-long :count 1 :offset 0)
  (iduser :unsigned-long :count 1 :offset 8)
  (message-id :int :count 1 :offset 16))

(defcstruct* game-connected-chat-join
  (idclan-chat :unsigned-long :count 1 :offset 0)
  (iduser :unsigned-long :count 1 :offset 8))

(defcstruct* game-connected-chat-leave
  (idclan-chat :unsigned-long :count 1 :offset 0)
  (iduser :unsigned-long :count 1 :offset 8)
  (kicked :bool :count 1 :offset 16)
  (dropped :bool :count 1 :offset 20))

(defcstruct* download-clan-activity-counts
  (success :bool :count 1 :offset 0))

(defcstruct* join-clan-chat-room-completion
  (idclan-chat :unsigned-long :count 1 :offset 0)
  (chat-room-enter-response echat-room-enter-response :count 1 :offset 8))

(defcstruct* game-connected-friend-chat-msg
  (iduser :unsigned-long :count 1 :offset 0)
  (message-id :int :count 1 :offset 8))

(defcstruct* friends-get-follower-count
  (result eresult :count 1 :offset 0)
  (id :unsigned-long :count 1 :offset 4)
  (count :int :count 1 :offset 12))

(defcstruct* friends-is-following
  (result eresult :count 1 :offset 0)
  (id :unsigned-long :count 1 :offset 4)
  (is-following :bool :count 1 :offset 12))

(defcstruct* friends-enumerate-following-list
  (result eresult :count 1 :offset 0)
  (steam-id :unsigned-long :count 50 :offset 4)
  (results-returned :int32 :count 1 :offset 404)
  (total-result-count :int32 :count 1 :offset 408))

(defcstruct* set-persona-name
  (success :bool :count 1 :offset 0)
  (local-success :bool :count 1 :offset 4)
  (result eresult :count 1 :offset 8))

(defcstruct* unread-chat-messages-changed)

(defcstruct* overlay-browser-protocol-navigation
  (uri :char :count 1024 :offset 0))

(defcstruct* equipped-profile-items-changed
  (id :unsigned-long :count 1 :offset 0))

(defcstruct* equipped-profile-items
  (result eresult :count 1 :offset 0)
  (id :unsigned-long :count 1 :offset 4)
  (has-animated-avatar :bool :count 1 :offset 12)
  (has-avatar-frame :bool :count 1 :offset 16)
  (has-profile-modifier :bool :count 1 :offset 20)
  (has-profile-background :bool :count 1 :offset 24)
  (has-mini-profile-background :bool :count 1 :offset 28)
  (from-cache :bool :count 1 :offset 32))

(defcstruct* ipcountry)

(defcstruct* low-battery-power
  (minutes-battery-left :uint8 :count 1 :offset 0))

(defcstruct* steam-apicall-completed
  (async-call steam-apicall :count 1 :offset 0)
  (callback :int :count 1 :offset 8)
  (param :uint32 :count 1 :offset 12))

(defcstruct* steam-shutdown)

(defcstruct* check-file-signature
  (check-file-signature echeck-file-signature :count 1 :offset 0))

(defcstruct* gamepad-text-input-dismissed
  (submitted :bool :count 1 :offset 0)
  (submitted-text :uint32 :count 1 :offset 4)
  (app-id app-id :count 1 :offset 8))

(defcstruct* app-resuming-from-suspend)

(defcstruct* floating-gamepad-text-input-dismissed)

(defcstruct* filter-text-dictionary-changed
  (language :int :count 1 :offset 0))

(defcstruct* favorites-list-changed
  (ip :uint32 :count 1 :offset 0)
  (query-port :uint32 :count 1 :offset 4)
  (conn-port :uint32 :count 1 :offset 8)
  (app-id :uint32 :count 1 :offset 12)
  (flags :uint32 :count 1 :offset 16)
  (add :bool :count 1 :offset 20)
  (account-id account-id :count 1 :offset 24))

(defcstruct* lobby-invite
  (steam-iduser :uint64 :count 1 :offset 0)
  (steam-idlobby :uint64 :count 1 :offset 8)
  (game-id :uint64 :count 1 :offset 16))

(defcstruct* lobby-enter
  (steam-idlobby :uint64 :count 1 :offset 0)
  (chat-permissions :uint32 :count 1 :offset 8)
  (locked :bool :count 1 :offset 12)
  (echat-room-enter-response :uint32 :count 1 :offset 16))

(defcstruct* lobby-data-update
  (steam-idlobby :uint64 :count 1 :offset 0)
  (steam-idmember :uint64 :count 1 :offset 8)
  (success :uint8 :count 1 :offset 16))

(defcstruct* lobby-chat-update
  (steam-idlobby :uint64 :count 1 :offset 0)
  (steam-iduser-changed :uint64 :count 1 :offset 8)
  (steam-idmaking-change :uint64 :count 1 :offset 16)
  (chat-member-state-change :uint32 :count 1 :offset 24))

(defcstruct* lobby-chat-msg
  (steam-idlobby :uint64 :count 1 :offset 0)
  (steam-iduser :uint64 :count 1 :offset 8)
  (chat-entry-type :uint8 :count 1 :offset 16)
  (chat-id :uint32 :count 1 :offset 20))

(defcstruct* lobby-game-created
  (steam-idlobby :uint64 :count 1 :offset 0)
  (steam-idgame-server :uint64 :count 1 :offset 8)
  (ip :uint32 :count 1 :offset 16)
  (port :uint16 :count 1 :offset 20))

(defcstruct* lobby-match-list
  (lobbies-matching :uint32 :count 1 :offset 0))

(defcstruct* lobby-kicked
  (steam-idlobby :uint64 :count 1 :offset 0)
  (steam-idadmin :uint64 :count 1 :offset 8)
  (kicked-due-to-disconnect :uint8 :count 1 :offset 16))

(defcstruct* lobby-created
  (result eresult :count 1 :offset 0)
  (steam-idlobby :uint64 :count 1 :offset 4))

(defcstruct* psngame-boot-invite
  (game-boot-invite-exists :bool :count 1 :offset 0)
  (idlobby :unsigned-long :count 1 :offset 4))

(defcstruct* favorites-list-accounts-updated
  (result eresult :count 1 :offset 0))

(defcstruct* search-for-game-progress-callback
  (search-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (id :unsigned-long :count 1 :offset 12)
  (idended-search :unsigned-long :count 1 :offset 20)
  (seconds-remaining-estimate :int32 :count 1 :offset 28)
  (players-searching :int32 :count 1 :offset 32))

(defcstruct* search-for-game-result-callback
  (search-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (count-players-in-game :int32 :count 1 :offset 12)
  (count-accepted-game :int32 :count 1 :offset 16)
  (idhost :unsigned-long :count 1 :offset 20)
  (final-callback :bool :count 1 :offset 28))

(defcstruct* request-players-for-game-progress-callback
  (result eresult :count 1 :offset 0)
  (search-id :uint64 :count 1 :offset 4))

(defcstruct* request-players-for-game-result-callback
  (result eresult :count 1 :offset 0)
  (search-id :uint64 :count 1 :offset 4)
  (steam-idplayer-found :unsigned-long :count 1 :offset 12)
  (steam-idlobby :unsigned-long :count 1 :offset 20)
  (player-accept-state
   request-players-for-game-result-callback-t-player-accept-state :count 1
   :offset 28)
  (player-index :int32 :count 1 :offset 32)
  (total-players-found :int32 :count 1 :offset 36)
  (total-players-accepted-game :int32 :count 1 :offset 40)
  (suggested-team-index :int32 :count 1 :offset 44)
  (unique-game-id :uint64 :count 1 :offset 48))

(defcstruct* request-players-for-game-final-result-callback
  (result eresult :count 1 :offset 0)
  (search-id :uint64 :count 1 :offset 4)
  (unique-game-id :uint64 :count 1 :offset 12))

(defcstruct* submit-player-result-result-callback
  (result eresult :count 1 :offset 0)
  (unique-game-id :uint64 :count 1 :offset 4)
  (idplayer :unsigned-long :count 1 :offset 12))

(defcstruct* end-game-result-callback
  (result eresult :count 1 :offset 0)
  (unique-game-id :uint64 :count 1 :offset 4))

(defcstruct* join-party-callback
  (result eresult :count 1 :offset 0)
  (beacon-id party-beacon-id :count 1 :offset 4)
  (steam-idbeacon-owner :unsigned-long :count 1 :offset 12)
  (connect-string :char :count 256 :offset 20))

(defcstruct* create-beacon-callback
  (result eresult :count 1 :offset 0)
  (beacon-id party-beacon-id :count 1 :offset 4))

(defcstruct* reservation-notification-callback
  (beacon-id party-beacon-id :count 1 :offset 0)
  (idjoiner :unsigned-long :count 1 :offset 8))

(defcstruct* change-num-open-slots-callback
  (result eresult :count 1 :offset 0))

(defcstruct* available-beacon-locations-updated)

(defcstruct* active-beacons-updated)

(defcstruct* remote-storage-file-share
  (result eresult :count 1 :offset 0)
  (file ugchandle :count 1 :offset 4)
  (filename :char :count 260 :offset 12))

(defcstruct* remote-storage-publish-file
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (user-needs-to-accept-workshop-legal-agreement :bool :count 1 :offset 12))

(defcstruct* remote-storage-delete-published-file
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4))

(defcstruct* remote-storage-enumerate-user-published-files
  (result eresult :count 1 :offset 0)
  (results-returned :int32 :count 1 :offset 4)
  (total-result-count :int32 :count 1 :offset 8)
  (published-file-id published-file-id :count 50 :offset 12))

(defcstruct* remote-storage-subscribe-published-file
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4))

(defcstruct* remote-storage-enumerate-user-subscribed-files
  (result eresult :count 1 :offset 0)
  (results-returned :int32 :count 1 :offset 4)
  (total-result-count :int32 :count 1 :offset 8)
  (published-file-id published-file-id :count 50 :offset 12)
  (rtime-subscribed :uint32 :count 50 :offset 412))

(defcstruct* remote-storage-unsubscribe-published-file
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4))

(defcstruct* remote-storage-update-published-file
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (user-needs-to-accept-workshop-legal-agreement :bool :count 1 :offset 12))

(defcstruct* remote-storage-download-ugc
  (result eresult :count 1 :offset 0)
  (file ugchandle :count 1 :offset 4)
  (app-id app-id :count 1 :offset 12)
  (size-in-bytes :int32 :count 1 :offset 16)
  (file-name :char :count 260 :offset 20)
  (steam-idowner :uint64 :count 1 :offset 280))

(defcstruct* remote-storage-get-published-file-details
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (creator-app-id app-id :count 1 :offset 12)
  (consumer-app-id app-id :count 1 :offset 16)
  (title :char :count 129 :offset 20)
  (description :char :count 8000 :offset 152)
  (file ugchandle :count 1 :offset 8152)
  (preview-file ugchandle :count 1 :offset 8160)
  (steam-idowner :uint64 :count 1 :offset 8168)
  (created :uint32 :count 1 :offset 8176)
  (updated :uint32 :count 1 :offset 8180)
  (visibility eremote-storage-published-file-visibility :count 1 :offset 8184)
  (banned :bool :count 1 :offset 8188)
  (tags :char :count 1025 :offset 8192)
  (tags-truncated :bool :count 1 :offset 9220)
  (file-name :char :count 260 :offset 9224)
  (file-size :int32 :count 1 :offset 9484)
  (preview-file-size :int32 :count 1 :offset 9488)
  (url :char :count 256 :offset 9492)
  (file-type eworkshop-file-type :count 1 :offset 9748)
  (accepted-for-use :bool :count 1 :offset 9752))

(defcstruct* remote-storage-enumerate-workshop-files
  (result eresult :count 1 :offset 0)
  (results-returned :int32 :count 1 :offset 4)
  (total-result-count :int32 :count 1 :offset 8)
  (published-file-id published-file-id :count 50 :offset 12)
  (score :float :count 50 :offset 412)
  (app-id app-id :count 1 :offset 612)
  (start-index :uint32 :count 1 :offset 616))

(defcstruct* remote-storage-get-published-item-vote-details
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (votes-for :int32 :count 1 :offset 12)
  (votes-against :int32 :count 1 :offset 16)
  (reports :int32 :count 1 :offset 20)
  (score :float :count 1 :offset 24))

(defcstruct* remote-storage-published-file-subscribed
  (published-file-id published-file-id :count 1 :offset 0)
  (app-id app-id :count 1 :offset 8))

(defcstruct* remote-storage-published-file-unsubscribed
  (published-file-id published-file-id :count 1 :offset 0)
  (app-id app-id :count 1 :offset 8))

(defcstruct* remote-storage-published-file-deleted
  (published-file-id published-file-id :count 1 :offset 0)
  (app-id app-id :count 1 :offset 8))

(defcstruct* remote-storage-update-user-published-item-vote
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4))

(defcstruct* remote-storage-user-vote-details
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (vote eworkshop-vote :count 1 :offset 12))

(defcstruct* remote-storage-enumerate-user-shared-workshop-files
  (result eresult :count 1 :offset 0)
  (results-returned :int32 :count 1 :offset 4)
  (total-result-count :int32 :count 1 :offset 8)
  (published-file-id published-file-id :count 50 :offset 12))

(defcstruct* remote-storage-set-user-published-file-action
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (action eworkshop-file-action :count 1 :offset 12))

(defcstruct* remote-storage-enumerate-published-files-by-user-action
  (result eresult :count 1 :offset 0)
  (action eworkshop-file-action :count 1 :offset 4)
  (results-returned :int32 :count 1 :offset 8)
  (total-result-count :int32 :count 1 :offset 12)
  (published-file-id published-file-id :count 50 :offset 16)
  (rtime-updated :uint32 :count 50 :offset 416))

(defcstruct* remote-storage-publish-file-progress
  (percent-file :double :count 1 :offset 0)
  (preview :bool :count 1 :offset 8))

(defcstruct* remote-storage-published-file-updated
  (published-file-id published-file-id :count 1 :offset 0)
  (app-id app-id :count 1 :offset 8)
  (unused :uint64 :count 1 :offset 12))

(defcstruct* remote-storage-file-write-async-complete
  (result eresult :count 1 :offset 0))

(defcstruct* remote-storage-file-read-async-complete
  (file-read-async steam-apicall :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (offset :uint32 :count 1 :offset 12)
  (read :uint32 :count 1 :offset 16))

(defcstruct* remote-storage-local-file-change)

(defcstruct* user-stats-received
  (game-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (iduser :unsigned-long :count 1 :offset 12))

(defcstruct* user-stats-stored
  (game-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8))

(defcstruct* user-achievement-stored
  (game-id :uint64 :count 1 :offset 0)
  (group-achievement :bool :count 1 :offset 8)
  (achievement-name :char :count 128 :offset 12)
  (cur-progress :uint32 :count 1 :offset 140)
  (max-progress :uint32 :count 1 :offset 144))

(defcstruct* leaderboard-find
  (steam-leaderboard steam-leaderboard :count 1 :offset 0)
  (leaderboard-found :uint8 :count 1 :offset 8))

(defcstruct* leaderboard-scores-downloaded
  (steam-leaderboard steam-leaderboard :count 1 :offset 0)
  (steam-leaderboard-entries steam-leaderboard-entries :count 1 :offset 8)
  (entry-count :int :count 1 :offset 16))

(defcstruct* leaderboard-score-uploaded
  (success :uint8 :count 1 :offset 0)
  (steam-leaderboard steam-leaderboard :count 1 :offset 4)
  (score :int32 :count 1 :offset 12)
  (score-changed :uint8 :count 1 :offset 16)
  (global-rank-new :int :count 1 :offset 20)
  (global-rank-previous :int :count 1 :offset 24))

(defcstruct* number-of-current-players
  (success :uint8 :count 1 :offset 0)
  (players :int32 :count 1 :offset 4))

(defcstruct* user-stats-unloaded
  (iduser :unsigned-long :count 1 :offset 0))

(defcstruct* user-achievement-icon-fetched
  (game-id :unsigned-long :count 1 :offset 0)
  (achievement-name :char :count 128 :offset 8)
  (achieved :bool :count 1 :offset 136)
  (icon-handle :int :count 1 :offset 140))

(defcstruct* global-achievement-percentages-ready
  (game-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8))

(defcstruct* leaderboard-ugcset
  (result eresult :count 1 :offset 0)
  (steam-leaderboard steam-leaderboard :count 1 :offset 4))

(defcstruct* ps3trophies-installed
  (game-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (required-disk-space :uint64 :count 1 :offset 12))

(defcstruct* global-stats-received
  (game-id :uint64 :count 1 :offset 0)
  (result eresult :count 1 :offset 8))

(defcstruct* dlc-installed
  (app-id app-id :count 1 :offset 0))

(defcstruct* new-url-launch-parameters)

(defcstruct* app-proof-of-purchase-key
  (result eresult :count 1 :offset 0)
  (app-id :uint32 :count 1 :offset 4)
  (key-length :uint32 :count 1 :offset 8)
  (key :char :count 240 :offset 12))

(defcstruct* file-details
  (result eresult :count 1 :offset 0)
  (file-size :uint64 :count 1 :offset 4)
  (file-sha :uint8 :count 20 :offset 12)
  (flags :uint32 :count 1 :offset 32))

(defcstruct* timed-trial-status
  (app-id app-id :count 1 :offset 0)
  (is-offline :bool :count 1 :offset 4)
  (seconds-allowed :uint32 :count 1 :offset 8)
  (seconds-played :uint32 :count 1 :offset 12))

(defcstruct* p2psession-request
  (idremote :unsigned-long :count 1 :offset 0))

(defcstruct* p2psession-connect-fail
  (idremote :unsigned-long :count 1 :offset 0)
  (p2psession-error :uint8 :count 1 :offset 8))

(defcstruct* socket-status-callback
  (socket snet-socket :count 1 :offset 0)
  (listen-socket snet-listen-socket :count 1 :offset 4)
  (idremote :unsigned-long :count 1 :offset 8)
  (snet-socket-state :int :count 1 :offset 16))

(defcstruct* screenshot-ready
  (local screenshot-handle :count 1 :offset 0)
  (result eresult :count 1 :offset 4))

(defcstruct* screenshot-requested)

(defcstruct* playback-status-has-changed)

(defcstruct* volume-has-changed
  (new-volume :float :count 1 :offset 0))

(defcstruct* music-player-remote-will-activate)

(defcstruct* music-player-remote-will-deactivate)

(defcstruct* music-player-remote-to-front)

(defcstruct* music-player-will-quit)

(defcstruct* music-player-wants-play)

(defcstruct* music-player-wants-pause)

(defcstruct* music-player-wants-play-previous)

(defcstruct* music-player-wants-play-next)

(defcstruct* music-player-wants-shuffled
  (shuffled :bool :count 1 :offset 0))

(defcstruct* music-player-wants-looped
  (looped :bool :count 1 :offset 0))

(defcstruct* music-player-wants-volume
  (new-volume :float :count 1 :offset 0))

(defcstruct* music-player-selects-queue-entry
  (id :int :count 1 :offset 0))

(defcstruct* music-player-selects-playlist-entry
  (id :int :count 1 :offset 0))

(defcstruct* music-player-wants-playing-repeat-status
  (playing-repeat-status :int :count 1 :offset 0))

(defcstruct* httprequest-completed
  (request httprequest-handle :count 1 :offset 0)
  (context-value :uint64 :count 1 :offset 4)
  (request-successful :bool :count 1 :offset 12)
  (status-code ehttpstatus-code :count 1 :offset 16)
  (body-size :uint32 :count 1 :offset 20))

(defcstruct* httprequest-headers-received
  (request httprequest-handle :count 1 :offset 0)
  (context-value :uint64 :count 1 :offset 4))

(defcstruct* httprequest-data-received
  (request httprequest-handle :count 1 :offset 0)
  (context-value :uint64 :count 1 :offset 4)
  (offset :uint32 :count 1 :offset 12)
  (bytes-received :uint32 :count 1 :offset 16))

(defcstruct* steam-input-device-connected
  (connected-device-handle input-handle :count 1 :offset 0))

(defcstruct* steam-input-device-disconnected
  (disconnected-device-handle input-handle :count 1 :offset 0))

(defcstruct* steam-input-configuration-loaded
  (app-id app-id :count 1 :offset 0)
  (device-handle input-handle :count 1 :offset 4)
  (mapping-creator :unsigned-long :count 1 :offset 12)
  (major-revision :uint32 :count 1 :offset 20)
  (minor-revision :uint32 :count 1 :offset 24)
  (uses-steam-input-api :bool :count 1 :offset 28)
  (uses-gamepad-api :bool :count 1 :offset 32))

(defcstruct* steam-input-gamepad-slot-change
  (app-id app-id :count 1 :offset 0)
  (device-handle input-handle :count 1 :offset 4)
  (device-type esteam-input-type :count 1 :offset 12)
  (old-gamepad-slot :int :count 1 :offset 16)
  (new-gamepad-slot :int :count 1 :offset 20))

(defcstruct* steam-ugcquery-completed
  (handle ugcquery-handle :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (num-results-returned :uint32 :count 1 :offset 12)
  (total-matching-results :uint32 :count 1 :offset 16)
  (cached-data :bool :count 1 :offset 20)
  (next-cursor :char :count 256 :offset 24))

(defcstruct* steam-ugcrequest-ugcdetails
  (details (:struct steam-ugcdetails) :count 1 :offset 0)
  (cached-data :bool :count 1 :offset 9784))

(defcstruct* create-item
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (user-needs-to-accept-workshop-legal-agreement :bool :count 1 :offset 12))

(defcstruct* submit-item-update
  (result eresult :count 1 :offset 0)
  (user-needs-to-accept-workshop-legal-agreement :bool :count 1 :offset 4)
  (published-file-id published-file-id :count 1 :offset 8))

(defcstruct* item-installed
  (app-id app-id :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (legacy-content ugchandle :count 1 :offset 12)
  (manifest-id :uint64 :count 1 :offset 20))

(defcstruct* download-item
  (app-id app-id :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (result eresult :count 1 :offset 12))

(defcstruct* user-favorite-items-list-changed
  (published-file-id published-file-id :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (was-add-request :bool :count 1 :offset 12))

(defcstruct* set-user-item-vote
  (published-file-id published-file-id :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (vote-up :bool :count 1 :offset 12))

(defcstruct* get-user-item-vote
  (published-file-id published-file-id :count 1 :offset 0)
  (result eresult :count 1 :offset 8)
  (voted-up :bool :count 1 :offset 12)
  (voted-down :bool :count 1 :offset 16)
  (vote-skipped :bool :count 1 :offset 20))

(defcstruct* start-playtime-tracking
  (result eresult :count 1 :offset 0))

(defcstruct* stop-playtime-tracking
  (result eresult :count 1 :offset 0))

(defcstruct* add-ugcdependency
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (child-published-file-id published-file-id :count 1 :offset 12))

(defcstruct* remove-ugcdependency
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (child-published-file-id published-file-id :count 1 :offset 12))

(defcstruct* add-app-dependency
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (app-id app-id :count 1 :offset 12))

(defcstruct* remove-app-dependency
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (app-id app-id :count 1 :offset 12))

(defcstruct* get-app-dependencies
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4)
  (app-ids app-id :count 32 :offset 12)
  (num-app-dependencies :uint32 :count 1 :offset 140)
  (total-num-app-dependencies :uint32 :count 1 :offset 144))

(defcstruct* delete-item
  (result eresult :count 1 :offset 0)
  (published-file-id published-file-id :count 1 :offset 4))

(defcstruct* user-subscribed-items-list-changed
  (app-id app-id :count 1 :offset 0))

(defcstruct* workshop-eulastatus
  (result eresult :count 1 :offset 0)
  (app-id app-id :count 1 :offset 4)
  (version :uint32 :count 1 :offset 8)
  (action rtime32 :count 1 :offset 12)
  (accepted :bool :count 1 :offset 16)
  (needs-action :bool :count 1 :offset 20))

(defcstruct* html-browser-ready
  (browser-handle hhtmlbrowser :count 1 :offset 0))

(defcstruct* html-needs-paint
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (bgra :string :count 1 :offset 4)
  (wide :uint32 :count 1 :offset 12)
  (tall :uint32 :count 1 :offset 16)
  (update-x :uint32 :count 1 :offset 20)
  (update-y :uint32 :count 1 :offset 24)
  (update-wide :uint32 :count 1 :offset 28)
  (update-tall :uint32 :count 1 :offset 32)
  (scroll-x :uint32 :count 1 :offset 36)
  (scroll-y :uint32 :count 1 :offset 40)
  (page-scale :float :count 1 :offset 44)
  (page-serial :uint32 :count 1 :offset 48))

(defcstruct* html-start-request
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (url :string :count 1 :offset 4)
  (target :string :count 1 :offset 12)
  (post-data :string :count 1 :offset 20)
  (is-redirect :bool :count 1 :offset 28))

(defcstruct* html-close-browser
  (browser-handle hhtmlbrowser :count 1 :offset 0))

(defcstruct* html-urlchanged
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (url :string :count 1 :offset 4)
  (post-data :string :count 1 :offset 12)
  (is-redirect :bool :count 1 :offset 20)
  (page-title :string :count 1 :offset 24)
  (new-navigation :bool :count 1 :offset 32))

(defcstruct* html-finished-request
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (url :string :count 1 :offset 4)
  (page-title :string :count 1 :offset 12))

(defcstruct* html-open-link-in-new-tab
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (url :string :count 1 :offset 4))

(defcstruct* html-changed-title
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (title :string :count 1 :offset 4))

(defcstruct* html-search-results
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (results :uint32 :count 1 :offset 4)
  (current-match :uint32 :count 1 :offset 8))

(defcstruct* html-can-go-back-and-forward
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (can-go-back :bool :count 1 :offset 4)
  (can-go-forward :bool :count 1 :offset 8))

(defcstruct* html-horizontal-scroll
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (scroll-max :uint32 :count 1 :offset 4)
  (scroll-current :uint32 :count 1 :offset 8)
  (page-scale :float :count 1 :offset 12)
  (visible :bool :count 1 :offset 16)
  (page-size :uint32 :count 1 :offset 20))

(defcstruct* html-vertical-scroll
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (scroll-max :uint32 :count 1 :offset 4)
  (scroll-current :uint32 :count 1 :offset 8)
  (page-scale :float :count 1 :offset 12)
  (visible :bool :count 1 :offset 16)
  (page-size :uint32 :count 1 :offset 20))

(defcstruct* html-link-at-position
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (x :uint32 :count 1 :offset 4)
  (y :uint32 :count 1 :offset 8)
  (url :string :count 1 :offset 12)
  (input :bool :count 1 :offset 20)
  (live-link :bool :count 1 :offset 24))

(defcstruct* html-jsalert
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (message :string :count 1 :offset 4))

(defcstruct* html-jsconfirm
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (message :string :count 1 :offset 4))

(defcstruct* html-file-open-dialog
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (title :string :count 1 :offset 4)
  (initial-file :string :count 1 :offset 12))

(defcstruct* html-new-window
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (url :string :count 1 :offset 4)
  (x :uint32 :count 1 :offset 12)
  (y :uint32 :count 1 :offset 16)
  (wide :uint32 :count 1 :offset 20)
  (tall :uint32 :count 1 :offset 24)
  (new-window-browser-handle-ignore hhtmlbrowser :count 1 :offset 28))

(defcstruct* html-set-cursor
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (mouse-cursor :uint32 :count 1 :offset 4))

(defcstruct* html-status-text
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (msg :string :count 1 :offset 4))

(defcstruct* html-show-tool-tip
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (msg :string :count 1 :offset 4))

(defcstruct* html-update-tool-tip
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (msg :string :count 1 :offset 4))

(defcstruct* html-hide-tool-tip
  (browser-handle hhtmlbrowser :count 1 :offset 0))

(defcstruct* html-browser-restarted
  (browser-handle hhtmlbrowser :count 1 :offset 0)
  (old-browser-handle hhtmlbrowser :count 1 :offset 4))

(defcstruct* steam-inventory-result-ready
  (handle steam-inventory-result :count 1 :offset 0)
  (result eresult :count 1 :offset 4))

(defcstruct* steam-inventory-full-update
  (handle steam-inventory-result :count 1 :offset 0))

(defcstruct* steam-inventory-definition-update)

(defcstruct* steam-inventory-eligible-promo-item-def-ids
  (result eresult :count 1 :offset 0)
  (id :unsigned-long :count 1 :offset 4)
  (eligible-promo-item-defs :int :count 1 :offset 12)
  (cached-data :bool :count 1 :offset 16))

(defcstruct* steam-inventory-start-purchase
  (result eresult :count 1 :offset 0)
  (order-id :uint64 :count 1 :offset 4)
  (trans-id :uint64 :count 1 :offset 12))

(defcstruct* steam-inventory-request-prices
  (result eresult :count 1 :offset 0)
  (currency :char :count 4 :offset 4))

(defcstruct* steam-timeline-game-phase-recording-exists
  (phase-id :char :count 64 :offset 0)
  (recording-ms :uint64 :count 1 :offset 64)
  (longest-clip-ms :uint64 :count 1 :offset 72)
  (clip-count :uint32 :count 1 :offset 80)
  (screenshot-count :uint32 :count 1 :offset 84))

(defcstruct* steam-timeline-event-recording-exists
  (event-id :uint64 :count 1 :offset 0)
  (recording-exists :bool :count 1 :offset 8))

(defcstruct* get-video-url
  (result eresult :count 1 :offset 0)
  (video-app-id app-id :count 1 :offset 4)
  (url :char :count 256 :offset 8))

(defcstruct* get-opfsettings
  (result eresult :count 1 :offset 0)
  (video-app-id app-id :count 1 :offset 4))

(defcstruct* broadcast-upload-start
  (is-rtmp :bool :count 1 :offset 0))

(defcstruct* broadcast-upload-stop
  (result ebroadcast-upload-result :count 1 :offset 0))

(defcstruct* steam-parental-settings-changed)

(defcstruct* steam-remote-play-session-connected
  (session-id remote-play-session-id :count 1 :offset 0))

(defcstruct* steam-remote-play-session-disconnected
  (session-id remote-play-session-id :count 1 :offset 0))

(defcstruct* steam-remote-play-together-guest-invite
  (connect-url :char :count 1024 :offset 0))

(defcstruct* steam-networking-messages-session-request
  (remote (:struct steam-networking-identity) :count 1 :offset 0))

(defcstruct* steam-networking-messages-session-failed
  (info (:struct steam-net-connection-info) :count 1 :offset 0))

(defcstruct* steam-net-connection-status-changed-callback
  (conn hsteam-net-connection :count 1 :offset 0)
  (info (:struct steam-net-connection-info) :count 1 :offset 4)
  (old-state esteam-networking-connection-state :count 1 :offset 708))

(defcstruct* steam-net-authentication-status
  (avail esteam-networking-availability :count 1 :offset 0)
  (msg :char :count 256 :offset 4))

(defcstruct* steam-relay-network-status
  (avail esteam-networking-availability :count 1 :offset 0)
  (ping-measurement-in-progress :int :count 1 :offset 4)
  (avail-network-config esteam-networking-availability :count 1 :offset 8)
  (avail-any-relay esteam-networking-availability :count 1 :offset 12)
  (msg :char :count 256 :offset 16))

(defcstruct* gsclient-approve
  (steam-id :unsigned-long :count 1 :offset 0)
  (owner-steam-id :unsigned-long :count 1 :offset 8))

(defcstruct* gsclient-deny
  (steam-id :unsigned-long :count 1 :offset 0)
  (deny-reason edeny-reason :count 1 :offset 8)
  (optional-text :char :count 128 :offset 12))

(defcstruct* gsclient-kick
  (steam-id :unsigned-long :count 1 :offset 0)
  (deny-reason edeny-reason :count 1 :offset 8))

(defcstruct* gsclient-achievement-status
  (steam-id :uint64 :count 1 :offset 0)
  (achievement :char :count 128 :offset 8)
  (unlocked :bool :count 1 :offset 136))

(defcstruct* gspolicy
  (secure :uint8 :count 1 :offset 0))

(defcstruct* gsgameplay-stats
  (result eresult :count 1 :offset 0)
  (rank :int32 :count 1 :offset 4)
  (total-connects :uint32 :count 1 :offset 8)
  (total-minutes-played :uint32 :count 1 :offset 12))

(defcstruct* gsclient-group-status
  (steam-iduser :unsigned-long :count 1 :offset 0)
  (steam-idgroup :unsigned-long :count 1 :offset 8)
  (member :bool :count 1 :offset 16)
  (officer :bool :count 1 :offset 20))

(defcstruct* gsreputation
  (result eresult :count 1 :offset 0)
  (reputation-score :uint32 :count 1 :offset 4)
  (banned :bool :count 1 :offset 8)
  (banned-ip :uint32 :count 1 :offset 12)
  (banned-port :uint16 :count 1 :offset 16)
  (banned-game-id :uint64 :count 1 :offset 20)
  (ban-expires :uint32 :count 1 :offset 28))

(defcstruct* associate-with-clan
  (result eresult :count 1 :offset 0))

(defcstruct* compute-new-player-compatibility
  (result eresult :count 1 :offset 0)
  (players-that-dont-like-candidate :int :count 1 :offset 4)
  (players-that-candidate-doesnt-like :int :count 1 :offset 8)
  (clan-players-that-dont-like-candidate :int :count 1 :offset 12)
  (steam-idcandidate :unsigned-long :count 1 :offset 16))

(defcstruct* gsstats-received
  (result eresult :count 1 :offset 0)
  (iduser :unsigned-long :count 1 :offset 4))

(defcstruct* gsstats-stored
  (result eresult :count 1 :offset 0)
  (iduser :unsigned-long :count 1 :offset 4))

(defcstruct* gsstats-unloaded
  (iduser :unsigned-long :count 1 :offset 0))

(defcstruct* steam-networking-fake-ip
  (result eresult :count 1 :offset 0)
  (identity (:struct steam-networking-identity) :count 1 :offset 4)
  (ip :uint32 :count 1 :offset 140)
  (ports :uint16 :count 8 :offset 144))

(common-lisp:setf (common-lisp:gethash 'user-stats-request-current-stats
                                       *function-callresult-map*)
                    'user-stats-received)

(common-lisp:setf (common-lisp:gethash 'user-request-encrypted-app-ticket
                                       *function-callresult-map*)
                    'encrypted-app-ticket)

(common-lisp:setf (common-lisp:gethash 'user-request-store-auth-url
                                       *function-callresult-map*)
                    'store-auth-url)

(common-lisp:setf (common-lisp:gethash 'user-get-market-eligibility
                                       *function-callresult-map*)
                    'market-eligibility)

(common-lisp:setf (common-lisp:gethash 'user-get-duration-control
                                       *function-callresult-map*)
                    'duration-control)

(common-lisp:setf (common-lisp:gethash 'friends-set-persona-name
                                       *function-callresult-map*)
                    'set-persona-name)

(common-lisp:setf (common-lisp:gethash 'friends-download-clan-activity-counts
                                       *function-callresult-map*)
                    'download-clan-activity-counts)

(common-lisp:setf (common-lisp:gethash 'friends-request-clan-officer-list
                                       *function-callresult-map*)
                    'clan-officer-list)

(common-lisp:setf (common-lisp:gethash 'friends-join-clan-chat-room
                                       *function-callresult-map*)
                    'join-clan-chat-room-completion)

(common-lisp:setf (common-lisp:gethash 'friends-get-follower-count
                                       *function-callresult-map*)
                    'friends-get-follower-count)

(common-lisp:setf (common-lisp:gethash 'friends-is-following
                                       *function-callresult-map*)
                    'friends-is-following)

(common-lisp:setf (common-lisp:gethash 'friends-enumerate-following-list
                                       *function-callresult-map*)
                    'friends-enumerate-following-list)

(common-lisp:setf (common-lisp:gethash 'friends-request-equipped-profile-items
                                       *function-callresult-map*)
                    'equipped-profile-items)

(common-lisp:setf (common-lisp:gethash 'utils-check-file-signature
                                       *function-callresult-map*)
                    'check-file-signature)

(common-lisp:setf (common-lisp:gethash 'matchmaking-request-lobby-list
                                       *function-callresult-map*)
                    'lobby-match-list)

(common-lisp:setf (common-lisp:gethash 'matchmaking-create-lobby
                                       *function-callresult-map*)
                    'lobby-created)

(common-lisp:setf (common-lisp:gethash 'matchmaking-join-lobby
                                       *function-callresult-map*)
                    'lobby-enter)

(common-lisp:setf (common-lisp:gethash 'parties-join-party
                                       *function-callresult-map*)
                    'join-party-callback)

(common-lisp:setf (common-lisp:gethash 'parties-create-beacon
                                       *function-callresult-map*)
                    'create-beacon-callback)

(common-lisp:setf (common-lisp:gethash 'parties-change-num-open-slots
                                       *function-callresult-map*)
                    'change-num-open-slots-callback)

(common-lisp:setf (common-lisp:gethash 'remote-storage-file-write-async
                                       *function-callresult-map*)
                    'remote-storage-file-write-async-complete)

(common-lisp:setf (common-lisp:gethash 'remote-storage-file-read-async
                                       *function-callresult-map*)
                    'remote-storage-file-read-async-complete)

(common-lisp:setf (common-lisp:gethash 'remote-storage-file-share
                                       *function-callresult-map*)
                    'remote-storage-file-share)

(common-lisp:setf (common-lisp:gethash 'remote-storage-ugcdownload
                                       *function-callresult-map*)
                    'remote-storage-download-ugc)

(common-lisp:setf (common-lisp:gethash 'remote-storage-publish-workshop-file
                                       *function-callresult-map*)
                    'remote-storage-publish-file-progress)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-commit-published-file-update
                   *function-callresult-map*)
                    'remote-storage-update-published-file)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-get-published-file-details
                   *function-callresult-map*)
                    'remote-storage-get-published-file-details)

(common-lisp:setf (common-lisp:gethash 'remote-storage-delete-published-file
                                       *function-callresult-map*)
                    'remote-storage-delete-published-file)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-published-files
                   *function-callresult-map*)
                    'remote-storage-enumerate-user-published-files)

(common-lisp:setf (common-lisp:gethash 'remote-storage-subscribe-published-file
                                       *function-callresult-map*)
                    'remote-storage-subscribe-published-file)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-subscribed-files
                   *function-callresult-map*)
                    'remote-storage-enumerate-user-subscribed-files)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-unsubscribe-published-file
                   *function-callresult-map*)
                    'remote-storage-unsubscribe-published-file)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-get-published-item-vote-details
                   *function-callresult-map*)
                    'remote-storage-get-published-item-vote-details)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-update-user-published-item-vote
                   *function-callresult-map*)
                    'remote-storage-update-user-published-item-vote)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-get-user-published-item-vote-details
                   *function-callresult-map*)
                    'remote-storage-get-published-item-vote-details)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-user-shared-workshop-files
                   *function-callresult-map*)
                    'remote-storage-enumerate-user-published-files)

(common-lisp:setf (common-lisp:gethash 'remote-storage-publish-video
                                       *function-callresult-map*)
                    'remote-storage-publish-file-progress)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-set-user-published-file-action
                   *function-callresult-map*)
                    'remote-storage-set-user-published-file-action)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-published-files-by-user-action
                   *function-callresult-map*)
                    'remote-storage-enumerate-published-files-by-user-action)

(common-lisp:setf (common-lisp:gethash
                   'remote-storage-enumerate-published-workshop-files
                   *function-callresult-map*)
                    'remote-storage-enumerate-workshop-files)

(common-lisp:setf (common-lisp:gethash 'remote-storage-ugcdownload-to-location
                                       *function-callresult-map*)
                    'remote-storage-download-ugc)

(common-lisp:setf (common-lisp:gethash 'user-stats-request-user-stats
                                       *function-callresult-map*)
                    'user-stats-received)

(common-lisp:setf (common-lisp:gethash 'user-stats-find-or-create-leaderboard
                                       *function-callresult-map*)
                    'leaderboard-find)

(common-lisp:setf (common-lisp:gethash 'user-stats-find-leaderboard
                                       *function-callresult-map*)
                    'leaderboard-find)

(common-lisp:setf (common-lisp:gethash 'user-stats-download-leaderboard-entries
                                       *function-callresult-map*)
                    'leaderboard-scores-downloaded)

(common-lisp:setf (common-lisp:gethash
                   'user-stats-download-leaderboard-entries-for-users
                   *function-callresult-map*)
                    'leaderboard-scores-downloaded)

(common-lisp:setf (common-lisp:gethash 'user-stats-upload-leaderboard-score
                                       *function-callresult-map*)
                    'leaderboard-score-uploaded)

(common-lisp:setf (common-lisp:gethash 'user-stats-attach-leaderboard-ugc
                                       *function-callresult-map*)
                    'leaderboard-ugcset)

(common-lisp:setf (common-lisp:gethash
                   'user-stats-get-number-of-current-players
                   *function-callresult-map*)
                    'number-of-current-players)

(common-lisp:setf (common-lisp:gethash
                   'user-stats-request-global-achievement-percentages
                   *function-callresult-map*)
                    'global-achievement-percentages-ready)

(common-lisp:setf (common-lisp:gethash 'user-stats-request-global-stats
                                       *function-callresult-map*)
                    'global-stats-received)

(common-lisp:setf (common-lisp:gethash 'apps-get-file-details
                                       *function-callresult-map*)
                    'file-details)

(common-lisp:setf (common-lisp:gethash 'ugc-send-query-ugcrequest
                                       *function-callresult-map*)
                    'steam-ugcquery-completed)

(common-lisp:setf (common-lisp:gethash 'ugc-request-ugcdetails
                                       *function-callresult-map*)
                    'steam-ugcrequest-ugcdetails)

(common-lisp:setf (common-lisp:gethash 'ugc-create-item
                                       *function-callresult-map*)
                    'create-item)

(common-lisp:setf (common-lisp:gethash 'ugc-submit-item-update
                                       *function-callresult-map*)
                    'submit-item-update)

(common-lisp:setf (common-lisp:gethash 'ugc-set-user-item-vote
                                       *function-callresult-map*)
                    'set-user-item-vote)

(common-lisp:setf (common-lisp:gethash 'ugc-get-user-item-vote
                                       *function-callresult-map*)
                    'get-user-item-vote)

(common-lisp:setf (common-lisp:gethash 'ugc-add-item-to-favorites
                                       *function-callresult-map*)
                    'user-favorite-items-list-changed)

(common-lisp:setf (common-lisp:gethash 'ugc-remove-item-from-favorites
                                       *function-callresult-map*)
                    'user-favorite-items-list-changed)

(common-lisp:setf (common-lisp:gethash 'ugc-subscribe-item
                                       *function-callresult-map*)
                    'remote-storage-subscribe-published-file)

(common-lisp:setf (common-lisp:gethash 'ugc-unsubscribe-item
                                       *function-callresult-map*)
                    'remote-storage-unsubscribe-published-file)

(common-lisp:setf (common-lisp:gethash 'ugc-start-playtime-tracking
                                       *function-callresult-map*)
                    'start-playtime-tracking)

(common-lisp:setf (common-lisp:gethash 'ugc-stop-playtime-tracking
                                       *function-callresult-map*)
                    'stop-playtime-tracking)

(common-lisp:setf (common-lisp:gethash
                   'ugc-stop-playtime-tracking-for-all-items
                   *function-callresult-map*)
                    'stop-playtime-tracking)

(common-lisp:setf (common-lisp:gethash 'ugc-add-dependency
                                       *function-callresult-map*)
                    'add-ugcdependency)

(common-lisp:setf (common-lisp:gethash 'ugc-remove-dependency
                                       *function-callresult-map*)
                    'remove-ugcdependency)

(common-lisp:setf (common-lisp:gethash 'ugc-add-app-dependency
                                       *function-callresult-map*)
                    'add-app-dependency)

(common-lisp:setf (common-lisp:gethash 'ugc-remove-app-dependency
                                       *function-callresult-map*)
                    'remove-app-dependency)

(common-lisp:setf (common-lisp:gethash 'ugc-get-app-dependencies
                                       *function-callresult-map*)
                    'get-app-dependencies)

(common-lisp:setf (common-lisp:gethash 'ugc-delete-item
                                       *function-callresult-map*)
                    'delete-item)

(common-lisp:setf (common-lisp:gethash 'ugc-get-workshop-eulastatus
                                       *function-callresult-map*)
                    'workshop-eulastatus)

(common-lisp:setf (common-lisp:gethash 'htmlsurface-create-browser
                                       *function-callresult-map*)
                    'html-browser-ready)

(common-lisp:setf (common-lisp:gethash
                   'inventory-request-eligible-promo-item-definitions-ids
                   *function-callresult-map*)
                    'steam-inventory-eligible-promo-item-def-ids)

(common-lisp:setf (common-lisp:gethash 'inventory-start-purchase
                                       *function-callresult-map*)
                    'steam-inventory-start-purchase)

(common-lisp:setf (common-lisp:gethash 'inventory-request-prices
                                       *function-callresult-map*)
                    'steam-inventory-request-prices)

(common-lisp:setf (common-lisp:gethash 'timeline-does-event-recording-exist
                                       *function-callresult-map*)
                    'steam-timeline-event-recording-exists)

(common-lisp:setf (common-lisp:gethash
                   'timeline-does-game-phase-recording-exist
                   *function-callresult-map*)
                    'steam-timeline-game-phase-recording-exists)

(common-lisp:setf (common-lisp:gethash 'game-server-get-server-reputation
                                       *function-callresult-map*)
                    'gsreputation)

(common-lisp:setf (common-lisp:gethash 'game-server-associate-with-clan
                                       *function-callresult-map*)
                    'associate-with-clan)

(common-lisp:setf (common-lisp:gethash
                   'game-server-compute-new-player-compatibility
                   *function-callresult-map*)
                    'compute-new-player-compatibility)

(common-lisp:setf (common-lisp:gethash 'game-server-stats-request-user-stats
                                       *function-callresult-map*)
                    'gsstats-received)

(common-lisp:setf (common-lisp:gethash 'game-server-stats-store-user-stats
                                       *function-callresult-map*)
                    'gsstats-stored)

(common-lisp:setf (common-lisp:gethash 'friends-download-clan-activity-counts
                                       *function-callresult-map*)
                    'download-clan-activity-counts)

(common-lisp:setf (common-lisp:gethash 'ugc-request-ugcdetails
                                       *function-callresult-map*)
                    'steam-ugcrequest-ugcdetails)

(defcfun*
 (app-ticket-get-app-ownership-ticket-data
  "SteamAPI_ISteamAppTicket_GetAppOwnershipTicketData" :library steamworks)
 :uint32 (this :pointer) (n-app-id :uint32) (pv-buffer :pointer)
 (cb-buffer-length :uint32) (pi-app-id :pointer) (pi-steam-id :pointer)
 (pi-signature :pointer) (pcb-signature :pointer))

(defcfun*
 (user-stats-request-current-stats
  "SteamAPI_ISteamUserStats_RequestCurrentStats" :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (client-create-steam-pipe "SteamAPI_ISteamClient_CreateSteamPipe" :library
                           steamworks)
 hsteam-pipe (this :pointer))

(defcfun*
 (client-brelease-steam-pipe "SteamAPI_ISteamClient_BReleaseSteamPipe" :library
                             steamworks)
 :bool (this :pointer) (h-steam-pipe hsteam-pipe))

(defcfun*
 (client-connect-to-global-user "SteamAPI_ISteamClient_ConnectToGlobalUser"
                                :library steamworks)
 hsteam-user (this :pointer) (h-steam-pipe hsteam-pipe))

(defcfun*
 (client-create-local-user "SteamAPI_ISteamClient_CreateLocalUser" :library
                           steamworks)
 hsteam-user (this :pointer) (ph-steam-pipe :pointer)
 (e-account-type eaccount-type))

(defcfun*
 (client-release-user "SteamAPI_ISteamClient_ReleaseUser" :library steamworks)
 :void (this :pointer) (h-steam-pipe hsteam-pipe) (h-user hsteam-user))

(defcfun*
 (client-get-isteam-user "SteamAPI_ISteamClient_GetISteamUser" :library
                         steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-game-server "SteamAPI_ISteamClient_GetISteamGameServer"
                                :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-set-local-ipbinding "SteamAPI_ISteamClient_SetLocalIPBinding" :library
                             steamworks)
 :void (this :pointer) (un-ip :pointer) (us-port :uint16))

(defcfun*
 (client-get-isteam-friends "SteamAPI_ISteamClient_GetISteamFriends" :library
                            steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-utils "SteamAPI_ISteamClient_GetISteamUtils" :library
                          steamworks)
 :pointer (this :pointer) (h-steam-pipe hsteam-pipe) (pch-version :string))

(defcfun*
 (client-get-isteam-matchmaking "SteamAPI_ISteamClient_GetISteamMatchmaking"
                                :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-matchmaking-servers
  "SteamAPI_ISteamClient_GetISteamMatchmakingServers" :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-generic-interface
  "SteamAPI_ISteamClient_GetISteamGenericInterface" :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-user-stats "SteamAPI_ISteamClient_GetISteamUserStats"
                               :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-game-server-stats
  "SteamAPI_ISteamClient_GetISteamGameServerStats" :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-apps "SteamAPI_ISteamClient_GetISteamApps" :library
                         steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-networking "SteamAPI_ISteamClient_GetISteamNetworking"
                               :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-remote-storage
  "SteamAPI_ISteamClient_GetISteamRemoteStorage" :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-screenshots "SteamAPI_ISteamClient_GetISteamScreenshots"
                                :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-game-search "SteamAPI_ISteamClient_GetISteamGameSearch"
                                :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-ipccall-count "SteamAPI_ISteamClient_GetIPCCallCount" :library
                           steamworks)
 :uint32 (this :pointer))

(defcfun*
 (client-set-warning-message-hook "SteamAPI_ISteamClient_SetWarningMessageHook"
                                  :library steamworks)
 :void (this :pointer) (p-function :pointer))

(defcfun*
 (client-bshutdown-if-all-pipes-closed
  "SteamAPI_ISteamClient_BShutdownIfAllPipesClosed" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (client-get-isteam-http "SteamAPI_ISteamClient_GetISteamHTTP" :library
                         steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-controller "SteamAPI_ISteamClient_GetISteamController"
                               :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-ugc "SteamAPI_ISteamClient_GetISteamUGC" :library
                        steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-music "SteamAPI_ISteamClient_GetISteamMusic" :library
                          steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-music-remote "SteamAPI_ISteamClient_GetISteamMusicRemote"
                                 :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-htmlsurface "SteamAPI_ISteamClient_GetISteamHTMLSurface"
                                :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-inventory "SteamAPI_ISteamClient_GetISteamInventory"
                              :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-video "SteamAPI_ISteamClient_GetISteamVideo" :library
                          steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-parental-settings
  "SteamAPI_ISteamClient_GetISteamParentalSettings" :library steamworks)
 :pointer (this :pointer) (h-steamuser hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-input "SteamAPI_ISteamClient_GetISteamInput" :library
                          steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-parties "SteamAPI_ISteamClient_GetISteamParties" :library
                            steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (client-get-isteam-remote-play "SteamAPI_ISteamClient_GetISteamRemotePlay"
                                :library steamworks)
 :pointer (this :pointer) (h-steam-user hsteam-user) (h-steam-pipe hsteam-pipe)
 (pch-version :string))

(defcfun*
 (user-get-hsteam-user "SteamAPI_ISteamUser_GetHSteamUser" :library steamworks)
 hsteam-user (this :pointer))

(defcfun* (user-blogged-on "SteamAPI_ISteamUser_BLoggedOn" :library steamworks)
          :bool (this :pointer))

(defcfun*
 (user-get-steam-id "SteamAPI_ISteamUser_GetSteamID" :library steamworks)
 :unsigned-long (this :pointer))

(defcfun*
 (user-initiate-game-connection-deprecated
  "SteamAPI_ISteamUser_InitiateGameConnection_DEPRECATED" :library steamworks)
 :int (this :pointer) (p-auth-blob :pointer) (cb-max-auth-blob :int)
 (steam-idgame-server :unsigned-long) (un-ipserver :uint32)
 (us-port-server :uint16) (b-secure :bool))

(defcfun*
 (user-terminate-game-connection-deprecated
  "SteamAPI_ISteamUser_TerminateGameConnection_DEPRECATED" :library steamworks)
 :void (this :pointer) (un-ipserver :uint32) (us-port-server :uint16))

(defcfun*
 (user-track-app-usage-event "SteamAPI_ISteamUser_TrackAppUsageEvent" :library
                             steamworks)
 :void (this :pointer) (game-id :unsigned-long) (e-app-usage-event :int)
 (pch-extra-info :string))

(defcfun*
 (user-get-user-data-folder "SteamAPI_ISteamUser_GetUserDataFolder" :library
                            steamworks)
 :bool (this :pointer) (pch-buffer :string) (cub-buffer :int))

(defcfun*
 (user-start-voice-recording "SteamAPI_ISteamUser_StartVoiceRecording" :library
                             steamworks)
 :void (this :pointer))

(defcfun*
 (user-stop-voice-recording "SteamAPI_ISteamUser_StopVoiceRecording" :library
                            steamworks)
 :void (this :pointer))

(defcfun*
 (user-get-available-voice "SteamAPI_ISteamUser_GetAvailableVoice" :library
                           steamworks)
 evoice-result (this :pointer) (pcb-compressed :pointer)
 (pcb-uncompressed-deprecated :pointer)
 (n-uncompressed-voice-desired-sample-rate-deprecated :uint32))

(defcfun* (user-get-voice "SteamAPI_ISteamUser_GetVoice" :library steamworks)
          evoice-result (this :pointer) (b-want-compressed :bool)
          (p-dest-buffer :pointer) (cb-dest-buffer-size :uint32)
          (n-bytes-written :pointer) (b-want-uncompressed-deprecated :bool)
          (p-uncompressed-dest-buffer-deprecated :pointer)
          (cb-uncompressed-dest-buffer-size-deprecated :uint32)
          (n-uncompress-bytes-written-deprecated :pointer)
          (n-uncompressed-voice-desired-sample-rate-deprecated :uint32))

(defcfun*
 (user-decompress-voice "SteamAPI_ISteamUser_DecompressVoice" :library
                        steamworks)
 evoice-result (this :pointer) (p-compressed :pointer) (cb-compressed :uint32)
 (p-dest-buffer :pointer) (cb-dest-buffer-size :uint32)
 (n-bytes-written :pointer) (n-desired-sample-rate :uint32))

(defcfun*
 (user-get-voice-optimal-sample-rate
  "SteamAPI_ISteamUser_GetVoiceOptimalSampleRate" :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (user-get-auth-session-ticket "SteamAPI_ISteamUser_GetAuthSessionTicket"
                               :library steamworks)
 hauth-ticket (this :pointer) (p-ticket :pointer) (cb-max-ticket :int)
 (pcb-ticket :pointer) (p-steam-networking-identity :pointer))

(defcfun*
 (user-get-auth-ticket-for-web-api "SteamAPI_ISteamUser_GetAuthTicketForWebApi"
                                   :library steamworks)
 hauth-ticket (this :pointer) (pch-identity :string))

(defcfun*
 (user-begin-auth-session "SteamAPI_ISteamUser_BeginAuthSession" :library
                          steamworks)
 ebegin-auth-session-result (this :pointer) (p-auth-ticket :pointer)
 (cb-auth-ticket :int) (steam-id :unsigned-long))

(defcfun*
 (user-end-auth-session "SteamAPI_ISteamUser_EndAuthSession" :library
                        steamworks)
 :void (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (user-cancel-auth-ticket "SteamAPI_ISteamUser_CancelAuthTicket" :library
                          steamworks)
 :void (this :pointer) (h-auth-ticket hauth-ticket))

(defcfun*
 (user-user-has-license-for-app "SteamAPI_ISteamUser_UserHasLicenseForApp"
                                :library steamworks)
 euser-has-license-for-app-result (this :pointer) (steam-id :unsigned-long)
 (app-id app-id))

(defcfun*
 (user-bis-behind-nat "SteamAPI_ISteamUser_BIsBehindNAT" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (user-advertise-game "SteamAPI_ISteamUser_AdvertiseGame" :library steamworks)
 :void (this :pointer) (steam-idgame-server :unsigned-long)
 (un-ipserver :uint32) (us-port-server :uint16))

(defcfun*
 (user-request-encrypted-app-ticket
  "SteamAPI_ISteamUser_RequestEncryptedAppTicket" :library steamworks)
 steam-apicall (this :pointer) (p-data-to-include :pointer)
 (cb-data-to-include :int))

(defcfun*
 (user-get-encrypted-app-ticket "SteamAPI_ISteamUser_GetEncryptedAppTicket"
                                :library steamworks)
 :bool (this :pointer) (p-ticket :pointer) (cb-max-ticket :int)
 (pcb-ticket :pointer))

(defcfun*
 (user-get-game-badge-level "SteamAPI_ISteamUser_GetGameBadgeLevel" :library
                            steamworks)
 :int (this :pointer) (n-series :int) (b-foil :bool))

(defcfun*
 (user-get-player-steam-level "SteamAPI_ISteamUser_GetPlayerSteamLevel"
                              :library steamworks)
 :int (this :pointer))

(defcfun*
 (user-request-store-auth-url "SteamAPI_ISteamUser_RequestStoreAuthURL"
                              :library steamworks)
 steam-apicall (this :pointer) (pch-redirect-url :string))

(defcfun*
 (user-bis-phone-verified "SteamAPI_ISteamUser_BIsPhoneVerified" :library
                          steamworks)
 :bool (this :pointer))

(defcfun*
 (user-bis-two-factor-enabled "SteamAPI_ISteamUser_BIsTwoFactorEnabled"
                              :library steamworks)
 :bool (this :pointer))

(defcfun*
 (user-bis-phone-identifying "SteamAPI_ISteamUser_BIsPhoneIdentifying" :library
                             steamworks)
 :bool (this :pointer))

(defcfun*
 (user-bis-phone-requiring-verification
  "SteamAPI_ISteamUser_BIsPhoneRequiringVerification" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (user-get-market-eligibility "SteamAPI_ISteamUser_GetMarketEligibility"
                              :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (user-get-duration-control "SteamAPI_ISteamUser_GetDurationControl" :library
                            steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (user-bset-duration-control-online-state
  "SteamAPI_ISteamUser_BSetDurationControlOnlineState" :library steamworks)
 :bool (this :pointer) (e-new-state eduration-control-online-state))

(defcfun*
 (friends-get-persona-name "SteamAPI_ISteamFriends_GetPersonaName" :library
                           steamworks)
 :string (this :pointer))

(defcfun*
 (friends-set-persona-name "SteamAPI_ISteamFriends_SetPersonaName" :library
                           steamworks)
 steam-apicall (this :pointer) (pch-persona-name :string))

(defcfun*
 (friends-get-persona-state "SteamAPI_ISteamFriends_GetPersonaState" :library
                            steamworks)
 epersona-state (this :pointer))

(defcfun*
 (friends-get-friend-count "SteamAPI_ISteamFriends_GetFriendCount" :library
                           steamworks)
 :int (this :pointer) (i-friend-flags :int))

(defcfun*
 (friends-get-friend-by-index "SteamAPI_ISteamFriends_GetFriendByIndex"
                              :library steamworks)
 :unsigned-long (this :pointer) (i-friend :int) (i-friend-flags :int))

(defcfun*
 (friends-get-friend-relationship
  "SteamAPI_ISteamFriends_GetFriendRelationship" :library steamworks)
 efriend-relationship (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-friend-persona-state
  "SteamAPI_ISteamFriends_GetFriendPersonaState" :library steamworks)
 epersona-state (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-friend-persona-name "SteamAPI_ISteamFriends_GetFriendPersonaName"
                                  :library steamworks)
 :string (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-friend-game-played "SteamAPI_ISteamFriends_GetFriendGamePlayed"
                                 :library steamworks)
 :bool (this :pointer) (steam-idfriend :unsigned-long)
 (p-friend-game-info :pointer))

(defcfun*
 (friends-get-friend-persona-name-history
  "SteamAPI_ISteamFriends_GetFriendPersonaNameHistory" :library steamworks)
 :string (this :pointer) (steam-idfriend :unsigned-long) (i-persona-name :int))

(defcfun*
 (friends-get-friend-steam-level "SteamAPI_ISteamFriends_GetFriendSteamLevel"
                                 :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-player-nickname "SteamAPI_ISteamFriends_GetPlayerNickname"
                              :library steamworks)
 :string (this :pointer) (steam-idplayer :unsigned-long))

(defcfun*
 (friends-get-friends-group-count "SteamAPI_ISteamFriends_GetFriendsGroupCount"
                                  :library steamworks)
 :int (this :pointer))

(defcfun*
 (friends-get-friends-group-idby-index
  "SteamAPI_ISteamFriends_GetFriendsGroupIDByIndex" :library steamworks)
 friends-group-id (this :pointer) (i-fg :int))

(defcfun*
 (friends-get-friends-group-name "SteamAPI_ISteamFriends_GetFriendsGroupName"
                                 :library steamworks)
 :string (this :pointer) (friends-group-id friends-group-id))

(defcfun*
 (friends-get-friends-group-members-count
  "SteamAPI_ISteamFriends_GetFriendsGroupMembersCount" :library steamworks)
 :int (this :pointer) (friends-group-id friends-group-id))

(defcfun*
 (friends-get-friends-group-members-list
  "SteamAPI_ISteamFriends_GetFriendsGroupMembersList" :library steamworks)
 :void (this :pointer) (friends-group-id friends-group-id)
 (p-out-steam-idmembers :pointer) (n-members-count :int))

(defcfun*
 (friends-has-friend "SteamAPI_ISteamFriends_HasFriend" :library steamworks)
 :bool (this :pointer) (steam-idfriend :unsigned-long) (i-friend-flags :int))

(defcfun*
 (friends-get-clan-count "SteamAPI_ISteamFriends_GetClanCount" :library
                         steamworks)
 :int (this :pointer))

(defcfun*
 (friends-get-clan-by-index "SteamAPI_ISteamFriends_GetClanByIndex" :library
                            steamworks)
 :unsigned-long (this :pointer) (i-clan :int))

(defcfun*
 (friends-get-clan-name "SteamAPI_ISteamFriends_GetClanName" :library
                        steamworks)
 :string (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-tag "SteamAPI_ISteamFriends_GetClanTag" :library steamworks)
 :string (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-activity-counts
  "SteamAPI_ISteamFriends_GetClanActivityCounts" :library steamworks)
 :bool (this :pointer) (steam-idclan :unsigned-long) (pn-online :pointer)
 (pn-in-game :pointer) (pn-chatting :pointer))

(defcfun*
 (friends-download-clan-activity-counts
  "SteamAPI_ISteamFriends_DownloadClanActivityCounts" :library steamworks)
 steam-apicall (this :pointer) (psteam-idclans :pointer)
 (c-clans-to-request :int))

(defcfun*
 (friends-get-friend-count-from-source
  "SteamAPI_ISteamFriends_GetFriendCountFromSource" :library steamworks)
 :int (this :pointer) (steam-idsource :unsigned-long))

(defcfun*
 (friends-get-friend-from-source-by-index
  "SteamAPI_ISteamFriends_GetFriendFromSourceByIndex" :library steamworks)
 :unsigned-long (this :pointer) (steam-idsource :unsigned-long) (i-friend :int))

(defcfun*
 (friends-is-user-in-source "SteamAPI_ISteamFriends_IsUserInSource" :library
                            steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long)
 (steam-idsource :unsigned-long))

(defcfun*
 (friends-set-in-game-voice-speaking
  "SteamAPI_ISteamFriends_SetInGameVoiceSpeaking" :library steamworks)
 :void (this :pointer) (steam-iduser :unsigned-long) (b-speaking :bool))

(defcfun*
 (friends-activate-game-overlay "SteamAPI_ISteamFriends_ActivateGameOverlay"
                                :library steamworks)
 :void (this :pointer) (pch-dialog :string))

(defcfun*
 (friends-activate-game-overlay-to-user
  "SteamAPI_ISteamFriends_ActivateGameOverlayToUser" :library steamworks)
 :void (this :pointer) (pch-dialog :string) (steam-id :unsigned-long))

(defcfun*
 (friends-activate-game-overlay-to-web-page
  "SteamAPI_ISteamFriends_ActivateGameOverlayToWebPage" :library steamworks)
 :void (this :pointer) (pch-url :string)
 (e-mode eactivate-game-overlay-to-web-page-mode))

(defcfun*
 (friends-activate-game-overlay-to-store
  "SteamAPI_ISteamFriends_ActivateGameOverlayToStore" :library steamworks)
 :void (this :pointer) (n-app-id app-id) (e-flag eoverlay-to-store-flag))

(defcfun*
 (friends-set-played-with "SteamAPI_ISteamFriends_SetPlayedWith" :library
                          steamworks)
 :void (this :pointer) (steam-iduser-played-with :unsigned-long))

(defcfun*
 (friends-activate-game-overlay-invite-dialog
  "SteamAPI_ISteamFriends_ActivateGameOverlayInviteDialog" :library steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (friends-get-small-friend-avatar "SteamAPI_ISteamFriends_GetSmallFriendAvatar"
                                  :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-medium-friend-avatar
  "SteamAPI_ISteamFriends_GetMediumFriendAvatar" :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-large-friend-avatar "SteamAPI_ISteamFriends_GetLargeFriendAvatar"
                                  :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-request-user-information
  "SteamAPI_ISteamFriends_RequestUserInformation" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long)
 (b-require-name-only :bool))

(defcfun*
 (friends-request-clan-officer-list
  "SteamAPI_ISteamFriends_RequestClanOfficerList" :library steamworks)
 steam-apicall (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-owner "SteamAPI_ISteamFriends_GetClanOwner" :library
                         steamworks)
 :unsigned-long (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-officer-count "SteamAPI_ISteamFriends_GetClanOfficerCount"
                                 :library steamworks)
 :int (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-officer-by-index
  "SteamAPI_ISteamFriends_GetClanOfficerByIndex" :library steamworks)
 :unsigned-long (this :pointer) (steam-idclan :unsigned-long) (i-officer :int))

(defcfun*
 (friends-get-user-restrictions "SteamAPI_ISteamFriends_GetUserRestrictions"
                                :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (friends-set-rich-presence "SteamAPI_ISteamFriends_SetRichPresence" :library
                            steamworks)
 :bool (this :pointer) (pch-key :string) (pch-value :string))

(defcfun*
 (friends-clear-rich-presence "SteamAPI_ISteamFriends_ClearRichPresence"
                              :library steamworks)
 :void (this :pointer))

(defcfun*
 (friends-get-friend-rich-presence
  "SteamAPI_ISteamFriends_GetFriendRichPresence" :library steamworks)
 :string (this :pointer) (steam-idfriend :unsigned-long) (pch-key :string))

(defcfun*
 (friends-get-friend-rich-presence-key-count
  "SteamAPI_ISteamFriends_GetFriendRichPresenceKeyCount" :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-friend-rich-presence-key-by-index
  "SteamAPI_ISteamFriends_GetFriendRichPresenceKeyByIndex" :library steamworks)
 :string (this :pointer) (steam-idfriend :unsigned-long) (i-key :int))

(defcfun*
 (friends-request-friend-rich-presence
  "SteamAPI_ISteamFriends_RequestFriendRichPresence" :library steamworks)
 :void (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-invite-user-to-game "SteamAPI_ISteamFriends_InviteUserToGame"
                              :library steamworks)
 :bool (this :pointer) (steam-idfriend :unsigned-long)
 (pch-connect-string :string))

(defcfun*
 (friends-get-coplay-friend-count "SteamAPI_ISteamFriends_GetCoplayFriendCount"
                                  :library steamworks)
 :int (this :pointer))

(defcfun*
 (friends-get-coplay-friend "SteamAPI_ISteamFriends_GetCoplayFriend" :library
                            steamworks)
 :unsigned-long (this :pointer) (i-coplay-friend :int))

(defcfun*
 (friends-get-friend-coplay-time "SteamAPI_ISteamFriends_GetFriendCoplayTime"
                                 :library steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-get-friend-coplay-game "SteamAPI_ISteamFriends_GetFriendCoplayGame"
                                 :library steamworks)
 app-id (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (friends-join-clan-chat-room "SteamAPI_ISteamFriends_JoinClanChatRoom"
                              :library steamworks)
 steam-apicall (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-leave-clan-chat-room "SteamAPI_ISteamFriends_LeaveClanChatRoom"
                               :library steamworks)
 :bool (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-clan-chat-member-count
  "SteamAPI_ISteamFriends_GetClanChatMemberCount" :library steamworks)
 :int (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-chat-member-by-index
  "SteamAPI_ISteamFriends_GetChatMemberByIndex" :library steamworks)
 :unsigned-long (this :pointer) (steam-idclan :unsigned-long) (i-user :int))

(defcfun*
 (friends-send-clan-chat-message "SteamAPI_ISteamFriends_SendClanChatMessage"
                                 :library steamworks)
 :bool (this :pointer) (steam-idclan-chat :unsigned-long) (pch-text :string))

(defcfun*
 (friends-get-clan-chat-message "SteamAPI_ISteamFriends_GetClanChatMessage"
                                :library steamworks)
 :int (this :pointer) (steam-idclan-chat :unsigned-long) (i-message :int)
 (prgch-text :pointer) (cch-text-max :int) (pe-chat-entry-type :pointer)
 (psteamid-chatter :pointer))

(defcfun*
 (friends-is-clan-chat-admin "SteamAPI_ISteamFriends_IsClanChatAdmin" :library
                             steamworks)
 :bool (this :pointer) (steam-idclan-chat :unsigned-long)
 (steam-iduser :unsigned-long))

(defcfun*
 (friends-is-clan-chat-window-open-in-steam
  "SteamAPI_ISteamFriends_IsClanChatWindowOpenInSteam" :library steamworks)
 :bool (this :pointer) (steam-idclan-chat :unsigned-long))

(defcfun*
 (friends-open-clan-chat-window-in-steam
  "SteamAPI_ISteamFriends_OpenClanChatWindowInSteam" :library steamworks)
 :bool (this :pointer) (steam-idclan-chat :unsigned-long))

(defcfun*
 (friends-close-clan-chat-window-in-steam
  "SteamAPI_ISteamFriends_CloseClanChatWindowInSteam" :library steamworks)
 :bool (this :pointer) (steam-idclan-chat :unsigned-long))

(defcfun*
 (friends-set-listen-for-friends-messages
  "SteamAPI_ISteamFriends_SetListenForFriendsMessages" :library steamworks)
 :bool (this :pointer) (b-intercept-enabled :bool))

(defcfun*
 (friends-reply-to-friend-message "SteamAPI_ISteamFriends_ReplyToFriendMessage"
                                  :library steamworks)
 :bool (this :pointer) (steam-idfriend :unsigned-long)
 (pch-msg-to-send :string))

(defcfun*
 (friends-get-friend-message "SteamAPI_ISteamFriends_GetFriendMessage" :library
                             steamworks)
 :int (this :pointer) (steam-idfriend :unsigned-long) (i-message-id :int)
 (pv-data :pointer) (cub-data :int) (pe-chat-entry-type :pointer))

(defcfun*
 (friends-get-follower-count "SteamAPI_ISteamFriends_GetFollowerCount" :library
                             steamworks)
 steam-apicall (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (friends-is-following "SteamAPI_ISteamFriends_IsFollowing" :library
                       steamworks)
 steam-apicall (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (friends-enumerate-following-list
  "SteamAPI_ISteamFriends_EnumerateFollowingList" :library steamworks)
 steam-apicall (this :pointer) (un-start-index :uint32))

(defcfun*
 (friends-is-clan-public "SteamAPI_ISteamFriends_IsClanPublic" :library
                         steamworks)
 :bool (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-is-clan-official-game-group
  "SteamAPI_ISteamFriends_IsClanOfficialGameGroup" :library steamworks)
 :bool (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (friends-get-num-chats-with-unread-priority-messages
  "SteamAPI_ISteamFriends_GetNumChatsWithUnreadPriorityMessages" :library
  steamworks)
 :int (this :pointer))

(defcfun*
 (friends-activate-game-overlay-remote-play-together-invite-dialog
  "SteamAPI_ISteamFriends_ActivateGameOverlayRemotePlayTogetherInviteDialog"
  :library steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (friends-register-protocol-in-overlay-browser
  "SteamAPI_ISteamFriends_RegisterProtocolInOverlayBrowser" :library
  steamworks)
 :bool (this :pointer) (pch-protocol :string))

(defcfun*
 (friends-activate-game-overlay-invite-dialog-connect-string
  "SteamAPI_ISteamFriends_ActivateGameOverlayInviteDialogConnectString"
  :library steamworks)
 :void (this :pointer) (pch-connect-string :string))

(defcfun*
 (friends-request-equipped-profile-items
  "SteamAPI_ISteamFriends_RequestEquippedProfileItems" :library steamworks)
 steam-apicall (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (friends-bhas-equipped-profile-item
  "SteamAPI_ISteamFriends_BHasEquippedProfileItem" :library steamworks)
 :bool (this :pointer) (steam-id :unsigned-long)
 (item-type ecommunity-profile-item-type))

(defcfun*
 (friends-get-profile-item-property-string
  "SteamAPI_ISteamFriends_GetProfileItemPropertyString" :library steamworks)
 :string (this :pointer) (steam-id :unsigned-long)
 (item-type ecommunity-profile-item-type)
 (prop ecommunity-profile-item-property))

(defcfun*
 (friends-get-profile-item-property-uint
  "SteamAPI_ISteamFriends_GetProfileItemPropertyUint" :library steamworks)
 :uint32 (this :pointer) (steam-id :unsigned-long)
 (item-type ecommunity-profile-item-type)
 (prop ecommunity-profile-item-property))

(defcfun*
 (utils-get-seconds-since-app-active
  "SteamAPI_ISteamUtils_GetSecondsSinceAppActive" :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (utils-get-seconds-since-computer-active
  "SteamAPI_ISteamUtils_GetSecondsSinceComputerActive" :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (utils-get-connected-universe "SteamAPI_ISteamUtils_GetConnectedUniverse"
                               :library steamworks)
 euniverse (this :pointer))

(defcfun*
 (utils-get-server-real-time "SteamAPI_ISteamUtils_GetServerRealTime" :library
                             steamworks)
 :uint32 (this :pointer))

(defcfun*
 (utils-get-ipcountry "SteamAPI_ISteamUtils_GetIPCountry" :library steamworks)
 :string (this :pointer))

(defcfun*
 (utils-get-image-size "SteamAPI_ISteamUtils_GetImageSize" :library steamworks)
 :bool (this :pointer) (i-image :int) (pn-width :pointer) (pn-height :pointer))

(defcfun*
 (utils-get-image-rgba "SteamAPI_ISteamUtils_GetImageRGBA" :library steamworks)
 :bool (this :pointer) (i-image :int) (pub-dest :pointer)
 (n-dest-buffer-size :int))

(defcfun*
 (utils-get-current-battery-power "SteamAPI_ISteamUtils_GetCurrentBatteryPower"
                                  :library steamworks)
 :uint8 (this :pointer))

(defcfun*
 (utils-get-app-id "SteamAPI_ISteamUtils_GetAppID" :library steamworks) :uint32
 (this :pointer))

(defcfun*
 (utils-set-overlay-notification-position
  "SteamAPI_ISteamUtils_SetOverlayNotificationPosition" :library steamworks)
 :void (this :pointer) (e-notification-position enotification-position))

(defcfun*
 (utils-is-apicall-completed "SteamAPI_ISteamUtils_IsAPICallCompleted" :library
                             steamworks)
 :bool (this :pointer) (h-steam-apicall steam-apicall) (pb-failed :pointer))

(defcfun*
 (utils-get-apicall-failure-reason
  "SteamAPI_ISteamUtils_GetAPICallFailureReason" :library steamworks)
 esteam-apicall-failure (this :pointer) (h-steam-apicall steam-apicall))

(defcfun*
 (utils-get-apicall-result "SteamAPI_ISteamUtils_GetAPICallResult" :library
                           steamworks)
 :bool (this :pointer) (h-steam-apicall steam-apicall) (p-callback :pointer)
 (cub-callback :int) (i-callback-expected :int) (pb-failed :pointer))

(defcfun*
 (utils-get-ipccall-count "SteamAPI_ISteamUtils_GetIPCCallCount" :library
                          steamworks)
 :uint32 (this :pointer))

(defcfun*
 (utils-set-warning-message-hook "SteamAPI_ISteamUtils_SetWarningMessageHook"
                                 :library steamworks)
 :void (this :pointer) (p-function :pointer))

(defcfun*
 (utils-is-overlay-enabled "SteamAPI_ISteamUtils_IsOverlayEnabled" :library
                           steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-boverlay-needs-present "SteamAPI_ISteamUtils_BOverlayNeedsPresent"
                               :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-check-file-signature "SteamAPI_ISteamUtils_CheckFileSignature" :library
                             steamworks)
 steam-apicall (this :pointer) (sz-file-name :string))

(defcfun*
 (utils-show-gamepad-text-input "SteamAPI_ISteamUtils_ShowGamepadTextInput"
                                :library steamworks)
 :bool (this :pointer) (e-input-mode egamepad-text-input-mode)
 (e-line-input-mode egamepad-text-input-line-mode) (pch-description :string)
 (un-char-max :uint32) (pch-existing-text :string))

(defcfun*
 (utils-get-entered-gamepad-text-length
  "SteamAPI_ISteamUtils_GetEnteredGamepadTextLength" :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (utils-get-entered-gamepad-text-input
  "SteamAPI_ISteamUtils_GetEnteredGamepadTextInput" :library steamworks)
 :bool (this :pointer) (pch-text :string) (cch-text :uint32))

(defcfun*
 (utils-get-steam-uilanguage "SteamAPI_ISteamUtils_GetSteamUILanguage" :library
                             steamworks)
 :string (this :pointer))

(defcfun*
 (utils-is-steam-running-in-vr "SteamAPI_ISteamUtils_IsSteamRunningInVR"
                               :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-set-overlay-notification-inset
  "SteamAPI_ISteamUtils_SetOverlayNotificationInset" :library steamworks)
 :void (this :pointer) (n-horizontal-inset :int) (n-vertical-inset :int))

(defcfun*
 (utils-is-steam-in-big-picture-mode
  "SteamAPI_ISteamUtils_IsSteamInBigPictureMode" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-start-vrdashboard "SteamAPI_ISteamUtils_StartVRDashboard" :library
                          steamworks)
 :void (this :pointer))

(defcfun*
 (utils-is-vrheadset-streaming-enabled
  "SteamAPI_ISteamUtils_IsVRHeadsetStreamingEnabled" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-set-vrheadset-streaming-enabled
  "SteamAPI_ISteamUtils_SetVRHeadsetStreamingEnabled" :library steamworks)
 :void (this :pointer) (b-enabled :bool))

(defcfun*
 (utils-is-steam-china-launcher "SteamAPI_ISteamUtils_IsSteamChinaLauncher"
                                :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-init-filter-text "SteamAPI_ISteamUtils_InitFilterText" :library
                         steamworks)
 :bool (this :pointer) (un-filter-options :uint32))

(defcfun*
 (utils-filter-text "SteamAPI_ISteamUtils_FilterText" :library steamworks) :int
 (this :pointer) (e-context etext-filtering-context)
 (source-steam-id :unsigned-long) (pch-input-message :string)
 (pch-out-filtered-text :string) (n-byte-size-out-filtered-text :uint32))

(defcfun*
 (utils-get-ipv6connectivity-state
  "SteamAPI_ISteamUtils_GetIPv6ConnectivityState" :library steamworks)
 esteam-ipv6connectivity-state (this :pointer)
 (e-protocol esteam-ipv6connectivity-protocol))

(defcfun*
 (utils-is-steam-running-on-steam-deck
  "SteamAPI_ISteamUtils_IsSteamRunningOnSteamDeck" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-show-floating-gamepad-text-input
  "SteamAPI_ISteamUtils_ShowFloatingGamepadTextInput" :library steamworks)
 :bool (this :pointer) (e-keyboard-mode efloating-gamepad-text-input-mode)
 (n-text-field-xposition :int) (n-text-field-yposition :int)
 (n-text-field-width :int) (n-text-field-height :int))

(defcfun*
 (utils-set-game-launcher-mode "SteamAPI_ISteamUtils_SetGameLauncherMode"
                               :library steamworks)
 :void (this :pointer) (b-launcher-mode :bool))

(defcfun*
 (utils-dismiss-floating-gamepad-text-input
  "SteamAPI_ISteamUtils_DismissFloatingGamepadTextInput" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (utils-dismiss-gamepad-text-input
  "SteamAPI_ISteamUtils_DismissGamepadTextInput" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (matchmaking-get-favorite-game-count
  "SteamAPI_ISteamMatchmaking_GetFavoriteGameCount" :library steamworks)
 :int (this :pointer))

(defcfun*
 (matchmaking-get-favorite-game "SteamAPI_ISteamMatchmaking_GetFavoriteGame"
                                :library steamworks)
 :bool (this :pointer) (i-game :int) (pn-app-id :pointer) (pn-ip :pointer)
 (pn-conn-port :pointer) (pn-query-port :pointer) (pun-flags :pointer)
 (p-rtime32last-played-on-server :pointer))

(defcfun*
 (matchmaking-add-favorite-game "SteamAPI_ISteamMatchmaking_AddFavoriteGame"
                                :library steamworks)
 :int (this :pointer) (n-app-id app-id) (n-ip :uint32) (n-conn-port :uint16)
 (n-query-port :uint16) (un-flags :uint32)
 (r-time32last-played-on-server :uint32))

(defcfun*
 (matchmaking-remove-favorite-game
  "SteamAPI_ISteamMatchmaking_RemoveFavoriteGame" :library steamworks)
 :bool (this :pointer) (n-app-id app-id) (n-ip :uint32) (n-conn-port :uint16)
 (n-query-port :uint16) (un-flags :uint32))

(defcfun*
 (matchmaking-request-lobby-list "SteamAPI_ISteamMatchmaking_RequestLobbyList"
                                 :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (matchmaking-add-request-lobby-list-string-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListStringFilter" :library
  steamworks)
 :void (this :pointer) (pch-key-to-match :string) (pch-value-to-match :string)
 (e-comparison-type elobby-comparison))

(defcfun*
 (matchmaking-add-request-lobby-list-numerical-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListNumericalFilter" :library
  steamworks)
 :void (this :pointer) (pch-key-to-match :string) (n-value-to-match :int)
 (e-comparison-type elobby-comparison))

(defcfun*
 (matchmaking-add-request-lobby-list-near-value-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListNearValueFilter" :library
  steamworks)
 :void (this :pointer) (pch-key-to-match :string) (n-value-to-be-close-to :int))

(defcfun*
 (matchmaking-add-request-lobby-list-filter-slots-available
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListFilterSlotsAvailable" :library
  steamworks)
 :void (this :pointer) (n-slots-available :int))

(defcfun*
 (matchmaking-add-request-lobby-list-distance-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListDistanceFilter" :library
  steamworks)
 :void (this :pointer) (e-lobby-distance-filter elobby-distance-filter))

(defcfun*
 (matchmaking-add-request-lobby-list-result-count-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListResultCountFilter" :library
  steamworks)
 :void (this :pointer) (c-max-results :int))

(defcfun*
 (matchmaking-add-request-lobby-list-compatible-members-filter
  "SteamAPI_ISteamMatchmaking_AddRequestLobbyListCompatibleMembersFilter"
  :library steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-get-lobby-by-index "SteamAPI_ISteamMatchmaking_GetLobbyByIndex"
                                 :library steamworks)
 :unsigned-long (this :pointer) (i-lobby :int))

(defcfun*
 (matchmaking-create-lobby "SteamAPI_ISteamMatchmaking_CreateLobby" :library
                           steamworks)
 steam-apicall (this :pointer) (e-lobby-type elobby-type) (c-max-members :int))

(defcfun*
 (matchmaking-join-lobby "SteamAPI_ISteamMatchmaking_JoinLobby" :library
                         steamworks)
 steam-apicall (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-leave-lobby "SteamAPI_ISteamMatchmaking_LeaveLobby" :library
                          steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-invite-user-to-lobby
  "SteamAPI_ISteamMatchmaking_InviteUserToLobby" :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long)
 (steam-idinvitee :unsigned-long))

(defcfun*
 (matchmaking-get-num-lobby-members
  "SteamAPI_ISteamMatchmaking_GetNumLobbyMembers" :library steamworks)
 :int (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-get-lobby-member-by-index
  "SteamAPI_ISteamMatchmaking_GetLobbyMemberByIndex" :library steamworks)
 :unsigned-long (this :pointer) (steam-idlobby :unsigned-long) (i-member :int))

(defcfun*
 (matchmaking-get-lobby-data "SteamAPI_ISteamMatchmaking_GetLobbyData" :library
                             steamworks)
 :string (this :pointer) (steam-idlobby :unsigned-long) (pch-key :string))

(defcfun*
 (matchmaking-set-lobby-data "SteamAPI_ISteamMatchmaking_SetLobbyData" :library
                             steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (pch-key :string)
 (pch-value :string))

(defcfun*
 (matchmaking-get-lobby-data-count
  "SteamAPI_ISteamMatchmaking_GetLobbyDataCount" :library steamworks)
 :int (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-get-lobby-data-by-index
  "SteamAPI_ISteamMatchmaking_GetLobbyDataByIndex" :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (i-lobby-data :int)
 (pch-key :string) (cch-key-buffer-size :int) (pch-value :string)
 (cch-value-buffer-size :int))

(defcfun*
 (matchmaking-delete-lobby-data "SteamAPI_ISteamMatchmaking_DeleteLobbyData"
                                :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (pch-key :string))

(defcfun*
 (matchmaking-get-lobby-member-data
  "SteamAPI_ISteamMatchmaking_GetLobbyMemberData" :library steamworks)
 :string (this :pointer) (steam-idlobby :unsigned-long)
 (steam-iduser :unsigned-long) (pch-key :string))

(defcfun*
 (matchmaking-set-lobby-member-data
  "SteamAPI_ISteamMatchmaking_SetLobbyMemberData" :library steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long) (pch-key :string)
 (pch-value :string))

(defcfun*
 (matchmaking-send-lobby-chat-msg "SteamAPI_ISteamMatchmaking_SendLobbyChatMsg"
                                  :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (pv-msg-body :pointer)
 (cub-msg-body :int))

(defcfun*
 (matchmaking-get-lobby-chat-entry
  "SteamAPI_ISteamMatchmaking_GetLobbyChatEntry" :library steamworks)
 :int (this :pointer) (steam-idlobby :unsigned-long) (i-chat-id :int)
 (p-steam-iduser :pointer) (pv-data :pointer) (cub-data :int)
 (pe-chat-entry-type :pointer))

(defcfun*
 (matchmaking-request-lobby-data "SteamAPI_ISteamMatchmaking_RequestLobbyData"
                                 :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-set-lobby-game-server
  "SteamAPI_ISteamMatchmaking_SetLobbyGameServer" :library steamworks)
 :void (this :pointer) (steam-idlobby :unsigned-long)
 (un-game-server-ip :uint32) (un-game-server-port :uint16)
 (steam-idgame-server :unsigned-long))

(defcfun*
 (matchmaking-get-lobby-game-server
  "SteamAPI_ISteamMatchmaking_GetLobbyGameServer" :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long)
 (pun-game-server-ip :pointer) (pun-game-server-port :pointer)
 (psteam-idgame-server :pointer))

(defcfun*
 (matchmaking-set-lobby-member-limit
  "SteamAPI_ISteamMatchmaking_SetLobbyMemberLimit" :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (c-max-members :int))

(defcfun*
 (matchmaking-get-lobby-member-limit
  "SteamAPI_ISteamMatchmaking_GetLobbyMemberLimit" :library steamworks)
 :int (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-set-lobby-type "SteamAPI_ISteamMatchmaking_SetLobbyType" :library
                             steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long)
 (e-lobby-type elobby-type))

(defcfun*
 (matchmaking-set-lobby-joinable "SteamAPI_ISteamMatchmaking_SetLobbyJoinable"
                                 :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long) (b-lobby-joinable :bool))

(defcfun*
 (matchmaking-get-lobby-owner "SteamAPI_ISteamMatchmaking_GetLobbyOwner"
                              :library steamworks)
 :unsigned-long (this :pointer) (steam-idlobby :unsigned-long))

(defcfun*
 (matchmaking-set-lobby-owner "SteamAPI_ISteamMatchmaking_SetLobbyOwner"
                              :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long)
 (steam-idnew-owner :unsigned-long))

(defcfun*
 (matchmaking-set-linked-lobby "SteamAPI_ISteamMatchmaking_SetLinkedLobby"
                               :library steamworks)
 :bool (this :pointer) (steam-idlobby :unsigned-long)
 (steam-idlobby-dependent :unsigned-long))

(defcfun*
 (matchmaking-server-list-response-server-responded
  "SteamAPI_ISteamMatchmakingServerListResponse_ServerResponded" :library
  steamworks)
 :void (this :pointer) (h-request hserver-list-request) (i-server :int))

(defcfun*
 (matchmaking-server-list-response-server-failed-to-respond
  "SteamAPI_ISteamMatchmakingServerListResponse_ServerFailedToRespond" :library
  steamworks)
 :void (this :pointer) (h-request hserver-list-request) (i-server :int))

(defcfun*
 (matchmaking-server-list-response-refresh-complete
  "SteamAPI_ISteamMatchmakingServerListResponse_RefreshComplete" :library
  steamworks)
 :void (this :pointer) (h-request hserver-list-request)
 (response ematch-making-server-response))

(defcfun*
 (matchmaking-ping-response-server-responded
  "SteamAPI_ISteamMatchmakingPingResponse_ServerResponded" :library steamworks)
 :void (this :pointer) (server :pointer))

(defcfun*
 (matchmaking-ping-response-server-failed-to-respond
  "SteamAPI_ISteamMatchmakingPingResponse_ServerFailedToRespond" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (matchmaking-players-response-add-player-to-list
  "SteamAPI_ISteamMatchmakingPlayersResponse_AddPlayerToList" :library
  steamworks)
 :void (this :pointer) (pch-name :string) (n-score :int)
 (fl-time-played :float))

(defcfun*
 (matchmaking-players-response-players-failed-to-respond
  "SteamAPI_ISteamMatchmakingPlayersResponse_PlayersFailedToRespond" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (matchmaking-players-response-players-refresh-complete
  "SteamAPI_ISteamMatchmakingPlayersResponse_PlayersRefreshComplete" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (matchmaking-rules-response-rules-responded
  "SteamAPI_ISteamMatchmakingRulesResponse_RulesResponded" :library steamworks)
 :void (this :pointer) (pch-rule :string) (pch-value :string))

(defcfun*
 (matchmaking-rules-response-rules-failed-to-respond
  "SteamAPI_ISteamMatchmakingRulesResponse_RulesFailedToRespond" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (matchmaking-rules-response-rules-refresh-complete
  "SteamAPI_ISteamMatchmakingRulesResponse_RulesRefreshComplete" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (matchmaking-servers-request-internet-server-list
  "SteamAPI_ISteamMatchmakingServers_RequestInternetServerList" :library
  steamworks)
 hserver-list-request (this :pointer) (i-app app-id) (ppch-filters :pointer)
 (n-filters :uint32) (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-request-lanserver-list
  "SteamAPI_ISteamMatchmakingServers_RequestLANServerList" :library steamworks)
 hserver-list-request (this :pointer) (i-app app-id)
 (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-request-friends-server-list
  "SteamAPI_ISteamMatchmakingServers_RequestFriendsServerList" :library
  steamworks)
 hserver-list-request (this :pointer) (i-app app-id) (ppch-filters :pointer)
 (n-filters :uint32) (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-request-favorites-server-list
  "SteamAPI_ISteamMatchmakingServers_RequestFavoritesServerList" :library
  steamworks)
 hserver-list-request (this :pointer) (i-app app-id) (ppch-filters :pointer)
 (n-filters :uint32) (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-request-history-server-list
  "SteamAPI_ISteamMatchmakingServers_RequestHistoryServerList" :library
  steamworks)
 hserver-list-request (this :pointer) (i-app app-id) (ppch-filters :pointer)
 (n-filters :uint32) (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-request-spectator-server-list
  "SteamAPI_ISteamMatchmakingServers_RequestSpectatorServerList" :library
  steamworks)
 hserver-list-request (this :pointer) (i-app app-id) (ppch-filters :pointer)
 (n-filters :uint32) (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-release-request
  "SteamAPI_ISteamMatchmakingServers_ReleaseRequest" :library steamworks)
 :void (this :pointer) (h-server-list-request hserver-list-request))

(defcfun*
 (matchmaking-servers-get-server-details
  "SteamAPI_ISteamMatchmakingServers_GetServerDetails" :library steamworks)
 :pointer (this :pointer) (h-request hserver-list-request) (i-server :int))

(defcfun*
 (matchmaking-servers-cancel-query
  "SteamAPI_ISteamMatchmakingServers_CancelQuery" :library steamworks)
 :void (this :pointer) (h-request hserver-list-request))

(defcfun*
 (matchmaking-servers-refresh-query
  "SteamAPI_ISteamMatchmakingServers_RefreshQuery" :library steamworks)
 :void (this :pointer) (h-request hserver-list-request))

(defcfun*
 (matchmaking-servers-is-refreshing
  "SteamAPI_ISteamMatchmakingServers_IsRefreshing" :library steamworks)
 :bool (this :pointer) (h-request hserver-list-request))

(defcfun*
 (matchmaking-servers-get-server-count
  "SteamAPI_ISteamMatchmakingServers_GetServerCount" :library steamworks)
 :int (this :pointer) (h-request hserver-list-request))

(defcfun*
 (matchmaking-servers-refresh-server
  "SteamAPI_ISteamMatchmakingServers_RefreshServer" :library steamworks)
 :void (this :pointer) (h-request hserver-list-request) (i-server :int))

(defcfun*
 (matchmaking-servers-ping-server
  "SteamAPI_ISteamMatchmakingServers_PingServer" :library steamworks)
 hserver-query (this :pointer) (un-ip :uint32) (us-port :uint16)
 (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-player-details
  "SteamAPI_ISteamMatchmakingServers_PlayerDetails" :library steamworks)
 hserver-query (this :pointer) (un-ip :uint32) (us-port :uint16)
 (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-server-rules
  "SteamAPI_ISteamMatchmakingServers_ServerRules" :library steamworks)
 hserver-query (this :pointer) (un-ip :uint32) (us-port :uint16)
 (p-request-servers-response :pointer))

(defcfun*
 (matchmaking-servers-cancel-server-query
  "SteamAPI_ISteamMatchmakingServers_CancelServerQuery" :library steamworks)
 :void (this :pointer) (h-server-query hserver-query))

(defcfun*
 (game-search-add-game-search-params
  "SteamAPI_ISteamGameSearch_AddGameSearchParams" :library steamworks)
 egame-search-error-code (this :pointer) (pch-key-to-find :string)
 (pch-values-to-find :string))

(defcfun*
 (game-search-search-for-game-with-lobby
  "SteamAPI_ISteamGameSearch_SearchForGameWithLobby" :library steamworks)
 egame-search-error-code (this :pointer) (steam-idlobby :unsigned-long)
 (n-player-min :int) (n-player-max :int))

(defcfun*
 (game-search-search-for-game-solo
  "SteamAPI_ISteamGameSearch_SearchForGameSolo" :library steamworks)
 egame-search-error-code (this :pointer) (n-player-min :int)
 (n-player-max :int))

(defcfun*
 (game-search-accept-game "SteamAPI_ISteamGameSearch_AcceptGame" :library
                          steamworks)
 egame-search-error-code (this :pointer))

(defcfun*
 (game-search-decline-game "SteamAPI_ISteamGameSearch_DeclineGame" :library
                           steamworks)
 egame-search-error-code (this :pointer))

(defcfun*
 (game-search-retrieve-connection-details
  "SteamAPI_ISteamGameSearch_RetrieveConnectionDetails" :library steamworks)
 egame-search-error-code (this :pointer) (steam-idhost :unsigned-long)
 (pch-connection-details :string) (cub-connection-details :int))

(defcfun*
 (game-search-end-game-search "SteamAPI_ISteamGameSearch_EndGameSearch"
                              :library steamworks)
 egame-search-error-code (this :pointer))

(defcfun*
 (game-search-set-game-host-params
  "SteamAPI_ISteamGameSearch_SetGameHostParams" :library steamworks)
 egame-search-error-code (this :pointer) (pch-key :string) (pch-value :string))

(defcfun*
 (game-search-set-connection-details
  "SteamAPI_ISteamGameSearch_SetConnectionDetails" :library steamworks)
 egame-search-error-code (this :pointer) (pch-connection-details :string)
 (cub-connection-details :int))

(defcfun*
 (game-search-request-players-for-game
  "SteamAPI_ISteamGameSearch_RequestPlayersForGame" :library steamworks)
 egame-search-error-code (this :pointer) (n-player-min :int)
 (n-player-max :int) (n-max-team-size :int))

(defcfun*
 (game-search-host-confirm-game-start
  "SteamAPI_ISteamGameSearch_HostConfirmGameStart" :library steamworks)
 egame-search-error-code (this :pointer) (ull-unique-game-id :uint64))

(defcfun*
 (game-search-cancel-request-players-for-game
  "SteamAPI_ISteamGameSearch_CancelRequestPlayersForGame" :library steamworks)
 egame-search-error-code (this :pointer))

(defcfun*
 (game-search-submit-player-result
  "SteamAPI_ISteamGameSearch_SubmitPlayerResult" :library steamworks)
 egame-search-error-code (this :pointer) (ull-unique-game-id :uint64)
 (steam-idplayer :unsigned-long) (eplayer-result eplayer-result))

(defcfun*
 (game-search-end-game "SteamAPI_ISteamGameSearch_EndGame" :library steamworks)
 egame-search-error-code (this :pointer) (ull-unique-game-id :uint64))

(defcfun*
 (parties-get-num-active-beacons "SteamAPI_ISteamParties_GetNumActiveBeacons"
                                 :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (parties-get-beacon-by-index "SteamAPI_ISteamParties_GetBeaconByIndex"
                              :library steamworks)
 party-beacon-id (this :pointer) (un-index :uint32))

(defcfun*
 (parties-get-beacon-details "SteamAPI_ISteamParties_GetBeaconDetails" :library
                             steamworks)
 :bool (this :pointer) (ul-beacon-id party-beacon-id)
 (p-steam-idbeacon-owner :pointer) (p-location :pointer) (pch-metadata :string)
 (cch-metadata :int))

(defcfun*
 (parties-join-party "SteamAPI_ISteamParties_JoinParty" :library steamworks)
 steam-apicall (this :pointer) (ul-beacon-id party-beacon-id))

(defcfun*
 (parties-get-num-available-beacon-locations
  "SteamAPI_ISteamParties_GetNumAvailableBeaconLocations" :library steamworks)
 :bool (this :pointer) (pu-num-locations :pointer))

(defcfun*
 (parties-get-available-beacon-locations
  "SteamAPI_ISteamParties_GetAvailableBeaconLocations" :library steamworks)
 :bool (this :pointer) (p-location-list :pointer) (u-max-num-locations :uint32))

(defcfun*
 (parties-create-beacon "SteamAPI_ISteamParties_CreateBeacon" :library
                        steamworks)
 steam-apicall (this :pointer) (un-open-slots :uint32)
 (p-beacon-location :pointer) (pch-connect-string :string)
 (pch-metadata :string))

(defcfun*
 (parties-on-reservation-completed
  "SteamAPI_ISteamParties_OnReservationCompleted" :library steamworks)
 :void (this :pointer) (ul-beacon party-beacon-id)
 (steam-iduser :unsigned-long))

(defcfun*
 (parties-cancel-reservation "SteamAPI_ISteamParties_CancelReservation"
                             :library steamworks)
 :void (this :pointer) (ul-beacon party-beacon-id)
 (steam-iduser :unsigned-long))

(defcfun*
 (parties-change-num-open-slots "SteamAPI_ISteamParties_ChangeNumOpenSlots"
                                :library steamworks)
 steam-apicall (this :pointer) (ul-beacon party-beacon-id)
 (un-open-slots :uint32))

(defcfun*
 (parties-destroy-beacon "SteamAPI_ISteamParties_DestroyBeacon" :library
                         steamworks)
 :bool (this :pointer) (ul-beacon party-beacon-id))

(defcfun*
 (remote-storage-file-write "SteamAPI_ISteamRemoteStorage_FileWrite" :library
                            steamworks)
 :bool (this :pointer) (pch-file :string) (pv-data :pointer) (cub-data :int32))

(defcfun*
 (remote-storage-file-read "SteamAPI_ISteamRemoteStorage_FileRead" :library
                           steamworks)
 :int32 (this :pointer) (pch-file :string) (pv-data :pointer)
 (cub-data-to-read :int32))

(defcfun*
 (remote-storage-file-write-async "SteamAPI_ISteamRemoteStorage_FileWriteAsync"
                                  :library steamworks)
 steam-apicall (this :pointer) (pch-file :string) (pv-data :pointer)
 (cub-data :uint32))

(defcfun*
 (remote-storage-file-read-async "SteamAPI_ISteamRemoteStorage_FileReadAsync"
                                 :library steamworks)
 steam-apicall (this :pointer) (pch-file :string) (n-offset :uint32)
 (cub-to-read :uint32))

(defcfun*
 (remote-storage-file-read-async-complete
  "SteamAPI_ISteamRemoteStorage_FileReadAsyncComplete" :library steamworks)
 :bool (this :pointer) (h-read-call steam-apicall) (pv-buffer :pointer)
 (cub-to-read :uint32))

(defcfun*
 (remote-storage-file-forget "SteamAPI_ISteamRemoteStorage_FileForget" :library
                             steamworks)
 :bool (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-file-delete "SteamAPI_ISteamRemoteStorage_FileDelete" :library
                             steamworks)
 :bool (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-file-share "SteamAPI_ISteamRemoteStorage_FileShare" :library
                            steamworks)
 steam-apicall (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-set-sync-platforms
  "SteamAPI_ISteamRemoteStorage_SetSyncPlatforms" :library steamworks)
 :bool (this :pointer) (pch-file :string)
 (e-remote-storage-platform eremote-storage-platform))

(defcfun*
 (remote-storage-file-write-stream-open
  "SteamAPI_ISteamRemoteStorage_FileWriteStreamOpen" :library steamworks)
 ugcfile-write-stream-handle (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-file-write-stream-write-chunk
  "SteamAPI_ISteamRemoteStorage_FileWriteStreamWriteChunk" :library steamworks)
 :bool (this :pointer) (write-handle ugcfile-write-stream-handle)
 (pv-data :pointer) (cub-data :int32))

(defcfun*
 (remote-storage-file-write-stream-close
  "SteamAPI_ISteamRemoteStorage_FileWriteStreamClose" :library steamworks)
 :bool (this :pointer) (write-handle ugcfile-write-stream-handle))

(defcfun*
 (remote-storage-file-write-stream-cancel
  "SteamAPI_ISteamRemoteStorage_FileWriteStreamCancel" :library steamworks)
 :bool (this :pointer) (write-handle ugcfile-write-stream-handle))

(defcfun*
 (remote-storage-file-exists "SteamAPI_ISteamRemoteStorage_FileExists" :library
                             steamworks)
 :bool (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-file-persisted "SteamAPI_ISteamRemoteStorage_FilePersisted"
                                :library steamworks)
 :bool (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-get-file-size "SteamAPI_ISteamRemoteStorage_GetFileSize"
                               :library steamworks)
 :int32 (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-get-file-timestamp
  "SteamAPI_ISteamRemoteStorage_GetFileTimestamp" :library steamworks)
 :int64 (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-get-sync-platforms
  "SteamAPI_ISteamRemoteStorage_GetSyncPlatforms" :library steamworks)
 eremote-storage-platform (this :pointer) (pch-file :string))

(defcfun*
 (remote-storage-get-file-count "SteamAPI_ISteamRemoteStorage_GetFileCount"
                                :library steamworks)
 :int32 (this :pointer))

(defcfun*
 (remote-storage-get-file-name-and-size
  "SteamAPI_ISteamRemoteStorage_GetFileNameAndSize" :library steamworks)
 :string (this :pointer) (i-file :int) (pn-file-size-in-bytes :pointer))

(defcfun*
 (remote-storage-get-quota "SteamAPI_ISteamRemoteStorage_GetQuota" :library
                           steamworks)
 :bool (this :pointer) (pn-total-bytes :pointer) (pu-available-bytes :pointer))

(defcfun*
 (remote-storage-is-cloud-enabled-for-account
  "SteamAPI_ISteamRemoteStorage_IsCloudEnabledForAccount" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (remote-storage-is-cloud-enabled-for-app
  "SteamAPI_ISteamRemoteStorage_IsCloudEnabledForApp" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (remote-storage-set-cloud-enabled-for-app
  "SteamAPI_ISteamRemoteStorage_SetCloudEnabledForApp" :library steamworks)
 :void (this :pointer) (b-enabled :bool))

(defcfun*
 (remote-storage-ugcdownload "SteamAPI_ISteamRemoteStorage_UGCDownload"
                             :library steamworks)
 steam-apicall (this :pointer) (h-content ugchandle) (un-priority :uint32))

(defcfun*
 (remote-storage-get-ugcdownload-progress
  "SteamAPI_ISteamRemoteStorage_GetUGCDownloadProgress" :library steamworks)
 :bool (this :pointer) (h-content ugchandle) (pn-bytes-downloaded :pointer)
 (pn-bytes-expected :pointer))

(defcfun*
 (remote-storage-get-ugcdetails "SteamAPI_ISteamRemoteStorage_GetUGCDetails"
                                :library steamworks)
 :bool (this :pointer) (h-content ugchandle) (pn-app-id :pointer)
 (ppch-name :string) (pn-file-size-in-bytes :pointer)
 (p-steam-idowner :pointer))

(defcfun*
 (remote-storage-ugcread "SteamAPI_ISteamRemoteStorage_UGCRead" :library
                         steamworks)
 :int32 (this :pointer) (h-content ugchandle) (pv-data :pointer)
 (cub-data-to-read :int32) (c-offset :uint32) (e-action eugcread-action))

(defcfun*
 (remote-storage-get-cached-ugccount
  "SteamAPI_ISteamRemoteStorage_GetCachedUGCCount" :library steamworks)
 :int32 (this :pointer))

(defcfun*
 (remote-storage-get-cached-ugchandle
  "SteamAPI_ISteamRemoteStorage_GetCachedUGCHandle" :library steamworks)
 ugchandle (this :pointer) (i-cached-content :int32))

(defcfun*
 (remote-storage-publish-workshop-file
  "SteamAPI_ISteamRemoteStorage_PublishWorkshopFile" :library steamworks)
 steam-apicall (this :pointer) (pch-file :string) (pch-preview-file :string)
 (n-consumer-app-id app-id) (pch-title :string) (pch-description :string)
 (e-visibility eremote-storage-published-file-visibility) (p-tags :pointer)
 (e-workshop-file-type eworkshop-file-type))

(defcfun*
 (remote-storage-create-published-file-update-request
  "SteamAPI_ISteamRemoteStorage_CreatePublishedFileUpdateRequest" :library
  steamworks)
 published-file-update-handle (this :pointer)
 (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-update-published-file-file
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileFile" :library steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (pch-file :string))

(defcfun*
 (remote-storage-update-published-file-preview-file
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFilePreviewFile" :library
  steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (pch-preview-file :string))

(defcfun*
 (remote-storage-update-published-file-title
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileTitle" :library steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (pch-title :string))

(defcfun*
 (remote-storage-update-published-file-description
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileDescription" :library
  steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (pch-description :string))

(defcfun*
 (remote-storage-update-published-file-visibility
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileVisibility" :library
  steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (e-visibility eremote-storage-published-file-visibility))

(defcfun*
 (remote-storage-update-published-file-tags
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileTags" :library steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (p-tags :pointer))

(defcfun*
 (remote-storage-commit-published-file-update
  "SteamAPI_ISteamRemoteStorage_CommitPublishedFileUpdate" :library steamworks)
 steam-apicall (this :pointer) (update-handle published-file-update-handle))

(defcfun*
 (remote-storage-get-published-file-details
  "SteamAPI_ISteamRemoteStorage_GetPublishedFileDetails" :library steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id)
 (un-max-seconds-old :uint32))

(defcfun*
 (remote-storage-delete-published-file
  "SteamAPI_ISteamRemoteStorage_DeletePublishedFile" :library steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-enumerate-user-published-files
  "SteamAPI_ISteamRemoteStorage_EnumerateUserPublishedFiles" :library
  steamworks)
 steam-apicall (this :pointer) (un-start-index :uint32))

(defcfun*
 (remote-storage-subscribe-published-file
  "SteamAPI_ISteamRemoteStorage_SubscribePublishedFile" :library steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-enumerate-user-subscribed-files
  "SteamAPI_ISteamRemoteStorage_EnumerateUserSubscribedFiles" :library
  steamworks)
 steam-apicall (this :pointer) (un-start-index :uint32))

(defcfun*
 (remote-storage-unsubscribe-published-file
  "SteamAPI_ISteamRemoteStorage_UnsubscribePublishedFile" :library steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-update-published-file-set-change-description
  "SteamAPI_ISteamRemoteStorage_UpdatePublishedFileSetChangeDescription"
  :library steamworks)
 :bool (this :pointer) (update-handle published-file-update-handle)
 (pch-change-description :string))

(defcfun*
 (remote-storage-get-published-item-vote-details
  "SteamAPI_ISteamRemoteStorage_GetPublishedItemVoteDetails" :library
  steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-update-user-published-item-vote
  "SteamAPI_ISteamRemoteStorage_UpdateUserPublishedItemVote" :library
  steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id)
 (b-vote-up :bool))

(defcfun*
 (remote-storage-get-user-published-item-vote-details
  "SteamAPI_ISteamRemoteStorage_GetUserPublishedItemVoteDetails" :library
  steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id))

(defcfun*
 (remote-storage-enumerate-user-shared-workshop-files
  "SteamAPI_ISteamRemoteStorage_EnumerateUserSharedWorkshopFiles" :library
  steamworks)
 steam-apicall (this :pointer) (steam-id :unsigned-long)
 (un-start-index :uint32) (p-required-tags :pointer) (p-excluded-tags :pointer))

(defcfun*
 (remote-storage-publish-video "SteamAPI_ISteamRemoteStorage_PublishVideo"
                               :library steamworks)
 steam-apicall (this :pointer) (e-video-provider eworkshop-video-provider)
 (pch-video-account :string) (pch-video-identifier :string)
 (pch-preview-file :string) (n-consumer-app-id app-id) (pch-title :string)
 (pch-description :string)
 (e-visibility eremote-storage-published-file-visibility) (p-tags :pointer))

(defcfun*
 (remote-storage-set-user-published-file-action
  "SteamAPI_ISteamRemoteStorage_SetUserPublishedFileAction" :library
  steamworks)
 steam-apicall (this :pointer) (un-published-file-id published-file-id)
 (e-action eworkshop-file-action))

(defcfun*
 (remote-storage-enumerate-published-files-by-user-action
  "SteamAPI_ISteamRemoteStorage_EnumeratePublishedFilesByUserAction" :library
  steamworks)
 steam-apicall (this :pointer) (e-action eworkshop-file-action)
 (un-start-index :uint32))

(defcfun*
 (remote-storage-enumerate-published-workshop-files
  "SteamAPI_ISteamRemoteStorage_EnumeratePublishedWorkshopFiles" :library
  steamworks)
 steam-apicall (this :pointer) (e-enumeration-type eworkshop-enumeration-type)
 (un-start-index :uint32) (un-count :uint32) (un-days :uint32)
 (p-tags :pointer) (p-user-tags :pointer))

(defcfun*
 (remote-storage-ugcdownload-to-location
  "SteamAPI_ISteamRemoteStorage_UGCDownloadToLocation" :library steamworks)
 steam-apicall (this :pointer) (h-content ugchandle) (pch-location :string)
 (un-priority :uint32))

(defcfun*
 (remote-storage-get-local-file-change-count
  "SteamAPI_ISteamRemoteStorage_GetLocalFileChangeCount" :library steamworks)
 :int32 (this :pointer))

(defcfun*
 (remote-storage-get-local-file-change
  "SteamAPI_ISteamRemoteStorage_GetLocalFileChange" :library steamworks)
 :string (this :pointer) (i-file :int) (p-echange-type :pointer)
 (p-efile-path-type :pointer))

(defcfun*
 (remote-storage-begin-file-write-batch
  "SteamAPI_ISteamRemoteStorage_BeginFileWriteBatch" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (remote-storage-end-file-write-batch
  "SteamAPI_ISteamRemoteStorage_EndFileWriteBatch" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (user-stats-get-stat-int32 "SteamAPI_ISteamUserStats_GetStatInt32" :library
                            steamworks)
 :bool (this :pointer) (pch-name :string) (p-data :pointer))

(defcfun*
 (user-stats-get-stat-float "SteamAPI_ISteamUserStats_GetStatFloat" :library
                            steamworks)
 :bool (this :pointer) (pch-name :string) (p-data :pointer))

(defcfun*
 (user-stats-set-stat-int32 "SteamAPI_ISteamUserStats_SetStatInt32" :library
                            steamworks)
 :bool (this :pointer) (pch-name :string) (n-data :int32))

(defcfun*
 (user-stats-set-stat-float "SteamAPI_ISteamUserStats_SetStatFloat" :library
                            steamworks)
 :bool (this :pointer) (pch-name :string) (f-data :float))

(defcfun*
 (user-stats-update-avg-rate-stat "SteamAPI_ISteamUserStats_UpdateAvgRateStat"
                                  :library steamworks)
 :bool (this :pointer) (pch-name :string) (fl-count-this-session :float)
 (d-session-length :double))

(defcfun*
 (user-stats-get-achievement "SteamAPI_ISteamUserStats_GetAchievement" :library
                             steamworks)
 :bool (this :pointer) (pch-name :string) (pb-achieved :pointer))

(defcfun*
 (user-stats-set-achievement "SteamAPI_ISteamUserStats_SetAchievement" :library
                             steamworks)
 :bool (this :pointer) (pch-name :string))

(defcfun*
 (user-stats-clear-achievement "SteamAPI_ISteamUserStats_ClearAchievement"
                               :library steamworks)
 :bool (this :pointer) (pch-name :string))

(defcfun*
 (user-stats-get-achievement-and-unlock-time
  "SteamAPI_ISteamUserStats_GetAchievementAndUnlockTime" :library steamworks)
 :bool (this :pointer) (pch-name :string) (pb-achieved :pointer)
 (pun-unlock-time :pointer))

(defcfun*
 (user-stats-store-stats "SteamAPI_ISteamUserStats_StoreStats" :library
                         steamworks)
 :bool (this :pointer))

(defcfun*
 (user-stats-get-achievement-icon "SteamAPI_ISteamUserStats_GetAchievementIcon"
                                  :library steamworks)
 :int (this :pointer) (pch-name :string))

(defcfun*
 (user-stats-get-achievement-display-attribute
  "SteamAPI_ISteamUserStats_GetAchievementDisplayAttribute" :library
  steamworks)
 :string (this :pointer) (pch-name :string) (pch-key :string))

(defcfun*
 (user-stats-indicate-achievement-progress
  "SteamAPI_ISteamUserStats_IndicateAchievementProgress" :library steamworks)
 :bool (this :pointer) (pch-name :string) (n-cur-progress :uint32)
 (n-max-progress :uint32))

(defcfun*
 (user-stats-get-num-achievements "SteamAPI_ISteamUserStats_GetNumAchievements"
                                  :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (user-stats-get-achievement-name "SteamAPI_ISteamUserStats_GetAchievementName"
                                  :library steamworks)
 :string (this :pointer) (i-achievement :uint32))

(defcfun*
 (user-stats-request-user-stats "SteamAPI_ISteamUserStats_RequestUserStats"
                                :library steamworks)
 steam-apicall (this :pointer) (steam-iduser :unsigned-long))

(defcfun*
 (user-stats-get-user-stat-int32 "SteamAPI_ISteamUserStats_GetUserStatInt32"
                                 :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (p-data :pointer))

(defcfun*
 (user-stats-get-user-stat-float "SteamAPI_ISteamUserStats_GetUserStatFloat"
                                 :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (p-data :pointer))

(defcfun*
 (user-stats-get-user-achievement "SteamAPI_ISteamUserStats_GetUserAchievement"
                                  :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (pb-achieved :pointer))

(defcfun*
 (user-stats-get-user-achievement-and-unlock-time
  "SteamAPI_ISteamUserStats_GetUserAchievementAndUnlockTime" :library
  steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (pb-achieved :pointer) (pun-unlock-time :pointer))

(defcfun*
 (user-stats-reset-all-stats "SteamAPI_ISteamUserStats_ResetAllStats" :library
                             steamworks)
 :bool (this :pointer) (b-achievements-too :bool))

(defcfun*
 (user-stats-find-or-create-leaderboard
  "SteamAPI_ISteamUserStats_FindOrCreateLeaderboard" :library steamworks)
 steam-apicall (this :pointer) (pch-leaderboard-name :string)
 (e-leaderboard-sort-method eleaderboard-sort-method)
 (e-leaderboard-display-type eleaderboard-display-type))

(defcfun*
 (user-stats-find-leaderboard "SteamAPI_ISteamUserStats_FindLeaderboard"
                              :library steamworks)
 steam-apicall (this :pointer) (pch-leaderboard-name :string))

(defcfun*
 (user-stats-get-leaderboard-name "SteamAPI_ISteamUserStats_GetLeaderboardName"
                                  :library steamworks)
 :string (this :pointer) (h-steam-leaderboard steam-leaderboard))

(defcfun*
 (user-stats-get-leaderboard-entry-count
  "SteamAPI_ISteamUserStats_GetLeaderboardEntryCount" :library steamworks)
 :int (this :pointer) (h-steam-leaderboard steam-leaderboard))

(defcfun*
 (user-stats-get-leaderboard-sort-method
  "SteamAPI_ISteamUserStats_GetLeaderboardSortMethod" :library steamworks)
 eleaderboard-sort-method (this :pointer)
 (h-steam-leaderboard steam-leaderboard))

(defcfun*
 (user-stats-get-leaderboard-display-type
  "SteamAPI_ISteamUserStats_GetLeaderboardDisplayType" :library steamworks)
 eleaderboard-display-type (this :pointer)
 (h-steam-leaderboard steam-leaderboard))

(defcfun*
 (user-stats-download-leaderboard-entries
  "SteamAPI_ISteamUserStats_DownloadLeaderboardEntries" :library steamworks)
 steam-apicall (this :pointer) (h-steam-leaderboard steam-leaderboard)
 (e-leaderboard-data-request eleaderboard-data-request) (n-range-start :int)
 (n-range-end :int))

(defcfun*
 (user-stats-download-leaderboard-entries-for-users
  "SteamAPI_ISteamUserStats_DownloadLeaderboardEntriesForUsers" :library
  steamworks)
 steam-apicall (this :pointer) (h-steam-leaderboard steam-leaderboard)
 (prg-users :pointer) (c-users :int))

(defcfun*
 (user-stats-get-downloaded-leaderboard-entry
  "SteamAPI_ISteamUserStats_GetDownloadedLeaderboardEntry" :library steamworks)
 :bool (this :pointer) (h-steam-leaderboard-entries steam-leaderboard-entries)
 (index :int) (p-leaderboard-entry :pointer) (p-details :pointer)
 (c-details-max :int))

(defcfun*
 (user-stats-upload-leaderboard-score
  "SteamAPI_ISteamUserStats_UploadLeaderboardScore" :library steamworks)
 steam-apicall (this :pointer) (h-steam-leaderboard steam-leaderboard)
 (e-leaderboard-upload-score-method eleaderboard-upload-score-method)
 (n-score :int32) (p-score-details :pointer) (c-score-details-count :int))

(defcfun*
 (user-stats-attach-leaderboard-ugc
  "SteamAPI_ISteamUserStats_AttachLeaderboardUGC" :library steamworks)
 steam-apicall (this :pointer) (h-steam-leaderboard steam-leaderboard)
 (h-ugc ugchandle))

(defcfun*
 (user-stats-get-number-of-current-players
  "SteamAPI_ISteamUserStats_GetNumberOfCurrentPlayers" :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (user-stats-request-global-achievement-percentages
  "SteamAPI_ISteamUserStats_RequestGlobalAchievementPercentages" :library
  steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (user-stats-get-most-achieved-achievement-info
  "SteamAPI_ISteamUserStats_GetMostAchievedAchievementInfo" :library
  steamworks)
 :int (this :pointer) (pch-name :string) (un-name-buf-len :uint32)
 (pfl-percent :pointer) (pb-achieved :pointer))

(defcfun*
 (user-stats-get-next-most-achieved-achievement-info
  "SteamAPI_ISteamUserStats_GetNextMostAchievedAchievementInfo" :library
  steamworks)
 :int (this :pointer) (i-iterator-previous :int) (pch-name :string)
 (un-name-buf-len :uint32) (pfl-percent :pointer) (pb-achieved :pointer))

(defcfun*
 (user-stats-get-achievement-achieved-percent
  "SteamAPI_ISteamUserStats_GetAchievementAchievedPercent" :library steamworks)
 :bool (this :pointer) (pch-name :string) (pfl-percent :pointer))

(defcfun*
 (user-stats-request-global-stats "SteamAPI_ISteamUserStats_RequestGlobalStats"
                                  :library steamworks)
 steam-apicall (this :pointer) (n-history-days :int))

(defcfun*
 (user-stats-get-global-stat-int64
  "SteamAPI_ISteamUserStats_GetGlobalStatInt64" :library steamworks)
 :bool (this :pointer) (pch-stat-name :string) (p-data :pointer))

(defcfun*
 (user-stats-get-global-stat-double
  "SteamAPI_ISteamUserStats_GetGlobalStatDouble" :library steamworks)
 :bool (this :pointer) (pch-stat-name :string) (p-data :pointer))

(defcfun*
 (user-stats-get-global-stat-history-int64
  "SteamAPI_ISteamUserStats_GetGlobalStatHistoryInt64" :library steamworks)
 :int32 (this :pointer) (pch-stat-name :string) (p-data :pointer)
 (cub-data :uint32))

(defcfun*
 (user-stats-get-global-stat-history-double
  "SteamAPI_ISteamUserStats_GetGlobalStatHistoryDouble" :library steamworks)
 :int32 (this :pointer) (pch-stat-name :string) (p-data :pointer)
 (cub-data :uint32))

(defcfun*
 (user-stats-get-achievement-progress-limits-int32
  "SteamAPI_ISteamUserStats_GetAchievementProgressLimitsInt32" :library
  steamworks)
 :bool (this :pointer) (pch-name :string) (pn-min-progress :pointer)
 (pn-max-progress :pointer))

(defcfun*
 (user-stats-get-achievement-progress-limits-float
  "SteamAPI_ISteamUserStats_GetAchievementProgressLimitsFloat" :library
  steamworks)
 :bool (this :pointer) (pch-name :string) (pf-min-progress :pointer)
 (pf-max-progress :pointer))

(defcfun*
 (apps-bis-subscribed "SteamAPI_ISteamApps_BIsSubscribed" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-bis-low-violence "SteamAPI_ISteamApps_BIsLowViolence" :library
                        steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-bis-cybercafe "SteamAPI_ISteamApps_BIsCybercafe" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-bis-vacbanned "SteamAPI_ISteamApps_BIsVACBanned" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-get-current-game-language "SteamAPI_ISteamApps_GetCurrentGameLanguage"
                                 :library steamworks)
 :string (this :pointer))

(defcfun*
 (apps-get-available-game-languages
  "SteamAPI_ISteamApps_GetAvailableGameLanguages" :library steamworks)
 :string (this :pointer))

(defcfun*
 (apps-bis-subscribed-app "SteamAPI_ISteamApps_BIsSubscribedApp" :library
                          steamworks)
 :bool (this :pointer) (app-id app-id))

(defcfun*
 (apps-bis-dlc-installed "SteamAPI_ISteamApps_BIsDlcInstalled" :library
                         steamworks)
 :bool (this :pointer) (app-id app-id))

(defcfun*
 (apps-get-earliest-purchase-unix-time
  "SteamAPI_ISteamApps_GetEarliestPurchaseUnixTime" :library steamworks)
 :uint32 (this :pointer) (n-app-id app-id))

(defcfun*
 (apps-bis-subscribed-from-free-weekend
  "SteamAPI_ISteamApps_BIsSubscribedFromFreeWeekend" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-get-dlccount "SteamAPI_ISteamApps_GetDLCCount" :library steamworks) :int
 (this :pointer))

(defcfun*
 (apps-bget-dlcdata-by-index "SteamAPI_ISteamApps_BGetDLCDataByIndex" :library
                             steamworks)
 :bool (this :pointer) (i-dlc :int) (p-app-id :pointer) (pb-available :pointer)
 (pch-name :string) (cch-name-buffer-size :int))

(defcfun*
 (apps-install-dlc "SteamAPI_ISteamApps_InstallDLC" :library steamworks) :void
 (this :pointer) (n-app-id app-id))

(defcfun*
 (apps-uninstall-dlc "SteamAPI_ISteamApps_UninstallDLC" :library steamworks)
 :void (this :pointer) (n-app-id app-id))

(defcfun*
 (apps-request-app-proof-of-purchase-key
  "SteamAPI_ISteamApps_RequestAppProofOfPurchaseKey" :library steamworks)
 :void (this :pointer) (n-app-id app-id))

(defcfun*
 (apps-get-current-beta-name "SteamAPI_ISteamApps_GetCurrentBetaName" :library
                             steamworks)
 :bool (this :pointer) (pch-name :string) (cch-name-buffer-size :int))

(defcfun*
 (apps-mark-content-corrupt "SteamAPI_ISteamApps_MarkContentCorrupt" :library
                            steamworks)
 :bool (this :pointer) (b-missing-files-only :bool))

(defcfun*
 (apps-get-installed-depots "SteamAPI_ISteamApps_GetInstalledDepots" :library
                            steamworks)
 :uint32 (this :pointer) (app-id app-id) (pvec-depots :pointer)
 (c-max-depots :uint32))

(defcfun*
 (apps-get-app-install-dir "SteamAPI_ISteamApps_GetAppInstallDir" :library
                           steamworks)
 :uint32 (this :pointer) (app-id app-id) (pch-folder :string)
 (cch-folder-buffer-size :uint32))

(defcfun*
 (apps-bis-app-installed "SteamAPI_ISteamApps_BIsAppInstalled" :library
                         steamworks)
 :bool (this :pointer) (app-id app-id))

(defcfun*
 (apps-get-app-owner "SteamAPI_ISteamApps_GetAppOwner" :library steamworks)
 :unsigned-long (this :pointer))

(defcfun*
 (apps-get-launch-query-param "SteamAPI_ISteamApps_GetLaunchQueryParam"
                              :library steamworks)
 :string (this :pointer) (pch-key :string))

(defcfun*
 (apps-get-dlc-download-progress "SteamAPI_ISteamApps_GetDlcDownloadProgress"
                                 :library steamworks)
 :bool (this :pointer) (n-app-id app-id) (pun-bytes-downloaded :pointer)
 (pun-bytes-total :pointer))

(defcfun*
 (apps-get-app-build-id "SteamAPI_ISteamApps_GetAppBuildId" :library
                        steamworks)
 :int (this :pointer))

(defcfun*
 (apps-request-all-proof-of-purchase-keys
  "SteamAPI_ISteamApps_RequestAllProofOfPurchaseKeys" :library steamworks)
 :void (this :pointer))

(defcfun*
 (apps-get-file-details "SteamAPI_ISteamApps_GetFileDetails" :library
                        steamworks)
 steam-apicall (this :pointer) (psz-file-name :string))

(defcfun*
 (apps-get-launch-command-line "SteamAPI_ISteamApps_GetLaunchCommandLine"
                               :library steamworks)
 :int (this :pointer) (psz-command-line :string) (cub-command-line :int))

(defcfun*
 (apps-bis-subscribed-from-family-sharing
  "SteamAPI_ISteamApps_BIsSubscribedFromFamilySharing" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (apps-bis-timed-trial "SteamAPI_ISteamApps_BIsTimedTrial" :library steamworks)
 :bool (this :pointer) (pun-seconds-allowed :pointer)
 (pun-seconds-played :pointer))

(defcfun*
 (apps-set-dlc-context "SteamAPI_ISteamApps_SetDlcContext" :library steamworks)
 :bool (this :pointer) (n-app-id app-id))

(defcfun*
 (apps-get-num-betas "SteamAPI_ISteamApps_GetNumBetas" :library steamworks)
 :int (this :pointer) (pn-available :pointer) (pn-private :pointer))

(defcfun*
 (apps-get-beta-info "SteamAPI_ISteamApps_GetBetaInfo" :library steamworks)
 :bool (this :pointer) (i-beta-index :int) (pun-flags :pointer)
 (pun-build-id :pointer) (pch-beta-name :string) (cch-beta-name :int)
 (pch-description :string) (cch-description :int))

(defcfun*
 (apps-set-active-beta "SteamAPI_ISteamApps_SetActiveBeta" :library steamworks)
 :bool (this :pointer) (pch-beta-name :string))

(defcfun*
 (networking-send-p2ppacket "SteamAPI_ISteamNetworking_SendP2PPacket" :library
                            steamworks)
 :bool (this :pointer) (steam-idremote :unsigned-long) (pub-data :pointer)
 (cub-data :uint32) (e-p2psend-type ep2psend) (n-channel :int))

(defcfun*
 (networking-is-p2ppacket-available
  "SteamAPI_ISteamNetworking_IsP2PPacketAvailable" :library steamworks)
 :bool (this :pointer) (pcub-msg-size :pointer) (n-channel :int))

(defcfun*
 (networking-read-p2ppacket "SteamAPI_ISteamNetworking_ReadP2PPacket" :library
                            steamworks)
 :bool (this :pointer) (pub-dest :pointer) (cub-dest :uint32)
 (pcub-msg-size :pointer) (psteam-idremote :pointer) (n-channel :int))

(defcfun*
 (networking-accept-p2psession-with-user
  "SteamAPI_ISteamNetworking_AcceptP2PSessionWithUser" :library steamworks)
 :bool (this :pointer) (steam-idremote :unsigned-long))

(defcfun*
 (networking-close-p2psession-with-user
  "SteamAPI_ISteamNetworking_CloseP2PSessionWithUser" :library steamworks)
 :bool (this :pointer) (steam-idremote :unsigned-long))

(defcfun*
 (networking-close-p2pchannel-with-user
  "SteamAPI_ISteamNetworking_CloseP2PChannelWithUser" :library steamworks)
 :bool (this :pointer) (steam-idremote :unsigned-long) (n-channel :int))

(defcfun*
 (networking-get-p2psession-state
  "SteamAPI_ISteamNetworking_GetP2PSessionState" :library steamworks)
 :bool (this :pointer) (steam-idremote :unsigned-long)
 (p-connection-state :pointer))

(defcfun*
 (networking-allow-p2ppacket-relay
  "SteamAPI_ISteamNetworking_AllowP2PPacketRelay" :library steamworks)
 :bool (this :pointer) (b-allow :bool))

(defcfun*
 (networking-create-p2pconnection-socket
  "SteamAPI_ISteamNetworking_CreateP2PConnectionSocket" :library steamworks)
 snet-socket (this :pointer) (steam-idtarget :unsigned-long)
 (n-virtual-port :int) (n-timeout-sec :int) (b-allow-use-of-packet-relay :bool))

(defcfun*
 (networking-destroy-socket "SteamAPI_ISteamNetworking_DestroySocket" :library
                            steamworks)
 :bool (this :pointer) (h-socket snet-socket) (b-notify-remote-end :bool))

(defcfun*
 (networking-destroy-listen-socket
  "SteamAPI_ISteamNetworking_DestroyListenSocket" :library steamworks)
 :bool (this :pointer) (h-socket snet-listen-socket)
 (b-notify-remote-end :bool))

(defcfun*
 (networking-send-data-on-socket "SteamAPI_ISteamNetworking_SendDataOnSocket"
                                 :library steamworks)
 :bool (this :pointer) (h-socket snet-socket) (pub-data :pointer)
 (cub-data :uint32) (b-reliable :bool))

(defcfun*
 (networking-is-data-available-on-socket
  "SteamAPI_ISteamNetworking_IsDataAvailableOnSocket" :library steamworks)
 :bool (this :pointer) (h-socket snet-socket) (pcub-msg-size :pointer))

(defcfun*
 (networking-retrieve-data-from-socket
  "SteamAPI_ISteamNetworking_RetrieveDataFromSocket" :library steamworks)
 :bool (this :pointer) (h-socket snet-socket) (pub-dest :pointer)
 (cub-dest :uint32) (pcub-msg-size :pointer))

(defcfun*
 (networking-is-data-available "SteamAPI_ISteamNetworking_IsDataAvailable"
                               :library steamworks)
 :bool (this :pointer) (h-listen-socket snet-listen-socket)
 (pcub-msg-size :pointer) (ph-socket :pointer))

(defcfun*
 (networking-retrieve-data "SteamAPI_ISteamNetworking_RetrieveData" :library
                           steamworks)
 :bool (this :pointer) (h-listen-socket snet-listen-socket) (pub-dest :pointer)
 (cub-dest :uint32) (pcub-msg-size :pointer) (ph-socket :pointer))

(defcfun*
 (networking-get-socket-info "SteamAPI_ISteamNetworking_GetSocketInfo" :library
                             steamworks)
 :bool (this :pointer) (h-socket snet-socket) (p-steam-idremote :pointer)
 (pe-socket-status :pointer) (pun-ipremote :pointer) (pun-port-remote :pointer))

(defcfun*
 (networking-get-listen-socket-info
  "SteamAPI_ISteamNetworking_GetListenSocketInfo" :library steamworks)
 :bool (this :pointer) (h-listen-socket snet-listen-socket) (pn-ip :pointer)
 (pn-port :pointer))

(defcfun*
 (networking-get-socket-connection-type
  "SteamAPI_ISteamNetworking_GetSocketConnectionType" :library steamworks)
 esnet-socket-connection-type (this :pointer) (h-socket snet-socket))

(defcfun*
 (networking-get-max-packet-size "SteamAPI_ISteamNetworking_GetMaxPacketSize"
                                 :library steamworks)
 :int (this :pointer) (h-socket snet-socket))

(defcfun*
 (screenshots-write-screenshot "SteamAPI_ISteamScreenshots_WriteScreenshot"
                               :library steamworks)
 screenshot-handle (this :pointer) (pub-rgb :pointer) (cub-rgb :uint32)
 (n-width :int) (n-height :int))

(defcfun*
 (screenshots-add-screenshot-to-library
  "SteamAPI_ISteamScreenshots_AddScreenshotToLibrary" :library steamworks)
 screenshot-handle (this :pointer) (pch-filename :string)
 (pch-thumbnail-filename :string) (n-width :int) (n-height :int))

(defcfun*
 (screenshots-trigger-screenshot "SteamAPI_ISteamScreenshots_TriggerScreenshot"
                                 :library steamworks)
 :void (this :pointer))

(defcfun*
 (screenshots-hook-screenshots "SteamAPI_ISteamScreenshots_HookScreenshots"
                               :library steamworks)
 :void (this :pointer) (b-hook :bool))

(defcfun*
 (screenshots-set-location "SteamAPI_ISteamScreenshots_SetLocation" :library
                           steamworks)
 :bool (this :pointer) (h-screenshot screenshot-handle) (pch-location :string))

(defcfun*
 (screenshots-tag-user "SteamAPI_ISteamScreenshots_TagUser" :library
                       steamworks)
 :bool (this :pointer) (h-screenshot screenshot-handle)
 (steam-id :unsigned-long))

(defcfun*
 (screenshots-tag-published-file "SteamAPI_ISteamScreenshots_TagPublishedFile"
                                 :library steamworks)
 :bool (this :pointer) (h-screenshot screenshot-handle)
 (un-published-file-id published-file-id))

(defcfun*
 (screenshots-is-screenshots-hooked
  "SteamAPI_ISteamScreenshots_IsScreenshotsHooked" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (screenshots-add-vrscreenshot-to-library
  "SteamAPI_ISteamScreenshots_AddVRScreenshotToLibrary" :library steamworks)
 screenshot-handle (this :pointer) (e-type evrscreenshot-type)
 (pch-filename :string) (pch-vrfilename :string))

(defcfun*
 (music-bis-enabled "SteamAPI_ISteamMusic_BIsEnabled" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-bis-playing "SteamAPI_ISteamMusic_BIsPlaying" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-get-playback-status "SteamAPI_ISteamMusic_GetPlaybackStatus" :library
                            steamworks)
 audio-playback-status (this :pointer))

(defcfun* (music-play "SteamAPI_ISteamMusic_Play" :library steamworks) :void
          (this :pointer))

(defcfun* (music-pause "SteamAPI_ISteamMusic_Pause" :library steamworks) :void
          (this :pointer))

(defcfun*
 (music-play-previous "SteamAPI_ISteamMusic_PlayPrevious" :library steamworks)
 :void (this :pointer))

(defcfun* (music-play-next "SteamAPI_ISteamMusic_PlayNext" :library steamworks)
          :void (this :pointer))

(defcfun*
 (music-set-volume "SteamAPI_ISteamMusic_SetVolume" :library steamworks) :void
 (this :pointer) (fl-volume :float))

(defcfun*
 (music-get-volume "SteamAPI_ISteamMusic_GetVolume" :library steamworks) :float
 (this :pointer))

(defcfun*
 (music-remote-register-steam-music-remote
  "SteamAPI_ISteamMusicRemote_RegisterSteamMusicRemote" :library steamworks)
 :bool (this :pointer) (pch-name :string))

(defcfun*
 (music-remote-deregister-steam-music-remote
  "SteamAPI_ISteamMusicRemote_DeregisterSteamMusicRemote" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-bis-current-music-remote
  "SteamAPI_ISteamMusicRemote_BIsCurrentMusicRemote" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-bactivation-success
  "SteamAPI_ISteamMusicRemote_BActivationSuccess" :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-set-display-name "SteamAPI_ISteamMusicRemote_SetDisplayName"
                                :library steamworks)
 :bool (this :pointer) (pch-display-name :string))

(defcfun*
 (music-remote-set-pngicon-64x64 "SteamAPI_ISteamMusicRemote_SetPNGIcon_64x64"
                                 :library steamworks)
 :bool (this :pointer) (pv-buffer :pointer) (cb-buffer-length :uint32))

(defcfun*
 (music-remote-enable-play-previous
  "SteamAPI_ISteamMusicRemote_EnablePlayPrevious" :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-enable-play-next "SteamAPI_ISteamMusicRemote_EnablePlayNext"
                                :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-enable-shuffled "SteamAPI_ISteamMusicRemote_EnableShuffled"
                               :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-enable-looped "SteamAPI_ISteamMusicRemote_EnableLooped" :library
                             steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-enable-queue "SteamAPI_ISteamMusicRemote_EnableQueue" :library
                            steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-enable-playlists "SteamAPI_ISteamMusicRemote_EnablePlaylists"
                                :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-update-playback-status
  "SteamAPI_ISteamMusicRemote_UpdatePlaybackStatus" :library steamworks)
 :bool (this :pointer) (n-status audio-playback-status))

(defcfun*
 (music-remote-update-shuffled "SteamAPI_ISteamMusicRemote_UpdateShuffled"
                               :library steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-update-looped "SteamAPI_ISteamMusicRemote_UpdateLooped" :library
                             steamworks)
 :bool (this :pointer) (b-value :bool))

(defcfun*
 (music-remote-update-volume "SteamAPI_ISteamMusicRemote_UpdateVolume" :library
                             steamworks)
 :bool (this :pointer) (fl-value :float))

(defcfun*
 (music-remote-current-entry-will-change
  "SteamAPI_ISteamMusicRemote_CurrentEntryWillChange" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-current-entry-is-available
  "SteamAPI_ISteamMusicRemote_CurrentEntryIsAvailable" :library steamworks)
 :bool (this :pointer) (b-available :bool))

(defcfun*
 (music-remote-update-current-entry-text
  "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryText" :library steamworks)
 :bool (this :pointer) (pch-text :string))

(defcfun*
 (music-remote-update-current-entry-elapsed-seconds
  "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryElapsedSeconds" :library
  steamworks)
 :bool (this :pointer) (n-value :int))

(defcfun*
 (music-remote-update-current-entry-cover-art
  "SteamAPI_ISteamMusicRemote_UpdateCurrentEntryCoverArt" :library steamworks)
 :bool (this :pointer) (pv-buffer :pointer) (cb-buffer-length :uint32))

(defcfun*
 (music-remote-current-entry-did-change
  "SteamAPI_ISteamMusicRemote_CurrentEntryDidChange" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-queue-will-change "SteamAPI_ISteamMusicRemote_QueueWillChange"
                                 :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-reset-queue-entries
  "SteamAPI_ISteamMusicRemote_ResetQueueEntries" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-set-queue-entry "SteamAPI_ISteamMusicRemote_SetQueueEntry"
                               :library steamworks)
 :bool (this :pointer) (n-id :int) (n-position :int) (pch-entry-text :string))

(defcfun*
 (music-remote-set-current-queue-entry
  "SteamAPI_ISteamMusicRemote_SetCurrentQueueEntry" :library steamworks)
 :bool (this :pointer) (n-id :int))

(defcfun*
 (music-remote-queue-did-change "SteamAPI_ISteamMusicRemote_QueueDidChange"
                                :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-playlist-will-change
  "SteamAPI_ISteamMusicRemote_PlaylistWillChange" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-reset-playlist-entries
  "SteamAPI_ISteamMusicRemote_ResetPlaylistEntries" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (music-remote-set-playlist-entry "SteamAPI_ISteamMusicRemote_SetPlaylistEntry"
                                  :library steamworks)
 :bool (this :pointer) (n-id :int) (n-position :int) (pch-entry-text :string))

(defcfun*
 (music-remote-set-current-playlist-entry
  "SteamAPI_ISteamMusicRemote_SetCurrentPlaylistEntry" :library steamworks)
 :bool (this :pointer) (n-id :int))

(defcfun*
 (music-remote-playlist-did-change
  "SteamAPI_ISteamMusicRemote_PlaylistDidChange" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (http-create-httprequest "SteamAPI_ISteamHTTP_CreateHTTPRequest" :library
                          steamworks)
 httprequest-handle (this :pointer) (e-httprequest-method ehttpmethod)
 (pch-absolute-url :string))

(defcfun*
 (http-set-httprequest-context-value
  "SteamAPI_ISteamHTTP_SetHTTPRequestContextValue" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (ul-context-value :uint64))

(defcfun*
 (http-set-httprequest-network-activity-timeout
  "SteamAPI_ISteamHTTP_SetHTTPRequestNetworkActivityTimeout" :library
  steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (un-timeout-seconds :uint32))

(defcfun*
 (http-set-httprequest-header-value
  "SteamAPI_ISteamHTTP_SetHTTPRequestHeaderValue" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (pch-header-name :string)
 (pch-header-value :string))

(defcfun*
 (http-set-httprequest-get-or-post-parameter
  "SteamAPI_ISteamHTTP_SetHTTPRequestGetOrPostParameter" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (pch-param-name :string)
 (pch-param-value :string))

(defcfun*
 (http-send-httprequest "SteamAPI_ISteamHTTP_SendHTTPRequest" :library
                        steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (p-call-handle :pointer))

(defcfun*
 (http-send-httprequest-and-stream-response
  "SteamAPI_ISteamHTTP_SendHTTPRequestAndStreamResponse" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (p-call-handle :pointer))

(defcfun*
 (http-defer-httprequest "SteamAPI_ISteamHTTP_DeferHTTPRequest" :library
                         steamworks)
 :bool (this :pointer) (h-request httprequest-handle))

(defcfun*
 (http-prioritize-httprequest "SteamAPI_ISteamHTTP_PrioritizeHTTPRequest"
                              :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle))

(defcfun*
 (http-get-httpresponse-header-size
  "SteamAPI_ISteamHTTP_GetHTTPResponseHeaderSize" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (pch-header-name :string)
 (un-response-header-size :pointer))

(defcfun*
 (http-get-httpresponse-header-value
  "SteamAPI_ISteamHTTP_GetHTTPResponseHeaderValue" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (pch-header-name :string)
 (p-header-value-buffer :pointer) (un-buffer-size :uint32))

(defcfun*
 (http-get-httpresponse-body-size "SteamAPI_ISteamHTTP_GetHTTPResponseBodySize"
                                  :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (un-body-size :pointer))

(defcfun*
 (http-get-httpresponse-body-data "SteamAPI_ISteamHTTP_GetHTTPResponseBodyData"
                                  :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (p-body-data-buffer :pointer) (un-buffer-size :uint32))

(defcfun*
 (http-get-httpstreaming-response-body-data
  "SteamAPI_ISteamHTTP_GetHTTPStreamingResponseBodyData" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (c-offset :uint32)
 (p-body-data-buffer :pointer) (un-buffer-size :uint32))

(defcfun*
 (http-release-httprequest "SteamAPI_ISteamHTTP_ReleaseHTTPRequest" :library
                           steamworks)
 :bool (this :pointer) (h-request httprequest-handle))

(defcfun*
 (http-get-httpdownload-progress-pct
  "SteamAPI_ISteamHTTP_GetHTTPDownloadProgressPct" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (pfl-percent-out :pointer))

(defcfun*
 (http-set-httprequest-raw-post-body
  "SteamAPI_ISteamHTTP_SetHTTPRequestRawPostBody" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (pch-content-type :string) (pub-body :pointer) (un-body-len :uint32))

(defcfun*
 (http-create-cookie-container "SteamAPI_ISteamHTTP_CreateCookieContainer"
                               :library steamworks)
 httpcookie-container-handle (this :pointer)
 (b-allow-responses-to-modify :bool))

(defcfun*
 (http-release-cookie-container "SteamAPI_ISteamHTTP_ReleaseCookieContainer"
                                :library steamworks)
 :bool (this :pointer) (h-cookie-container httpcookie-container-handle))

(defcfun* (http-set-cookie "SteamAPI_ISteamHTTP_SetCookie" :library steamworks)
          :bool (this :pointer)
          (h-cookie-container httpcookie-container-handle) (pch-host :string)
          (pch-url :string) (pch-cookie :string))

(defcfun*
 (http-set-httprequest-cookie-container
  "SteamAPI_ISteamHTTP_SetHTTPRequestCookieContainer" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (h-cookie-container httpcookie-container-handle))

(defcfun*
 (http-set-httprequest-user-agent-info
  "SteamAPI_ISteamHTTP_SetHTTPRequestUserAgentInfo" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (pch-user-agent-info :string))

(defcfun*
 (http-set-httprequest-requires-verified-certificate
  "SteamAPI_ISteamHTTP_SetHTTPRequestRequiresVerifiedCertificate" :library
  steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (b-require-verified-certificate :bool))

(defcfun*
 (http-set-httprequest-absolute-timeout-ms
  "SteamAPI_ISteamHTTP_SetHTTPRequestAbsoluteTimeoutMS" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle) (un-milliseconds :uint32))

(defcfun*
 (http-get-httprequest-was-timed-out
  "SteamAPI_ISteamHTTP_GetHTTPRequestWasTimedOut" :library steamworks)
 :bool (this :pointer) (h-request httprequest-handle)
 (pb-was-timed-out :pointer))

(defcfun* (input-init "SteamAPI_ISteamInput_Init" :library steamworks) :bool
          (this :pointer) (b-explicitly-call-run-frame :bool))

(defcfun* (input-shutdown "SteamAPI_ISteamInput_Shutdown" :library steamworks)
          :bool (this :pointer))

(defcfun*
 (input-set-input-action-manifest-file-path
  "SteamAPI_ISteamInput_SetInputActionManifestFilePath" :library steamworks)
 :bool (this :pointer) (pch-input-action-manifest-absolute-path :string))

(defcfun* (input-run-frame "SteamAPI_ISteamInput_RunFrame" :library steamworks)
          :void (this :pointer) (b-reserved-value :bool))

(defcfun*
 (input-bwait-for-data "SteamAPI_ISteamInput_BWaitForData" :library steamworks)
 :bool (this :pointer) (b-wait-forever :bool) (un-timeout :uint32))

(defcfun*
 (input-bnew-data-available "SteamAPI_ISteamInput_BNewDataAvailable" :library
                            steamworks)
 :bool (this :pointer))

(defcfun*
 (input-get-connected-controllers
  "SteamAPI_ISteamInput_GetConnectedControllers" :library steamworks)
 :int (this :pointer) (handles-out :pointer))

(defcfun*
 (input-enable-device-callbacks "SteamAPI_ISteamInput_EnableDeviceCallbacks"
                                :library steamworks)
 :void (this :pointer))

(defcfun*
 (input-enable-action-event-callbacks
  "SteamAPI_ISteamInput_EnableActionEventCallbacks" :library steamworks)
 :void (this :pointer) (p-callback steam-input-action-event-callback-pointer))

(defcfun*
 (input-get-action-set-handle "SteamAPI_ISteamInput_GetActionSetHandle"
                              :library steamworks)
 input-action-set-handle (this :pointer) (psz-action-set-name :string))

(defcfun*
 (input-activate-action-set "SteamAPI_ISteamInput_ActivateActionSet" :library
                            steamworks)
 :void (this :pointer) (input-handle input-handle)
 (action-set-handle input-action-set-handle))

(defcfun*
 (input-get-current-action-set "SteamAPI_ISteamInput_GetCurrentActionSet"
                               :library steamworks)
 input-action-set-handle (this :pointer) (input-handle input-handle))

(defcfun*
 (input-activate-action-set-layer "SteamAPI_ISteamInput_ActivateActionSetLayer"
                                  :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (action-set-layer-handle input-action-set-handle))

(defcfun*
 (input-deactivate-action-set-layer
  "SteamAPI_ISteamInput_DeactivateActionSetLayer" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (action-set-layer-handle input-action-set-handle))

(defcfun*
 (input-deactivate-all-action-set-layers
  "SteamAPI_ISteamInput_DeactivateAllActionSetLayers" :library steamworks)
 :void (this :pointer) (input-handle input-handle))

(defcfun*
 (input-get-active-action-set-layers
  "SteamAPI_ISteamInput_GetActiveActionSetLayers" :library steamworks)
 :int (this :pointer) (input-handle input-handle) (handles-out :pointer))

(defcfun*
 (input-get-digital-action-handle "SteamAPI_ISteamInput_GetDigitalActionHandle"
                                  :library steamworks)
 input-digital-action-handle (this :pointer) (psz-action-name :string))

(defcfun*
 (input-get-digital-action-origins
  "SteamAPI_ISteamInput_GetDigitalActionOrigins" :library steamworks)
 :int (this :pointer) (input-handle input-handle)
 (action-set-handle input-action-set-handle)
 (digital-action-handle input-digital-action-handle) (origins-out :pointer))

(defcfun*
 (input-get-string-for-digital-action-name
  "SteamAPI_ISteamInput_GetStringForDigitalActionName" :library steamworks)
 :string (this :pointer) (e-action-handle input-digital-action-handle))

(defcfun*
 (input-get-analog-action-handle "SteamAPI_ISteamInput_GetAnalogActionHandle"
                                 :library steamworks)
 input-analog-action-handle (this :pointer) (psz-action-name :string))

(defcfun*
 (input-get-analog-action-origins "SteamAPI_ISteamInput_GetAnalogActionOrigins"
                                  :library steamworks)
 :int (this :pointer) (input-handle input-handle)
 (action-set-handle input-action-set-handle)
 (analog-action-handle input-analog-action-handle) (origins-out :pointer))

(defcfun*
 (input-get-glyph-pngfor-action-origin
  "SteamAPI_ISteamInput_GetGlyphPNGForActionOrigin" :library steamworks)
 :string (this :pointer) (e-origin einput-action-origin)
 (e-size esteam-input-glyph-size) (un-flags :uint32))

(defcfun*
 (input-get-glyph-svgfor-action-origin
  "SteamAPI_ISteamInput_GetGlyphSVGForActionOrigin" :library steamworks)
 :string (this :pointer) (e-origin einput-action-origin) (un-flags :uint32))

(defcfun*
 (input-get-glyph-for-action-origin-legacy
  "SteamAPI_ISteamInput_GetGlyphForActionOrigin_Legacy" :library steamworks)
 :string (this :pointer) (e-origin einput-action-origin))

(defcfun*
 (input-get-string-for-action-origin
  "SteamAPI_ISteamInput_GetStringForActionOrigin" :library steamworks)
 :string (this :pointer) (e-origin einput-action-origin))

(defcfun*
 (input-get-string-for-analog-action-name
  "SteamAPI_ISteamInput_GetStringForAnalogActionName" :library steamworks)
 :string (this :pointer) (e-action-handle input-analog-action-handle))

(defcfun*
 (input-stop-analog-action-momentum
  "SteamAPI_ISteamInput_StopAnalogActionMomentum" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (e-action input-analog-action-handle))

(defcfun*
 (input-trigger-vibration "SteamAPI_ISteamInput_TriggerVibration" :library
                          steamworks)
 :void (this :pointer) (input-handle input-handle)
 (us-left-speed :unsigned-short) (us-right-speed :unsigned-short))

(defcfun*
 (input-trigger-vibration-extended
  "SteamAPI_ISteamInput_TriggerVibrationExtended" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (us-left-speed :unsigned-short) (us-right-speed :unsigned-short)
 (us-left-trigger-speed :unsigned-short)
 (us-right-trigger-speed :unsigned-short))

(defcfun*
 (input-trigger-simple-haptic-event
  "SteamAPI_ISteamInput_TriggerSimpleHapticEvent" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (e-haptic-location econtroller-haptic-location) (n-intensity :uint8)
 (n-gain-db :char) (n-other-intensity :uint8) (n-other-gain-db :char))

(defcfun*
 (input-set-ledcolor "SteamAPI_ISteamInput_SetLEDColor" :library steamworks)
 :void (this :pointer) (input-handle input-handle) (n-color-r :uint8)
 (n-color-g :uint8) (n-color-b :uint8) (n-flags :unsigned-int))

(defcfun*
 (input-legacy-trigger-haptic-pulse
  "SteamAPI_ISteamInput_Legacy_TriggerHapticPulse" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (e-target-pad esteam-controller-pad) (us-duration-micro-sec :unsigned-short))

(defcfun*
 (input-legacy-trigger-repeated-haptic-pulse
  "SteamAPI_ISteamInput_Legacy_TriggerRepeatedHapticPulse" :library steamworks)
 :void (this :pointer) (input-handle input-handle)
 (e-target-pad esteam-controller-pad) (us-duration-micro-sec :unsigned-short)
 (us-off-micro-sec :unsigned-short) (un-repeat :unsigned-short)
 (n-flags :unsigned-int))

(defcfun*
 (input-show-binding-panel "SteamAPI_ISteamInput_ShowBindingPanel" :library
                           steamworks)
 :bool (this :pointer) (input-handle input-handle))

(defcfun*
 (input-get-input-type-for-handle "SteamAPI_ISteamInput_GetInputTypeForHandle"
                                  :library steamworks)
 esteam-input-type (this :pointer) (input-handle input-handle))

(defcfun*
 (input-get-controller-for-gamepad-index
  "SteamAPI_ISteamInput_GetControllerForGamepadIndex" :library steamworks)
 input-handle (this :pointer) (n-index :int))

(defcfun*
 (input-get-gamepad-index-for-controller
  "SteamAPI_ISteamInput_GetGamepadIndexForController" :library steamworks)
 :int (this :pointer) (ulinput-handle input-handle))

(defcfun*
 (input-get-string-for-xbox-origin
  "SteamAPI_ISteamInput_GetStringForXboxOrigin" :library steamworks)
 :string (this :pointer) (e-origin exbox-origin))

(defcfun*
 (input-get-glyph-for-xbox-origin "SteamAPI_ISteamInput_GetGlyphForXboxOrigin"
                                  :library steamworks)
 :string (this :pointer) (e-origin exbox-origin))

(defcfun*
 (input-get-action-origin-from-xbox-origin
  "SteamAPI_ISteamInput_GetActionOriginFromXboxOrigin" :library steamworks)
 einput-action-origin (this :pointer) (input-handle input-handle)
 (e-origin exbox-origin))

(defcfun*
 (input-translate-action-origin "SteamAPI_ISteamInput_TranslateActionOrigin"
                                :library steamworks)
 einput-action-origin (this :pointer)
 (e-destination-input-type esteam-input-type)
 (e-source-origin einput-action-origin))

(defcfun*
 (input-get-device-binding-revision
  "SteamAPI_ISteamInput_GetDeviceBindingRevision" :library steamworks)
 :bool (this :pointer) (input-handle input-handle) (p-major :pointer)
 (p-minor :pointer))

(defcfun*
 (input-get-remote-play-session-id
  "SteamAPI_ISteamInput_GetRemotePlaySessionID" :library steamworks)
 :uint32 (this :pointer) (input-handle input-handle))

(defcfun*
 (input-get-session-input-configuration-settings
  "SteamAPI_ISteamInput_GetSessionInputConfigurationSettings" :library
  steamworks)
 :uint16 (this :pointer))

(defcfun*
 (input-set-dual-sense-trigger-effect
  "SteamAPI_ISteamInput_SetDualSenseTriggerEffect" :library steamworks)
 :void (this :pointer) (input-handle input-handle) (p-param :pointer))

(defcfun*
 (controller-init "SteamAPI_ISteamController_Init" :library steamworks) :bool
 (this :pointer))

(defcfun*
 (controller-shutdown "SteamAPI_ISteamController_Shutdown" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (controller-run-frame "SteamAPI_ISteamController_RunFrame" :library
                       steamworks)
 :void (this :pointer))

(defcfun*
 (controller-get-connected-controllers
  "SteamAPI_ISteamController_GetConnectedControllers" :library steamworks)
 :int (this :pointer) (handles-out :pointer))

(defcfun*
 (controller-get-action-set-handle
  "SteamAPI_ISteamController_GetActionSetHandle" :library steamworks)
 controller-action-set-handle (this :pointer) (psz-action-set-name :string))

(defcfun*
 (controller-activate-action-set "SteamAPI_ISteamController_ActivateActionSet"
                                 :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (action-set-handle controller-action-set-handle))

(defcfun*
 (controller-get-current-action-set
  "SteamAPI_ISteamController_GetCurrentActionSet" :library steamworks)
 controller-action-set-handle (this :pointer)
 (controller-handle controller-handle))

(defcfun*
 (controller-activate-action-set-layer
  "SteamAPI_ISteamController_ActivateActionSetLayer" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (action-set-layer-handle controller-action-set-handle))

(defcfun*
 (controller-deactivate-action-set-layer
  "SteamAPI_ISteamController_DeactivateActionSetLayer" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (action-set-layer-handle controller-action-set-handle))

(defcfun*
 (controller-deactivate-all-action-set-layers
  "SteamAPI_ISteamController_DeactivateAllActionSetLayers" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle))

(defcfun*
 (controller-get-active-action-set-layers
  "SteamAPI_ISteamController_GetActiveActionSetLayers" :library steamworks)
 :int (this :pointer) (controller-handle controller-handle)
 (handles-out :pointer))

(defcfun*
 (controller-get-digital-action-handle
  "SteamAPI_ISteamController_GetDigitalActionHandle" :library steamworks)
 controller-digital-action-handle (this :pointer) (psz-action-name :string))

(defcfun*
 (controller-get-digital-action-origins
  "SteamAPI_ISteamController_GetDigitalActionOrigins" :library steamworks)
 :int (this :pointer) (controller-handle controller-handle)
 (action-set-handle controller-action-set-handle)
 (digital-action-handle controller-digital-action-handle)
 (origins-out :pointer))

(defcfun*
 (controller-get-analog-action-handle
  "SteamAPI_ISteamController_GetAnalogActionHandle" :library steamworks)
 controller-analog-action-handle (this :pointer) (psz-action-name :string))

(defcfun*
 (controller-get-analog-action-origins
  "SteamAPI_ISteamController_GetAnalogActionOrigins" :library steamworks)
 :int (this :pointer) (controller-handle controller-handle)
 (action-set-handle controller-action-set-handle)
 (analog-action-handle controller-analog-action-handle) (origins-out :pointer))

(defcfun*
 (controller-get-glyph-for-action-origin
  "SteamAPI_ISteamController_GetGlyphForActionOrigin" :library steamworks)
 :string (this :pointer) (e-origin econtroller-action-origin))

(defcfun*
 (controller-get-string-for-action-origin
  "SteamAPI_ISteamController_GetStringForActionOrigin" :library steamworks)
 :string (this :pointer) (e-origin econtroller-action-origin))

(defcfun*
 (controller-stop-analog-action-momentum
  "SteamAPI_ISteamController_StopAnalogActionMomentum" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (e-action controller-analog-action-handle))

(defcfun*
 (controller-trigger-haptic-pulse
  "SteamAPI_ISteamController_TriggerHapticPulse" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (e-target-pad esteam-controller-pad) (us-duration-micro-sec :unsigned-short))

(defcfun*
 (controller-trigger-repeated-haptic-pulse
  "SteamAPI_ISteamController_TriggerRepeatedHapticPulse" :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (e-target-pad esteam-controller-pad) (us-duration-micro-sec :unsigned-short)
 (us-off-micro-sec :unsigned-short) (un-repeat :unsigned-short)
 (n-flags :unsigned-int))

(defcfun*
 (controller-trigger-vibration "SteamAPI_ISteamController_TriggerVibration"
                               :library steamworks)
 :void (this :pointer) (controller-handle controller-handle)
 (us-left-speed :unsigned-short) (us-right-speed :unsigned-short))

(defcfun*
 (controller-set-ledcolor "SteamAPI_ISteamController_SetLEDColor" :library
                          steamworks)
 :void (this :pointer) (controller-handle controller-handle) (n-color-r :uint8)
 (n-color-g :uint8) (n-color-b :uint8) (n-flags :unsigned-int))

(defcfun*
 (controller-show-binding-panel "SteamAPI_ISteamController_ShowBindingPanel"
                                :library steamworks)
 :bool (this :pointer) (controller-handle controller-handle))

(defcfun*
 (controller-get-input-type-for-handle
  "SteamAPI_ISteamController_GetInputTypeForHandle" :library steamworks)
 esteam-input-type (this :pointer) (controller-handle controller-handle))

(defcfun*
 (controller-get-controller-for-gamepad-index
  "SteamAPI_ISteamController_GetControllerForGamepadIndex" :library steamworks)
 controller-handle (this :pointer) (n-index :int))

(defcfun*
 (controller-get-gamepad-index-for-controller
  "SteamAPI_ISteamController_GetGamepadIndexForController" :library steamworks)
 :int (this :pointer) (ul-controller-handle controller-handle))

(defcfun*
 (controller-get-string-for-xbox-origin
  "SteamAPI_ISteamController_GetStringForXboxOrigin" :library steamworks)
 :string (this :pointer) (e-origin exbox-origin))

(defcfun*
 (controller-get-glyph-for-xbox-origin
  "SteamAPI_ISteamController_GetGlyphForXboxOrigin" :library steamworks)
 :string (this :pointer) (e-origin exbox-origin))

(defcfun*
 (controller-get-action-origin-from-xbox-origin
  "SteamAPI_ISteamController_GetActionOriginFromXboxOrigin" :library
  steamworks)
 econtroller-action-origin (this :pointer)
 (controller-handle controller-handle) (e-origin exbox-origin))

(defcfun*
 (controller-translate-action-origin
  "SteamAPI_ISteamController_TranslateActionOrigin" :library steamworks)
 econtroller-action-origin (this :pointer)
 (e-destination-input-type esteam-input-type)
 (e-source-origin econtroller-action-origin))

(defcfun*
 (controller-get-controller-binding-revision
  "SteamAPI_ISteamController_GetControllerBindingRevision" :library steamworks)
 :bool (this :pointer) (controller-handle controller-handle) (p-major :pointer)
 (p-minor :pointer))

(defcfun*
 (ugc-create-query-user-ugcrequest
  "SteamAPI_ISteamUGC_CreateQueryUserUGCRequest" :library steamworks)
 ugcquery-handle (this :pointer) (un-account-id account-id)
 (e-list-type euser-ugclist) (e-matching-ugctype eugcmatching-ugctype)
 (e-sort-order euser-ugclist-sort-order) (n-creator-app-id app-id)
 (n-consumer-app-id app-id) (un-page :uint32))

(defcfun*
 (ugc-create-query-all-ugcrequest-page
  "SteamAPI_ISteamUGC_CreateQueryAllUGCRequestPage" :library steamworks)
 ugcquery-handle (this :pointer) (e-query-type eugcquery)
 (e-matchinge-matching-ugctype-file-type eugcmatching-ugctype)
 (n-creator-app-id app-id) (n-consumer-app-id app-id) (un-page :uint32))

(defcfun*
 (ugc-create-query-all-ugcrequest-cursor
  "SteamAPI_ISteamUGC_CreateQueryAllUGCRequestCursor" :library steamworks)
 ugcquery-handle (this :pointer) (e-query-type eugcquery)
 (e-matchinge-matching-ugctype-file-type eugcmatching-ugctype)
 (n-creator-app-id app-id) (n-consumer-app-id app-id) (pch-cursor :string))

(defcfun*
 (ugc-create-query-ugcdetails-request
  "SteamAPI_ISteamUGC_CreateQueryUGCDetailsRequest" :library steamworks)
 ugcquery-handle (this :pointer) (pvec-published-file-id :pointer)
 (un-num-published-file-ids :uint32))

(defcfun*
 (ugc-send-query-ugcrequest "SteamAPI_ISteamUGC_SendQueryUGCRequest" :library
                            steamworks)
 steam-apicall (this :pointer) (handle ugcquery-handle))

(defcfun*
 (ugc-get-query-ugcresult "SteamAPI_ISteamUGC_GetQueryUGCResult" :library
                          steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (p-details :pointer))

(defcfun*
 (ugc-get-query-ugcnum-tags "SteamAPI_ISteamUGC_GetQueryUGCNumTags" :library
                            steamworks)
 :uint32 (this :pointer) (handle ugcquery-handle) (index :uint32))

(defcfun*
 (ugc-get-query-ugctag "SteamAPI_ISteamUGC_GetQueryUGCTag" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (index-tag :uint32) (pch-value :string) (cch-value-size :uint32))

(defcfun*
 (ugc-get-query-ugctag-display-name
  "SteamAPI_ISteamUGC_GetQueryUGCTagDisplayName" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (index-tag :uint32) (pch-value :string) (cch-value-size :uint32))

(defcfun*
 (ugc-get-query-ugcpreview-url "SteamAPI_ISteamUGC_GetQueryUGCPreviewURL"
                               :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (pch-url :string) (cch-urlsize :uint32))

(defcfun*
 (ugc-get-query-ugcmetadata "SteamAPI_ISteamUGC_GetQueryUGCMetadata" :library
                            steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (pch-metadata :string) (cch-metadatasize :uint32))

(defcfun*
 (ugc-get-query-ugcchildren "SteamAPI_ISteamUGC_GetQueryUGCChildren" :library
                            steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (pvec-published-file-id :pointer) (c-max-entries :uint32))

(defcfun*
 (ugc-get-query-ugcstatistic "SteamAPI_ISteamUGC_GetQueryUGCStatistic" :library
                             steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (e-stat-type eitem-statistic) (p-stat-value :pointer))

(defcfun*
 (ugc-get-query-ugcnum-additional-previews
  "SteamAPI_ISteamUGC_GetQueryUGCNumAdditionalPreviews" :library steamworks)
 :uint32 (this :pointer) (handle ugcquery-handle) (index :uint32))

(defcfun*
 (ugc-get-query-ugcadditional-preview
  "SteamAPI_ISteamUGC_GetQueryUGCAdditionalPreview" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (preview-index :uint32) (pch-urlor-video-id :string) (cch-urlsize :uint32)
 (pch-original-file-name :string) (cch-original-file-name-size :uint32)
 (p-preview-type :pointer))

(defcfun*
 (ugc-get-query-ugcnum-key-value-tags
  "SteamAPI_ISteamUGC_GetQueryUGCNumKeyValueTags" :library steamworks)
 :uint32 (this :pointer) (handle ugcquery-handle) (index :uint32))

(defcfun*
 (ugc-get-query-ugckey-value-tag "SteamAPI_ISteamUGC_GetQueryUGCKeyValueTag"
                                 :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (key-value-tag-index :uint32) (pch-key :string) (cch-key-size :uint32)
 (pch-value :string) (cch-value-size :uint32))

(defcfun*
 (ugc-get-query-first-ugckey-value-tag
  "SteamAPI_ISteamUGC_GetQueryFirstUGCKeyValueTag" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (pch-key :string) (pch-value :string) (cch-value-size :uint32))

(defcfun*
 (ugc-get-num-supported-game-versions
  "SteamAPI_ISteamUGC_GetNumSupportedGameVersions" :library steamworks)
 :uint32 (this :pointer) (handle ugcquery-handle) (index :uint32))

(defcfun*
 (ugc-get-supported-game-version-data
  "SteamAPI_ISteamUGC_GetSupportedGameVersionData" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (index :uint32)
 (version-index :uint32) (pch-game-branch-min :string)
 (pch-game-branch-max :string) (cch-game-branch-size :uint32))

(defcfun*
 (ugc-get-query-ugccontent-descriptors
  "SteamAPI_ISteamUGC_GetQueryUGCContentDescriptors" :library steamworks)
 :uint32 (this :pointer) (handle ugcquery-handle) (index :uint32)
 (pvec-descriptors :pointer) (c-max-entries :uint32))

(defcfun*
 (ugc-release-query-ugcrequest "SteamAPI_ISteamUGC_ReleaseQueryUGCRequest"
                               :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle))

(defcfun*
 (ugc-add-required-tag "SteamAPI_ISteamUGC_AddRequiredTag" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (p-tag-name :string))

(defcfun*
 (ugc-add-required-tag-group "SteamAPI_ISteamUGC_AddRequiredTagGroup" :library
                             steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (p-tag-groups :pointer))

(defcfun*
 (ugc-add-excluded-tag "SteamAPI_ISteamUGC_AddExcludedTag" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (p-tag-name :string))

(defcfun*
 (ugc-set-return-only-ids "SteamAPI_ISteamUGC_SetReturnOnlyIDs" :library
                          steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-return-only-ids :bool))

(defcfun*
 (ugc-set-return-key-value-tags "SteamAPI_ISteamUGC_SetReturnKeyValueTags"
                                :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-return-key-value-tags :bool))

(defcfun*
 (ugc-set-return-long-description "SteamAPI_ISteamUGC_SetReturnLongDescription"
                                  :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle)
 (b-return-long-description :bool))

(defcfun*
 (ugc-set-return-metadata "SteamAPI_ISteamUGC_SetReturnMetadata" :library
                          steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-return-metadata :bool))

(defcfun*
 (ugc-set-return-children "SteamAPI_ISteamUGC_SetReturnChildren" :library
                          steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-return-children :bool))

(defcfun*
 (ugc-set-return-additional-previews
  "SteamAPI_ISteamUGC_SetReturnAdditionalPreviews" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle)
 (b-return-additional-previews :bool))

(defcfun*
 (ugc-set-return-total-only "SteamAPI_ISteamUGC_SetReturnTotalOnly" :library
                            steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-return-total-only :bool))

(defcfun*
 (ugc-set-return-playtime-stats "SteamAPI_ISteamUGC_SetReturnPlaytimeStats"
                                :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (un-days :uint32))

(defcfun*
 (ugc-set-language "SteamAPI_ISteamUGC_SetLanguage" :library steamworks) :bool
 (this :pointer) (handle ugcquery-handle) (pch-language :string))

(defcfun*
 (ugc-set-allow-cached-response "SteamAPI_ISteamUGC_SetAllowCachedResponse"
                                :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (un-max-age-seconds :uint32))

(defcfun*
 (ugc-set-admin-query "SteamAPI_ISteamUGC_SetAdminQuery" :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (b-admin-query :bool))

(defcfun*
 (ugc-set-cloud-file-name-filter "SteamAPI_ISteamUGC_SetCloudFileNameFilter"
                                 :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle)
 (p-match-cloud-file-name :string))

(defcfun*
 (ugc-set-match-any-tag "SteamAPI_ISteamUGC_SetMatchAnyTag" :library
                        steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (b-match-any-tag :bool))

(defcfun*
 (ugc-set-search-text "SteamAPI_ISteamUGC_SetSearchText" :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (p-search-text :string))

(defcfun*
 (ugc-set-ranked-by-trend-days "SteamAPI_ISteamUGC_SetRankedByTrendDays"
                               :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (un-days :uint32))

(defcfun*
 (ugc-set-time-created-date-range "SteamAPI_ISteamUGC_SetTimeCreatedDateRange"
                                  :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (rt-start rtime32)
 (rt-end rtime32))

(defcfun*
 (ugc-set-time-updated-date-range "SteamAPI_ISteamUGC_SetTimeUpdatedDateRange"
                                  :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (rt-start rtime32)
 (rt-end rtime32))

(defcfun*
 (ugc-add-required-key-value-tag "SteamAPI_ISteamUGC_AddRequiredKeyValueTag"
                                 :library steamworks)
 :bool (this :pointer) (handle ugcquery-handle) (p-key :string)
 (p-value :string))

(defcfun*
 (ugc-request-ugcdetails "SteamAPI_ISteamUGC_RequestUGCDetails" :library
                         steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id)
 (un-max-age-seconds :uint32))

(defcfun* (ugc-create-item "SteamAPI_ISteamUGC_CreateItem" :library steamworks)
          steam-apicall (this :pointer) (n-consumer-app-id app-id)
          (e-file-type eworkshop-file-type))

(defcfun*
 (ugc-start-item-update "SteamAPI_ISteamUGC_StartItemUpdate" :library
                        steamworks)
 ugcupdate-handle (this :pointer) (n-consumer-app-id app-id)
 (n-published-file-id published-file-id))

(defcfun*
 (ugc-set-item-title "SteamAPI_ISteamUGC_SetItemTitle" :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-title :string))

(defcfun*
 (ugc-set-item-description "SteamAPI_ISteamUGC_SetItemDescription" :library
                           steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-description :string))

(defcfun*
 (ugc-set-item-update-language "SteamAPI_ISteamUGC_SetItemUpdateLanguage"
                               :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-language :string))

(defcfun*
 (ugc-set-item-metadata "SteamAPI_ISteamUGC_SetItemMetadata" :library
                        steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-meta-data :string))

(defcfun*
 (ugc-set-item-visibility "SteamAPI_ISteamUGC_SetItemVisibility" :library
                          steamworks)
 :bool (this :pointer) (handle ugcupdate-handle)
 (e-visibility eremote-storage-published-file-visibility))

(defcfun*
 (ugc-set-item-tags "SteamAPI_ISteamUGC_SetItemTags" :library steamworks) :bool
 (this :pointer) (update-handle ugcupdate-handle) (p-tags :pointer)
 (b-allow-admin-tags :bool))

(defcfun*
 (ugc-set-item-content "SteamAPI_ISteamUGC_SetItemContent" :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (psz-content-folder :string))

(defcfun*
 (ugc-set-item-preview "SteamAPI_ISteamUGC_SetItemPreview" :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (psz-preview-file :string))

(defcfun*
 (ugc-set-allow-legacy-upload "SteamAPI_ISteamUGC_SetAllowLegacyUpload"
                              :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (b-allow-legacy-upload :bool))

(defcfun*
 (ugc-remove-all-item-key-value-tags
  "SteamAPI_ISteamUGC_RemoveAllItemKeyValueTags" :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle))

(defcfun*
 (ugc-remove-item-key-value-tags "SteamAPI_ISteamUGC_RemoveItemKeyValueTags"
                                 :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-key :string))

(defcfun*
 (ugc-add-item-key-value-tag "SteamAPI_ISteamUGC_AddItemKeyValueTag" :library
                             steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (pch-key :string)
 (pch-value :string))

(defcfun*
 (ugc-add-item-preview-file "SteamAPI_ISteamUGC_AddItemPreviewFile" :library
                            steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (psz-preview-file :string)
 (type eitem-preview-type))

(defcfun*
 (ugc-add-item-preview-video "SteamAPI_ISteamUGC_AddItemPreviewVideo" :library
                             steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (psz-video-id :string))

(defcfun*
 (ugc-update-item-preview-file "SteamAPI_ISteamUGC_UpdateItemPreviewFile"
                               :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (index :uint32)
 (psz-preview-file :string))

(defcfun*
 (ugc-update-item-preview-video "SteamAPI_ISteamUGC_UpdateItemPreviewVideo"
                                :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (index :uint32)
 (psz-video-id :string))

(defcfun*
 (ugc-remove-item-preview "SteamAPI_ISteamUGC_RemoveItemPreview" :library
                          steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (index :uint32))

(defcfun*
 (ugc-add-content-descriptor "SteamAPI_ISteamUGC_AddContentDescriptor" :library
                             steamworks)
 :bool (this :pointer) (handle ugcupdate-handle)
 (descid eugccontent-descriptor-id))

(defcfun*
 (ugc-remove-content-descriptor "SteamAPI_ISteamUGC_RemoveContentDescriptor"
                                :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle)
 (descid eugccontent-descriptor-id))

(defcfun*
 (ugc-set-required-game-versions "SteamAPI_ISteamUGC_SetRequiredGameVersions"
                                 :library steamworks)
 :bool (this :pointer) (handle ugcupdate-handle) (psz-game-branch-min :string)
 (psz-game-branch-max :string))

(defcfun*
 (ugc-submit-item-update "SteamAPI_ISteamUGC_SubmitItemUpdate" :library
                         steamworks)
 steam-apicall (this :pointer) (handle ugcupdate-handle)
 (pch-change-note :string))

(defcfun*
 (ugc-get-item-update-progress "SteamAPI_ISteamUGC_GetItemUpdateProgress"
                               :library steamworks)
 eitem-update-status (this :pointer) (handle ugcupdate-handle)
 (pun-bytes-processed :pointer) (pun-bytes-total :pointer))

(defcfun*
 (ugc-set-user-item-vote "SteamAPI_ISteamUGC_SetUserItemVote" :library
                         steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id)
 (b-vote-up :bool))

(defcfun*
 (ugc-get-user-item-vote "SteamAPI_ISteamUGC_GetUserItemVote" :library
                         steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id))

(defcfun*
 (ugc-add-item-to-favorites "SteamAPI_ISteamUGC_AddItemToFavorites" :library
                            steamworks)
 steam-apicall (this :pointer) (n-app-id app-id)
 (n-published-file-id published-file-id))

(defcfun*
 (ugc-remove-item-from-favorites "SteamAPI_ISteamUGC_RemoveItemFromFavorites"
                                 :library steamworks)
 steam-apicall (this :pointer) (n-app-id app-id)
 (n-published-file-id published-file-id))

(defcfun*
 (ugc-subscribe-item "SteamAPI_ISteamUGC_SubscribeItem" :library steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id))

(defcfun*
 (ugc-unsubscribe-item "SteamAPI_ISteamUGC_UnsubscribeItem" :library
                       steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id))

(defcfun*
 (ugc-get-num-subscribed-items "SteamAPI_ISteamUGC_GetNumSubscribedItems"
                               :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (ugc-get-subscribed-items "SteamAPI_ISteamUGC_GetSubscribedItems" :library
                           steamworks)
 :uint32 (this :pointer) (pvec-published-file-id :pointer)
 (c-max-entries :uint32))

(defcfun*
 (ugc-get-item-state "SteamAPI_ISteamUGC_GetItemState" :library steamworks)
 :uint32 (this :pointer) (n-published-file-id published-file-id))

(defcfun*
 (ugc-get-item-install-info "SteamAPI_ISteamUGC_GetItemInstallInfo" :library
                            steamworks)
 :bool (this :pointer) (n-published-file-id published-file-id)
 (pun-size-on-disk :pointer) (pch-folder :string) (cch-folder-size :uint32)
 (pun-time-stamp :pointer))

(defcfun*
 (ugc-get-item-download-info "SteamAPI_ISteamUGC_GetItemDownloadInfo" :library
                             steamworks)
 :bool (this :pointer) (n-published-file-id published-file-id)
 (pun-bytes-downloaded :pointer) (pun-bytes-total :pointer))

(defcfun*
 (ugc-download-item "SteamAPI_ISteamUGC_DownloadItem" :library steamworks)
 :bool (this :pointer) (n-published-file-id published-file-id)
 (b-high-priority :bool))

(defcfun*
 (ugc-binit-workshop-for-game-server
  "SteamAPI_ISteamUGC_BInitWorkshopForGameServer" :library steamworks)
 :bool (this :pointer) (un-workshop-depot-id depot-id) (psz-folder :string))

(defcfun*
 (ugc-suspend-downloads "SteamAPI_ISteamUGC_SuspendDownloads" :library
                        steamworks)
 :void (this :pointer) (b-suspend :bool))

(defcfun*
 (ugc-start-playtime-tracking "SteamAPI_ISteamUGC_StartPlaytimeTracking"
                              :library steamworks)
 steam-apicall (this :pointer) (pvec-published-file-id :pointer)
 (un-num-published-file-ids :uint32))

(defcfun*
 (ugc-stop-playtime-tracking "SteamAPI_ISteamUGC_StopPlaytimeTracking" :library
                             steamworks)
 steam-apicall (this :pointer) (pvec-published-file-id :pointer)
 (un-num-published-file-ids :uint32))

(defcfun*
 (ugc-stop-playtime-tracking-for-all-items
  "SteamAPI_ISteamUGC_StopPlaytimeTrackingForAllItems" :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (ugc-add-dependency "SteamAPI_ISteamUGC_AddDependency" :library steamworks)
 steam-apicall (this :pointer) (n-parent-published-file-id published-file-id)
 (n-child-published-file-id published-file-id))

(defcfun*
 (ugc-remove-dependency "SteamAPI_ISteamUGC_RemoveDependency" :library
                        steamworks)
 steam-apicall (this :pointer) (n-parent-published-file-id published-file-id)
 (n-child-published-file-id published-file-id))

(defcfun*
 (ugc-add-app-dependency "SteamAPI_ISteamUGC_AddAppDependency" :library
                         steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id)
 (n-app-id app-id))

(defcfun*
 (ugc-remove-app-dependency "SteamAPI_ISteamUGC_RemoveAppDependency" :library
                            steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id)
 (n-app-id app-id))

(defcfun*
 (ugc-get-app-dependencies "SteamAPI_ISteamUGC_GetAppDependencies" :library
                           steamworks)
 steam-apicall (this :pointer) (n-published-file-id published-file-id))

(defcfun* (ugc-delete-item "SteamAPI_ISteamUGC_DeleteItem" :library steamworks)
          steam-apicall (this :pointer) (n-published-file-id published-file-id))

(defcfun*
 (ugc-show-workshop-eula "SteamAPI_ISteamUGC_ShowWorkshopEULA" :library
                         steamworks)
 :bool (this :pointer))

(defcfun*
 (ugc-get-workshop-eulastatus "SteamAPI_ISteamUGC_GetWorkshopEULAStatus"
                              :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (ugc-get-user-content-descriptor-preferences
  "SteamAPI_ISteamUGC_GetUserContentDescriptorPreferences" :library steamworks)
 :uint32 (this :pointer) (pvec-descriptors :pointer) (c-max-entries :uint32))

(defcfun*
 (htmlsurface-init "SteamAPI_ISteamHTMLSurface_Init" :library steamworks) :bool
 (this :pointer))

(defcfun*
 (htmlsurface-shutdown "SteamAPI_ISteamHTMLSurface_Shutdown" :library
                       steamworks)
 :bool (this :pointer))

(defcfun*
 (htmlsurface-create-browser "SteamAPI_ISteamHTMLSurface_CreateBrowser"
                             :library steamworks)
 steam-apicall (this :pointer) (pch-user-agent :string) (pch-user-css :string))

(defcfun*
 (htmlsurface-remove-browser "SteamAPI_ISteamHTMLSurface_RemoveBrowser"
                             :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-load-url "SteamAPI_ISteamHTMLSurface_LoadURL" :library
                       steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (pch-url :string)
 (pch-post-data :string))

(defcfun*
 (htmlsurface-set-size "SteamAPI_ISteamHTMLSurface_SetSize" :library
                       steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (un-width :uint32)
 (un-height :uint32))

(defcfun*
 (htmlsurface-stop-load "SteamAPI_ISteamHTMLSurface_StopLoad" :library
                        steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-reload "SteamAPI_ISteamHTMLSurface_Reload" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-go-back "SteamAPI_ISteamHTMLSurface_GoBack" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-go-forward "SteamAPI_ISteamHTMLSurface_GoForward" :library
                         steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-add-header "SteamAPI_ISteamHTMLSurface_AddHeader" :library
                         steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (pch-key :string)
 (pch-value :string))

(defcfun*
 (htmlsurface-execute-javascript "SteamAPI_ISteamHTMLSurface_ExecuteJavascript"
                                 :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (pch-script :string))

(defcfun*
 (htmlsurface-mouse-up "SteamAPI_ISteamHTMLSurface_MouseUp" :library
                       steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (e-mouse-button isteam-htmlsurface-ehtmlmouse-button))

(defcfun*
 (htmlsurface-mouse-down "SteamAPI_ISteamHTMLSurface_MouseDown" :library
                         steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (e-mouse-button isteam-htmlsurface-ehtmlmouse-button))

(defcfun*
 (htmlsurface-mouse-double-click "SteamAPI_ISteamHTMLSurface_MouseDoubleClick"
                                 :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (e-mouse-button isteam-htmlsurface-ehtmlmouse-button))

(defcfun*
 (htmlsurface-mouse-move "SteamAPI_ISteamHTMLSurface_MouseMove" :library
                         steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (x :int) (y :int))

(defcfun*
 (htmlsurface-mouse-wheel "SteamAPI_ISteamHTMLSurface_MouseWheel" :library
                          steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (n-delta :int32))

(defcfun*
 (htmlsurface-key-down "SteamAPI_ISteamHTMLSurface_KeyDown" :library
                       steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (n-native-key-code :uint32)
 (e-htmlkey-modifiers isteam-htmlsurface-ehtmlkey-modifiers)
 (b-is-system-key :bool))

(defcfun*
 (htmlsurface-key-up "SteamAPI_ISteamHTMLSurface_KeyUp" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (n-native-key-code :uint32)
 (e-htmlkey-modifiers isteam-htmlsurface-ehtmlkey-modifiers))

(defcfun*
 (htmlsurface-key-char "SteamAPI_ISteamHTMLSurface_KeyChar" :library
                       steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (c-unicode-char :uint32)
 (e-htmlkey-modifiers isteam-htmlsurface-ehtmlkey-modifiers))

(defcfun*
 (htmlsurface-set-horizontal-scroll
  "SteamAPI_ISteamHTMLSurface_SetHorizontalScroll" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (n-absolute-pixel-scroll :uint32))

(defcfun*
 (htmlsurface-set-vertical-scroll
  "SteamAPI_ISteamHTMLSurface_SetVerticalScroll" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (n-absolute-pixel-scroll :uint32))

(defcfun*
 (htmlsurface-set-key-focus "SteamAPI_ISteamHTMLSurface_SetKeyFocus" :library
                            steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (b-has-key-focus :bool))

(defcfun*
 (htmlsurface-view-source "SteamAPI_ISteamHTMLSurface_ViewSource" :library
                          steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-copy-to-clipboard "SteamAPI_ISteamHTMLSurface_CopyToClipboard"
                                :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-paste-from-clipboard
  "SteamAPI_ISteamHTMLSurface_PasteFromClipboard" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-find "SteamAPI_ISteamHTMLSurface_Find" :library steamworks) :void
 (this :pointer) (un-browser-handle hhtmlbrowser) (pch-search-str :string)
 (b-currently-in-find :bool) (b-reverse :bool))

(defcfun*
 (htmlsurface-stop-find "SteamAPI_ISteamHTMLSurface_StopFind" :library
                        steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-get-link-at-position
  "SteamAPI_ISteamHTMLSurface_GetLinkAtPosition" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (x :int) (y :int))

(defcfun*
 (htmlsurface-set-cookie "SteamAPI_ISteamHTMLSurface_SetCookie" :library
                         steamworks)
 :void (this :pointer) (pch-hostname :string) (pch-key :string)
 (pch-value :string) (pch-path :string) (n-expires rtime32) (b-secure :bool)
 (b-httponly :bool))

(defcfun*
 (htmlsurface-set-page-scale-factor
  "SteamAPI_ISteamHTMLSurface_SetPageScaleFactor" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (fl-zoom :float)
 (n-point-x :int) (n-point-y :int))

(defcfun*
 (htmlsurface-set-background-mode
  "SteamAPI_ISteamHTMLSurface_SetBackgroundMode" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (b-background-mode :bool))

(defcfun*
 (htmlsurface-set-dpiscaling-factor
  "SteamAPI_ISteamHTMLSurface_SetDPIScalingFactor" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (fl-dpiscaling :float))

(defcfun*
 (htmlsurface-open-developer-tools
  "SteamAPI_ISteamHTMLSurface_OpenDeveloperTools" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser))

(defcfun*
 (htmlsurface-allow-start-request
  "SteamAPI_ISteamHTMLSurface_AllowStartRequest" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (b-allowed :bool))

(defcfun*
 (htmlsurface-jsdialog-response "SteamAPI_ISteamHTMLSurface_JSDialogResponse"
                                :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser) (b-result :bool))

(defcfun*
 (htmlsurface-file-load-dialog-response
  "SteamAPI_ISteamHTMLSurface_FileLoadDialogResponse" :library steamworks)
 :void (this :pointer) (un-browser-handle hhtmlbrowser)
 (pch-selected-files :string))

(defcfun*
 (inventory-get-result-status "SteamAPI_ISteamInventory_GetResultStatus"
                              :library steamworks)
 eresult (this :pointer) (result-handle steam-inventory-result))

(defcfun*
 (inventory-get-result-items "SteamAPI_ISteamInventory_GetResultItems" :library
                             steamworks)
 :bool (this :pointer) (result-handle steam-inventory-result)
 (p-out-items-array :pointer) (pun-out-items-array-size :pointer))

(defcfun*
 (inventory-get-result-item-property
  "SteamAPI_ISteamInventory_GetResultItemProperty" :library steamworks)
 :bool (this :pointer) (result-handle steam-inventory-result)
 (un-item-index :uint32) (pch-property-name :string) (pch-value-buffer :string)
 (pun-value-buffer-size-out :pointer))

(defcfun*
 (inventory-get-result-timestamp "SteamAPI_ISteamInventory_GetResultTimestamp"
                                 :library steamworks)
 :uint32 (this :pointer) (result-handle steam-inventory-result))

(defcfun*
 (inventory-check-result-steam-id "SteamAPI_ISteamInventory_CheckResultSteamID"
                                  :library steamworks)
 :bool (this :pointer) (result-handle steam-inventory-result)
 (steam-idexpected :unsigned-long))

(defcfun*
 (inventory-destroy-result "SteamAPI_ISteamInventory_DestroyResult" :library
                           steamworks)
 :void (this :pointer) (result-handle steam-inventory-result))

(defcfun*
 (inventory-get-all-items "SteamAPI_ISteamInventory_GetAllItems" :library
                          steamworks)
 :bool (this :pointer) (p-result-handle :pointer))

(defcfun*
 (inventory-get-items-by-id "SteamAPI_ISteamInventory_GetItemsByID" :library
                            steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (p-instance-ids :pointer)
 (un-count-instance-ids :uint32))

(defcfun*
 (inventory-serialize-result "SteamAPI_ISteamInventory_SerializeResult"
                             :library steamworks)
 :bool (this :pointer) (result-handle steam-inventory-result)
 (p-out-buffer :pointer) (pun-out-buffer-size :pointer))

(defcfun*
 (inventory-deserialize-result "SteamAPI_ISteamInventory_DeserializeResult"
                               :library steamworks)
 :bool (this :pointer) (p-out-result-handle :pointer) (p-buffer :pointer)
 (un-buffer-size :uint32) (b-reserved-must-be-false :bool))

(defcfun*
 (inventory-generate-items "SteamAPI_ISteamInventory_GenerateItems" :library
                           steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (p-array-item-defs :pointer)
 (pun-array-quantity :pointer) (un-array-length :uint32))

(defcfun*
 (inventory-grant-promo-items "SteamAPI_ISteamInventory_GrantPromoItems"
                              :library steamworks)
 :bool (this :pointer) (p-result-handle :pointer))

(defcfun*
 (inventory-add-promo-item "SteamAPI_ISteamInventory_AddPromoItem" :library
                           steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (item-def steam-item-def))

(defcfun*
 (inventory-add-promo-items "SteamAPI_ISteamInventory_AddPromoItems" :library
                            steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (p-array-item-defs :pointer)
 (un-array-length :uint32))

(defcfun*
 (inventory-consume-item "SteamAPI_ISteamInventory_ConsumeItem" :library
                         steamworks)
 :bool (this :pointer) (p-result-handle :pointer)
 (item-consume steam-item-instance-id) (un-quantity :uint32))

(defcfun*
 (inventory-exchange-items "SteamAPI_ISteamInventory_ExchangeItems" :library
                           steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (p-array-generate :pointer)
 (pun-array-generate-quantity :pointer) (un-array-generate-length :uint32)
 (p-array-destroy :pointer) (pun-array-destroy-quantity :pointer)
 (un-array-destroy-length :uint32))

(defcfun*
 (inventory-transfer-item-quantity
  "SteamAPI_ISteamInventory_TransferItemQuantity" :library steamworks)
 :bool (this :pointer) (p-result-handle :pointer)
 (item-id-source steam-item-instance-id) (un-quantity :uint32)
 (item-id-dest steam-item-instance-id))

(defcfun*
 (inventory-send-item-drop-heartbeat
  "SteamAPI_ISteamInventory_SendItemDropHeartbeat" :library steamworks)
 :void (this :pointer))

(defcfun*
 (inventory-trigger-item-drop "SteamAPI_ISteamInventory_TriggerItemDrop"
                              :library steamworks)
 :bool (this :pointer) (p-result-handle :pointer)
 (drop-list-definition steam-item-def))

(defcfun*
 (inventory-trade-items "SteamAPI_ISteamInventory_TradeItems" :library
                        steamworks)
 :bool (this :pointer) (p-result-handle :pointer)
 (steam-idtrade-partner :unsigned-long) (p-array-give :pointer)
 (p-array-give-quantity :pointer) (n-array-give-length :uint32)
 (p-array-get :pointer) (p-array-get-quantity :pointer)
 (n-array-get-length :uint32))

(defcfun*
 (inventory-load-item-definitions
  "SteamAPI_ISteamInventory_LoadItemDefinitions" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (inventory-get-item-definition-ids
  "SteamAPI_ISteamInventory_GetItemDefinitionIDs" :library steamworks)
 :bool (this :pointer) (p-item-def-ids :pointer)
 (pun-item-def-ids-array-size :pointer))

(defcfun*
 (inventory-get-item-definition-property
  "SteamAPI_ISteamInventory_GetItemDefinitionProperty" :library steamworks)
 :bool (this :pointer) (i-definition steam-item-def)
 (pch-property-name :string) (pch-value-buffer :string)
 (pun-value-buffer-size-out :pointer))

(defcfun*
 (inventory-request-eligible-promo-item-definitions-ids
  "SteamAPI_ISteamInventory_RequestEligiblePromoItemDefinitionsIDs" :library
  steamworks)
 steam-apicall (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (inventory-get-eligible-promo-item-definition-ids
  "SteamAPI_ISteamInventory_GetEligiblePromoItemDefinitionIDs" :library
  steamworks)
 :bool (this :pointer) (steam-id :unsigned-long) (p-item-def-ids :pointer)
 (pun-item-def-ids-array-size :pointer))

(defcfun*
 (inventory-start-purchase "SteamAPI_ISteamInventory_StartPurchase" :library
                           steamworks)
 steam-apicall (this :pointer) (p-array-item-defs :pointer)
 (pun-array-quantity :pointer) (un-array-length :uint32))

(defcfun*
 (inventory-request-prices "SteamAPI_ISteamInventory_RequestPrices" :library
                           steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (inventory-get-num-items-with-prices
  "SteamAPI_ISteamInventory_GetNumItemsWithPrices" :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (inventory-get-items-with-prices "SteamAPI_ISteamInventory_GetItemsWithPrices"
                                  :library steamworks)
 :bool (this :pointer) (p-array-item-defs :pointer) (p-current-prices :pointer)
 (p-base-prices :pointer) (un-array-length :uint32))

(defcfun*
 (inventory-get-item-price "SteamAPI_ISteamInventory_GetItemPrice" :library
                           steamworks)
 :bool (this :pointer) (i-definition steam-item-def) (p-current-price :pointer)
 (p-base-price :pointer))

(defcfun*
 (inventory-start-update-properties
  "SteamAPI_ISteamInventory_StartUpdateProperties" :library steamworks)
 steam-inventory-update-handle (this :pointer))

(defcfun*
 (inventory-remove-property "SteamAPI_ISteamInventory_RemoveProperty" :library
                            steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (n-item-id steam-item-instance-id) (pch-property-name :string))

(defcfun*
 (inventory-set-property-string "SteamAPI_ISteamInventory_SetPropertyString"
                                :library steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (n-item-id steam-item-instance-id) (pch-property-name :string)
 (pch-property-value :string))

(defcfun*
 (inventory-set-property-bool "SteamAPI_ISteamInventory_SetPropertyBool"
                              :library steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (n-item-id steam-item-instance-id) (pch-property-name :string) (b-value :bool))

(defcfun*
 (inventory-set-property-int64 "SteamAPI_ISteamInventory_SetPropertyInt64"
                               :library steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (n-item-id steam-item-instance-id) (pch-property-name :string)
 (n-value :int64))

(defcfun*
 (inventory-set-property-float "SteamAPI_ISteamInventory_SetPropertyFloat"
                               :library steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (n-item-id steam-item-instance-id) (pch-property-name :string)
 (fl-value :float))

(defcfun*
 (inventory-submit-update-properties
  "SteamAPI_ISteamInventory_SubmitUpdateProperties" :library steamworks)
 :bool (this :pointer) (handle steam-inventory-update-handle)
 (p-result-handle :pointer))

(defcfun*
 (inventory-inspect-item "SteamAPI_ISteamInventory_InspectItem" :library
                         steamworks)
 :bool (this :pointer) (p-result-handle :pointer) (pch-item-token :string))

(defcfun*
 (timeline-set-timeline-tooltip "SteamAPI_ISteamTimeline_SetTimelineTooltip"
                                :library steamworks)
 :void (this :pointer) (pch-description :string) (fl-time-delta :float))

(defcfun*
 (timeline-clear-timeline-tooltip
  "SteamAPI_ISteamTimeline_ClearTimelineTooltip" :library steamworks)
 :void (this :pointer) (fl-time-delta :float))

(defcfun*
 (timeline-set-timeline-game-mode "SteamAPI_ISteamTimeline_SetTimelineGameMode"
                                  :library steamworks)
 :void (this :pointer) (e-mode etimeline-game-mode))

(defcfun*
 (timeline-add-instantaneous-timeline-event
  "SteamAPI_ISteamTimeline_AddInstantaneousTimelineEvent" :library steamworks)
 timeline-event-handle (this :pointer) (pch-title :string)
 (pch-description :string) (pch-icon :string) (un-icon-priority :uint32)
 (fl-start-offset-seconds :float)
 (e-possible-clip etimeline-event-clip-priority))

(defcfun*
 (timeline-add-range-timeline-event
  "SteamAPI_ISteamTimeline_AddRangeTimelineEvent" :library steamworks)
 timeline-event-handle (this :pointer) (pch-title :string)
 (pch-description :string) (pch-icon :string) (un-icon-priority :uint32)
 (fl-start-offset-seconds :float) (fl-duration :float)
 (e-possible-clip etimeline-event-clip-priority))

(defcfun*
 (timeline-start-range-timeline-event
  "SteamAPI_ISteamTimeline_StartRangeTimelineEvent" :library steamworks)
 timeline-event-handle (this :pointer) (pch-title :string)
 (pch-description :string) (pch-icon :string) (un-priority :uint32)
 (fl-start-offset-seconds :float)
 (e-possible-clip etimeline-event-clip-priority))

(defcfun*
 (timeline-update-range-timeline-event
  "SteamAPI_ISteamTimeline_UpdateRangeTimelineEvent" :library steamworks)
 :void (this :pointer) (ul-event timeline-event-handle) (pch-title :string)
 (pch-description :string) (pch-icon :string) (un-priority :uint32)
 (e-possible-clip etimeline-event-clip-priority))

(defcfun*
 (timeline-end-range-timeline-event
  "SteamAPI_ISteamTimeline_EndRangeTimelineEvent" :library steamworks)
 :void (this :pointer) (ul-event timeline-event-handle)
 (fl-end-offset-seconds :float))

(defcfun*
 (timeline-remove-timeline-event "SteamAPI_ISteamTimeline_RemoveTimelineEvent"
                                 :library steamworks)
 :void (this :pointer) (ul-event timeline-event-handle))

(defcfun*
 (timeline-does-event-recording-exist
  "SteamAPI_ISteamTimeline_DoesEventRecordingExist" :library steamworks)
 steam-apicall (this :pointer) (ul-event timeline-event-handle))

(defcfun*
 (timeline-start-game-phase "SteamAPI_ISteamTimeline_StartGamePhase" :library
                            steamworks)
 :void (this :pointer))

(defcfun*
 (timeline-end-game-phase "SteamAPI_ISteamTimeline_EndGamePhase" :library
                          steamworks)
 :void (this :pointer))

(defcfun*
 (timeline-set-game-phase-id "SteamAPI_ISteamTimeline_SetGamePhaseID" :library
                             steamworks)
 :void (this :pointer) (pch-phase-id :string))

(defcfun*
 (timeline-does-game-phase-recording-exist
  "SteamAPI_ISteamTimeline_DoesGamePhaseRecordingExist" :library steamworks)
 steam-apicall (this :pointer) (pch-phase-id :string))

(defcfun*
 (timeline-add-game-phase-tag "SteamAPI_ISteamTimeline_AddGamePhaseTag"
                              :library steamworks)
 :void (this :pointer) (pch-tag-name :string) (pch-tag-icon :string)
 (pch-tag-group :string) (un-priority :uint32))

(defcfun*
 (timeline-set-game-phase-attribute
  "SteamAPI_ISteamTimeline_SetGamePhaseAttribute" :library steamworks)
 :void (this :pointer) (pch-attribute-group :string)
 (pch-attribute-value :string) (un-priority :uint32))

(defcfun*
 (timeline-open-overlay-to-game-phase
  "SteamAPI_ISteamTimeline_OpenOverlayToGamePhase" :library steamworks)
 :void (this :pointer) (pch-phase-id :string))

(defcfun*
 (timeline-open-overlay-to-timeline-event
  "SteamAPI_ISteamTimeline_OpenOverlayToTimelineEvent" :library steamworks)
 :void (this :pointer) (ul-event timeline-event-handle))

(defcfun*
 (video-get-video-url "SteamAPI_ISteamVideo_GetVideoURL" :library steamworks)
 :void (this :pointer) (un-video-app-id app-id))

(defcfun*
 (video-is-broadcasting "SteamAPI_ISteamVideo_IsBroadcasting" :library
                        steamworks)
 :bool (this :pointer) (pn-num-viewers :pointer))

(defcfun*
 (video-get-opfsettings "SteamAPI_ISteamVideo_GetOPFSettings" :library
                        steamworks)
 :void (this :pointer) (un-video-app-id app-id))

(defcfun*
 (video-get-opfstring-for-app "SteamAPI_ISteamVideo_GetOPFStringForApp"
                              :library steamworks)
 :bool (this :pointer) (un-video-app-id app-id) (pch-buffer :string)
 (pn-buffer-size :pointer))

(defcfun*
 (parental-settings-bis-parental-lock-enabled
  "SteamAPI_ISteamParentalSettings_BIsParentalLockEnabled" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (parental-settings-bis-parental-lock-locked
  "SteamAPI_ISteamParentalSettings_BIsParentalLockLocked" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (parental-settings-bis-app-blocked
  "SteamAPI_ISteamParentalSettings_BIsAppBlocked" :library steamworks)
 :bool (this :pointer) (n-app-id app-id))

(defcfun*
 (parental-settings-bis-app-in-block-list
  "SteamAPI_ISteamParentalSettings_BIsAppInBlockList" :library steamworks)
 :bool (this :pointer) (n-app-id app-id))

(defcfun*
 (parental-settings-bis-feature-blocked
  "SteamAPI_ISteamParentalSettings_BIsFeatureBlocked" :library steamworks)
 :bool (this :pointer) (e-feature eparental-feature))

(defcfun*
 (parental-settings-bis-feature-in-block-list
  "SteamAPI_ISteamParentalSettings_BIsFeatureInBlockList" :library steamworks)
 :bool (this :pointer) (e-feature eparental-feature))

(defcfun*
 (remote-play-get-session-count "SteamAPI_ISteamRemotePlay_GetSessionCount"
                                :library steamworks)
 :uint32 (this :pointer))

(defcfun*
 (remote-play-get-session-id "SteamAPI_ISteamRemotePlay_GetSessionID" :library
                             steamworks)
 remote-play-session-id (this :pointer) (i-session-index :int))

(defcfun*
 (remote-play-get-session-steam-id
  "SteamAPI_ISteamRemotePlay_GetSessionSteamID" :library steamworks)
 :unsigned-long (this :pointer) (un-session-id remote-play-session-id))

(defcfun*
 (remote-play-get-session-client-name
  "SteamAPI_ISteamRemotePlay_GetSessionClientName" :library steamworks)
 :string (this :pointer) (un-session-id remote-play-session-id))

(defcfun*
 (remote-play-get-session-client-form-factor
  "SteamAPI_ISteamRemotePlay_GetSessionClientFormFactor" :library steamworks)
 esteam-device-form-factor (this :pointer)
 (un-session-id remote-play-session-id))

(defcfun*
 (remote-play-bget-session-client-resolution
  "SteamAPI_ISteamRemotePlay_BGetSessionClientResolution" :library steamworks)
 :bool (this :pointer) (un-session-id remote-play-session-id)
 (pn-resolution-x :pointer) (pn-resolution-y :pointer))

(defcfun*
 (remote-play-bstart-remote-play-together
  "SteamAPI_ISteamRemotePlay_BStartRemotePlayTogether" :library steamworks)
 :bool (this :pointer) (b-show-overlay :bool))

(defcfun*
 (remote-play-bsend-remote-play-together-invite
  "SteamAPI_ISteamRemotePlay_BSendRemotePlayTogetherInvite" :library
  steamworks)
 :bool (this :pointer) (steam-idfriend :unsigned-long))

(defcfun*
 (networking-messages-send-message-to-user
  "SteamAPI_ISteamNetworkingMessages_SendMessageToUser" :library steamworks)
 eresult (this :pointer) (identity-remote :pointer) (pub-data :pointer)
 (cub-data :uint32) (n-send-flags :int) (n-remote-channel :int))

(defcfun*
 (networking-messages-receive-messages-on-channel
  "SteamAPI_ISteamNetworkingMessages_ReceiveMessagesOnChannel" :library
  steamworks)
 :int (this :pointer) (n-local-channel :int) (pp-out-messages :pointer)
 (n-max-messages :int))

(defcfun*
 (networking-messages-accept-session-with-user
  "SteamAPI_ISteamNetworkingMessages_AcceptSessionWithUser" :library
  steamworks)
 :bool (this :pointer) (identity-remote :pointer))

(defcfun*
 (networking-messages-close-session-with-user
  "SteamAPI_ISteamNetworkingMessages_CloseSessionWithUser" :library steamworks)
 :bool (this :pointer) (identity-remote :pointer))

(defcfun*
 (networking-messages-close-channel-with-user
  "SteamAPI_ISteamNetworkingMessages_CloseChannelWithUser" :library steamworks)
 :bool (this :pointer) (identity-remote :pointer) (n-local-channel :int))

(defcfun*
 (networking-messages-get-session-connection-info
  "SteamAPI_ISteamNetworkingMessages_GetSessionConnectionInfo" :library
  steamworks)
 esteam-networking-connection-state (this :pointer) (identity-remote :pointer)
 (p-connection-info :pointer) (p-quick-status :pointer))

(defcfun*
 (networking-sockets-create-listen-socket-ip
  "SteamAPI_ISteamNetworkingSockets_CreateListenSocketIP" :library steamworks)
 hsteam-listen-socket (this :pointer) (local-address :pointer) (n-options :int)
 (p-options :pointer))

(defcfun*
 (networking-sockets-connect-by-ipaddress
  "SteamAPI_ISteamNetworkingSockets_ConnectByIPAddress" :library steamworks)
 hsteam-net-connection (this :pointer) (address :pointer) (n-options :int)
 (p-options :pointer))

(defcfun*
 (networking-sockets-create-listen-socket-p2p
  "SteamAPI_ISteamNetworkingSockets_CreateListenSocketP2P" :library steamworks)
 hsteam-listen-socket (this :pointer) (n-local-virtual-port :int)
 (n-options :int) (p-options :pointer))

(defcfun*
 (networking-sockets-connect-p2p "SteamAPI_ISteamNetworkingSockets_ConnectP2P"
                                 :library steamworks)
 hsteam-net-connection (this :pointer) (identity-remote :pointer)
 (n-remote-virtual-port :int) (n-options :int) (p-options :pointer))

(defcfun*
 (networking-sockets-accept-connection
  "SteamAPI_ISteamNetworkingSockets_AcceptConnection" :library steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection))

(defcfun*
 (networking-sockets-close-connection
  "SteamAPI_ISteamNetworkingSockets_CloseConnection" :library steamworks)
 :bool (this :pointer) (h-peer hsteam-net-connection) (n-reason :int)
 (psz-debug :string) (b-enable-linger :bool))

(defcfun*
 (networking-sockets-close-listen-socket
  "SteamAPI_ISteamNetworkingSockets_CloseListenSocket" :library steamworks)
 :bool (this :pointer) (h-socket hsteam-listen-socket))

(defcfun*
 (networking-sockets-set-connection-user-data
  "SteamAPI_ISteamNetworkingSockets_SetConnectionUserData" :library steamworks)
 :bool (this :pointer) (h-peer hsteam-net-connection) (n-user-data :int64))

(defcfun*
 (networking-sockets-get-connection-user-data
  "SteamAPI_ISteamNetworkingSockets_GetConnectionUserData" :library steamworks)
 :int64 (this :pointer) (h-peer hsteam-net-connection))

(defcfun*
 (networking-sockets-set-connection-name
  "SteamAPI_ISteamNetworkingSockets_SetConnectionName" :library steamworks)
 :void (this :pointer) (h-peer hsteam-net-connection) (psz-name :string))

(defcfun*
 (networking-sockets-get-connection-name
  "SteamAPI_ISteamNetworkingSockets_GetConnectionName" :library steamworks)
 :bool (this :pointer) (h-peer hsteam-net-connection) (psz-name :string)
 (n-max-len :int))

(defcfun*
 (networking-sockets-send-message-to-connection
  "SteamAPI_ISteamNetworkingSockets_SendMessageToConnection" :library
  steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection) (p-data :pointer)
 (cb-data :uint32) (n-send-flags :int) (p-out-message-number :pointer))

(defcfun*
 (networking-sockets-send-messages
  "SteamAPI_ISteamNetworkingSockets_SendMessages" :library steamworks)
 :void (this :pointer) (n-messages :int) (p-messages :pointer)
 (p-out-message-number-or-result :pointer))

(defcfun*
 (networking-sockets-flush-messages-on-connection
  "SteamAPI_ISteamNetworkingSockets_FlushMessagesOnConnection" :library
  steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection))

(defcfun*
 (networking-sockets-receive-messages-on-connection
  "SteamAPI_ISteamNetworkingSockets_ReceiveMessagesOnConnection" :library
  steamworks)
 :int (this :pointer) (h-conn hsteam-net-connection) (pp-out-messages :pointer)
 (n-max-messages :int))

(defcfun*
 (networking-sockets-get-connection-info
  "SteamAPI_ISteamNetworkingSockets_GetConnectionInfo" :library steamworks)
 :bool (this :pointer) (h-conn hsteam-net-connection) (p-info :pointer))

(defcfun*
 (networking-sockets-get-connection-real-time-status
  "SteamAPI_ISteamNetworkingSockets_GetConnectionRealTimeStatus" :library
  steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection) (p-status :pointer)
 (n-lanes :int) (p-lanes :pointer))

(defcfun*
 (networking-sockets-get-detailed-connection-status
  "SteamAPI_ISteamNetworkingSockets_GetDetailedConnectionStatus" :library
  steamworks)
 :int (this :pointer) (h-conn hsteam-net-connection) (psz-buf :string)
 (cb-buf :int))

(defcfun*
 (networking-sockets-get-listen-socket-address
  "SteamAPI_ISteamNetworkingSockets_GetListenSocketAddress" :library
  steamworks)
 :bool (this :pointer) (h-socket hsteam-listen-socket) (address :pointer))

(defcfun*
 (networking-sockets-create-socket-pair
  "SteamAPI_ISteamNetworkingSockets_CreateSocketPair" :library steamworks)
 :bool (this :pointer) (p-out-connection1 :pointer)
 (p-out-connection2 :pointer) (b-use-network-loopback :bool)
 (p-identity1 :pointer) (p-identity2 :pointer))

(defcfun*
 (networking-sockets-configure-connection-lanes
  "SteamAPI_ISteamNetworkingSockets_ConfigureConnectionLanes" :library
  steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection) (n-num-lanes :int)
 (p-lane-priorities :pointer) (p-lane-weights :pointer))

(defcfun*
 (networking-sockets-get-identity
  "SteamAPI_ISteamNetworkingSockets_GetIdentity" :library steamworks)
 :bool (this :pointer) (p-identity :pointer))

(defcfun*
 (networking-sockets-init-authentication
  "SteamAPI_ISteamNetworkingSockets_InitAuthentication" :library steamworks)
 esteam-networking-availability (this :pointer))

(defcfun*
 (networking-sockets-get-authentication-status
  "SteamAPI_ISteamNetworkingSockets_GetAuthenticationStatus" :library
  steamworks)
 esteam-networking-availability (this :pointer) (p-details :pointer))

(defcfun*
 (networking-sockets-create-poll-group
  "SteamAPI_ISteamNetworkingSockets_CreatePollGroup" :library steamworks)
 hsteam-net-poll-group (this :pointer))

(defcfun*
 (networking-sockets-destroy-poll-group
  "SteamAPI_ISteamNetworkingSockets_DestroyPollGroup" :library steamworks)
 :bool (this :pointer) (h-poll-group hsteam-net-poll-group))

(defcfun*
 (networking-sockets-set-connection-poll-group
  "SteamAPI_ISteamNetworkingSockets_SetConnectionPollGroup" :library
  steamworks)
 :bool (this :pointer) (h-conn hsteam-net-connection)
 (h-poll-group hsteam-net-poll-group))

(defcfun*
 (networking-sockets-receive-messages-on-poll-group
  "SteamAPI_ISteamNetworkingSockets_ReceiveMessagesOnPollGroup" :library
  steamworks)
 :int (this :pointer) (h-poll-group hsteam-net-poll-group)
 (pp-out-messages :pointer) (n-max-messages :int))

(defcfun*
 (networking-sockets-received-relay-auth-ticket
  "SteamAPI_ISteamNetworkingSockets_ReceivedRelayAuthTicket" :library
  steamworks)
 :bool (this :pointer) (pv-ticket :pointer) (cb-ticket :int)
 (p-out-parsed-ticket :pointer))

(defcfun*
 (networking-sockets-find-relay-auth-ticket-for-server
  "SteamAPI_ISteamNetworkingSockets_FindRelayAuthTicketForServer" :library
  steamworks)
 :int (this :pointer) (identity-game-server :pointer)
 (n-remote-virtual-port :int) (p-out-parsed-ticket :pointer))

(defcfun*
 (networking-sockets-connect-to-hosted-dedicated-server
  "SteamAPI_ISteamNetworkingSockets_ConnectToHostedDedicatedServer" :library
  steamworks)
 hsteam-net-connection (this :pointer) (identity-target :pointer)
 (n-remote-virtual-port :int) (n-options :int) (p-options :pointer))

(defcfun*
 (networking-sockets-get-hosted-dedicated-server-port
  "SteamAPI_ISteamNetworkingSockets_GetHostedDedicatedServerPort" :library
  steamworks)
 :uint16 (this :pointer))

(defcfun*
 (networking-sockets-get-hosted-dedicated-server-popid
  "SteamAPI_ISteamNetworkingSockets_GetHostedDedicatedServerPOPID" :library
  steamworks)
 steam-networking-popid (this :pointer))

(defcfun*
 (networking-sockets-get-hosted-dedicated-server-address
  "SteamAPI_ISteamNetworkingSockets_GetHostedDedicatedServerAddress" :library
  steamworks)
 eresult (this :pointer) (p-routing :pointer))

(defcfun*
 (networking-sockets-create-hosted-dedicated-server-listen-socket
  "SteamAPI_ISteamNetworkingSockets_CreateHostedDedicatedServerListenSocket"
  :library steamworks)
 hsteam-listen-socket (this :pointer) (n-local-virtual-port :int)
 (n-options :int) (p-options :pointer))

(defcfun*
 (networking-sockets-get-game-coordinator-server-login
  "SteamAPI_ISteamNetworkingSockets_GetGameCoordinatorServerLogin" :library
  steamworks)
 eresult (this :pointer) (p-login-info :pointer) (pcb-signed-blob :pointer)
 (p-blob :pointer))

(defcfun*
 (networking-sockets-connect-p2pcustom-signaling
  "SteamAPI_ISteamNetworkingSockets_ConnectP2PCustomSignaling" :library
  steamworks)
 hsteam-net-connection (this :pointer) (p-signaling :pointer)
 (p-peer-identity :pointer) (n-remote-virtual-port :int) (n-options :int)
 (p-options :pointer))

(defcfun*
 (networking-sockets-received-p2pcustom-signal
  "SteamAPI_ISteamNetworkingSockets_ReceivedP2PCustomSignal" :library
  steamworks)
 :bool (this :pointer) (p-msg :pointer) (cb-msg :int) (p-context :pointer))

(defcfun*
 (networking-sockets-get-certificate-request
  "SteamAPI_ISteamNetworkingSockets_GetCertificateRequest" :library steamworks)
 :bool (this :pointer) (pcb-blob :pointer) (p-blob :pointer) (err-msg :pointer))

(defcfun*
 (networking-sockets-set-certificate
  "SteamAPI_ISteamNetworkingSockets_SetCertificate" :library steamworks)
 :bool (this :pointer) (p-certificate :pointer) (cb-certificate :int)
 (err-msg :pointer))

(defcfun*
 (networking-sockets-reset-identity
  "SteamAPI_ISteamNetworkingSockets_ResetIdentity" :library steamworks)
 :void (this :pointer) (p-identity :pointer))

(defcfun*
 (networking-sockets-run-callbacks
  "SteamAPI_ISteamNetworkingSockets_RunCallbacks" :library steamworks)
 :void (this :pointer))

(defcfun*
 (networking-sockets-begin-async-request-fake-ip
  "SteamAPI_ISteamNetworkingSockets_BeginAsyncRequestFakeIP" :library
  steamworks)
 :bool (this :pointer) (n-num-ports :int))

(defcfun*
 (networking-sockets-get-fake-ip "SteamAPI_ISteamNetworkingSockets_GetFakeIP"
                                 :library steamworks)
 :void (this :pointer) (idx-first-port :int) (p-info :pointer))

(defcfun*
 (networking-sockets-create-listen-socket-p2pfake-ip
  "SteamAPI_ISteamNetworkingSockets_CreateListenSocketP2PFakeIP" :library
  steamworks)
 hsteam-listen-socket (this :pointer) (idx-fake-port :int) (n-options :int)
 (p-options :pointer))

(defcfun*
 (networking-sockets-get-remote-fake-ipfor-connection
  "SteamAPI_ISteamNetworkingSockets_GetRemoteFakeIPForConnection" :library
  steamworks)
 eresult (this :pointer) (h-conn hsteam-net-connection) (p-out-addr :pointer))

(defcfun*
 (networking-sockets-create-fake-udpport
  "SteamAPI_ISteamNetworkingSockets_CreateFakeUDPPort" :library steamworks)
 :pointer (this :pointer) (idx-fake-server-port :int))

(defcfun*
 (networking-utils-allocate-message
  "SteamAPI_ISteamNetworkingUtils_AllocateMessage" :library steamworks)
 :pointer (this :pointer) (cb-allocate-buffer :int))

(defcfun*
 (networking-utils-init-relay-network-access
  "SteamAPI_ISteamNetworkingUtils_InitRelayNetworkAccess" :library steamworks)
 :void (this :pointer))

(defcfun*
 (networking-utils-get-relay-network-status
  "SteamAPI_ISteamNetworkingUtils_GetRelayNetworkStatus" :library steamworks)
 esteam-networking-availability (this :pointer) (p-details :pointer))

(defcfun*
 (networking-utils-get-local-ping-location
  "SteamAPI_ISteamNetworkingUtils_GetLocalPingLocation" :library steamworks)
 :float (this :pointer) (result :pointer))

(defcfun*
 (networking-utils-estimate-ping-time-between-two-locations
  "SteamAPI_ISteamNetworkingUtils_EstimatePingTimeBetweenTwoLocations" :library
  steamworks)
 :int (this :pointer) (location1 :pointer) (location2 :pointer))

(defcfun*
 (networking-utils-estimate-ping-time-from-local-host
  "SteamAPI_ISteamNetworkingUtils_EstimatePingTimeFromLocalHost" :library
  steamworks)
 :int (this :pointer) (remote-location :pointer))

(defcfun*
 (networking-utils-convert-ping-location-to-string
  "SteamAPI_ISteamNetworkingUtils_ConvertPingLocationToString" :library
  steamworks)
 :void (this :pointer) (location :pointer) (psz-buf :string)
 (cch-buf-size :int))

(defcfun*
 (networking-utils-parse-ping-location-string
  "SteamAPI_ISteamNetworkingUtils_ParsePingLocationString" :library steamworks)
 :bool (this :pointer) (psz-string :string) (result :pointer))

(defcfun*
 (networking-utils-check-ping-data-up-to-date
  "SteamAPI_ISteamNetworkingUtils_CheckPingDataUpToDate" :library steamworks)
 :bool (this :pointer) (fl-max-age-seconds :float))

(defcfun*
 (networking-utils-get-ping-to-data-center
  "SteamAPI_ISteamNetworkingUtils_GetPingToDataCenter" :library steamworks)
 :int (this :pointer) (pop-id steam-networking-popid)
 (p-via-relay-po-p :pointer))

(defcfun*
 (networking-utils-get-direct-ping-to-pop
  "SteamAPI_ISteamNetworkingUtils_GetDirectPingToPOP" :library steamworks)
 :int (this :pointer) (pop-id steam-networking-popid))

(defcfun*
 (networking-utils-get-popcount "SteamAPI_ISteamNetworkingUtils_GetPOPCount"
                                :library steamworks)
 :int (this :pointer))

(defcfun*
 (networking-utils-get-poplist "SteamAPI_ISteamNetworkingUtils_GetPOPList"
                               :library steamworks)
 :int (this :pointer) (list :pointer) (n-list-sz :int))

(defcfun*
 (networking-utils-get-local-timestamp
  "SteamAPI_ISteamNetworkingUtils_GetLocalTimestamp" :library steamworks)
 steam-networking-microseconds (this :pointer))

(defcfun*
 (networking-utils-set-debug-output-function
  "SteamAPI_ISteamNetworkingUtils_SetDebugOutputFunction" :library steamworks)
 :void (this :pointer)
 (e-detail-level esteam-networking-sockets-debug-output-type)
 (pfn-func fsteam-networking-sockets-debug-output))

(defcfun*
 (networking-utils-is-fake-ipv4 "SteamAPI_ISteamNetworkingUtils_IsFakeIPv4"
                                :library steamworks)
 :bool (this :pointer) (n-ipv4 :uint32))

(defcfun*
 (networking-utils-get-ipv4fake-iptype
  "SteamAPI_ISteamNetworkingUtils_GetIPv4FakeIPType" :library steamworks)
 esteam-networking-fake-iptype (this :pointer) (n-ipv4 :uint32))

(defcfun*
 (networking-utils-get-real-identity-for-fake-ip
  "SteamAPI_ISteamNetworkingUtils_GetRealIdentityForFakeIP" :library
  steamworks)
 eresult (this :pointer) (fake-ip :pointer) (p-out-real-identity :pointer))

(defcfun*
 (networking-utils-set-global-config-value-int32
  "SteamAPI_ISteamNetworkingUtils_SetGlobalConfigValueInt32" :library
  steamworks)
 :bool (this :pointer) (e-value esteam-networking-config-value) (val :int32))

(defcfun*
 (networking-utils-set-global-config-value-float
  "SteamAPI_ISteamNetworkingUtils_SetGlobalConfigValueFloat" :library
  steamworks)
 :bool (this :pointer) (e-value esteam-networking-config-value) (val :float))

(defcfun*
 (networking-utils-set-global-config-value-string
  "SteamAPI_ISteamNetworkingUtils_SetGlobalConfigValueString" :library
  steamworks)
 :bool (this :pointer) (e-value esteam-networking-config-value) (val :string))

(defcfun*
 (networking-utils-set-global-config-value-ptr
  "SteamAPI_ISteamNetworkingUtils_SetGlobalConfigValuePtr" :library steamworks)
 :bool (this :pointer) (e-value esteam-networking-config-value) (val :pointer))

(defcfun*
 (networking-utils-set-connection-config-value-int32
  "SteamAPI_ISteamNetworkingUtils_SetConnectionConfigValueInt32" :library
  steamworks)
 :bool (this :pointer) (h-conn hsteam-net-connection)
 (e-value esteam-networking-config-value) (val :int32))

(defcfun*
 (networking-utils-set-connection-config-value-float
  "SteamAPI_ISteamNetworkingUtils_SetConnectionConfigValueFloat" :library
  steamworks)
 :bool (this :pointer) (h-conn hsteam-net-connection)
 (e-value esteam-networking-config-value) (val :float))

(defcfun*
 (networking-utils-set-connection-config-value-string
  "SteamAPI_ISteamNetworkingUtils_SetConnectionConfigValueString" :library
  steamworks)
 :bool (this :pointer) (h-conn hsteam-net-connection)
 (e-value esteam-networking-config-value) (val :string))

(defcfun*
 (networking-utils-set-global-callback-steam-net-connection-status-changed
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_SteamNetConnectionStatusChanged"
  :library steamworks)
 :bool (this :pointer) (fn-callback fn-steam-net-connection-status-changed))

(defcfun*
 (networking-utils-set-global-callback-steam-net-authentication-status-changed
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_SteamNetAuthenticationStatusChanged"
  :library steamworks)
 :bool (this :pointer) (fn-callback fn-steam-net-authentication-status-changed))

(defcfun*
 (networking-utils-set-global-callback-steam-relay-network-status-changed
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_SteamRelayNetworkStatusChanged"
  :library steamworks)
 :bool (this :pointer) (fn-callback fn-steam-relay-network-status-changed))

(defcfun*
 (networking-utils-set-global-callback-fake-ipresult
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_FakeIPResult" :library
  steamworks)
 :bool (this :pointer) (fn-callback fn-steam-networking-fake-ipresult))

(defcfun*
 (networking-utils-set-global-callback-messages-session-request
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_MessagesSessionRequest"
  :library steamworks)
 :bool (this :pointer)
 (fn-callback fn-steam-networking-messages-session-request))

(defcfun*
 (networking-utils-set-global-callback-messages-session-failed
  "SteamAPI_ISteamNetworkingUtils_SetGlobalCallback_MessagesSessionFailed"
  :library steamworks)
 :bool (this :pointer)
 (fn-callback fn-steam-networking-messages-session-failed))

(defcfun*
 (networking-utils-set-config-value
  "SteamAPI_ISteamNetworkingUtils_SetConfigValue" :library steamworks)
 :bool (this :pointer) (e-value esteam-networking-config-value)
 (e-scope-type esteam-networking-config-scope) (scope-obj intptr)
 (e-data-type esteam-networking-config-data-type) (p-arg :pointer))

(defcfun*
 (networking-utils-set-config-value-struct
  "SteamAPI_ISteamNetworkingUtils_SetConfigValueStruct" :library steamworks)
 :bool (this :pointer) (opt :pointer)
 (e-scope-type esteam-networking-config-scope) (scope-obj intptr))

(defcfun*
 (networking-utils-get-config-value
  "SteamAPI_ISteamNetworkingUtils_GetConfigValue" :library steamworks)
 esteam-networking-get-config-value-result (this :pointer)
 (e-value esteam-networking-config-value)
 (e-scope-type esteam-networking-config-scope) (scope-obj intptr)
 (p-out-data-type :pointer) (p-result :pointer) (cb-result :pointer))

(defcfun*
 (networking-utils-get-config-value-info
  "SteamAPI_ISteamNetworkingUtils_GetConfigValueInfo" :library steamworks)
 :string (this :pointer) (e-value esteam-networking-config-value)
 (p-out-data-type :pointer) (p-out-scope :pointer))

(defcfun*
 (networking-utils-iterate-generic-editable-config-values
  "SteamAPI_ISteamNetworkingUtils_IterateGenericEditableConfigValues" :library
  steamworks)
 esteam-networking-config-value (this :pointer)
 (e-current esteam-networking-config-value) (b-enumerate-dev-vars :bool))

(defcfun*
 (networking-utils-steam-networking-ipaddr-to-string
  "SteamAPI_ISteamNetworkingUtils_SteamNetworkingIPAddr_ToString" :library
  steamworks)
 :void (this :pointer) (addr :pointer) (buf :string) (cb-buf :uint32)
 (b-with-port :bool))

(defcfun*
 (networking-utils-steam-networking-ipaddr-parse-string
  "SteamAPI_ISteamNetworkingUtils_SteamNetworkingIPAddr_ParseString" :library
  steamworks)
 :bool (this :pointer) (p-addr :pointer) (psz-str :string))

(defcfun*
 (networking-utils-steam-networking-ipaddr-get-fake-iptype
  "SteamAPI_ISteamNetworkingUtils_SteamNetworkingIPAddr_GetFakeIPType" :library
  steamworks)
 esteam-networking-fake-iptype (this :pointer) (addr :pointer))

(defcfun*
 (networking-utils-steam-networking-identity-to-string
  "SteamAPI_ISteamNetworkingUtils_SteamNetworkingIdentity_ToString" :library
  steamworks)
 :void (this :pointer) (identity :pointer) (buf :string) (cb-buf :uint32))

(defcfun*
 (networking-utils-steam-networking-identity-parse-string
  "SteamAPI_ISteamNetworkingUtils_SteamNetworkingIdentity_ParseString" :library
  steamworks)
 :bool (this :pointer) (p-identity :pointer) (psz-str :string))

(defcfun*
 (game-server-set-product "SteamAPI_ISteamGameServer_SetProduct" :library
                          steamworks)
 :void (this :pointer) (psz-product :string))

(defcfun*
 (game-server-set-game-description
  "SteamAPI_ISteamGameServer_SetGameDescription" :library steamworks)
 :void (this :pointer) (psz-game-description :string))

(defcfun*
 (game-server-set-mod-dir "SteamAPI_ISteamGameServer_SetModDir" :library
                          steamworks)
 :void (this :pointer) (psz-mod-dir :string))

(defcfun*
 (game-server-set-dedicated-server
  "SteamAPI_ISteamGameServer_SetDedicatedServer" :library steamworks)
 :void (this :pointer) (b-dedicated :bool))

(defcfun*
 (game-server-log-on "SteamAPI_ISteamGameServer_LogOn" :library steamworks)
 :void (this :pointer) (psz-token :string))

(defcfun*
 (game-server-log-on-anonymous "SteamAPI_ISteamGameServer_LogOnAnonymous"
                               :library steamworks)
 :void (this :pointer))

(defcfun*
 (game-server-log-off "SteamAPI_ISteamGameServer_LogOff" :library steamworks)
 :void (this :pointer))

(defcfun*
 (game-server-blogged-on "SteamAPI_ISteamGameServer_BLoggedOn" :library
                         steamworks)
 :bool (this :pointer))

(defcfun*
 (game-server-bsecure "SteamAPI_ISteamGameServer_BSecure" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (game-server-get-steam-id "SteamAPI_ISteamGameServer_GetSteamID" :library
                           steamworks)
 :unsigned-long (this :pointer))

(defcfun*
 (game-server-was-restart-requested
  "SteamAPI_ISteamGameServer_WasRestartRequested" :library steamworks)
 :bool (this :pointer))

(defcfun*
 (game-server-set-max-player-count
  "SteamAPI_ISteamGameServer_SetMaxPlayerCount" :library steamworks)
 :void (this :pointer) (c-players-max :int))

(defcfun*
 (game-server-set-bot-player-count
  "SteamAPI_ISteamGameServer_SetBotPlayerCount" :library steamworks)
 :void (this :pointer) (c-botplayers :int))

(defcfun*
 (game-server-set-server-name "SteamAPI_ISteamGameServer_SetServerName"
                              :library steamworks)
 :void (this :pointer) (psz-server-name :string))

(defcfun*
 (game-server-set-map-name "SteamAPI_ISteamGameServer_SetMapName" :library
                           steamworks)
 :void (this :pointer) (psz-map-name :string))

(defcfun*
 (game-server-set-password-protected
  "SteamAPI_ISteamGameServer_SetPasswordProtected" :library steamworks)
 :void (this :pointer) (b-password-protected :bool))

(defcfun*
 (game-server-set-spectator-port "SteamAPI_ISteamGameServer_SetSpectatorPort"
                                 :library steamworks)
 :void (this :pointer) (un-spectator-port :uint16))

(defcfun*
 (game-server-set-spectator-server-name
  "SteamAPI_ISteamGameServer_SetSpectatorServerName" :library steamworks)
 :void (this :pointer) (psz-spectator-server-name :string))

(defcfun*
 (game-server-clear-all-key-values
  "SteamAPI_ISteamGameServer_ClearAllKeyValues" :library steamworks)
 :void (this :pointer))

(defcfun*
 (game-server-set-key-value "SteamAPI_ISteamGameServer_SetKeyValue" :library
                            steamworks)
 :void (this :pointer) (p-key :string) (p-value :string))

(defcfun*
 (game-server-set-game-tags "SteamAPI_ISteamGameServer_SetGameTags" :library
                            steamworks)
 :void (this :pointer) (pch-game-tags :string))

(defcfun*
 (game-server-set-game-data "SteamAPI_ISteamGameServer_SetGameData" :library
                            steamworks)
 :void (this :pointer) (pch-game-data :string))

(defcfun*
 (game-server-set-region "SteamAPI_ISteamGameServer_SetRegion" :library
                         steamworks)
 :void (this :pointer) (psz-region :string))

(defcfun*
 (game-server-set-advertise-server-active
  "SteamAPI_ISteamGameServer_SetAdvertiseServerActive" :library steamworks)
 :void (this :pointer) (b-active :bool))

(defcfun*
 (game-server-get-auth-session-ticket
  "SteamAPI_ISteamGameServer_GetAuthSessionTicket" :library steamworks)
 hauth-ticket (this :pointer) (p-ticket :pointer) (cb-max-ticket :int)
 (pcb-ticket :pointer) (p-snid :pointer))

(defcfun*
 (game-server-begin-auth-session "SteamAPI_ISteamGameServer_BeginAuthSession"
                                 :library steamworks)
 ebegin-auth-session-result (this :pointer) (p-auth-ticket :pointer)
 (cb-auth-ticket :int) (steam-id :unsigned-long))

(defcfun*
 (game-server-end-auth-session "SteamAPI_ISteamGameServer_EndAuthSession"
                               :library steamworks)
 :void (this :pointer) (steam-id :unsigned-long))

(defcfun*
 (game-server-cancel-auth-ticket "SteamAPI_ISteamGameServer_CancelAuthTicket"
                                 :library steamworks)
 :void (this :pointer) (h-auth-ticket hauth-ticket))

(defcfun*
 (game-server-user-has-license-for-app
  "SteamAPI_ISteamGameServer_UserHasLicenseForApp" :library steamworks)
 euser-has-license-for-app-result (this :pointer) (steam-id :unsigned-long)
 (app-id app-id))

(defcfun*
 (game-server-request-user-group-status
  "SteamAPI_ISteamGameServer_RequestUserGroupStatus" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long)
 (steam-idgroup :unsigned-long))

(defcfun*
 (game-server-get-gameplay-stats "SteamAPI_ISteamGameServer_GetGameplayStats"
                                 :library steamworks)
 :void (this :pointer))

(defcfun*
 (game-server-get-server-reputation
  "SteamAPI_ISteamGameServer_GetServerReputation" :library steamworks)
 steam-apicall (this :pointer))

(defcfun*
 (game-server-handle-incoming-packet
  "SteamAPI_ISteamGameServer_HandleIncomingPacket" :library steamworks)
 :bool (this :pointer) (p-data :pointer) (cb-data :int) (src-ip :uint32)
 (src-port :uint16))

(defcfun*
 (game-server-get-next-outgoing-packet
  "SteamAPI_ISteamGameServer_GetNextOutgoingPacket" :library steamworks)
 :int (this :pointer) (p-out :pointer) (cb-max-out :int) (p-net-adr :pointer)
 (p-port :pointer))

(defcfun*
 (game-server-associate-with-clan "SteamAPI_ISteamGameServer_AssociateWithClan"
                                  :library steamworks)
 steam-apicall (this :pointer) (steam-idclan :unsigned-long))

(defcfun*
 (game-server-compute-new-player-compatibility
  "SteamAPI_ISteamGameServer_ComputeNewPlayerCompatibility" :library
  steamworks)
 steam-apicall (this :pointer) (steam-idnew-player :unsigned-long))

(defcfun*
 (game-server-send-user-connect-and-authenticate-deprecated
  "SteamAPI_ISteamGameServer_SendUserConnectAndAuthenticate_DEPRECATED"
  :library steamworks)
 :bool (this :pointer) (un-ipclient :uint32) (pv-auth-blob :pointer)
 (cub-auth-blob-size :uint32) (p-steam-iduser :pointer))

(defcfun*
 (game-server-create-unauthenticated-user-connection
  "SteamAPI_ISteamGameServer_CreateUnauthenticatedUserConnection" :library
  steamworks)
 :unsigned-long (this :pointer))

(defcfun*
 (game-server-send-user-disconnect-deprecated
  "SteamAPI_ISteamGameServer_SendUserDisconnect_DEPRECATED" :library
  steamworks)
 :void (this :pointer) (steam-iduser :unsigned-long))

(defcfun*
 (game-server-bupdate-user-data "SteamAPI_ISteamGameServer_BUpdateUserData"
                                :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-player-name :string)
 (u-score :uint32))

(defcfun*
 (game-server-stats-request-user-stats
  "SteamAPI_ISteamGameServerStats_RequestUserStats" :library steamworks)
 steam-apicall (this :pointer) (steam-iduser :unsigned-long))

(defcfun*
 (game-server-stats-get-user-stat-int32
  "SteamAPI_ISteamGameServerStats_GetUserStatInt32" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (p-data :pointer))

(defcfun*
 (game-server-stats-get-user-stat-float
  "SteamAPI_ISteamGameServerStats_GetUserStatFloat" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (p-data :pointer))

(defcfun*
 (game-server-stats-get-user-achievement
  "SteamAPI_ISteamGameServerStats_GetUserAchievement" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (pb-achieved :pointer))

(defcfun*
 (game-server-stats-set-user-stat-int32
  "SteamAPI_ISteamGameServerStats_SetUserStatInt32" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (n-data :int32))

(defcfun*
 (game-server-stats-set-user-stat-float
  "SteamAPI_ISteamGameServerStats_SetUserStatFloat" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (f-data :float))

(defcfun*
 (game-server-stats-update-user-avg-rate-stat
  "SteamAPI_ISteamGameServerStats_UpdateUserAvgRateStat" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string)
 (fl-count-this-session :float) (d-session-length :double))

(defcfun*
 (game-server-stats-set-user-achievement
  "SteamAPI_ISteamGameServerStats_SetUserAchievement" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string))

(defcfun*
 (game-server-stats-clear-user-achievement
  "SteamAPI_ISteamGameServerStats_ClearUserAchievement" :library steamworks)
 :bool (this :pointer) (steam-iduser :unsigned-long) (pch-name :string))

(defcfun*
 (game-server-stats-store-user-stats
  "SteamAPI_ISteamGameServerStats_StoreUserStats" :library steamworks)
 steam-apicall (this :pointer) (steam-iduser :unsigned-long))

(defcfun*
 (networking-fake-udpport-destroy-fake-udpport
  "SteamAPI_ISteamNetworkingFakeUDPPort_DestroyFakeUDPPort" :library
  steamworks)
 :void (this :pointer))

(defcfun*
 (networking-fake-udpport-send-message-to-fake-ip
  "SteamAPI_ISteamNetworkingFakeUDPPort_SendMessageToFakeIP" :library
  steamworks)
 eresult (this :pointer) (remote-address :pointer) (p-data :pointer)
 (cb-data :uint32) (n-send-flags :int))

(defcfun*
 (networking-fake-udpport-receive-messages
  "SteamAPI_ISteamNetworkingFakeUDPPort_ReceiveMessages" :library steamworks)
 :int (this :pointer) (pp-out-messages :pointer) (n-max-messages :int))

(defcfun*
 (networking-fake-udpport-schedule-cleanup
  "SteamAPI_ISteamNetworkingFakeUDPPort_ScheduleCleanup" :library steamworks)
 :void (this :pointer) (remote-address :pointer))

(defcfun* (init "SteamAPI_Init" :library steamworks) :bool)

(defcfun* (init-safe "SteamAPI_InitSafe" :library steamworks) :bool)

(defcfun* (run-callbacks "SteamAPI_RunCallbacks" :library steamworks) :void)

(defcfun*
 (game-server-run-callbacks "SteamGameServer_RunCallbacks" :library steamworks)
 :void)

(defcfun* (register-callback "SteamAPI_RegisterCallback" :library steamworks)
          :void (p-callback :pointer) (callback :int))

(defcfun*
 (unregister-callback "SteamAPI_UnregisterCallback" :library steamworks) :void
 (p-callback :pointer))

(defcfun*
 (register-call-result "SteamAPI_RegisterCallResult" :library steamworks) :void
 (p-callback :pointer) (callback steam-apicall))

(defcfun*
 (unregister-call-result "SteamAPI_UnregisterCallResult" :library steamworks)
 :void (p-callback :pointer) (callback steam-apicall))

(defcfun*
 (game-server-init "SteamInternal_GameServer_Init" :library steamworks) :bool
 (un-ip :uint32) (us-port :uint16) (us-game-port :uint16)
 (us-query-port :uint16) (e-server-mode eserver-mode)
 (pch-version-string :string))

(defcfun* (shutdown "SteamAPI_Shutdown" :library steamworks) :void)

(defcfun* (game-server-shutdown "SteamGameServer_Shutdown" :library steamworks)
          :void)

(defcfun* (get-hsteam-user "SteamAPI_GetHSteamUser" :library steamworks)
          hsteam-user)

(defcfun* (get-hsteam-pipe "SteamAPI_GetHSteamPipe" :library steamworks)
          hsteam-pipe)

(defcfun*
 (game-server-get-hsteam-user "SteamGameServer_GetHSteamUser" :library
                              steamworks)
 hsteam-user)

(defcfun*
 (game-server-get-hsteam-pipe "SteamGameServer_GetHSteamPipe" :library
                              steamworks)
 hsteam-pipe)

(defcfun*
 (create-interface "SteamInternal_CreateInterface" :library steamworks)
 :pointer (version :string))

(defcfun*
 (restart-app-if-necessary "SteamAPI_RestartAppIfNecessary" :library
                           steamworks)
 :bool (un-own-app-id :uint32))

(defcfun*
 (shim-isteam-input-get-digital-action-data
  "shim_ISteamInput_GetDigitalActionData" :library steamworks)
 :void (self :pointer) (controller input-handle)
 (action input-digital-action-handle) (out :pointer))

(defcfun*
 (shim-isteam-input-get-analog-action-data
  "shim_ISteamInput_GetAnalogActionData" :library steamworks)
 :void (self :pointer) (controller input-handle)
 (action input-analog-action-handle) (out :pointer))

(defcfun*
 (shim-isteam-input-get-motion-data "shim_ISteamInput_GetMotionData" :library
                                    steamworks)
 :void (self :pointer) (controller input-handle) (out :pointer))

(defcfun*
 (shim-isteam-controller-get-digital-action-data
  "shim_ISteamController_GetDigitalActionData" :library steamworks)
 :void (self :pointer) (controller controller-handle)
 (action controller-digital-action-handle) (out :pointer))

(defcfun*
 (shim-isteam-controller-get-analog-action-data
  "shim_ISteamController_GetAnalogActionData" :library steamworks)
 :void (self :pointer) (controller controller-handle)
 (action controller-analog-action-handle) (out :pointer))

(defcfun*
 (shim-isteam-controller-get-motion-data "shim_ISteamController_GetMotionData"
                                         :library steamworks)
 :void (self :pointer) (controller controller-handle) (out :pointer))
