sap.ui.define([],function(){"use strict";return{navegarAPP:function(e){var a=this.extensionAPI.getSelectedContexts();var t=a[0].getObject().Contrato;var i=a[0].getObject().Tarefa;var r=a[0].getObject().Usuario;sap.ushell.Container.getService("CrossApplic+
ationNavigation").isNavigationSupported([{target:{shellHash:"TimeSheetConfiguration-display"}}]).done(function(e){e.map(function(e,a){if(e.supported===true){var n=sap.ushell&&sap.ushell.Container&&sap.ushell.Container.getService("CrossApplicationNavigati+
on").hrefForExternal({target:{semanticObject:"TimeSheetConfiguration",action:"display"},params:{Contrato:t,Tarefa:i,Usuario:r}});sap.m.URLHelper.redirect(n,false)}else{alert("Usuário sem permissão para acessar o link")}})}).fail(function(){alert("Falha a+
o acessar o link")})}}});                                                                                                                                                                                                                                      