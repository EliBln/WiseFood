// regenerator-runtime/runtime@0.13.11 downloaded from https://ga.jspm.io/npm:regenerator-runtime@0.13.11/runtime.js

var t="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var e={};var r=function(e){var r=Object.prototype;var n=r.hasOwnProperty;var o=Object.defineProperty||function(t,e,r){t[e]=r.value};var a;var i="function"===typeof Symbol?Symbol:{};var u=i.iterator||"@@iterator";var c=i.asyncIterator||"@@asyncIterator";var l=i.toStringTag||"@@toStringTag";function define(t,e,r){Object.defineProperty(t,e,{value:r,enumerable:true,configurable:true,writable:true});return t[e]}try{define({},"")}catch(t){define=function(t,e,r){return t[e]=r}}function wrap(t,e,r,n){var a=e&&e.prototype instanceof Generator?e:Generator;var i=Object.create(a.prototype);var u=new Context(n||[]);o(i,"_invoke",{value:makeInvokeMethod(t,r,u)});return i}e.wrap=wrap;function tryCatch(t,e,r){try{return{type:"normal",arg:t.call(e,r)}}catch(t){return{type:"throw",arg:t}}}var h="suspendedStart";var f="suspendedYield";var s="executing";var y="completed";var v={};function Generator(){}function GeneratorFunction(){}function GeneratorFunctionPrototype(){}var p={};define(p,u,(function(){return this||t}));var d=Object.getPrototypeOf;var g=d&&d(d(values([])));g&&g!==r&&n.call(g,u)&&(p=g);var m=GeneratorFunctionPrototype.prototype=Generator.prototype=Object.create(p);GeneratorFunction.prototype=GeneratorFunctionPrototype;o(m,"constructor",{value:GeneratorFunctionPrototype,configurable:true});o(GeneratorFunctionPrototype,"constructor",{value:GeneratorFunction,configurable:true});GeneratorFunction.displayName=define(GeneratorFunctionPrototype,l,"GeneratorFunction");function defineIteratorMethods(t){["next","throw","return"].forEach((function(e){define(t,e,(function(t){return this._invoke(e,t)}))}))}e.isGeneratorFunction=function(t){var e="function"===typeof t&&t.constructor;return!!e&&(e===GeneratorFunction||"GeneratorFunction"===(e.displayName||e.name))};e.mark=function(t){if(Object.setPrototypeOf)Object.setPrototypeOf(t,GeneratorFunctionPrototype);else{t.__proto__=GeneratorFunctionPrototype;define(t,l,"GeneratorFunction")}t.prototype=Object.create(m);return t};e.awrap=function(t){return{__await:t}};function AsyncIterator(e,r){function invoke(t,o,a,i){var u=tryCatch(e[t],e,o);if("throw"!==u.type){var c=u.arg;var l=c.value;return l&&"object"===typeof l&&n.call(l,"__await")?r.resolve(l.__await).then((function(t){invoke("next",t,a,i)}),(function(t){invoke("throw",t,a,i)})):r.resolve(l).then((function(t){c.value=t;a(c)}),(function(t){return invoke("throw",t,a,i)}))}i(u.arg)}var a;function enqueue(t,e){function callInvokeWithMethodAndArg(){return new r((function(r,n){invoke(t,e,r,n)}))}return a=a?a.then(callInvokeWithMethodAndArg,callInvokeWithMethodAndArg):callInvokeWithMethodAndArg()}o(this||t,"_invoke",{value:enqueue})}defineIteratorMethods(AsyncIterator.prototype);define(AsyncIterator.prototype,c,(function(){return this||t}));e.AsyncIterator=AsyncIterator;e.async=function(t,r,n,o,a){void 0===a&&(a=Promise);var i=new AsyncIterator(wrap(t,r,n,o),a);return e.isGeneratorFunction(r)?i:i.next().then((function(t){return t.done?t.value:i.next()}))};function makeInvokeMethod(t,e,r){var n=h;return function invoke(o,a){if(n===s)throw new Error("Generator is already running");if(n===y){if("throw"===o)throw a;return doneResult()}r.method=o;r.arg=a;while(true){var i=r.delegate;if(i){var u=maybeInvokeDelegate(i,r);if(u){if(u===v)continue;return u}}if("next"===r.method)r.sent=r._sent=r.arg;else if("throw"===r.method){if(n===h){n=y;throw r.arg}r.dispatchException(r.arg)}else"return"===r.method&&r.abrupt("return",r.arg);n=s;var c=tryCatch(t,e,r);if("normal"===c.type){n=r.done?y:f;if(c.arg===v)continue;return{value:c.arg,done:r.done}}if("throw"===c.type){n=y;r.method="throw";r.arg=c.arg}}}}function maybeInvokeDelegate(t,e){var r=e.method;var n=t.iterator[r];if(n===a){e.delegate=null;if("throw"===r&&t.iterator.return){e.method="return";e.arg=a;maybeInvokeDelegate(t,e);if("throw"===e.method)return v}if("return"!==r){e.method="throw";e.arg=new TypeError("The iterator does not provide a '"+r+"' method")}return v}var o=tryCatch(n,t.iterator,e.arg);if("throw"===o.type){e.method="throw";e.arg=o.arg;e.delegate=null;return v}var i=o.arg;if(!i){e.method="throw";e.arg=new TypeError("iterator result is not an object");e.delegate=null;return v}if(!i.done)return i;e[t.resultName]=i.value;e.next=t.nextLoc;if("return"!==e.method){e.method="next";e.arg=a}e.delegate=null;return v}defineIteratorMethods(m);define(m,l,"Generator");define(m,u,(function(){return this||t}));define(m,"toString",(function(){return"[object Generator]"}));function pushTryEntry(e){var r={tryLoc:e[0]};1 in e&&(r.catchLoc=e[1]);if(2 in e){r.finallyLoc=e[2];r.afterLoc=e[3]}(this||t).tryEntries.push(r)}function resetTryEntry(t){var e=t.completion||{};e.type="normal";delete e.arg;t.completion=e}function Context(e){(this||t).tryEntries=[{tryLoc:"root"}];e.forEach(pushTryEntry,this||t);this.reset(true)}e.keys=function(t){var e=Object(t);var r=[];for(var n in e)r.push(n);r.reverse();return function next(){while(r.length){var t=r.pop();if(t in e){next.value=t;next.done=false;return next}}next.done=true;return next}};function values(t){if(t){var e=t[u];if(e)return e.call(t);if("function"===typeof t.next)return t;if(!isNaN(t.length)){var r=-1,o=function next(){while(++r<t.length)if(n.call(t,r)){next.value=t[r];next.done=false;return next}next.value=a;next.done=true;return next};return o.next=o}}return{next:doneResult}}e.values=values;function doneResult(){return{value:a,done:true}}Context.prototype={constructor:Context,reset:function(e){(this||t).prev=0;(this||t).next=0;(this||t).sent=(this||t)._sent=a;(this||t).done=false;(this||t).delegate=null;(this||t).method="next";(this||t).arg=a;(this||t).tryEntries.forEach(resetTryEntry);if(!e)for(var r in this||t)"t"===r.charAt(0)&&n.call(this||t,r)&&!isNaN(+r.slice(1))&&((this||t)[r]=a)},stop:function(){(this||t).done=true;var e=(this||t).tryEntries[0];var r=e.completion;if("throw"===r.type)throw r.arg;return(this||t).rval},dispatchException:function(e){if((this||t).done)throw e;var r=this||t;function handle(t,n){u.type="throw";u.arg=e;r.next=t;if(n){r.method="next";r.arg=a}return!!n}for(var o=(this||t).tryEntries.length-1;o>=0;--o){var i=(this||t).tryEntries[o];var u=i.completion;if("root"===i.tryLoc)return handle("end");if(i.tryLoc<=(this||t).prev){var c=n.call(i,"catchLoc");var l=n.call(i,"finallyLoc");if(c&&l){if((this||t).prev<i.catchLoc)return handle(i.catchLoc,true);if((this||t).prev<i.finallyLoc)return handle(i.finallyLoc)}else if(c){if((this||t).prev<i.catchLoc)return handle(i.catchLoc,true)}else{if(!l)throw new Error("try statement without catch or finally");if((this||t).prev<i.finallyLoc)return handle(i.finallyLoc)}}}},abrupt:function(e,r){for(var o=(this||t).tryEntries.length-1;o>=0;--o){var a=(this||t).tryEntries[o];if(a.tryLoc<=(this||t).prev&&n.call(a,"finallyLoc")&&(this||t).prev<a.finallyLoc){var i=a;break}}i&&("break"===e||"continue"===e)&&i.tryLoc<=r&&r<=i.finallyLoc&&(i=null);var u=i?i.completion:{};u.type=e;u.arg=r;if(i){(this||t).method="next";(this||t).next=i.finallyLoc;return v}return this.complete(u)},complete:function(e,r){if("throw"===e.type)throw e.arg;if("break"===e.type||"continue"===e.type)(this||t).next=e.arg;else if("return"===e.type){(this||t).rval=(this||t).arg=e.arg;(this||t).method="return";(this||t).next="end"}else"normal"===e.type&&r&&((this||t).next=r);return v},finish:function(e){for(var r=(this||t).tryEntries.length-1;r>=0;--r){var n=(this||t).tryEntries[r];if(n.finallyLoc===e){this.complete(n.completion,n.afterLoc);resetTryEntry(n);return v}}},catch:function(e){for(var r=(this||t).tryEntries.length-1;r>=0;--r){var n=(this||t).tryEntries[r];if(n.tryLoc===e){var o=n.completion;if("throw"===o.type){var a=o.arg;resetTryEntry(n)}return a}}throw new Error("illegal catch attempt")},delegateYield:function(e,r,n){(this||t).delegate={iterator:values(e),resultName:r,nextLoc:n};"next"===(this||t).method&&((this||t).arg=a);return v}};return e}(e);try{t.regeneratorRuntime=r}catch(t){"object"===typeof globalThis?globalThis.regeneratorRuntime=r:Function("r","regeneratorRuntime = r")(r)}const n=e.wrap,o=e.isGeneratorFunction,a=e.mark,i=e.awrap,u=e.AsyncIterator,c=e.async,l=e.keys,h=e.values;export{u as AsyncIterator,c as async,i as awrap,e as default,o as isGeneratorFunction,l as keys,a as mark,h as values,n as wrap};
