grammar cral;

@header {
package language;

import lib.*;
import java.util.*;
}

/*PARSER RULES*/

program: top* EOF;

top:
	assignment			#topAssign
	| declaration		#topDeclare
	| behaviourDeclare	#topBehaviour
	| functionDeclare	#topFunction
;

type returns[Type res]:
	'bool'	{ $res=new BoolType(); }
	| 'cond' { $res=new CondType(); }
	| 'num' { $res=new NumberType(); }
	| 'string' { $res=new StringType(); }
;
literal returns[Type res]:
	BOOL			#literalBool
	| NUM			#literalNum
	| string		#literalString
;
string returns[List<ParserRuleContext> exprs]: '"' (ESC | ref | ~'$')*? '"';
ref: '$' expr '$';
value returns[Type res]:
	literal			#atomLiteral
	| actionCall	#atomCall
	| functionCall	#atomFunction
	| ID			#atomID
;

declaration: op='local'? type ID;
assignment:
	declaration '=' expr						#assignDeclare
	| ID '=' expr								#assignID
	| ID op=('^'|'*'|'/'|'%'|'+'|'-') '=' expr	#assignOp
	| increment									#assignInc
;
increment:
	op=('++'|'--') ID		#incLeftExpr
	| ID op=('++'|'--')		#incRightExpr
;

behaviourSet: 'set' ID;
behaviourDeclare: 'behav' ID 'until' expr ':' block* 'end';

actionCall returns[Type res]: 'call' ID '(' (argumentCall)? ')';

functionCall returns[Type res]: ID '(' (argumentCall)? ')';
argumentCall returns[List<String> names, List<Type> types, List<String> vals]: (ID '=')? expr (',' (ID '=')? expr)*;
functionDeclare: type? ID '(' (argumentDeclare)? ')' ':' block* 'end';
argumentDeclare returns[List<VariableSymbol> args]: type ID (',' type ID)*;
returnStat: 'return' expr?;

statement:
	whenStat
	| whileStat
	| untilStat
	| forStat
	| breakStat
	| returnStat
;

block:
	declaration
	| assignment
	| behaviourSet
	| actionCall
	| functionCall
	| statement
;

whenStat: 'when' (checkStat)+ otherStat? 'end';
whileStat: 'while' checkStat 'end';
untilStat: 'until' checkStat 'end';
forStat: 'for' forRange 'end';
breakStat: 'break';

checkStat: expr ':' block*;
otherStat: 'other' ':' block*;
forRange: type ID 'in' interval ':' block*;

expr returns[Type res, String varName]:
	'(' expr ')'														#parExpr
	| value																#atomExpr
	| op='not' expr														#unaryExpr
	| op=('+'|'-') expr													#unaryExpr
	| increment															#incExpr
	| <assoc=right> expr op='^' expr									#binaryExpr
	| expr op=('*'|'/'|'%') expr										#binaryExpr
	| expr op=('+'|'-') expr											#binaryExpr
	| expr op=('is'|'==') expr											#binaryExpr
	| expr op='!=' expr													#binaryExpr
	| expr op='and' expr												#binaryExpr
	| expr op='or' expr													#binaryExpr
	| expr op1=('>='|'<='|'>'|'<') expr op2=('>='|'<='|'>'|'<') expr	#ternaryExpr
	| expr op=('>='|'<='|'>'|'<') expr									#binaryExpr
	| expr op='in' interval												#intervalExpr
;
interval: del1=('['|']') expr ',' expr del2=('['|']');

/*LEXER RULES*/

BOOL: 'true' | 'false';
NUM: [0-9]+ ('.' [0-9]+)?;
ESC: '\\' ["\\$];
ID: LETTER (LETTER | DIGIT)*;
fragment LETTER: [a-zA-Z_];
fragment DIGIT: [0-9];

BLOCK_COMMENT: '#*' .*? '*#' -> skip;
LINE_COMMENT: '#' .*? '\n' -> skip;
NL: [\r\n]+ -> skip;
WS: [ \t]+ -> skip;
ERROR: .;
