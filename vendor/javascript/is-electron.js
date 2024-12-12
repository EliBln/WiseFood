// is-electron@2.2.2 downloaded from https://ga.jspm.io/npm:is-electron@2.2.2/index.js

import e from"process";var o={};var r=e;function isElectron(){return"undefined"!==typeof window&&"object"===typeof window.process&&"renderer"===window.process.type||(!("undefined"===typeof r||"object"!==typeof r.versions||!r.versions.electron)||"object"===typeof navigator&&"string"===typeof navigator.userAgent&&navigator.userAgent.indexOf("Electron")>=0)}o=isElectron;var t=o;export{t as default};

