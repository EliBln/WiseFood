// tesseract.js@5.1.1 downloaded from https://ga.jspm.io/npm:tesseract.js@5.1.1/src/index.js

import*as e from"regenerator-runtime/runtime";import*as t from"is-electron";import o from"#src/worker/node/index.js";var a={};a=(e,t)=>`${e}-${t}-${Math.random().toString(16).slice(3,8)}`;var n=a;var r={};const s=n;let c=0;r=({id:e,action:t,payload:o={}})=>{let a=e;if(typeof a==="undefined"){a=s("Job",c);c+=1}return{id:a,action:t,payload:o}};var i=r;var l=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var d={};let g=false;d.logging=g;d.setLogging=e=>{g=e};d.log=(...e)=>g?console.log.apply((void 0,l),e):null;var u=typeof globalThis!=="undefined"?globalThis:typeof self!=="undefined"?self:global;var p={};const h=i;const{log:f}=d;const y=n;let m=0;p=()=>{const e=y("Scheduler",m);const t={};const o={};let a=[];m+=1;const getQueueLen=()=>a.length;const getNumWorkers=()=>Object.keys(t).length;const dequeue=()=>{if(a.length!==0){const e=Object.keys(t);for(let n=0;n<e.length;n+=1)if(typeof o[e[n]]==="undefined"){a[0](t[e[n]]);break}}};const queue=(t,n)=>new Promise(((r,s)=>{const c=h({action:t,payload:n});a.push((async e=>{a.shift();o[e.id]=c;try{r(await e[t].apply((void 0,u),[...n,c.id]))}catch(e){s(e)}finally{delete o[e.id];dequeue()}}));f(`[${e}]: Add ${c.id} to JobQueue`);f(`[${e}]: JobQueue length=${a.length}`);dequeue()}));const addWorker=o=>{t[o.id]=o;f(`[${e}]: Add ${o.id}`);f(`[${e}]: Number of workers=${getNumWorkers()}`);dequeue();return o.id};const addJob=async(t,...o)=>{if(getNumWorkers()===0)throw Error(`[${e}]: You need to have at least one worker before adding jobs`);return queue(t,o)};const terminate=async()=>{Object.keys(t).forEach((async e=>{await t[e].terminate()}));a=[]};return{addWorker:addWorker,addJob:addJob,terminate:terminate,getQueueLen:getQueueLen,getNumWorkers:getNumWorkers}};var L=p;var S=t;try{"default"in t&&(S=t.default)}catch(e){}var E={};const T=S;E=e=>{const t={};typeof WorkerGlobalScope!=="undefined"?t.type="webworker":T()?t.type="electron":typeof document==="object"?t.type="browser":typeof process==="object"&&true&&(t.type="node");return typeof e==="undefined"?t:t[e]};var b=E;var A={};const w=b("type")==="browser";const k=w?e=>new URL(e,window.location.href).href:e=>e;A=e=>{const t={...e};["corePath","workerPath","langPath"].forEach((o=>{e[o]&&(t[o]=k(t[o]))}));return t};var v=A;var O={};O=e=>{const t=[];const o=[];const a=[];const n=[];const r=[];e.blocks&&e.blocks.forEach((s=>{s.paragraphs.forEach((t=>{t.lines.forEach((o=>{o.words.forEach((a=>{a.symbols.forEach((n=>{r.push({...n,page:e,block:s,paragraph:t,line:o,word:a})}));n.push({...a,page:e,block:s,paragraph:t,line:o})}));a.push({...o,page:e,block:s,paragraph:t})}));o.push({...t,page:e,block:s})}));t.push({...s,page:e})}));return{...e,blocks:t,paragraphs:o,lines:a,words:n,symbols:r}};var R=O;var _={};_={TESSERACT_ONLY:0,LSTM_ONLY:1,TESSERACT_LSTM_COMBINED:2,DEFAULT:3};var N=_;var P={};const I=v;const M=R;const D=i;const{log:C}=d;const U=n;const F=N;const{defaultOptions:$,spawnWorker:z,terminateWorker:j,onMessage:G,loadImage:K,send:Y}=o;let W=0;P=async(e="eng",t=F.LSTM_ONLY,o={},a={})=>{const n=U("Worker",W);const{logger:r,errorHandler:s,...c}=I({...$,...o});const i={};const l={};const d=typeof e==="string"?e.split("+"):e;let g=t;let u=a;const p=[F.DEFAULT,F.LSTM_ONLY].includes(t)&&!c.legacyCore;let h;let f;const y=new Promise(((e,t)=>{f=e;h=t}));const workerError=e=>{h(e.message)};let m=z(c);m.onerror=workerError;W+=1;const setResolve=(e,t)=>{i[e]=t};const setReject=(e,t)=>{l[e]=t};const startJob=({id:e,action:t,payload:o})=>new Promise(((a,r)=>{C(`[${n}]: Start ${e}, action=${t}`);const s=`${t}-${e}`;setResolve(s,a);setReject(s,r);Y(m,{workerId:n,jobId:e,action:t,payload:o})}));const load=()=>console.warn("`load` is depreciated and should be removed from code (workers now come pre-loaded)");const loadInternal=e=>startJob(D({id:e,action:"load",payload:{options:{lstmOnly:p,corePath:c.corePath,logging:c.logging}}}));const writeText=(e,t,o)=>startJob(D({id:o,action:"FS",payload:{method:"writeFile",args:[e,t]}}));const readText=(e,t)=>startJob(D({id:t,action:"FS",payload:{method:"readFile",args:[e,{encoding:"utf8"}]}}));const removeFile=(e,t)=>startJob(D({id:t,action:"FS",payload:{method:"unlink",args:[e]}}));const FS=(e,t,o)=>startJob(D({id:o,action:"FS",payload:{method:e,args:t}}));const loadLanguage=()=>console.warn("`loadLanguage` is depreciated and should be removed from code (workers now come with language pre-loaded)");const loadLanguageInternal=(e,t)=>startJob(D({id:t,action:"loadLanguage",payload:{langs:e,options:{langPath:c.langPath,dataPath:c.dataPath,cachePath:c.cachePath,cacheMethod:c.cacheMethod,gzip:c.gzip,lstmOnly:[F.DEFAULT,F.LSTM_ONLY].includes(g)&&!c.legacyLang}}}));const initialize=()=>console.warn("`initialize` is depreciated and should be removed from code (workers now come pre-initialized)");const initializeInternal=(e,t,o,a)=>startJob(D({id:a,action:"initialize",payload:{langs:e,oem:t,config:o}}));const reinitialize=(e="eng",t,o,a)=>{if(p&&[F.TESSERACT_ONLY,F.TESSERACT_LSTM_COMBINED].includes(t))throw Error("Legacy model requested but code missing.");const n=t||g;g=n;const r=o||u;u=r;const s=typeof e==="string"?e.split("+"):e;const c=s.filter((e=>!d.includes(e)));d.push(...c);return c.length>0?loadLanguageInternal(c,a).then((()=>initializeInternal(e,n,r,a))):initializeInternal(e,n,r,a)};const setParameters=(e={},t)=>startJob(D({id:t,action:"setParameters",payload:{params:e}}));const recognize=async(e,t={},o={blocks:true,text:true,hocr:true,tsv:true},a)=>startJob(D({id:a,action:"recognize",payload:{image:await K(e),options:t,output:o}}));const getPDF=(e="Tesseract OCR Result",t=false,o)=>{console.log("`getPDF` function is depreciated. `recognize` option `savePDF` should be used instead.");return startJob(D({id:o,action:"getPDF",payload:{title:e,textonly:t}}))};const detect=async(e,t)=>{if(p)throw Error("`worker.detect` requires Legacy model, which was not loaded.");return startJob(D({id:t,action:"detect",payload:{image:await K(e)}}))};const terminate=async()=>{if(m!==null){j(m);m=null}return Promise.resolve()};G(m,(({workerId:e,jobId:t,status:o,action:a,data:n})=>{const c=`${a}-${t}`;if(o==="resolve"){C(`[${e}]: Complete ${t}`);let o=n;a==="recognize"?o=M(n):a==="getPDF"&&(o=Array.from({...n,length:Object.keys(n).length}));i[c]({jobId:t,data:o})}else if(o==="reject"){l[c](n);a==="load"&&h(n);if(!s)throw Error(n);s(n)}else o==="progress"&&r({...n,userJobId:t})}));const L={id:n,worker:m,setResolve:setResolve,setReject:setReject,load:load,writeText:writeText,readText:readText,removeFile:removeFile,FS:FS,loadLanguage:loadLanguage,initialize:initialize,reinitialize:reinitialize,setParameters:setParameters,recognize:recognize,getPDF:getPDF,detect:detect,terminate:terminate};loadInternal().then((()=>loadLanguageInternal(e))).then((()=>initializeInternal(e,t,a))).then((()=>f(L))).catch((()=>{}));return y};var B=P;var H={};const J=B;const recognize=async(e,t,o)=>{const a=await J(t,1,o);return a.recognize(e).finally((async()=>{await a.terminate()}))};const detect=async(e,t)=>{const o=await J("osd",0,t);return o.detect(e).finally((async()=>{await o.terminate()}))};H={recognize:recognize,detect:detect};var x=H;var V={};
/**
 * @typedef {object} Languages
 * @property {string} AFR Afrikaans
 * @property {string} AMH Amharic
 * @property {string} ARA Arabic
 * @property {string} ASM Assamese
 * @property {string} AZE Azerbaijani
 * @property {string} AZE_CYRL Azerbaijani - Cyrillic
 * @property {string} BEL Belarusian
 * @property {string} BEN Bengali
 * @property {string} BOD Tibetan
 * @property {string} BOS Bosnian
 * @property {string} BUL Bulgarian
 * @property {string} CAT Catalan; Valencian
 * @property {string} CEB Cebuano
 * @property {string} CES Czech
 * @property {string} CHI_SIM Chinese - Simplified
 * @property {string} CHI_TRA Chinese - Traditional
 * @property {string} CHR Cherokee
 * @property {string} CYM Welsh
 * @property {string} DAN Danish
 * @property {string} DEU German
 * @property {string} DZO Dzongkha
 * @property {string} ELL Greek, Modern (1453-)
 * @property {string} ENG English
 * @property {string} ENM English, Middle (1100-1500)
 * @property {string} EPO Esperanto
 * @property {string} EST Estonian
 * @property {string} EUS Basque
 * @property {string} FAS Persian
 * @property {string} FIN Finnish
 * @property {string} FRA French
 * @property {string} FRK German Fraktur
 * @property {string} FRM French, Middle (ca. 1400-1600)
 * @property {string} GLE Irish
 * @property {string} GLG Galician
 * @property {string} GRC Greek, Ancient (-1453)
 * @property {string} GUJ Gujarati
 * @property {string} HAT Haitian; Haitian Creole
 * @property {string} HEB Hebrew
 * @property {string} HIN Hindi
 * @property {string} HRV Croatian
 * @property {string} HUN Hungarian
 * @property {string} IKU Inuktitut
 * @property {string} IND Indonesian
 * @property {string} ISL Icelandic
 * @property {string} ITA Italian
 * @property {string} ITA_OLD Italian - Old
 * @property {string} JAV Javanese
 * @property {string} JPN Japanese
 * @property {string} KAN Kannada
 * @property {string} KAT Georgian
 * @property {string} KAT_OLD Georgian - Old
 * @property {string} KAZ Kazakh
 * @property {string} KHM Central Khmer
 * @property {string} KIR Kirghiz; Kyrgyz
 * @property {string} KOR Korean
 * @property {string} KUR Kurdish
 * @property {string} LAO Lao
 * @property {string} LAT Latin
 * @property {string} LAV Latvian
 * @property {string} LIT Lithuanian
 * @property {string} MAL Malayalam
 * @property {string} MAR Marathi
 * @property {string} MKD Macedonian
 * @property {string} MLT Maltese
 * @property {string} MSA Malay
 * @property {string} MYA Burmese
 * @property {string} NEP Nepali
 * @property {string} NLD Dutch; Flemish
 * @property {string} NOR Norwegian
 * @property {string} ORI Oriya
 * @property {string} PAN Panjabi; Punjabi
 * @property {string} POL Polish
 * @property {string} POR Portuguese
 * @property {string} PUS Pushto; Pashto
 * @property {string} RON Romanian; Moldavian; Moldovan
 * @property {string} RUS Russian
 * @property {string} SAN Sanskrit
 * @property {string} SIN Sinhala; Sinhalese
 * @property {string} SLK Slovak
 * @property {string} SLV Slovenian
 * @property {string} SPA Spanish; Castilian
 * @property {string} SPA_OLD Spanish; Castilian - Old
 * @property {string} SQI Albanian
 * @property {string} SRP Serbian
 * @property {string} SRP_LATN Serbian - Latin
 * @property {string} SWA Swahili
 * @property {string} SWE Swedish
 * @property {string} SYR Syriac
 * @property {string} TAM Tamil
 * @property {string} TEL Telugu
 * @property {string} TGK Tajik
 * @property {string} TGL Tagalog
 * @property {string} THA Thai
 * @property {string} TIR Tigrinya
 * @property {string} TUR Turkish
 * @property {string} UIG Uighur; Uyghur
 * @property {string} UKR Ukrainian
 * @property {string} URD Urdu
 * @property {string} UZB Uzbek
 * @property {string} UZB_CYRL Uzbek - Cyrillic
 * @property {string} VIE Vietnamese
 * @property {string} YID Yiddish
 */
/**
  * @type {Languages}
  */V={AFR:"afr",AMH:"amh",ARA:"ara",ASM:"asm",AZE:"aze",AZE_CYRL:"aze_cyrl",BEL:"bel",BEN:"ben",BOD:"bod",BOS:"bos",BUL:"bul",CAT:"cat",CEB:"ceb",CES:"ces",CHI_SIM:"chi_sim",CHI_TRA:"chi_tra",CHR:"chr",CYM:"cym",DAN:"dan",DEU:"deu",DZO:"dzo",ELL:"ell",ENG:"eng",ENM:"enm",EPO:"epo",EST:"est",EUS:"eus",FAS:"fas",FIN:"fin",FRA:"fra",FRK:"frk",FRM:"frm",GLE:"gle",GLG:"glg",GRC:"grc",GUJ:"guj",HAT:"hat",HEB:"heb",HIN:"hin",HRV:"hrv",HUN:"hun",IKU:"iku",IND:"ind",ISL:"isl",ITA:"ita",ITA_OLD:"ita_old",JAV:"jav",JPN:"jpn",KAN:"kan",KAT:"kat",KAT_OLD:"kat_old",KAZ:"kaz",KHM:"khm",KIR:"kir",KOR:"kor",KUR:"kur",LAO:"lao",LAT:"lat",LAV:"lav",LIT:"lit",MAL:"mal",MAR:"mar",MKD:"mkd",MLT:"mlt",MSA:"msa",MYA:"mya",NEP:"nep",NLD:"nld",NOR:"nor",ORI:"ori",PAN:"pan",POL:"pol",POR:"por",PUS:"pus",RON:"ron",RUS:"rus",SAN:"san",SIN:"sin",SLK:"slk",SLV:"slv",SPA:"spa",SPA_OLD:"spa_old",SQI:"sqi",SRP:"srp",SRP_LATN:"srp_latn",SWA:"swa",SWE:"swe",SYR:"syr",TAM:"tam",TEL:"tel",TGK:"tgk",TGL:"tgl",THA:"tha",TIR:"tir",TUR:"tur",UIG:"uig",UKR:"ukr",URD:"urd",UZB:"uzb",UZB_CYRL:"uzb_cyrl",VIE:"vie",YID:"yid"};var Z=V;var Q={};Q={OSD_ONLY:"0",AUTO_OSD:"1",AUTO_ONLY:"2",AUTO:"3",SINGLE_COLUMN:"4",SINGLE_BLOCK_VERT_TEXT:"5",SINGLE_BLOCK:"6",SINGLE_LINE:"7",SINGLE_WORD:"8",CIRCLE_WORD:"9",SINGLE_CHAR:"10",SPARSE_TEXT:"11",SPARSE_TEXT_OSD:"12",RAW_LINE:"13"};var q=Q;var X=e;try{"default"in e&&(X=e.default)}catch(e){}var ee={};X;const te=L;const oe=B;const ae=x;const ne=Z;const re=N;const se=q;const{setLogging:ce}=d;ee={languages:ne,OEM:re,PSM:se,createScheduler:te,createWorker:oe,setLogging:ce,...ae};var ie=ee;const le=ee.languages,de=ee.OEM,ge=ee.PSM,ue=ee.createScheduler,pe=ee.createWorker,he=ee.setLogging;export{de as OEM,ge as PSM,ue as createScheduler,pe as createWorker,ie as default,le as languages,he as setLogging};

