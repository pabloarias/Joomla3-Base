/*
 * @version   $Id: sidemenu.js 12458 2013-08-05 22:27:48Z djamil $
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
 */
((function(){var a=this.SideMenu=new Class({initialize:function(){this.build();
this.attachEvents();this.mediaQuery(RokMediaQueries.getQuery());},build:function(){if(this.toggler){return this.toggler;}this.toggler=new Element("div.gf-menu-toggle").inject(document.body);
this.container=document.getElement(".gf-menu-device-container");this.wrapper=new Element("div.gf-menu-device-container-wrapper").inject(this.container);
this.container=new Element("div.gf-menu-device-wrapper-sidemenu").wraps(this.container);this.menu=document.getElement(".gf-menu");this.originalPosition=this.menu.getParent();
this.open=false;(3).times(function(b){new Element("span.icon-bar").inject(this.toggler);},this);this.container.inject(document.body);return this.toggler;
},attachEvents:function(){var c=this.toggler.retrieve("roknavmenu:click",function(d){this.toggle.call(this,d,this.toggler);}.bind(this));this.toggler.addEvent("click",c);
try{RokMediaQueries.on("(max-width: 767px)",this.mediaQuery.bind(this));RokMediaQueries.on("(min-width: 768px)",this.mediaQuery.bind(this));}catch(b){if(typeof console!="undefined"){console.error('Error [Responsive Menu] while trying to add a RokMediaQuery "match" event',b);
}}},toggle:function(b,c){this.container[!this.open?"addClass":"removeClass"]("gf-sidemenu-size-left");document.body[!this.open?"addClass":"removeClass"]("gf-sidemenu-size-marginleft");
c[!this.open?"addClass":"removeClass"]("active");this.open=!this.open;},mediaQuery:function(d){var e=this.menu,c=this.wrapper,b=this.toggler.retrieve("roknavmenu:slidehor");
if(!e&&!c){return;}if(d=="(min-width: 768px)"){e.inject(this.originalPosition);this.toggler.setStyle("display","none");}else{e.inject(c);this.toggler.setStyle("display","block");
}this.toggler.removeClass("active");}});window.addEvent("domready",function(){this.RokNavMenu=new a();});})());