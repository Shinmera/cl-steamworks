#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((name '#:org.shirakumo.fraf.steamworks.cffi))
    (unless (find-package name)
      (make-package name :use ())
      (intern (string '#:steamworks) name)
      (intern (string '#:steamworks-shim) name))))

(defpackage #:cl-steamworks
  (:nicknames #:org.shirakumo.fraf.steamworks)
  (:local-nicknames (#:steam #:org.shirakumo.fraf.steamworks.cffi))
  (:import-from #:org.shirakumo.fraf.steamworks.cffi #:steamworks #:steamworks-shim)
  (:use #:cl)
  ;; c-object.lisp
  (:export
   #:pointer->object
   #:c-object
   #:handle
   #:c-registered-object
   #:c-managed-object
   #:free
   #:with-c-objects)
  ;; c-support.lisp
  (:export
   #:steamworks
   #:steamworks-shim)
  ;; callback-class.lisp
  (:export
   #:response-object
   #:status
   #:response-failed
   #:response-completed
   #:results-response-object
   #:results
   #:server-list-response
   #:server-list-updated
   #:server-list-failed
   #:server-list-completed
   #:ping-response
   #:ping-received
   #:player-details-response
   #:player-details-updated
   #:rules-response
   #:rule-updated)
  ;; callback.lisp
  (:export
   #:global-callback
   #:remove-global-callback
   #:define-callback
   #:callback
   #:closure-callback
   #:callresult
   #:token
   #:maybe-result
   #:result
   #:closure-callresult
   #:poll-for-result
   #:with-call-result)
  ;; conditions.lisp
  (:export
   #:steamworks-condition
   #:argument-missing
   #:argument
   #:api-call-failed
   #:api-call
   #:error-code
   #:string-too-long
   #:oversized-string
   #:octet-limit
   #:no-such-callback
   #:callback-name
   #:no-such-file
   #:file-handle
   #:no-such-user
   #:user-handle
   #:buffer-too-short
   #:required-bytes
   #:voice-data-corrupted
   #:interface-creation-failed
   #:interface-name
   #:not-an-image-file
   #:file-handle
   #:string-malformed
   #:malformed-string
   #:pathname-not-a-directory
   #:file-handle
   #:too-many-requests
   #:request-limit
   #:workshop-agreement-not-accepted
   #:file-seeking-impossible
   #:request-denied
   #:cannot-set-member-data-for-others
   #:steamworks-not-initialized
   #:steamworks-already-initialized
   #:initialization-failed
   #:user-stats-not-ready
   #:low-level-not-loaded)
  ;; interface.lisp
  (:export
   #:interface
   #:ensure-iface-obj
   #:interface
   #:interface-object
   #:remove-interface-object
   #:call-with
   #:interface-object
   #:iface
   #:iface*)
  ;; steamapps.lisp
  (:export
   #:steamapps
   #:low-violence-p
   #:subscribed-p
   #:family-shared-p
   #:free-weekend-p
   #:cybercafe-p
   #:vac-banned-p
   #:build-id
   #:owner
   #:languages
   #:language
   #:launch-parameter
   #:mark-as-corrupt
   #:list-dlcs
   #:beta-name
   #:file-details
   #:launch-command-line
   #:list-apps
   #:find-app
   #:app
   #:installed-p
   #:subscribed-p
   #:purchase-time
   #:app-id
   #:install-directory
   #:list-installed-depots
   #:ticket-data
   #:dlc
   #:available-p
   #:display-name
   #:installed-p
   #:install
   #:uninstall
   #:download-status)
  ;; steamclient.lisp
  (:export
   #:steamclient
   #:ipc-call-count
   #:make-pipe
   #:make-user
   #:client-pipe
   #:client-user
   #:pipe
   #:account-type)
  ;; steamfriends.lisp
  (:export
   #:steamfriends
   #:clear-rich-presence
   #:close-clan-chat-window
   #:display-name
   #:state
   #:listen-for-messages
   #:restricted-p
   #:activate-overlay
   #:clan
   #:list-clans
   #:follower-count
   #:list-friend-groups
   #:list-friends
   #:rich-presence
   #:friend
   #:coplay-game
   #:coplay-time
   #:state
   #:relationship
   #:rich-presence
   #:steam-level
   #:following-p
   #:in-source-p
   #:send-message
   #:request-rich-presence
   #:steam-id
   #:in-source-p
   #:rich-presence
   #:display-name
   #:nickname
   #:display-name-history
   #:current-game
   #:avatar
   #:kind-p
   #:invite
   #:mark-as-played-with
   #:get-message
   #:friend-group
   #:display-name
   #:members
   #:clan
   #:member-count
   #:admin-p
   #:public-p
   #:official-p
   #:chat-window-open-p
   #:join
   #:leave
   #:open-chat-window
   #:send-message
   #:admin-p
   #:activity
   #:display-name
   #:tag-name
   #:refresh-clas
   #:officer
   #:list-officers
   #:owner
   #:get-message)
  ;; steamgameserver.lisp
  (:export
   #:steamgameserver
   #:logged-on-p
   #:secure-p
   #:heartbeat
   #:public-ip
   #:steam-id
   #:logoff
   #:bot-count
   #:max-player-count
   #:password-protected
   #:region
   #:spectator-port
   #:restart-requested-p
   #:logon
   #:key-value
   #:associate-with-clan
   #:compute-player-compatibility
   #:next-outgoing-packet
   #:handle-incoming-packet
   #:request-user-group-status
   #:game-data
   #:game-description
   #:game-tags
   #:map-name
   #:heartbeat
   #:product
   #:spectator-port
   #:spectator-server
   #:user-stats
   #:make-session-ticket
   #:server-session-ticket
   #:begin-session
   #:server-auth-session)
  ;; steamhtmlsurface.lisp
  (:export
   #:steamhtmlsurface
   #:cookie
   #:browser
   #:add-header
   #:request-accepted-p
   #:dialog-accepted-p
   #:copy-to-clipboard
   #:paste-from-clipboard
   #:eval-js
   #:request-link
   #:go-back
   #:go-forward
   #:reload
   #:backgrounded-p
   #:focused-p
   #:stop
   #:view-page-source
   #:find-in-page
   #:selected-files
   #:cause-event
   #:scroll
   #:zoom
   #:size
   #:open-page
   #:clone
   #:can-navigate
   #:title-changed
   #:close-requested
   #:file-open-requested
   #:request-finished
   #:tooltip-hide-requested
   #:scroll-extents
   #:alert-requested
   #:confirm-requested
   #:link-result
   #:paint-requested
   #:window-opened
   #:tab-open-requested
   #:search-result
   #:cursor-change-requested
   #:tooltip-show-requested
   #:navigation-requested
   #:status-text-requested
   #:tool-tip-updated
   #:url-changed)
  ;; steamhttp.lisp
  (:export
   #:steamhttp
   #:cookie-container
   #:cookie
   #:http-request
   #:cookie-container
   #:defer
   #:stream-request-body
   #:prioritize
   #:context-value
   #:parameter
   #:header
   #:soft-timeout
   #:valid-certificate-required-p
   #:user-agent
   #:download-status
   #:timed-out-p
   #:request-body
   #:header
   #:send
   #:timeout)
  ;; steaminput.lisp
  (:export
   #:steaminput
   #:find-action-set
   #:find-analog-action
   #:find-digital-action
   #:find-controller
   #:action-glyph
   #:action-label
   #:run-frame
   #:translate-action-origin
   #:list-controllers
   #:controller
   #:list-action-set-layers
   #:action-set
   #:index
   #:input-type
   #:show-binding-panel
   #:remote-play-session-id
   #:xboxb-action-origin
   #:device-binding-revision
   #:led-color
   #:motion-data
   #:haptic-pulse
   #:vibrate
   #:action-set
   #:activate
   #:action-set-layer
   #:analog-action
   #:origins
   #:action-data
   #:stop-action-momentum
   #:digital-action)
  ;; steaminventory.lisp
  (:export
   #:steaminventory
   #:load-items
   #:ensure-prices-available
   #:grant
   #:deserialize-result
   #:list-items
   #:list-item-instances
   #:update-item-properties
   #:item
   #:item-instance
   #:consume
   #:transfer
   #:property
   #:item
   #:grant-promo
   #:grant-promo
   #:generate-items
   #:exchange
   #:property
   #:list-properties
   #:properties
   #:price
   #:purchase-items
   #:trigger-item-drop
   #:inventory-result
   #:check-steam-id
   #:status
   #:result-time
   #:result-property
   #:list-result-properties
   #:result-properties
   #:list-items
   #:serialize-result)
  ;; steammatchmaking.lisp
  (:export
   #:steammatchmaking
   #:add-favorite-game
   #:remove-favorite-game
   #:favorite-games
   #:request-lobby-list
   #:lobby
   #:steam-id
   #:data
   #:member-limit
   #:owner
   #:member-count
   #:leave
   #:refresh
   #:joinable-p
   #:lobby-type
   #:join
   #:invite
   #:data
   #:list-data
   #:member-data
   #:chat-entry
   #:server-details
   #:list-members
   #:send-message
   #:owner
   #:request-servers
   #:ping-server
   #:player-details
   #:server-rules
   #:server-query
   #:response
   #:status
   #:server-list-query
   #:response
   #:server-count
   #:refreshing-p
   #:refresh
   #:list-servers)
  ;; steammusic.lisp
  (:export
   #:steammusic
   #:enabled-p
   #:playing-p
   #:status
   #:volume
   #:play
   #:play-next
   #:play-previous)
  ;; steammusicremote.lisp
  (:export
   #:steammusicremote
   #:activated
   #:remote-p
   #:entry-changed-p
   #:entry-available-p
   #:entry-will-change-p
   #:looped-p
   #:playlists-enabled-p
   #:play-next-enabled-p
   #:play-previous-enabled-p
   #:queue-enabled-p
   #:shuffle-enabled-p
   #:playlist-changed-p
   #:playlist-will-change-p
   #:queue-changed-p
   #:queue-will-change-p
   #:reset-playlist
   #:reset-queue
   #:current-playlist-entry
   #:current-queue-entry
   #:display-name
   #:elapsed-seconds
   #:entry-text
   #:looped-p
   #:playback-status
   #:shuffled-p
   #:volume
   #:queue-entry
   #:playlist-entry
   #:icon
   #:cover-art)
  ;; steamnetworking.lisp
  (:export
   #:steamnetworking
   #:p2p-packet-relay-allowed-p
   #:next-packet-size
   #:read-packet
   #:p2p-session
   #:close-channel
   #:steam-id
   #:user
   #:state
   #:send-packet)
  ;; steamparties.lisp
  (:export
   #:steamparties
   #:list-beacon-locations
   #:list-beacons
   #:beacon-location
   #:location-type
   #:beacon
   #:owner
   #:location
   #:metadata
   #:complete-reservation
   #:open-slots
   #:join)
  ;; steamremotestorage.lisp
  (:export
   #:steamremotestorage
   #:cloud-enabled-p
   #:list-cached-ugc
   #:list-files
   #:quota
   #:file
   #:destroy
   #:exists-p
   #:forget
   #:persisted-p
   #:share
   #:size
   #:last-modified
   #:sync-platforms
   #:name
   #:read-file
   #:start-async-read
   #:complete-async-read
   #:write-file
   #:start-async-write
   #:write-stream
   #:with-write-stream
   #:file-write-stream
   #:ugc
   #:app
   #:name
   #:size
   #:owner
   #:download
   #:read-file
   #:download-status)
  ;; steamscreenshots.lisp
  (:export
   #:steamscreenshots
   #:trigger
   #:hooked-p
   #:add-screenshot
   #:screenshot
   #:loaction
   #:add-tag)
  ;; steamuser.lisp
  (:export
   #:steamuser
   #:advertise-game
   #:behind-nat-p
   #:phone-identified-p
   #:phone-verification-needed-p
   #:phone-verified-p
   #:two-factor-p
   #:logged-on-p
   #:badge-level
   #:steam-level
   #:steam-id
   #:optimal-voice-sample-rate
   #:make-store-url
   #:start-voice-recording
   #:stop-voice-recording
   #:compressed-voice-buffer
   #:voice
   #:make-session-ticket
   #:session-ticket
   #:payload
   #:begin-session
   #:auth-session
   #:user)
  ;; steamuserstats.lisp
  (:export
   #:steamuserstats
   #:player-count
   #:store-stats
   #:list-achievements
   #:ensure-current-stats
   #:ensure-global-stats
   #:ensure-global-percentages
   #:ensure-user-stats
   #:most-achieved
   #:reset-stats
   #:leaderboard
   #:stat
   #:stat-type
   #:stat-history
   #:stat-value
   #:achievement
   #:icon
   #:show-progress
   #:display-name
   #:description
   #:hidden-p
   #:achieved-p
   #:unlock-tyme
   #:achieved-percentage
   #:leaderboard
   #:display-type
   #:entry-count
   #:display-name
   #:sort-method
   #:ugc
   #:entries
   #:score)
  ;; steamutils.lisp
  (:export
   #:steamutils
   #:app-id
   #:ipc-call-count
   #:country-code
   #:uptime
   #:idle-time
   #:server-real-time
   #:big-picture-p
   #:virtual-reality-p
   #:virtual-reality-streaming-p
   #:start-virtual-reality-dashboard
   #:show-text-input
   #:battery-power
   #:input-text
   #:with-input-text
   #:overlay-notification-location
   #:image
   #:width
   #:height
   #:rgba)
  ;; steamvideo.lisp
  (:export
   #:steamvideo
   #:request-opf-settings
   #:request-video-url
   #:viewer-count
   #:opf-string)
  ;; steamworks.lisp
  (:export
   #:*default-interfaces*
   #:*default-server-interfaces*
   #:steamworks
   #:pipe
   #:user
   #:pipe
   #:steamworks
   #:interfaces
   #:user
   #:pipe
   #:create-interfaces
   #:interface
   #:list-interfaces
   #:steamworks-client
   #:restart
   #:run-callbacks
   #:steamworks-server
   #:ip-address
   #:steam-port
   #:game-port
   #:query-port
   #:server-mode
   #:version-string
   #:server-depot)
  ;; steamworkshop.lisp
  (:export
   #:steamworkshop
   #:downloads-suspended-p
   #:list-subscribed-files
   #:query
   #:stop-tracking
   #:workshop-query
   #:app
   #:add-excluded-tag
   #:add-required-tag
   #:add-key-value-tag
   #:cached-response-allowed-p
   #:cloud-file-name-filter
   #:any-tag-matches-p
   #:ranked-by-trend-days-p
   #:all-previews-requested-p
   #:children-requested-p
   #:key-value-tags-requested-p
   #:full-description-requested-p
   #:metadata-requested-p
   #:ids-only-p
   #:playtime-stats-requested-p
   #:totals-only-p
   #:search-text
   #:language
   #:execute
   #:get-previews
   #:get-children
   #:get-key-value-tags
   #:get-metadata
   #:get-statistics
   #:get-details
   #:get-workshop-file
   #:workshop-global-query
   #:workshop-user-query
   #:workshop-detail-query
   #:workshop-update
   #:workshop-file
   #:change-note
   #:metadata
   #:language
   #:visibility
   #:display-name
   #:description
   #:preview
   #:tags
   #:content
   #:previews
   #:key-value-tags
   #:execute
   #:update-status
   #:workshop-file
   #:app
   #:kind
   #:consumer
   #:display-name
   #:description
   #:owner
   #:created
   #:updated
   #:added
   #:visibility
   #:banned-p
   #:accepted-for-use-p
   #:tags
   #:file
   #:preview
   #:url
   #:votes-up
   #:votes-down
   #:score
   #:previews
   #:metadata
   #:statistics
   #:app-dependencies
   #:file-dependencies
   #:key-value-tags
   #:clear-cache
   #:download
   #:state
   #:start-tracking
   #:stop-tracking
   #:file-dependencies
   #:app-dependencies
   #:favorite
   #:unfavorite
   #:destroy
   #:subscribe
   #:unsubscribe
   #:download-status
   #:installation-info
   #:vote
   #:complete-from-query)
  ;; toolkit.lisp
  (:export))
