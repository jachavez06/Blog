(function(a){if(typeof exports=="object"&&typeof module=="object"){a(require("../../lib/codemirror"))}else{if(typeof define=="function"&&define.amd){define(["../../lib/codemirror"],a)}else{a(CodeMirror)}}})(function(a){function b(e,d,c){return/^(?:operator|sof|keyword c|case|new|[\[{}\(,;:]|=>)$/.test(d.lastType)||(d.lastType=="quasi"&&/\{\s*$/.test(e.string.slice(0,e.pos-(c||0))))}a.defineMode("javascript",function(af,ap){var m=af.indentUnit;var C=ap.statementIndent;var aG=ap.jsonld;var B=ap.json||aG;var g=ap.typescript;var aB=ap.wordCharacters||/[\w$\xa1-\uffff]/;var az=function(){function aX(aZ){return{type:aZ,style:"keyword"}}var aS=aX("keyword a"),aQ=aX("keyword b"),aP=aX("keyword c");var aR=aX("operator"),aV={type:"atom",style:"atom"};var aT={"if":aX("if"),"while":aS,"with":aS,"else":aQ,"do":aQ,"try":aQ,"finally":aQ,"return":aP,"break":aP,"continue":aP,"new":aX("new"),"delete":aP,"throw":aP,"debugger":aP,"var":aX("var"),"const":aX("var"),let:aX("var"),"function":aX("function"),"catch":aX("catch"),"for":aX("for"),"switch":aX("switch"),"case":aX("case"),"default":aX("default"),"in":aR,"typeof":aR,"instanceof":aR,"true":aV,"false":aV,"null":aV,"undefined":aV,"NaN":aV,"Infinity":aV,"this":aX("this"),"class":aX("class"),"super":aX("atom"),yield:aP,"export":aX("export"),"import":aX("import"),"extends":aP,await:aP,async:aX("async")};if(g){var aY={type:"variable",style:"variable-3"};var aU={"interface":aX("class"),"implements":aP,namespace:aP,module:aX("module"),"enum":aX("module"),type:aX("type"),"public":aX("modifier"),"private":aX("modifier"),"protected":aX("modifier"),"abstract":aX("modifier"),as:aR,string:aY,number:aY,"boolean":aY,any:aY};for(var aW in aU){aT[aW]=aU[aW]}}return aT}();var T=/[+\-*&%=<>!?|~^]/;var ay=/^@(context|id|value|language|type|container|list|set|reverse|index|base|vocab|graph)"/;function H(aS){var aQ=false,aP,aR=false;while((aP=aS.next())!=null){if(!aQ){if(aP=="/"&&!aR){return}if(aP=="["){aR=true}else{if(aR&&aP=="]"){aR=false}}}aQ=!aQ&&aP=="\\"}}var X,I;function P(aR,aQ,aP){X=aR;I=aP;return aQ}function Z(aT,aR){var aP=aT.next();if(aP=='"'||aP=="'"){aR.tokenize=W(aP);return aR.tokenize(aT,aR)}else{if(aP=="."&&aT.match(/^\d+(?:[eE][+\-]?\d+)?/)){return P("number","number")}else{if(aP=="."&&aT.match("..")){return P("spread","meta")}else{if(/[\[\]{}\(\),;\:\.]/.test(aP)){return P(aP)}else{if(aP=="="&&aT.eat(">")){return P("=>","operator")}else{if(aP=="0"&&aT.eat(/x/i)){aT.eatWhile(/[\da-f]/i);return P("number","number")}else{if(aP=="0"&&aT.eat(/o/i)){aT.eatWhile(/[0-7]/i);return P("number","number")}else{if(aP=="0"&&aT.eat(/b/i)){aT.eatWhile(/[01]/i);return P("number","number")}else{if(/\d/.test(aP)){aT.match(/^\d*(?:\.\d*)?(?:[eE][+\-]?\d+)?/);return P("number","number")}else{if(aP=="/"){if(aT.eat("*")){aR.tokenize=aF;return aF(aT,aR)}else{if(aT.eat("/")){aT.skipToEnd();return P("comment","comment")}else{if(b(aT,aR,1)){H(aT);aT.match(/^\b(([gimyu])(?![gimyu]*\2))+\b/);return P("regexp","string-2")}else{aT.eatWhile(T);return P("operator","operator",aT.current())}}}}else{if(aP=="`"){aR.tokenize=aH;return aH(aT,aR)}else{if(aP=="#"){aT.skipToEnd();return P("error","error")}else{if(T.test(aP)){aT.eatWhile(T);return P("operator","operator",aT.current())}else{if(aB.test(aP)){aT.eatWhile(aB);var aS=aT.current(),aQ=az.propertyIsEnumerable(aS)&&az[aS];return(aQ&&aR.lastType!=".")?P(aQ.type,aQ.style,aS):P("variable","variable",aS)}}}}}}}}}}}}}}}function W(aP){return function(aT,aR){var aS=false,aQ;if(aG&&aT.peek()=="@"&&aT.match(ay)){aR.tokenize=Z;return P("jsonld-keyword","meta")}while((aQ=aT.next())!=null){if(aQ==aP&&!aS){break}aS=!aS&&aQ=="\\"}if(!aS){aR.tokenize=Z}return P("string","string")}}function aF(aS,aR){var aP=false,aQ;while(aQ=aS.next()){if(aQ=="/"&&aP){aR.tokenize=Z;break}aP=(aQ=="*")}return P("comment","comment")}function aH(aS,aQ){var aR=false,aP;while((aP=aS.next())!=null){if(!aR&&(aP=="`"||aP=="$"&&aS.eat("{"))){aQ.tokenize=Z;break}aR=!aR&&aP=="\\"}return P("quasi","string-2",aS.current())}var n="([{}])";function aD(aX,aR){if(aR.fatArrowAt){aR.fatArrowAt=null}var aW=aX.string.indexOf("=>",aX.start);if(aW<0){return}if(g){var aT=/:\s*(?:\w+(?:<[^>]*>|\[\])?|\{[^}]*\})\s*$/.exec(aX.string.slice(aX.start,aW));if(aT){aW=aT.index}}var aU=0,aS=false;for(var aV=aW-1;aV>=0;--aV){var aP=aX.string.charAt(aV);var aQ=n.indexOf(aP);if(aQ>=0&&aQ<3){if(!aU){++aV;break}if(--aU==0){if(aP=="("){aS=true}break}}else{if(aQ>=3&&aQ<6){++aU}else{if(aB.test(aP)){aS=true}else{if(/["'\/]/.test(aP)){return}else{if(aS&&!aU){++aV;break}}}}}}if(aS&&!aU){aR.fatArrowAt=aV}}var c={atom:true,number:true,variable:true,string:true,regexp:true,"this":true,"jsonld-keyword":true};function N(aU,aQ,aP,aT,aR,aS){this.indented=aU;this.column=aQ;this.type=aP;this.prev=aR;this.info=aS;if(aT!=null){this.align=aT}}function u(aS,aR){for(var aQ=aS.localVars;aQ;aQ=aQ.next){if(aQ.name==aR){return true}}for(var aP=aS.context;aP;aP=aP.prev){for(var aQ=aP.vars;aQ;aQ=aQ.next){if(aQ.name==aR){return true}}}}function f(aT,aQ,aP,aS,aU){var aV=aT.cc;G.state=aT;G.stream=aU;G.marked=null,G.cc=aV;G.style=aQ;if(!aT.lexical.hasOwnProperty("align")){aT.lexical.align=true}while(true){var aR=aV.length?aV.pop():B?au:aM;if(aR(aP,aS)){while(aV.length&&aV[aV.length-1].lex){aV.pop()()}if(G.marked){return G.marked}if(aP=="variable"&&u(aT,aS)){return"variable-2"}return aQ}}}var G={state:null,column:null,marked:null,cc:null};function ag(){for(var aP=arguments.length-1;aP>=0;aP--){G.cc.push(arguments[aP])}}function al(){ag.apply(null,arguments);return true}function aC(aQ){function aP(aT){for(var aS=aT;aS;aS=aS.next){if(aS.name==aQ){return true}}return false}var aR=G.state;G.marked="def";if(aR.context){if(aP(aR.localVars)){return}aR.localVars={name:aQ,next:aR.localVars}}else{if(aP(aR.globalVars)){return}if(ap.globalVars){aR.globalVars={name:aQ,next:aR.globalVars}}}}var s={name:"this",next:{name:"arguments"}};function y(){G.state.context={prev:G.state.context,vars:G.state.localVars};G.state.localVars=s}function z(){G.state.localVars=G.state.context.vars;G.state.context=G.state.context.prev}function aK(aQ,aR){var aP=function(){var aU=G.state,aS=aU.indented;if(aU.lexical.type=="stat"){aS=aU.lexical.indented}else{for(var aT=aU.lexical;aT&&aT.type==")"&&aT.align;aT=aT.prev){aS=aT.indented}}aU.lexical=new N(aS,G.stream.column(),aQ,null,aU.lexical,aR)};aP.lex=true;return aP}function h(){var aP=G.state;if(aP.lexical.prev){if(aP.lexical.type==")"){aP.indented=aP.lexical.indented}aP.lexical=aP.lexical.prev}}h.lex=true;function t(aP){function aQ(aR){if(aR==aP){return al()}else{if(aP==";"){return ag()}else{return al(aQ)}}}return aQ}function aM(aP,aQ){if(aP=="var"){return al(aK("vardef",aQ.length),d,t(";"),h)}if(aP=="keyword a"){return al(aK("form"),av,aM,h)}if(aP=="keyword b"){return al(aK("form"),aM,h)}if(aP=="{"){return al(aK("}"),A,h)}if(aP==";"){return al()}if(aP=="if"){if(G.state.lexical.info=="else"&&G.state.cc[G.state.cc.length-1]==h){G.state.cc.pop()()}return al(aK("form"),av,aM,h,e)}if(aP=="function"){return al(Q)}if(aP=="for"){return al(aK("form"),w,aM,h)}if(aP=="variable"){return al(aK("stat"),aN)}if(aP=="switch"){return al(aK("form"),av,aK("}","switch"),t("{"),A,h,h)}if(aP=="case"){return al(au,t(":"))}if(aP=="default"){return al(t(":"))}if(aP=="catch"){return al(aK("form"),y,t("("),ak,t(")"),aM,h,z)}if(aP=="class"){return al(aK("form"),ab,h)}if(aP=="export"){return al(aK("stat"),aL,h)}if(aP=="import"){return al(aK("stat"),am,h)}if(aP=="module"){return al(aK("form"),i,aK("}"),t("{"),A,h,h)}if(aP=="type"){return al(j,t("operator"),j,t(";"))}if(aP=="async"){return al(aM)}return ag(aK("stat"),au,t(";"),h)}function au(aP){return ae(aP,false)}function aJ(aP){return ae(aP,true)}function av(aP){if(aP!="("){return ag()}return al(aK(")"),au,t(")"),h)}function ae(aQ,aS){if(G.state.fatArrowAt==G.stream.start){var aP=aS?R:ac;if(aQ=="("){return al(y,aK(")"),aA(i,")"),h,t("=>"),aP,z)}else{if(aQ=="variable"){return ag(y,i,t("=>"),aP,z)}}}var aR=aS?k:ah;if(c.hasOwnProperty(aQ)){return al(aR)}if(aQ=="function"){return al(Q,aR)}if(aQ=="class"){return al(aK("form"),L,h)}if(aQ=="keyword c"||aQ=="async"){return al(aS?aq:ao)}if(aQ=="("){return al(aK(")"),ao,t(")"),h,aR)}if(aQ=="operator"||aQ=="spread"){return al(aS?aJ:au)}if(aQ=="["){return al(aK("]"),o,h,aR)}if(aQ=="{"){return aE(v,"}",null,aR)}if(aQ=="quasi"){return ag(U,aR)}if(aQ=="new"){return al(K(aS))}return al()}function ao(aP){if(aP.match(/[;\}\)\],]/)){return ag()}return ag(au)}function aq(aP){if(aP.match(/[;\}\)\],]/)){return ag()}return ag(aJ)}function ah(aP,aQ){if(aP==","){return al(au)}return k(aP,aQ,false)}function k(aP,aR,aT){var aQ=aT==false?ah:k;var aS=aT==false?au:aJ;if(aP=="=>"){return al(y,aT?R:ac,z)}if(aP=="operator"){if(/\+\+|--/.test(aR)){return al(aQ)}if(aR=="?"){return al(au,t(":"),aS)}return al(aS)}if(aP=="quasi"){return ag(U,aQ)}if(aP==";"){return}if(aP=="("){return aE(aJ,")","call",aQ)}if(aP=="."){return al(ar,aQ)}if(aP=="["){return al(aK("]"),ao,t("]"),h,aQ)}}function U(aP,aQ){if(aP!="quasi"){return ag()}if(aQ.slice(aQ.length-2)!="${"){return al(U)}return al(au,r)}function r(aP){if(aP=="}"){G.marked="string-2";G.state.tokenize=aH;return al(U)}}function ac(aP){aD(G.stream,G.state);return ag(aP=="{"?aM:au)}function R(aP){aD(G.stream,G.state);return ag(aP=="{"?aM:aJ)}function K(aP){return function(aQ){if(aQ=="."){return al(aP?p:aa)}else{return ag(aP?aJ:au)}}}function aa(aP,aQ){if(aQ=="target"){G.marked="keyword";return al(ah)}}function p(aP,aQ){if(aQ=="target"){G.marked="keyword";return al(k)}}function aN(aP){if(aP==":"){return al(h,aM)}return ag(ah,t(";"),h)}function ar(aP){if(aP=="variable"){G.marked="property";return al()}}function v(aP,aQ){if(aP=="async"){G.marked="property";return al(v)}else{if(aP=="variable"||G.style=="keyword"){G.marked="property";if(aQ=="get"||aQ=="set"){return al(M)}return al(O)}else{if(aP=="number"||aP=="string"){G.marked=aG?"property":(G.style+" property");return al(O)}else{if(aP=="jsonld-keyword"){return al(O)}else{if(aP=="modifier"){return al(v)}else{if(aP=="["){return al(au,t("]"),O)}else{if(aP=="spread"){return al(au)}else{if(aP==":"){return ag(O)}}}}}}}}}function M(aP){if(aP!="variable"){return ag(O)}G.marked="property";return al(Q)}function O(aP){if(aP==":"){return al(aJ)}if(aP=="("){return ag(Q)}}function aA(aR,aP){function aQ(aT,aU){if(aT==","){var aS=G.state.lexical;if(aS.info=="call"){aS.pos=(aS.pos||0)+1}return al(function(aV,aW){if(aV==aP||aW==aP){return ag()}return ag(aR)},aQ)}if(aT==aP||aU==aP){return al()}return al(t(aP))}return function(aS,aT){if(aS==aP||aT==aP){return al()}return ag(aR,aQ)}}function aE(aS,aP,aR){for(var aQ=3;aQ<arguments.length;aQ++){G.cc.push(arguments[aQ])}return al(aK(aP,aR),aA(aS,aP),h)}function A(aP){if(aP=="}"){return al()}return ag(aM,A)}function Y(aP,aQ){if(g){if(aP==":"){return al(j)}if(aQ=="?"){return al(Y)}}}function j(aP){if(aP=="variable"){G.marked="variable-3";return al(J)}if(aP=="{"){return al(aA(at,"}"))}if(aP=="("){return al(aA(ai,")"),V)}}function V(aP){if(aP=="=>"){return al(j)}}function at(aP){if(aP=="variable"||G.style=="keyword"){G.marked="property";return al(at)}else{if(aP==":"){return al(j)}}}function ai(aP){if(aP=="variable"){return al(ai)}else{if(aP==":"){return al(j)}}}function J(aP,aQ){if(aQ=="<"){return al(aA(j,">"),J)}if(aP=="["){return al(t("]"),J)}}function d(){return ag(i,Y,aj,ad)}function i(aP,aQ){if(aP=="modifier"){return al(i)}if(aP=="variable"){aC(aQ);return al()}if(aP=="spread"){return al(i)}if(aP=="["){return aE(i,"]")}if(aP=="{"){return aE(aI,"}")}}function aI(aP,aQ){if(aP=="variable"&&!G.stream.match(/^\s*:/,false)){aC(aQ);return al(aj)}if(aP=="variable"){G.marked="property"}if(aP=="spread"){return al(i)}if(aP=="}"){return ag()}return al(t(":"),i,aj)}function aj(aP,aQ){if(aQ=="="){return al(aJ)}}function ad(aP){if(aP==","){return al(d)}}function e(aP,aQ){if(aP=="keyword b"&&aQ=="else"){return al(aK("form","else"),aM,h)}}function w(aP){if(aP=="("){return al(aK(")"),F,t(")"),h)}}function F(aP){if(aP=="var"){return al(d,t(";"),E)}if(aP==";"){return al(E)}if(aP=="variable"){return al(x)}return ag(au,t(";"),E)}function x(aP,aQ){if(aQ=="in"||aQ=="of"){G.marked="keyword";return al(au)}return al(ah,E)}function E(aP,aQ){if(aP==";"){return al(D)}if(aQ=="in"||aQ=="of"){G.marked="keyword";return al(au)}return ag(au,t(";"),D)}function D(aP){if(aP!=")"){al(au)}}function Q(aP,aQ){if(aQ=="*"){G.marked="keyword";return al(Q)}if(aP=="variable"){aC(aQ);return al(Q)}if(aP=="("){return al(y,aK(")"),aA(ak,")"),h,Y,aM,z)}}function ak(aP){if(aP=="spread"){return al(ak)}return ag(i,Y,aj)}function L(aP,aQ){if(aP=="variable"){return ab(aP,aQ)}return S(aP,aQ)}function ab(aP,aQ){if(aP=="variable"){aC(aQ);return al(S)}}function S(aP,aQ){if(aQ=="extends"||aQ=="implements"){return al(g?j:au,S)}if(aP=="{"){return al(aK("}"),q,h)}}function q(aP,aQ){if(aP=="variable"||G.style=="keyword"){if((aQ=="static"||aQ=="get"||aQ=="set"||(g&&(aQ=="public"||aQ=="private"||aQ=="protected"||aQ=="readonly"||aQ=="abstract")))&&G.stream.match(/^\s+[\w$\xa1-\uffff]/,false)){G.marked="keyword";return al(q)}G.marked="property";return al(g?aO:Q,q)}if(aQ=="*"){G.marked="keyword";return al(q)}if(aP==";"){return al(q)}if(aP=="}"){return al()}}function aO(aP,aQ){if(aQ=="?"){return al(aO)}if(aP==":"){return al(j,aj)}return ag(Q)}function aL(aP,aQ){if(aQ=="*"){G.marked="keyword";return al(an,t(";"))}if(aQ=="default"){G.marked="keyword";return al(au,t(";"))}return ag(aM)}function am(aP){if(aP=="string"){return al()}return ag(ax,an)}function ax(aP,aQ){if(aP=="{"){return aE(ax,"}")}if(aP=="variable"){aC(aQ)}if(aQ=="*"){G.marked="keyword"}return al(l)}function l(aP,aQ){if(aQ=="as"){G.marked="keyword";return al(ax)}}function an(aP,aQ){if(aQ=="from"){G.marked="keyword";return al(au)}}function o(aP){if(aP=="]"){return al()}return ag(aA(aJ,"]"))}function aw(aQ,aP){return aQ.lastType=="operator"||aQ.lastType==","||T.test(aP.charAt(0))||/[,.]/.test(aP.charAt(0))}return{startState:function(aQ){var aP={tokenize:Z,lastType:"sof",cc:[],lexical:new N((aQ||0)-m,0,"block",false),localVars:ap.localVars,context:ap.localVars&&{vars:ap.localVars},indented:aQ||0};if(ap.globalVars&&typeof ap.globalVars=="object"){aP.globalVars=ap.globalVars}return aP},token:function(aR,aQ){if(aR.sol()){if(!aQ.lexical.hasOwnProperty("align")){aQ.lexical.align=false}aQ.indented=aR.indentation();aD(aR,aQ)}if(aQ.tokenize!=aF&&aR.eatSpace()){return null}var aP=aQ.tokenize(aR,aQ);if(X=="comment"){return aP}aQ.lastType=X=="operator"&&(I=="++"||I=="--")?"incdec":X;return f(aQ,aP,X,I,aR)},indent:function(aP,aS){if(aP.tokenize==aF){return a.Pass}if(aP.tokenize!=Z){return 0}var aW=aS&&aS.charAt(0),aX=aP.lexical,aV;if(!/^\s*else\b/.test(aS)){for(var aR=aP.cc.length-1;aR>=0;--aR){var aT=aP.cc[aR];if(aT==h){aX=aX.prev}else{if(aT!=e){break}}}}while((aX.type=="stat"||aX.type=="form")&&(aW=="}"||((aV=aP.cc[aP.cc.length-1])&&(aV==ah||aV==k)&&!/^[,\.=+\-*:?[\(]/.test(aS)))){aX=aX.prev}if(C&&aX.type==")"&&aX.prev.type=="stat"){aX=aX.prev}var aU=aX.type,aQ=aW==aU;if(aU=="vardef"){return aX.indented+(aP.lastType=="operator"||aP.lastType==","?aX.info+1:0)}else{if(aU=="form"&&aW=="{"){return aX.indented}else{if(aU=="form"){return aX.indented+m}else{if(aU=="stat"){return aX.indented+(aw(aP,aS)?C||m:0)}else{if(aX.info=="switch"&&!aQ&&ap.doubleIndentSwitch!=false){return aX.indented+(/^(?:case|default)\b/.test(aS)?m:2*m)}else{if(aX.align){return aX.column+(aQ?0:1)}else{return aX.indented+(aQ?0:m)}}}}}}},electricInput:/^\s*(?:case .*?:|default:|\{|\})$/,blockCommentStart:B?null:"/*",blockCommentEnd:B?null:"*/",lineComment:B?null:"//",fold:"brace",closeBrackets:"()[]{}''\"\"``",helperType:B?"json":"javascript",jsonldMode:aG,jsonMode:B,expressionAllowed:b,skipExpression:function(aP){var aQ=aP.cc[aP.cc.length-1];if(aQ==au||aQ==aJ){aP.cc.pop()}}}});a.registerHelper("wordChars","javascript",/[\w$]/);a.defineMIME("text/javascript","javascript");a.defineMIME("text/ecmascript","javascript");a.defineMIME("application/javascript","javascript");a.defineMIME("application/x-javascript","javascript");a.defineMIME("application/ecmascript","javascript");a.defineMIME("application/json",{name:"javascript",json:true});a.defineMIME("application/x-json",{name:"javascript",json:true});a.defineMIME("application/ld+json",{name:"javascript",jsonld:true});a.defineMIME("text/typescript",{name:"javascript",typescript:true});a.defineMIME("application/typescript",{name:"javascript",typescript:true})});