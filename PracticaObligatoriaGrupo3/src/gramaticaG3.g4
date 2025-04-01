grammar gramaticaG3;

axioma: (ID | CONSTINT | CONSTREAL | CONSTLIT | COMMENT | WS)+;

ID: [a-zA-Z]([a-zA-Z0-9_])*;
CONSTINT: ('+'|'-'| )[0-9]+;
CONSTREAL: CONSTINT(('.'[0-9]+)|(('e'|'E')CONSTINT)|('.'[0-9]+)(('e'|'E')CONSTINT));
CONSTLIT: '\''(~'\''|'\\\'')* '\'';
COMMENT: '{'~[{}\n]*'}' | '{*' .*? '*}';
WS : [ \t\r\n]+->skip;

prg : 'program' ID ';' blq '.'{} | 'unit' ID ';' dcllist '.' ;
blq : dcllist 'begin' sentlist 'end';

dcllist : dcl dcllist | ;

sentlist : sent sentlistP;
sentlistP : sent sentlistP | ;

dcl : defcte | defvar | defproc | deffun;
defcte : 'const' ctelist;
ctelist : ID '=' simpvalue ';' ctelistP;
ctelistP : ID '=' simpvalue ';' ctelistP | ;

simpvalue : CONSTINT{$text = $CONSTINT.text;} | CONSTREAL{$text = $CONSTREAL.text;} | CONSTLIT{$text = $CONSTLIT.text;};
defvar : 'var' defvarlist ';';

defvarlist : varlist ':' tbas defvarlistP;
defvarlistP : ';' varlist ':' tbas defvarlistP | ;

varlist : ID | ID ',' varlist;
defproc : 'procedure' ID formal_paramlist ';' blq ';';
deffun : 'function' ID formal_paramlist ':' tbas ';' blq ';';

formal_paramlist : '(' formal_param ')' | ;
formal_param : varlist ':' tbas | varlist ':' tbas ';' formal_param;

tbas : 'INTEGER'{$text = 'int';} | 'REAL'{$text = 'float';};

sent : asig ';' | proc_call ';'
       |'if' expcond 'then' blq 'else' blq
       |'while' expcond 'do' blq
       | 'repeat' blq 'until' expcond ';'
       | 'for' ID ':=' exp inc exp 'do' blq;

asig : ID ':=' exp;

exp : factor expP;
expP : op exp expP | ;

op : oparit;
oparit : '+'{$text = '+'; } | '-' {$text = '-';}| '*' {$text = '*'}| 'div' {$text = '/';}| 'mod'{$text = '%';};

factor : simpvalue | '(' exp ')' | ID subparamlist;
subparamlist : '(' explist ')' | ;
explist : exp | exp ',' explist;

proc_call : ID subparamlist;

inc     : 'to' | 'downto' ;

expcond : factorcond expcondP;
expcondP: oplog factorcond expcondP | ;

oplog   : 'or' {$text = '||';}| 'and'{$text = '&&';} ;

factorcond : exp opcomp exp
           | '(' exp ')'
           | 'not' factorcond
           ;

opcomp  : '<' {$text = '<';}| '>' {$text = '>';}| '<='{$text = '<=';} | '>=' {$text = '>=';}| '='{$text = '==';} ;
