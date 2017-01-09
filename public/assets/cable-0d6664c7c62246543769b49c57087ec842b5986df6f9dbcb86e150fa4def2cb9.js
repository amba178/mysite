(function(){(function(){(function(){var e=[].slice;this.ActionCable={INTERNAL:{message_types:{welcome:"welcome",ping:"ping",confirmation:"confirm_subscription",rejection:"reject_subscription"},default_mount_path:"/cable",protocols:["actioncable-v1-json","actioncable-unsupported"]},createConsumer:function(e){var n;return null==e&&(e=null!=(n=this.getConfig("url"))?n:this.INTERNAL.default_mount_path),new t.Consumer(this.createWebSocketURL(e))},getConfig:function(t){var e;return e=document.head.querySelector("meta[name='action-cable-"+t+"']"),null!=e?e.getAttribute("content"):void 0},createWebSocketURL:function(t){var e;return t&&!/^wss?:/i.test(t)?(e=document.createElement("a"),e.href=t,e.href=e.href,e.protocol=e.protocol.replace("http","ws"),e.href):t},startDebugging:function(){return this.debugging=!0},stopDebugging:function(){return this.debugging=null},log:function(){var t;if(t=1<=arguments.length?e.call(arguments,0):[],this.debugging)return t.push(Date.now()),console.log.apply(console,["[ActionCable]"].concat(e.call(t)))}}}).call(this)}).call(this);var t=this.ActionCable;(function(){(function(){var e=function(t,e){return function(){return t.apply(e,arguments)}};t.ConnectionMonitor=function(){function n(t){this.connection=t,this.visibilityDidChange=e(this.visibilityDidChange,this),this.reconnectAttempts=0}var i,o,r;return n.pollInterval={min:3,max:30},n.staleThreshold=6,n.prototype.start=function(){if(!this.isRunning())return this.startedAt=o(),delete this.stoppedAt,this.startPolling(),document.addEventListener("visibilitychange",this.visibilityDidChange),t.log("ConnectionMonitor started. pollInterval = "+this.getPollInterval()+" ms")},n.prototype.stop=function(){if(this.isRunning())return this.stoppedAt=o(),this.stopPolling(),document.removeEventListener("visibilitychange",this.visibilityDidChange),t.log("ConnectionMonitor stopped")},n.prototype.isRunning=function(){return null!=this.startedAt&&null==this.stoppedAt},n.prototype.recordPing=function(){return this.pingedAt=o()},n.prototype.recordConnect=function(){return this.reconnectAttempts=0,this.recordPing(),delete this.disconnectedAt,t.log("ConnectionMonitor recorded connect")},n.prototype.recordDisconnect=function(){return this.disconnectedAt=o(),t.log("ConnectionMonitor recorded disconnect")},n.prototype.startPolling=function(){return this.stopPolling(),this.poll()},n.prototype.stopPolling=function(){return clearTimeout(this.pollTimeout)},n.prototype.poll=function(){return this.pollTimeout=setTimeout(function(t){return function(){return t.reconnectIfStale(),t.poll()}}(this),this.getPollInterval())},n.prototype.getPollInterval=function(){var t,e,n,o;return o=this.constructor.pollInterval,n=o.min,e=o.max,t=5*Math.log(this.reconnectAttempts+1),Math.round(1e3*i(t,n,e))},n.prototype.reconnectIfStale=function(){if(this.connectionIsStale())return t.log("ConnectionMonitor detected stale connection. reconnectAttempts = "+this.reconnectAttempts+", pollInterval = "+this.getPollInterval()+" ms, time disconnected = "+r(this.disconnectedAt)+" s, stale threshold = "+this.constructor.staleThreshold+" s"),this.reconnectAttempts++,this.disconnectedRecently()?t.log("ConnectionMonitor skipping reopening recent disconnect"):(t.log("ConnectionMonitor reopening"),this.connection.reopen())},n.prototype.connectionIsStale=function(){var t;return r(null!=(t=this.pingedAt)?t:this.startedAt)>this.constructor.staleThreshold},n.prototype.disconnectedRecently=function(){return this.disconnectedAt&&r(this.disconnectedAt)<this.constructor.staleThreshold},n.prototype.visibilityDidChange=function(){if("visible"===document.visibilityState)return setTimeout(function(e){return function(){if(e.connectionIsStale()||!e.connection.isOpen())return t.log("ConnectionMonitor reopening stale connection on visibilitychange. visbilityState = "+document.visibilityState),e.connection.reopen()}}(this),200)},o=function(){return(new Date).getTime()},r=function(t){return(o()-t)/1e3},i=function(t,e,n){return Math.max(e,Math.min(n,t))},n}()}).call(this),function(){var e,n,i,o,r,s,a=[].slice,l=function(t,e){return function(){return t.apply(e,arguments)}},c=[].indexOf||function(t){for(var e=0,n=this.length;e<n;e++)if(e in this&&this[e]===t)return e;return-1};o=t.INTERNAL,n=o.message_types,i=o.protocols,r=2<=i.length?a.call(i,0,e=i.length-1):(e=0,[]),s=i[e++],t.Connection=function(){function e(e){this.consumer=e,this.open=l(this.open,this),this.subscriptions=this.consumer.subscriptions,this.monitor=new t.ConnectionMonitor(this),this.disconnected=!0}return e.reopenDelay=500,e.prototype.send=function(t){return!!this.isOpen()&&(this.webSocket.send(JSON.stringify(t)),!0)},e.prototype.open=function(){if(this.isActive())throw t.log("Attempted to open WebSocket, but existing socket is "+this.getState()),new Error("Existing connection must be closed before opening");return t.log("Opening WebSocket, current state is "+this.getState()+", subprotocols: "+i),null!=this.webSocket&&this.uninstallEventHandlers(),this.webSocket=new WebSocket(this.consumer.url,i),this.installEventHandlers(),this.monitor.start(),!0},e.prototype.close=function(t){var e,n;if(e=(null!=t?t:{allowReconnect:!0}).allowReconnect,e||this.monitor.stop(),this.isActive())return null!=(n=this.webSocket)?n.close():void 0},e.prototype.reopen=function(){var e;if(t.log("Reopening WebSocket, current state is "+this.getState()),!this.isActive())return this.open();try{return this.close()}catch(n){return e=n,t.log("Failed to reopen WebSocket",e)}finally{t.log("Reopening WebSocket in "+this.constructor.reopenDelay+"ms"),setTimeout(this.open,this.constructor.reopenDelay)}},e.prototype.getProtocol=function(){var t;return null!=(t=this.webSocket)?t.protocol:void 0},e.prototype.isOpen=function(){return this.isState("open")},e.prototype.isActive=function(){return this.isState("open","connecting")},e.prototype.isProtocolSupported=function(){var t;return t=this.getProtocol(),c.call(r,t)>=0},e.prototype.isState=function(){var t,e;return e=1<=arguments.length?a.call(arguments,0):[],t=this.getState(),c.call(e,t)>=0},e.prototype.getState=function(){var t,e,n;for(e in WebSocket)if(n=WebSocket[e],n===(null!=(t=this.webSocket)?t.readyState:void 0))return e.toLowerCase();return null},e.prototype.installEventHandlers=function(){var t,e;for(t in this.events)e=this.events[t].bind(this),this.webSocket["on"+t]=e},e.prototype.uninstallEventHandlers=function(){var t;for(t in this.events)this.webSocket["on"+t]=function(){}},e.prototype.events={message:function(t){var e,i,o,r;if(this.isProtocolSupported())switch(o=JSON.parse(t.data),e=o.identifier,i=o.message,r=o.type,r){case n.welcome:return this.monitor.recordConnect(),this.subscriptions.reload();case n.ping:return this.monitor.recordPing();case n.confirmation:return this.subscriptions.notify(e,"connected");case n.rejection:return this.subscriptions.reject(e);default:return this.subscriptions.notify(e,"received",i)}},open:function(){if(t.log("WebSocket onopen event, using '"+this.getProtocol()+"' subprotocol"),this.disconnected=!1,!this.isProtocolSupported())return t.log("Protocol is unsupported. Stopping monitor and disconnecting."),this.close({allowReconnect:!1})},close:function(){if(t.log("WebSocket onclose event"),!this.disconnected)return this.disconnected=!0,this.monitor.recordDisconnect(),this.subscriptions.notifyAll("disconnected",{willAttemptReconnect:this.monitor.isRunning()})},error:function(){return t.log("WebSocket onerror event")}},e}()}.call(this),function(){var e=[].slice;t.Subscriptions=function(){function n(t){this.consumer=t,this.subscriptions=[]}return n.prototype.create=function(e,n){var i,o,r;return i=e,o="object"==typeof i?i:{channel:i},r=new t.Subscription(this.consumer,o,n),this.add(r)},n.prototype.add=function(t){return this.subscriptions.push(t),this.consumer.ensureActiveConnection(),this.notify(t,"initialized"),this.sendCommand(t,"subscribe"),t},n.prototype.remove=function(t){return this.forget(t),this.findAll(t.identifier).length||this.sendCommand(t,"unsubscribe"),t},n.prototype.reject=function(t){var e,n,i,o,r;for(i=this.findAll(t),o=[],e=0,n=i.length;e<n;e++)r=i[e],this.forget(r),this.notify(r,"rejected"),o.push(r);return o},n.prototype.forget=function(t){var e;return this.subscriptions=function(){var n,i,o,r;for(o=this.subscriptions,r=[],n=0,i=o.length;n<i;n++)e=o[n],e!==t&&r.push(e);return r}.call(this),t},n.prototype.findAll=function(t){var e,n,i,o,r;for(i=this.subscriptions,o=[],e=0,n=i.length;e<n;e++)r=i[e],r.identifier===t&&o.push(r);return o},n.prototype.reload=function(){var t,e,n,i,o;for(n=this.subscriptions,i=[],t=0,e=n.length;t<e;t++)o=n[t],i.push(this.sendCommand(o,"subscribe"));return i},n.prototype.notifyAll=function(){var t,n,i,o,r,s,a;for(n=arguments[0],t=2<=arguments.length?e.call(arguments,1):[],r=this.subscriptions,s=[],i=0,o=r.length;i<o;i++)a=r[i],s.push(this.notify.apply(this,[a,n].concat(e.call(t))));return s},n.prototype.notify=function(){var t,n,i,o,r,s,a;for(s=arguments[0],n=arguments[1],t=3<=arguments.length?e.call(arguments,2):[],a="string"==typeof s?this.findAll(s):[s],r=[],i=0,o=a.length;i<o;i++)s=a[i],r.push("function"==typeof s[n]?s[n].apply(s,t):void 0);return r},n.prototype.sendCommand=function(t,e){var n;return n=t.identifier,this.consumer.send({command:e,identifier:n})},n}()}.call(this),function(){t.Subscription=function(){function t(t,n,i){this.consumer=t,null==n&&(n={}),this.identifier=JSON.stringify(n),e(this,i)}var e;return t.prototype.perform=function(t,e){return null==e&&(e={}),e.action=t,this.send(e)},t.prototype.send=function(t){return this.consumer.send({command:"message",identifier:this.identifier,data:JSON.stringify(t)})},t.prototype.unsubscribe=function(){return this.consumer.subscriptions.remove(this)},e=function(t,e){var n,i;if(null!=e)for(n in e)i=e[n],t[n]=i;return t},t}()}.call(this),function(){t.Consumer=function(){function e(e){this.url=e,this.subscriptions=new t.Subscriptions(this),this.connection=new t.Connection(this)}return e.prototype.send=function(t){return this.connection.send(t)},e.prototype.connect=function(){return this.connection.open()},e.prototype.disconnect=function(){return this.connection.close({allowReconnect:!1})},e.prototype.ensureActiveConnection=function(){if(!this.connection.isActive())return this.connection.open()},e}()}.call(this)}).call(this),"object"==typeof module&&module.exports?module.exports=t:"function"==typeof define&&define.amd&&define(t)}).call(this),function(){this.App||(this.App={}),App.cable=ActionCable.createConsumer()}.call(this);