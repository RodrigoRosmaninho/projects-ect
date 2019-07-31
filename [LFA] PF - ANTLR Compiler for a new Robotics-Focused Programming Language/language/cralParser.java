// Generated from cral.g4 by ANTLR 4.7.2

package language;

import lib.*;
import java.util.*;

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class cralParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, T__36=37, T__37=38, 
		T__38=39, T__39=40, T__40=41, T__41=42, T__42=43, T__43=44, BOOL=45, NUM=46, 
		ESC=47, ID=48, BLOCK_COMMENT=49, LINE_COMMENT=50, NL=51, WS=52, ERROR=53;
	public static final int
		RULE_program = 0, RULE_top = 1, RULE_type = 2, RULE_literal = 3, RULE_string = 4, 
		RULE_ref = 5, RULE_value = 6, RULE_declaration = 7, RULE_assignment = 8, 
		RULE_increment = 9, RULE_behaviourSet = 10, RULE_behaviourDeclare = 11, 
		RULE_actionCall = 12, RULE_functionCall = 13, RULE_argumentCall = 14, 
		RULE_functionDeclare = 15, RULE_argumentDeclare = 16, RULE_returnStat = 17, 
		RULE_statement = 18, RULE_block = 19, RULE_whenStat = 20, RULE_whileStat = 21, 
		RULE_untilStat = 22, RULE_forStat = 23, RULE_breakStat = 24, RULE_checkStat = 25, 
		RULE_otherStat = 26, RULE_forRange = 27, RULE_expr = 28, RULE_interval = 29;
	private static String[] makeRuleNames() {
		return new String[] {
			"program", "top", "type", "literal", "string", "ref", "value", "declaration", 
			"assignment", "increment", "behaviourSet", "behaviourDeclare", "actionCall", 
			"functionCall", "argumentCall", "functionDeclare", "argumentDeclare", 
			"returnStat", "statement", "block", "whenStat", "whileStat", "untilStat", 
			"forStat", "breakStat", "checkStat", "otherStat", "forRange", "expr", 
			"interval"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'bool'", "'cond'", "'num'", "'string'", "'\"'", "'$'", "'local'", 
			"'='", "'^'", "'*'", "'/'", "'%'", "'+'", "'-'", "'++'", "'--'", "'set'", 
			"'behav'", "'until'", "':'", "'end'", "'call'", "'('", "')'", "','", 
			"'return'", "'when'", "'while'", "'for'", "'break'", "'other'", "'in'", 
			"'not'", "'is'", "'=='", "'!='", "'and'", "'or'", "'>='", "'<='", "'>'", 
			"'<'", "'['", "']'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, "BOOL", "NUM", 
			"ESC", "ID", "BLOCK_COMMENT", "LINE_COMMENT", "NL", "WS", "ERROR"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "cral.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public cralParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class ProgramContext extends ParserRuleContext {
		public TerminalNode EOF() { return getToken(cralParser.EOF, 0); }
		public List<TopContext> top() {
			return getRuleContexts(TopContext.class);
		}
		public TopContext top(int i) {
			return getRuleContext(TopContext.class,i);
		}
		public ProgramContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_program; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitProgram(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ProgramContext program() throws RecognitionException {
		ProgramContext _localctx = new ProgramContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_program);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(63);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3) | (1L << T__6) | (1L << T__14) | (1L << T__15) | (1L << T__17) | (1L << ID))) != 0)) {
				{
				{
				setState(60);
				top();
				}
				}
				setState(65);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(66);
			match(EOF);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TopContext extends ParserRuleContext {
		public TopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_top; }
	 
		public TopContext() { }
		public void copyFrom(TopContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class TopAssignContext extends TopContext {
		public AssignmentContext assignment() {
			return getRuleContext(AssignmentContext.class,0);
		}
		public TopAssignContext(TopContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitTopAssign(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TopDeclareContext extends TopContext {
		public DeclarationContext declaration() {
			return getRuleContext(DeclarationContext.class,0);
		}
		public TopDeclareContext(TopContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitTopDeclare(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TopBehaviourContext extends TopContext {
		public BehaviourDeclareContext behaviourDeclare() {
			return getRuleContext(BehaviourDeclareContext.class,0);
		}
		public TopBehaviourContext(TopContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitTopBehaviour(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TopFunctionContext extends TopContext {
		public FunctionDeclareContext functionDeclare() {
			return getRuleContext(FunctionDeclareContext.class,0);
		}
		public TopFunctionContext(TopContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitTopFunction(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TopContext top() throws RecognitionException {
		TopContext _localctx = new TopContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_top);
		try {
			setState(72);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				_localctx = new TopAssignContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(68);
				assignment();
				}
				break;
			case 2:
				_localctx = new TopDeclareContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(69);
				declaration();
				}
				break;
			case 3:
				_localctx = new TopBehaviourContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(70);
				behaviourDeclare();
				}
				break;
			case 4:
				_localctx = new TopFunctionContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(71);
				functionDeclare();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeContext extends ParserRuleContext {
		public Type res;
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitType(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TypeContext type() throws RecognitionException {
		TypeContext _localctx = new TypeContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_type);
		try {
			setState(82);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__0:
				enterOuterAlt(_localctx, 1);
				{
				setState(74);
				match(T__0);
				 ((TypeContext)_localctx).res = new BoolType(); 
				}
				break;
			case T__1:
				enterOuterAlt(_localctx, 2);
				{
				setState(76);
				match(T__1);
				 ((TypeContext)_localctx).res = new CondType(); 
				}
				break;
			case T__2:
				enterOuterAlt(_localctx, 3);
				{
				setState(78);
				match(T__2);
				 ((TypeContext)_localctx).res = new NumberType(); 
				}
				break;
			case T__3:
				enterOuterAlt(_localctx, 4);
				{
				setState(80);
				match(T__3);
				 ((TypeContext)_localctx).res = new StringType(); 
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class LiteralContext extends ParserRuleContext {
		public Type res;
		public LiteralContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_literal; }
	 
		public LiteralContext() { }
		public void copyFrom(LiteralContext ctx) {
			super.copyFrom(ctx);
			this.res = ctx.res;
		}
	}
	public static class LiteralStringContext extends LiteralContext {
		public StringContext string() {
			return getRuleContext(StringContext.class,0);
		}
		public LiteralStringContext(LiteralContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitLiteralString(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class LiteralBoolContext extends LiteralContext {
		public TerminalNode BOOL() { return getToken(cralParser.BOOL, 0); }
		public LiteralBoolContext(LiteralContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitLiteralBool(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class LiteralNumContext extends LiteralContext {
		public TerminalNode NUM() { return getToken(cralParser.NUM, 0); }
		public LiteralNumContext(LiteralContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitLiteralNum(this);
			else return visitor.visitChildren(this);
		}
	}

	public final LiteralContext literal() throws RecognitionException {
		LiteralContext _localctx = new LiteralContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_literal);
		try {
			setState(87);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case BOOL:
				_localctx = new LiteralBoolContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(84);
				match(BOOL);
				}
				break;
			case NUM:
				_localctx = new LiteralNumContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(85);
				match(NUM);
				}
				break;
			case T__4:
				_localctx = new LiteralStringContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(86);
				string();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StringContext extends ParserRuleContext {
		public List<ParserRuleContext> exprs;
		public List<TerminalNode> ESC() { return getTokens(cralParser.ESC); }
		public TerminalNode ESC(int i) {
			return getToken(cralParser.ESC, i);
		}
		public List<RefContext> ref() {
			return getRuleContexts(RefContext.class);
		}
		public RefContext ref(int i) {
			return getRuleContext(RefContext.class,i);
		}
		public StringContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_string; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitString(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StringContext string() throws RecognitionException {
		StringContext _localctx = new StringContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_string);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(89);
			match(T__4);
			setState(95);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,5,_ctx);
			while ( _alt!=1 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1+1 ) {
					{
					setState(93);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
					case 1:
						{
						setState(90);
						match(ESC);
						}
						break;
					case 2:
						{
						setState(91);
						ref();
						}
						break;
					case 3:
						{
						setState(92);
						_la = _input.LA(1);
						if ( _la <= 0 || (_la==T__5) ) {
						_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						}
						break;
					}
					} 
				}
				setState(97);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,5,_ctx);
			}
			setState(98);
			match(T__4);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class RefContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public RefContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ref; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitRef(this);
			else return visitor.visitChildren(this);
		}
	}

	public final RefContext ref() throws RecognitionException {
		RefContext _localctx = new RefContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_ref);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(100);
			match(T__5);
			setState(101);
			expr(0);
			setState(102);
			match(T__5);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ValueContext extends ParserRuleContext {
		public Type res;
		public ValueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_value; }
	 
		public ValueContext() { }
		public void copyFrom(ValueContext ctx) {
			super.copyFrom(ctx);
			this.res = ctx.res;
		}
	}
	public static class AtomIDContext extends ValueContext {
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public AtomIDContext(ValueContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAtomID(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AtomCallContext extends ValueContext {
		public ActionCallContext actionCall() {
			return getRuleContext(ActionCallContext.class,0);
		}
		public AtomCallContext(ValueContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAtomCall(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AtomFunctionContext extends ValueContext {
		public FunctionCallContext functionCall() {
			return getRuleContext(FunctionCallContext.class,0);
		}
		public AtomFunctionContext(ValueContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAtomFunction(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AtomLiteralContext extends ValueContext {
		public LiteralContext literal() {
			return getRuleContext(LiteralContext.class,0);
		}
		public AtomLiteralContext(ValueContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAtomLiteral(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ValueContext value() throws RecognitionException {
		ValueContext _localctx = new ValueContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_value);
		try {
			setState(108);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,6,_ctx) ) {
			case 1:
				_localctx = new AtomLiteralContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(104);
				literal();
				}
				break;
			case 2:
				_localctx = new AtomCallContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(105);
				actionCall();
				}
				break;
			case 3:
				_localctx = new AtomFunctionContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(106);
				functionCall();
				}
				break;
			case 4:
				_localctx = new AtomIDContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(107);
				match(ID);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class DeclarationContext extends ParserRuleContext {
		public Token op;
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public DeclarationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_declaration; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitDeclaration(this);
			else return visitor.visitChildren(this);
		}
	}

	public final DeclarationContext declaration() throws RecognitionException {
		DeclarationContext _localctx = new DeclarationContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_declaration);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(111);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__6) {
				{
				setState(110);
				((DeclarationContext)_localctx).op = match(T__6);
				}
			}

			setState(113);
			type();
			setState(114);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AssignmentContext extends ParserRuleContext {
		public AssignmentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignment; }
	 
		public AssignmentContext() { }
		public void copyFrom(AssignmentContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class AssignIncContext extends AssignmentContext {
		public IncrementContext increment() {
			return getRuleContext(IncrementContext.class,0);
		}
		public AssignIncContext(AssignmentContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAssignInc(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AssignDeclareContext extends AssignmentContext {
		public DeclarationContext declaration() {
			return getRuleContext(DeclarationContext.class,0);
		}
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public AssignDeclareContext(AssignmentContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAssignDeclare(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AssignOpContext extends AssignmentContext {
		public Token op;
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public AssignOpContext(AssignmentContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAssignOp(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AssignIDContext extends AssignmentContext {
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public AssignIDContext(AssignmentContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAssignID(this);
			else return visitor.visitChildren(this);
		}
	}

	public final AssignmentContext assignment() throws RecognitionException {
		AssignmentContext _localctx = new AssignmentContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_assignment);
		int _la;
		try {
			setState(128);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,8,_ctx) ) {
			case 1:
				_localctx = new AssignDeclareContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(116);
				declaration();
				setState(117);
				match(T__7);
				setState(118);
				expr(0);
				}
				break;
			case 2:
				_localctx = new AssignIDContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(120);
				match(ID);
				setState(121);
				match(T__7);
				setState(122);
				expr(0);
				}
				break;
			case 3:
				_localctx = new AssignOpContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(123);
				match(ID);
				setState(124);
				((AssignOpContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__8) | (1L << T__9) | (1L << T__10) | (1L << T__11) | (1L << T__12) | (1L << T__13))) != 0)) ) {
					((AssignOpContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(125);
				match(T__7);
				setState(126);
				expr(0);
				}
				break;
			case 4:
				_localctx = new AssignIncContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(127);
				increment();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class IncrementContext extends ParserRuleContext {
		public IncrementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_increment; }
	 
		public IncrementContext() { }
		public void copyFrom(IncrementContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class IncLeftExprContext extends IncrementContext {
		public Token op;
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public IncLeftExprContext(IncrementContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitIncLeftExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IncRightExprContext extends IncrementContext {
		public Token op;
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public IncRightExprContext(IncrementContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitIncRightExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IncrementContext increment() throws RecognitionException {
		IncrementContext _localctx = new IncrementContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_increment);
		int _la;
		try {
			setState(134);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__14:
			case T__15:
				_localctx = new IncLeftExprContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(130);
				((IncLeftExprContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__14 || _la==T__15) ) {
					((IncLeftExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(131);
				match(ID);
				}
				break;
			case ID:
				_localctx = new IncRightExprContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(132);
				match(ID);
				setState(133);
				((IncRightExprContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__14 || _la==T__15) ) {
					((IncRightExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BehaviourSetContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public BehaviourSetContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_behaviourSet; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitBehaviourSet(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BehaviourSetContext behaviourSet() throws RecognitionException {
		BehaviourSetContext _localctx = new BehaviourSetContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_behaviourSet);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(136);
			match(T__16);
			setState(137);
			match(ID);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BehaviourDeclareContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<BlockContext> block() {
			return getRuleContexts(BlockContext.class);
		}
		public BlockContext block(int i) {
			return getRuleContext(BlockContext.class,i);
		}
		public BehaviourDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_behaviourDeclare; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitBehaviourDeclare(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BehaviourDeclareContext behaviourDeclare() throws RecognitionException {
		BehaviourDeclareContext _localctx = new BehaviourDeclareContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_behaviourDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(139);
			match(T__17);
			setState(140);
			match(ID);
			setState(141);
			match(T__18);
			setState(142);
			expr(0);
			setState(143);
			match(T__19);
			setState(147);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3) | (1L << T__6) | (1L << T__14) | (1L << T__15) | (1L << T__16) | (1L << T__18) | (1L << T__21) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << ID))) != 0)) {
				{
				{
				setState(144);
				block();
				}
				}
				setState(149);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(150);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ActionCallContext extends ParserRuleContext {
		public Type res;
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public ArgumentCallContext argumentCall() {
			return getRuleContext(ArgumentCallContext.class,0);
		}
		public ActionCallContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_actionCall; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitActionCall(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ActionCallContext actionCall() throws RecognitionException {
		ActionCallContext _localctx = new ActionCallContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_actionCall);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(152);
			match(T__21);
			setState(153);
			match(ID);
			setState(154);
			match(T__22);
			setState(156);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__4) | (1L << T__12) | (1L << T__13) | (1L << T__14) | (1L << T__15) | (1L << T__21) | (1L << T__22) | (1L << T__32) | (1L << BOOL) | (1L << NUM) | (1L << ID))) != 0)) {
				{
				setState(155);
				argumentCall();
				}
			}

			setState(158);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionCallContext extends ParserRuleContext {
		public Type res;
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public ArgumentCallContext argumentCall() {
			return getRuleContext(ArgumentCallContext.class,0);
		}
		public FunctionCallContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionCall; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitFunctionCall(this);
			else return visitor.visitChildren(this);
		}
	}

	public final FunctionCallContext functionCall() throws RecognitionException {
		FunctionCallContext _localctx = new FunctionCallContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_functionCall);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(160);
			match(ID);
			setState(161);
			match(T__22);
			setState(163);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__4) | (1L << T__12) | (1L << T__13) | (1L << T__14) | (1L << T__15) | (1L << T__21) | (1L << T__22) | (1L << T__32) | (1L << BOOL) | (1L << NUM) | (1L << ID))) != 0)) {
				{
				setState(162);
				argumentCall();
				}
			}

			setState(165);
			match(T__23);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ArgumentCallContext extends ParserRuleContext {
		public List<String> names;
		public List<Type> types;
		public List<String> vals;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public List<TerminalNode> ID() { return getTokens(cralParser.ID); }
		public TerminalNode ID(int i) {
			return getToken(cralParser.ID, i);
		}
		public ArgumentCallContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_argumentCall; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitArgumentCall(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ArgumentCallContext argumentCall() throws RecognitionException {
		ArgumentCallContext _localctx = new ArgumentCallContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_argumentCall);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(169);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				{
				setState(167);
				match(ID);
				setState(168);
				match(T__7);
				}
				break;
			}
			setState(171);
			expr(0);
			setState(180);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__24) {
				{
				{
				setState(172);
				match(T__24);
				setState(175);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
				case 1:
					{
					setState(173);
					match(ID);
					setState(174);
					match(T__7);
					}
					break;
				}
				setState(177);
				expr(0);
				}
				}
				setState(182);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FunctionDeclareContext extends ParserRuleContext {
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public ArgumentDeclareContext argumentDeclare() {
			return getRuleContext(ArgumentDeclareContext.class,0);
		}
		public List<BlockContext> block() {
			return getRuleContexts(BlockContext.class);
		}
		public BlockContext block(int i) {
			return getRuleContext(BlockContext.class,i);
		}
		public FunctionDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_functionDeclare; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitFunctionDeclare(this);
			else return visitor.visitChildren(this);
		}
	}

	public final FunctionDeclareContext functionDeclare() throws RecognitionException {
		FunctionDeclareContext _localctx = new FunctionDeclareContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_functionDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(184);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3))) != 0)) {
				{
				setState(183);
				type();
				}
			}

			setState(186);
			match(ID);
			setState(187);
			match(T__22);
			setState(189);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3))) != 0)) {
				{
				setState(188);
				argumentDeclare();
				}
			}

			setState(191);
			match(T__23);
			setState(192);
			match(T__19);
			setState(196);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3) | (1L << T__6) | (1L << T__14) | (1L << T__15) | (1L << T__16) | (1L << T__18) | (1L << T__21) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << ID))) != 0)) {
				{
				{
				setState(193);
				block();
				}
				}
				setState(198);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(199);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ArgumentDeclareContext extends ParserRuleContext {
		public List<VariableSymbol> args;
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> ID() { return getTokens(cralParser.ID); }
		public TerminalNode ID(int i) {
			return getToken(cralParser.ID, i);
		}
		public ArgumentDeclareContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_argumentDeclare; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitArgumentDeclare(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ArgumentDeclareContext argumentDeclare() throws RecognitionException {
		ArgumentDeclareContext _localctx = new ArgumentDeclareContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_argumentDeclare);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(201);
			type();
			setState(202);
			match(ID);
			setState(209);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__24) {
				{
				{
				setState(203);
				match(T__24);
				setState(204);
				type();
				setState(205);
				match(ID);
				}
				}
				setState(211);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ReturnStatContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ReturnStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_returnStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitReturnStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ReturnStatContext returnStat() throws RecognitionException {
		ReturnStatContext _localctx = new ReturnStatContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_returnStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(212);
			match(T__25);
			setState(214);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,20,_ctx) ) {
			case 1:
				{
				setState(213);
				expr(0);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementContext extends ParserRuleContext {
		public WhenStatContext whenStat() {
			return getRuleContext(WhenStatContext.class,0);
		}
		public WhileStatContext whileStat() {
			return getRuleContext(WhileStatContext.class,0);
		}
		public UntilStatContext untilStat() {
			return getRuleContext(UntilStatContext.class,0);
		}
		public ForStatContext forStat() {
			return getRuleContext(ForStatContext.class,0);
		}
		public BreakStatContext breakStat() {
			return getRuleContext(BreakStatContext.class,0);
		}
		public ReturnStatContext returnStat() {
			return getRuleContext(ReturnStatContext.class,0);
		}
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitStatement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_statement);
		try {
			setState(222);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__26:
				enterOuterAlt(_localctx, 1);
				{
				setState(216);
				whenStat();
				}
				break;
			case T__27:
				enterOuterAlt(_localctx, 2);
				{
				setState(217);
				whileStat();
				}
				break;
			case T__18:
				enterOuterAlt(_localctx, 3);
				{
				setState(218);
				untilStat();
				}
				break;
			case T__28:
				enterOuterAlt(_localctx, 4);
				{
				setState(219);
				forStat();
				}
				break;
			case T__29:
				enterOuterAlt(_localctx, 5);
				{
				setState(220);
				breakStat();
				}
				break;
			case T__25:
				enterOuterAlt(_localctx, 6);
				{
				setState(221);
				returnStat();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BlockContext extends ParserRuleContext {
		public DeclarationContext declaration() {
			return getRuleContext(DeclarationContext.class,0);
		}
		public AssignmentContext assignment() {
			return getRuleContext(AssignmentContext.class,0);
		}
		public BehaviourSetContext behaviourSet() {
			return getRuleContext(BehaviourSetContext.class,0);
		}
		public ActionCallContext actionCall() {
			return getRuleContext(ActionCallContext.class,0);
		}
		public FunctionCallContext functionCall() {
			return getRuleContext(FunctionCallContext.class,0);
		}
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public BlockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_block; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitBlock(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BlockContext block() throws RecognitionException {
		BlockContext _localctx = new BlockContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_block);
		try {
			setState(230);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,22,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(224);
				declaration();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(225);
				assignment();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(226);
				behaviourSet();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(227);
				actionCall();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(228);
				functionCall();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(229);
				statement();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WhenStatContext extends ParserRuleContext {
		public List<CheckStatContext> checkStat() {
			return getRuleContexts(CheckStatContext.class);
		}
		public CheckStatContext checkStat(int i) {
			return getRuleContext(CheckStatContext.class,i);
		}
		public OtherStatContext otherStat() {
			return getRuleContext(OtherStatContext.class,0);
		}
		public WhenStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_whenStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitWhenStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final WhenStatContext whenStat() throws RecognitionException {
		WhenStatContext _localctx = new WhenStatContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_whenStat);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(232);
			match(T__26);
			setState(234); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(233);
				checkStat();
				}
				}
				setState(236); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__4) | (1L << T__12) | (1L << T__13) | (1L << T__14) | (1L << T__15) | (1L << T__21) | (1L << T__22) | (1L << T__32) | (1L << BOOL) | (1L << NUM) | (1L << ID))) != 0) );
			setState(239);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__30) {
				{
				setState(238);
				otherStat();
				}
			}

			setState(241);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class WhileStatContext extends ParserRuleContext {
		public CheckStatContext checkStat() {
			return getRuleContext(CheckStatContext.class,0);
		}
		public WhileStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_whileStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitWhileStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final WhileStatContext whileStat() throws RecognitionException {
		WhileStatContext _localctx = new WhileStatContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_whileStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(243);
			match(T__27);
			setState(244);
			checkStat();
			setState(245);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UntilStatContext extends ParserRuleContext {
		public CheckStatContext checkStat() {
			return getRuleContext(CheckStatContext.class,0);
		}
		public UntilStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_untilStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitUntilStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final UntilStatContext untilStat() throws RecognitionException {
		UntilStatContext _localctx = new UntilStatContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_untilStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(247);
			match(T__18);
			setState(248);
			checkStat();
			setState(249);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ForStatContext extends ParserRuleContext {
		public ForRangeContext forRange() {
			return getRuleContext(ForRangeContext.class,0);
		}
		public ForStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_forStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitForStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ForStatContext forStat() throws RecognitionException {
		ForStatContext _localctx = new ForStatContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_forStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(251);
			match(T__28);
			setState(252);
			forRange();
			setState(253);
			match(T__20);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BreakStatContext extends ParserRuleContext {
		public BreakStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_breakStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitBreakStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BreakStatContext breakStat() throws RecognitionException {
		BreakStatContext _localctx = new BreakStatContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_breakStat);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(255);
			match(T__29);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CheckStatContext extends ParserRuleContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public List<BlockContext> block() {
			return getRuleContexts(BlockContext.class);
		}
		public BlockContext block(int i) {
			return getRuleContext(BlockContext.class,i);
		}
		public CheckStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_checkStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitCheckStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final CheckStatContext checkStat() throws RecognitionException {
		CheckStatContext _localctx = new CheckStatContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_checkStat);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(257);
			expr(0);
			setState(258);
			match(T__19);
			setState(262);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,25,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(259);
					block();
					}
					} 
				}
				setState(264);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,25,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class OtherStatContext extends ParserRuleContext {
		public List<BlockContext> block() {
			return getRuleContexts(BlockContext.class);
		}
		public BlockContext block(int i) {
			return getRuleContext(BlockContext.class,i);
		}
		public OtherStatContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_otherStat; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitOtherStat(this);
			else return visitor.visitChildren(this);
		}
	}

	public final OtherStatContext otherStat() throws RecognitionException {
		OtherStatContext _localctx = new OtherStatContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_otherStat);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(265);
			match(T__30);
			setState(266);
			match(T__19);
			setState(270);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3) | (1L << T__6) | (1L << T__14) | (1L << T__15) | (1L << T__16) | (1L << T__18) | (1L << T__21) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << ID))) != 0)) {
				{
				{
				setState(267);
				block();
				}
				}
				setState(272);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ForRangeContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode ID() { return getToken(cralParser.ID, 0); }
		public IntervalContext interval() {
			return getRuleContext(IntervalContext.class,0);
		}
		public List<BlockContext> block() {
			return getRuleContexts(BlockContext.class);
		}
		public BlockContext block(int i) {
			return getRuleContext(BlockContext.class,i);
		}
		public ForRangeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_forRange; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitForRange(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ForRangeContext forRange() throws RecognitionException {
		ForRangeContext _localctx = new ForRangeContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_forRange);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(273);
			type();
			setState(274);
			match(ID);
			setState(275);
			match(T__31);
			setState(276);
			interval();
			setState(277);
			match(T__19);
			setState(281);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << T__1) | (1L << T__2) | (1L << T__3) | (1L << T__6) | (1L << T__14) | (1L << T__15) | (1L << T__16) | (1L << T__18) | (1L << T__21) | (1L << T__25) | (1L << T__26) | (1L << T__27) | (1L << T__28) | (1L << T__29) | (1L << ID))) != 0)) {
				{
				{
				setState(278);
				block();
				}
				}
				setState(283);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExprContext extends ParserRuleContext {
		public Type res;
		public String varName;
		public ExprContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expr; }
	 
		public ExprContext() { }
		public void copyFrom(ExprContext ctx) {
			super.copyFrom(ctx);
			this.res = ctx.res;
			this.varName = ctx.varName;
		}
	}
	public static class ParExprContext extends ExprContext {
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public ParExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitParExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class UnaryExprContext extends ExprContext {
		public Token op;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public UnaryExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitUnaryExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IncExprContext extends ExprContext {
		public IncrementContext increment() {
			return getRuleContext(IncrementContext.class,0);
		}
		public IncExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitIncExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TernaryExprContext extends ExprContext {
		public Token op1;
		public Token op2;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public TernaryExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitTernaryExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AtomExprContext extends ExprContext {
		public ValueContext value() {
			return getRuleContext(ValueContext.class,0);
		}
		public AtomExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitAtomExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BinaryExprContext extends ExprContext {
		public Token op;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public BinaryExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitBinaryExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IntervalExprContext extends ExprContext {
		public Token op;
		public ExprContext expr() {
			return getRuleContext(ExprContext.class,0);
		}
		public IntervalContext interval() {
			return getRuleContext(IntervalContext.class,0);
		}
		public IntervalExprContext(ExprContext ctx) { copyFrom(ctx); }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitIntervalExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExprContext expr() throws RecognitionException {
		return expr(0);
	}

	private ExprContext expr(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExprContext _localctx = new ExprContext(_ctx, _parentState);
		ExprContext _prevctx = _localctx;
		int _startState = 56;
		enterRecursionRule(_localctx, 56, RULE_expr, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(295);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,28,_ctx) ) {
			case 1:
				{
				_localctx = new ParExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(285);
				match(T__22);
				setState(286);
				expr(0);
				setState(287);
				match(T__23);
				}
				break;
			case 2:
				{
				_localctx = new AtomExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(289);
				value();
				}
				break;
			case 3:
				{
				_localctx = new UnaryExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(290);
				((UnaryExprContext)_localctx).op = match(T__32);
				setState(291);
				expr(13);
				}
				break;
			case 4:
				{
				_localctx = new UnaryExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(292);
				((UnaryExprContext)_localctx).op = _input.LT(1);
				_la = _input.LA(1);
				if ( !(_la==T__12 || _la==T__13) ) {
					((UnaryExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
				}
				else {
					if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
					_errHandler.reportMatch(this);
					consume();
				}
				setState(293);
				expr(12);
				}
				break;
			case 5:
				{
				_localctx = new IncExprContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(294);
				increment();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(332);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(330);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,29,_ctx) ) {
					case 1:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(297);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						setState(298);
						((BinaryExprContext)_localctx).op = match(T__8);
						setState(299);
						expr(10);
						}
						break;
					case 2:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(300);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						setState(301);
						((BinaryExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__9) | (1L << T__10) | (1L << T__11))) != 0)) ) {
							((BinaryExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(302);
						expr(10);
						}
						break;
					case 3:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(303);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(304);
						((BinaryExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__12 || _la==T__13) ) {
							((BinaryExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(305);
						expr(9);
						}
						break;
					case 4:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(306);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(307);
						((BinaryExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !(_la==T__33 || _la==T__34) ) {
							((BinaryExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(308);
						expr(8);
						}
						break;
					case 5:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(309);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						setState(310);
						((BinaryExprContext)_localctx).op = match(T__35);
						setState(311);
						expr(7);
						}
						break;
					case 6:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(312);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(313);
						((BinaryExprContext)_localctx).op = match(T__36);
						setState(314);
						expr(6);
						}
						break;
					case 7:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(315);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(316);
						((BinaryExprContext)_localctx).op = match(T__37);
						setState(317);
						expr(5);
						}
						break;
					case 8:
						{
						_localctx = new TernaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(318);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(319);
						((TernaryExprContext)_localctx).op1 = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__38) | (1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) ) {
							((TernaryExprContext)_localctx).op1 = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(320);
						expr(0);
						setState(321);
						((TernaryExprContext)_localctx).op2 = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__38) | (1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) ) {
							((TernaryExprContext)_localctx).op2 = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(322);
						expr(4);
						}
						break;
					case 9:
						{
						_localctx = new BinaryExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(324);
						if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
						setState(325);
						((BinaryExprContext)_localctx).op = _input.LT(1);
						_la = _input.LA(1);
						if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__38) | (1L << T__39) | (1L << T__40) | (1L << T__41))) != 0)) ) {
							((BinaryExprContext)_localctx).op = (Token)_errHandler.recoverInline(this);
						}
						else {
							if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
							_errHandler.reportMatch(this);
							consume();
						}
						setState(326);
						expr(3);
						}
						break;
					case 10:
						{
						_localctx = new IntervalExprContext(new ExprContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_expr);
						setState(327);
						if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
						setState(328);
						((IntervalExprContext)_localctx).op = match(T__31);
						setState(329);
						interval();
						}
						break;
					}
					} 
				}
				setState(334);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class IntervalContext extends ParserRuleContext {
		public Token del1;
		public Token del2;
		public List<ExprContext> expr() {
			return getRuleContexts(ExprContext.class);
		}
		public ExprContext expr(int i) {
			return getRuleContext(ExprContext.class,i);
		}
		public IntervalContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_interval; }
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof cralVisitor ) return ((cralVisitor<? extends T>)visitor).visitInterval(this);
			else return visitor.visitChildren(this);
		}
	}

	public final IntervalContext interval() throws RecognitionException {
		IntervalContext _localctx = new IntervalContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_interval);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(335);
			((IntervalContext)_localctx).del1 = _input.LT(1);
			_la = _input.LA(1);
			if ( !(_la==T__42 || _la==T__43) ) {
				((IntervalContext)_localctx).del1 = (Token)_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(336);
			expr(0);
			setState(337);
			match(T__24);
			setState(338);
			expr(0);
			setState(339);
			((IntervalContext)_localctx).del2 = _input.LT(1);
			_la = _input.LA(1);
			if ( !(_la==T__42 || _la==T__43) ) {
				((IntervalContext)_localctx).del2 = (Token)_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 28:
			return expr_sempred((ExprContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean expr_sempred(ExprContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 10);
		case 1:
			return precpred(_ctx, 9);
		case 2:
			return precpred(_ctx, 8);
		case 3:
			return precpred(_ctx, 7);
		case 4:
			return precpred(_ctx, 6);
		case 5:
			return precpred(_ctx, 5);
		case 6:
			return precpred(_ctx, 4);
		case 7:
			return precpred(_ctx, 3);
		case 8:
			return precpred(_ctx, 2);
		case 9:
			return precpred(_ctx, 1);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\67\u0158\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\3\2\7\2@"+
		"\n\2\f\2\16\2C\13\2\3\2\3\2\3\3\3\3\3\3\3\3\5\3K\n\3\3\4\3\4\3\4\3\4\3"+
		"\4\3\4\3\4\3\4\5\4U\n\4\3\5\3\5\3\5\5\5Z\n\5\3\6\3\6\3\6\3\6\7\6`\n\6"+
		"\f\6\16\6c\13\6\3\6\3\6\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\5\bo\n\b\3\t\5"+
		"\tr\n\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\n\5"+
		"\n\u0083\n\n\3\13\3\13\3\13\3\13\5\13\u0089\n\13\3\f\3\f\3\f\3\r\3\r\3"+
		"\r\3\r\3\r\3\r\7\r\u0094\n\r\f\r\16\r\u0097\13\r\3\r\3\r\3\16\3\16\3\16"+
		"\3\16\5\16\u009f\n\16\3\16\3\16\3\17\3\17\3\17\5\17\u00a6\n\17\3\17\3"+
		"\17\3\20\3\20\5\20\u00ac\n\20\3\20\3\20\3\20\3\20\5\20\u00b2\n\20\3\20"+
		"\7\20\u00b5\n\20\f\20\16\20\u00b8\13\20\3\21\5\21\u00bb\n\21\3\21\3\21"+
		"\3\21\5\21\u00c0\n\21\3\21\3\21\3\21\7\21\u00c5\n\21\f\21\16\21\u00c8"+
		"\13\21\3\21\3\21\3\22\3\22\3\22\3\22\3\22\3\22\7\22\u00d2\n\22\f\22\16"+
		"\22\u00d5\13\22\3\23\3\23\5\23\u00d9\n\23\3\24\3\24\3\24\3\24\3\24\3\24"+
		"\5\24\u00e1\n\24\3\25\3\25\3\25\3\25\3\25\3\25\5\25\u00e9\n\25\3\26\3"+
		"\26\6\26\u00ed\n\26\r\26\16\26\u00ee\3\26\5\26\u00f2\n\26\3\26\3\26\3"+
		"\27\3\27\3\27\3\27\3\30\3\30\3\30\3\30\3\31\3\31\3\31\3\31\3\32\3\32\3"+
		"\33\3\33\3\33\7\33\u0107\n\33\f\33\16\33\u010a\13\33\3\34\3\34\3\34\7"+
		"\34\u010f\n\34\f\34\16\34\u0112\13\34\3\35\3\35\3\35\3\35\3\35\3\35\7"+
		"\35\u011a\n\35\f\35\16\35\u011d\13\35\3\36\3\36\3\36\3\36\3\36\3\36\3"+
		"\36\3\36\3\36\3\36\3\36\5\36\u012a\n\36\3\36\3\36\3\36\3\36\3\36\3\36"+
		"\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36"+
		"\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\3\36\7\36"+
		"\u014d\n\36\f\36\16\36\u0150\13\36\3\37\3\37\3\37\3\37\3\37\3\37\3\37"+
		"\3a\3: \2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(*,.\60\62\64\668:"+
		"<\2\n\3\2\b\b\3\2\13\20\3\2\21\22\3\2\17\20\3\2\f\16\3\2$%\3\2),\3\2-"+
		".\2\u0175\2A\3\2\2\2\4J\3\2\2\2\6T\3\2\2\2\bY\3\2\2\2\n[\3\2\2\2\ff\3"+
		"\2\2\2\16n\3\2\2\2\20q\3\2\2\2\22\u0082\3\2\2\2\24\u0088\3\2\2\2\26\u008a"+
		"\3\2\2\2\30\u008d\3\2\2\2\32\u009a\3\2\2\2\34\u00a2\3\2\2\2\36\u00ab\3"+
		"\2\2\2 \u00ba\3\2\2\2\"\u00cb\3\2\2\2$\u00d6\3\2\2\2&\u00e0\3\2\2\2(\u00e8"+
		"\3\2\2\2*\u00ea\3\2\2\2,\u00f5\3\2\2\2.\u00f9\3\2\2\2\60\u00fd\3\2\2\2"+
		"\62\u0101\3\2\2\2\64\u0103\3\2\2\2\66\u010b\3\2\2\28\u0113\3\2\2\2:\u0129"+
		"\3\2\2\2<\u0151\3\2\2\2>@\5\4\3\2?>\3\2\2\2@C\3\2\2\2A?\3\2\2\2AB\3\2"+
		"\2\2BD\3\2\2\2CA\3\2\2\2DE\7\2\2\3E\3\3\2\2\2FK\5\22\n\2GK\5\20\t\2HK"+
		"\5\30\r\2IK\5 \21\2JF\3\2\2\2JG\3\2\2\2JH\3\2\2\2JI\3\2\2\2K\5\3\2\2\2"+
		"LM\7\3\2\2MU\b\4\1\2NO\7\4\2\2OU\b\4\1\2PQ\7\5\2\2QU\b\4\1\2RS\7\6\2\2"+
		"SU\b\4\1\2TL\3\2\2\2TN\3\2\2\2TP\3\2\2\2TR\3\2\2\2U\7\3\2\2\2VZ\7/\2\2"+
		"WZ\7\60\2\2XZ\5\n\6\2YV\3\2\2\2YW\3\2\2\2YX\3\2\2\2Z\t\3\2\2\2[a\7\7\2"+
		"\2\\`\7\61\2\2]`\5\f\7\2^`\n\2\2\2_\\\3\2\2\2_]\3\2\2\2_^\3\2\2\2`c\3"+
		"\2\2\2ab\3\2\2\2a_\3\2\2\2bd\3\2\2\2ca\3\2\2\2de\7\7\2\2e\13\3\2\2\2f"+
		"g\7\b\2\2gh\5:\36\2hi\7\b\2\2i\r\3\2\2\2jo\5\b\5\2ko\5\32\16\2lo\5\34"+
		"\17\2mo\7\62\2\2nj\3\2\2\2nk\3\2\2\2nl\3\2\2\2nm\3\2\2\2o\17\3\2\2\2p"+
		"r\7\t\2\2qp\3\2\2\2qr\3\2\2\2rs\3\2\2\2st\5\6\4\2tu\7\62\2\2u\21\3\2\2"+
		"\2vw\5\20\t\2wx\7\n\2\2xy\5:\36\2y\u0083\3\2\2\2z{\7\62\2\2{|\7\n\2\2"+
		"|\u0083\5:\36\2}~\7\62\2\2~\177\t\3\2\2\177\u0080\7\n\2\2\u0080\u0083"+
		"\5:\36\2\u0081\u0083\5\24\13\2\u0082v\3\2\2\2\u0082z\3\2\2\2\u0082}\3"+
		"\2\2\2\u0082\u0081\3\2\2\2\u0083\23\3\2\2\2\u0084\u0085\t\4\2\2\u0085"+
		"\u0089\7\62\2\2\u0086\u0087\7\62\2\2\u0087\u0089\t\4\2\2\u0088\u0084\3"+
		"\2\2\2\u0088\u0086\3\2\2\2\u0089\25\3\2\2\2\u008a\u008b\7\23\2\2\u008b"+
		"\u008c\7\62\2\2\u008c\27\3\2\2\2\u008d\u008e\7\24\2\2\u008e\u008f\7\62"+
		"\2\2\u008f\u0090\7\25\2\2\u0090\u0091\5:\36\2\u0091\u0095\7\26\2\2\u0092"+
		"\u0094\5(\25\2\u0093\u0092\3\2\2\2\u0094\u0097\3\2\2\2\u0095\u0093\3\2"+
		"\2\2\u0095\u0096\3\2\2\2\u0096\u0098\3\2\2\2\u0097\u0095\3\2\2\2\u0098"+
		"\u0099\7\27\2\2\u0099\31\3\2\2\2\u009a\u009b\7\30\2\2\u009b\u009c\7\62"+
		"\2\2\u009c\u009e\7\31\2\2\u009d\u009f\5\36\20\2\u009e\u009d\3\2\2\2\u009e"+
		"\u009f\3\2\2\2\u009f\u00a0\3\2\2\2\u00a0\u00a1\7\32\2\2\u00a1\33\3\2\2"+
		"\2\u00a2\u00a3\7\62\2\2\u00a3\u00a5\7\31\2\2\u00a4\u00a6\5\36\20\2\u00a5"+
		"\u00a4\3\2\2\2\u00a5\u00a6\3\2\2\2\u00a6\u00a7\3\2\2\2\u00a7\u00a8\7\32"+
		"\2\2\u00a8\35\3\2\2\2\u00a9\u00aa\7\62\2\2\u00aa\u00ac\7\n\2\2\u00ab\u00a9"+
		"\3\2\2\2\u00ab\u00ac\3\2\2\2\u00ac\u00ad\3\2\2\2\u00ad\u00b6\5:\36\2\u00ae"+
		"\u00b1\7\33\2\2\u00af\u00b0\7\62\2\2\u00b0\u00b2\7\n\2\2\u00b1\u00af\3"+
		"\2\2\2\u00b1\u00b2\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b3\u00b5\5:\36\2\u00b4"+
		"\u00ae\3\2\2\2\u00b5\u00b8\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b6\u00b7\3\2"+
		"\2\2\u00b7\37\3\2\2\2\u00b8\u00b6\3\2\2\2\u00b9\u00bb\5\6\4\2\u00ba\u00b9"+
		"\3\2\2\2\u00ba\u00bb\3\2\2\2\u00bb\u00bc\3\2\2\2\u00bc\u00bd\7\62\2\2"+
		"\u00bd\u00bf\7\31\2\2\u00be\u00c0\5\"\22\2\u00bf\u00be\3\2\2\2\u00bf\u00c0"+
		"\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\u00c2\7\32\2\2\u00c2\u00c6\7\26\2\2"+
		"\u00c3\u00c5\5(\25\2\u00c4\u00c3\3\2\2\2\u00c5\u00c8\3\2\2\2\u00c6\u00c4"+
		"\3\2\2\2\u00c6\u00c7\3\2\2\2\u00c7\u00c9\3\2\2\2\u00c8\u00c6\3\2\2\2\u00c9"+
		"\u00ca\7\27\2\2\u00ca!\3\2\2\2\u00cb\u00cc\5\6\4\2\u00cc\u00d3\7\62\2"+
		"\2\u00cd\u00ce\7\33\2\2\u00ce\u00cf\5\6\4\2\u00cf\u00d0\7\62\2\2\u00d0"+
		"\u00d2\3\2\2\2\u00d1\u00cd\3\2\2\2\u00d2\u00d5\3\2\2\2\u00d3\u00d1\3\2"+
		"\2\2\u00d3\u00d4\3\2\2\2\u00d4#\3\2\2\2\u00d5\u00d3\3\2\2\2\u00d6\u00d8"+
		"\7\34\2\2\u00d7\u00d9\5:\36\2\u00d8\u00d7\3\2\2\2\u00d8\u00d9\3\2\2\2"+
		"\u00d9%\3\2\2\2\u00da\u00e1\5*\26\2\u00db\u00e1\5,\27\2\u00dc\u00e1\5"+
		".\30\2\u00dd\u00e1\5\60\31\2\u00de\u00e1\5\62\32\2\u00df\u00e1\5$\23\2"+
		"\u00e0\u00da\3\2\2\2\u00e0\u00db\3\2\2\2\u00e0\u00dc\3\2\2\2\u00e0\u00dd"+
		"\3\2\2\2\u00e0\u00de\3\2\2\2\u00e0\u00df\3\2\2\2\u00e1\'\3\2\2\2\u00e2"+
		"\u00e9\5\20\t\2\u00e3\u00e9\5\22\n\2\u00e4\u00e9\5\26\f\2\u00e5\u00e9"+
		"\5\32\16\2\u00e6\u00e9\5\34\17\2\u00e7\u00e9\5&\24\2\u00e8\u00e2\3\2\2"+
		"\2\u00e8\u00e3\3\2\2\2\u00e8\u00e4\3\2\2\2\u00e8\u00e5\3\2\2\2\u00e8\u00e6"+
		"\3\2\2\2\u00e8\u00e7\3\2\2\2\u00e9)\3\2\2\2\u00ea\u00ec\7\35\2\2\u00eb"+
		"\u00ed\5\64\33\2\u00ec\u00eb\3\2\2\2\u00ed\u00ee\3\2\2\2\u00ee\u00ec\3"+
		"\2\2\2\u00ee\u00ef\3\2\2\2\u00ef\u00f1\3\2\2\2\u00f0\u00f2\5\66\34\2\u00f1"+
		"\u00f0\3\2\2\2\u00f1\u00f2\3\2\2\2\u00f2\u00f3\3\2\2\2\u00f3\u00f4\7\27"+
		"\2\2\u00f4+\3\2\2\2\u00f5\u00f6\7\36\2\2\u00f6\u00f7\5\64\33\2\u00f7\u00f8"+
		"\7\27\2\2\u00f8-\3\2\2\2\u00f9\u00fa\7\25\2\2\u00fa\u00fb\5\64\33\2\u00fb"+
		"\u00fc\7\27\2\2\u00fc/\3\2\2\2\u00fd\u00fe\7\37\2\2\u00fe\u00ff\58\35"+
		"\2\u00ff\u0100\7\27\2\2\u0100\61\3\2\2\2\u0101\u0102\7 \2\2\u0102\63\3"+
		"\2\2\2\u0103\u0104\5:\36\2\u0104\u0108\7\26\2\2\u0105\u0107\5(\25\2\u0106"+
		"\u0105\3\2\2\2\u0107\u010a\3\2\2\2\u0108\u0106\3\2\2\2\u0108\u0109\3\2"+
		"\2\2\u0109\65\3\2\2\2\u010a\u0108\3\2\2\2\u010b\u010c\7!\2\2\u010c\u0110"+
		"\7\26\2\2\u010d\u010f\5(\25\2\u010e\u010d\3\2\2\2\u010f\u0112\3\2\2\2"+
		"\u0110\u010e\3\2\2\2\u0110\u0111\3\2\2\2\u0111\67\3\2\2\2\u0112\u0110"+
		"\3\2\2\2\u0113\u0114\5\6\4\2\u0114\u0115\7\62\2\2\u0115\u0116\7\"\2\2"+
		"\u0116\u0117\5<\37\2\u0117\u011b\7\26\2\2\u0118\u011a\5(\25\2\u0119\u0118"+
		"\3\2\2\2\u011a\u011d\3\2\2\2\u011b\u0119\3\2\2\2\u011b\u011c\3\2\2\2\u011c"+
		"9\3\2\2\2\u011d\u011b\3\2\2\2\u011e\u011f\b\36\1\2\u011f\u0120\7\31\2"+
		"\2\u0120\u0121\5:\36\2\u0121\u0122\7\32\2\2\u0122\u012a\3\2\2\2\u0123"+
		"\u012a\5\16\b\2\u0124\u0125\7#\2\2\u0125\u012a\5:\36\17\u0126\u0127\t"+
		"\5\2\2\u0127\u012a\5:\36\16\u0128\u012a\5\24\13\2\u0129\u011e\3\2\2\2"+
		"\u0129\u0123\3\2\2\2\u0129\u0124\3\2\2\2\u0129\u0126\3\2\2\2\u0129\u0128"+
		"\3\2\2\2\u012a\u014e\3\2\2\2\u012b\u012c\f\f\2\2\u012c\u012d\7\13\2\2"+
		"\u012d\u014d\5:\36\f\u012e\u012f\f\13\2\2\u012f\u0130\t\6\2\2\u0130\u014d"+
		"\5:\36\f\u0131\u0132\f\n\2\2\u0132\u0133\t\5\2\2\u0133\u014d\5:\36\13"+
		"\u0134\u0135\f\t\2\2\u0135\u0136\t\7\2\2\u0136\u014d\5:\36\n\u0137\u0138"+
		"\f\b\2\2\u0138\u0139\7&\2\2\u0139\u014d\5:\36\t\u013a\u013b\f\7\2\2\u013b"+
		"\u013c\7\'\2\2\u013c\u014d\5:\36\b\u013d\u013e\f\6\2\2\u013e\u013f\7("+
		"\2\2\u013f\u014d\5:\36\7\u0140\u0141\f\5\2\2\u0141\u0142\t\b\2\2\u0142"+
		"\u0143\5:\36\2\u0143\u0144\t\b\2\2\u0144\u0145\5:\36\6\u0145\u014d\3\2"+
		"\2\2\u0146\u0147\f\4\2\2\u0147\u0148\t\b\2\2\u0148\u014d\5:\36\5\u0149"+
		"\u014a\f\3\2\2\u014a\u014b\7\"\2\2\u014b\u014d\5<\37\2\u014c\u012b\3\2"+
		"\2\2\u014c\u012e\3\2\2\2\u014c\u0131\3\2\2\2\u014c\u0134\3\2\2\2\u014c"+
		"\u0137\3\2\2\2\u014c\u013a\3\2\2\2\u014c\u013d\3\2\2\2\u014c\u0140\3\2"+
		"\2\2\u014c\u0146\3\2\2\2\u014c\u0149\3\2\2\2\u014d\u0150\3\2\2\2\u014e"+
		"\u014c\3\2\2\2\u014e\u014f\3\2\2\2\u014f;\3\2\2\2\u0150\u014e\3\2\2\2"+
		"\u0151\u0152\t\t\2\2\u0152\u0153\5:\36\2\u0153\u0154\7\33\2\2\u0154\u0155"+
		"\5:\36\2\u0155\u0156\t\t\2\2\u0156=\3\2\2\2!AJTY_anq\u0082\u0088\u0095"+
		"\u009e\u00a5\u00ab\u00b1\u00b6\u00ba\u00bf\u00c6\u00d3\u00d8\u00e0\u00e8"+
		"\u00ee\u00f1\u0108\u0110\u011b\u0129\u014c\u014e";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}