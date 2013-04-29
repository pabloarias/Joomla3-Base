/*
 * @author    RocketTheme http://www.rockettheme.com
 * @copyright Copyright (C) 2007 - 2013 RocketTheme, LLC
 * @license   http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only
 */
((function(){var a=this.GantryFonts={init:function(b){this.data=b;this.element=document.id(b.param);this.element.store("g4:fonts:value",this.element.get("value"));
Object.each(b.paths,function(c,d){this.load(d,c.delim,b.baseurl+c.json);},this);},load:function(i,g,e){var b=new Element("optgroup",{label:i}).inject(this.element),h=new Element("option",{value:"-1",text:"Loading..."}).inject(b,"top"),f,c,d;
new Request.JSON({url:e,method:"get",onSuccess:function(k){for(var m=0,j=k.items.length;m<j;m++){f=k.items[m].family;c="";if(!k.items[m].variants.contains("regular")){c=":"+k.items[m].variants[0];
}d=new Element("option",{text:f,value:g+f+c}).inject(b);}h.dispose();this.validate();if(typeof jQuery!="undefined"){jQuery("#"+this.data.param).trigger("liszt:updated");
}}.bind(this),onError:function(k,j){h.set("text","Error("+i+"): "+j);}}).send();},validate:function(){var c=this.element.get("data-value");if(c.contains(":")){return this.element.set("value",c);
}var b=this.element.getElement("[value$=:"+c+"]");this.element.set("value",(b?b:this.element.getElement("option")).get("value"));}};})());