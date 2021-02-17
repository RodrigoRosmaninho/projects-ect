grammar config;

@header {
package config;

import lib.*;
}

/*
-----------------------------
        PARSER RULES
-----------------------------
*/

// Starting rule
program:  header? declare? calls EOF;

declare: 'define' ':' literal+ 'end';
literal: STRING ':' type;
header: HeaderBlock;
calls: 'calls' ':' call+ 'end';
call: 'call' STRING ':' init? apply? critical? returnType? vars? methods 'end';

apply: 'apply';
critical: 'critical';
init: 'init';

returnType: 'return' ':' type 'end';

vars: 'vars'':' var+ 'end';

var : STRING ':' type interval? message ;

interval: '[' min=number? ':' max= number? ']';

message: STRING;

methods: 'methods' ':' method+ 'end';

method: ('[' (Name (',' Name)*)? ']') ':' STRING ;

type returns[Type res]:
      'int' { $res = new IntegerType(); }
    | 'double' { $res = new RealType(); }
    | 'float' { $res = new RealType(); }
    | 'string' { $res = new StringType(); }
    | 'void' { $res = new VoidType(); }
    | 'bool' { $res = new BoolType(); }
    ;

number: DOUBLE | INT;

HeaderBlock: 'header' ' '*? ':' .*? 'end';
Name: [a-zA-Z] [a-zA-Z0-9]*;
STRING: ('"' (~'"')* '"');
INT:  '-'? [0-9]+;
DOUBLE:  '-'? [0-9]+ ('.' [0-9]+)?;

BLOCK_COMMENT: '#*' .*? '*#' -> skip;
LINE_COMMENT: '#' .*? '\n' -> skip;
WS: [ \t\n\r] -> skip;

