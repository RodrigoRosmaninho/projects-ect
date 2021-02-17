// Generated from config.g4 by ANTLR 4.7.2

package config;

import lib.*;

import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class configLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, HeaderBlock=21, Name=22, STRING=23, INT=24, 
		DOUBLE=25, BLOCK_COMMENT=26, LINE_COMMENT=27, WS=28;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
			"T__9", "T__10", "T__11", "T__12", "T__13", "T__14", "T__15", "T__16", 
			"T__17", "T__18", "T__19", "HeaderBlock", "Name", "STRING", "INT", "DOUBLE", 
			"BLOCK_COMMENT", "LINE_COMMENT", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'define'", "':'", "'end'", "'calls'", "'call'", "'apply'", "'critical'", 
			"'init'", "'return'", "'vars'", "'['", "']'", "'methods'", "','", "'int'", 
			"'double'", "'float'", "'string'", "'void'", "'bool'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, "HeaderBlock", 
			"Name", "STRING", "INT", "DOUBLE", "BLOCK_COMMENT", "LINE_COMMENT", "WS"
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


	public configLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "config.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\36\u0100\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\3\2\3\2\3\2\3\2\3\2\3\2"+
		"\3\2\3\3\3\3\3\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3"+
		"\6\3\7\3\7\3\7\3\7\3\7\3\7\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\b\3\t\3\t"+
		"\3\t\3\t\3\t\3\n\3\n\3\n\3\n\3\n\3\n\3\n\3\13\3\13\3\13\3\13\3\13\3\f"+
		"\3\f\3\r\3\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\17\3\17\3\20\3"+
		"\20\3\20\3\20\3\21\3\21\3\21\3\21\3\21\3\21\3\21\3\22\3\22\3\22\3\22\3"+
		"\22\3\22\3\23\3\23\3\23\3\23\3\23\3\23\3\23\3\24\3\24\3\24\3\24\3\24\3"+
		"\25\3\25\3\25\3\25\3\25\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\7\26\u00ac"+
		"\n\26\f\26\16\26\u00af\13\26\3\26\3\26\7\26\u00b3\n\26\f\26\16\26\u00b6"+
		"\13\26\3\26\3\26\3\26\3\26\3\27\3\27\7\27\u00be\n\27\f\27\16\27\u00c1"+
		"\13\27\3\30\3\30\7\30\u00c5\n\30\f\30\16\30\u00c8\13\30\3\30\3\30\3\31"+
		"\5\31\u00cd\n\31\3\31\6\31\u00d0\n\31\r\31\16\31\u00d1\3\32\5\32\u00d5"+
		"\n\32\3\32\6\32\u00d8\n\32\r\32\16\32\u00d9\3\32\3\32\6\32\u00de\n\32"+
		"\r\32\16\32\u00df\5\32\u00e2\n\32\3\33\3\33\3\33\3\33\7\33\u00e8\n\33"+
		"\f\33\16\33\u00eb\13\33\3\33\3\33\3\33\3\33\3\33\3\34\3\34\7\34\u00f4"+
		"\n\34\f\34\16\34\u00f7\13\34\3\34\3\34\3\34\3\34\3\35\3\35\3\35\3\35\6"+
		"\u00ad\u00b4\u00e9\u00f5\2\36\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13"+
		"\25\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61"+
		"\32\63\33\65\34\67\359\36\3\2\7\4\2C\\c|\5\2\62;C\\c|\3\2$$\3\2\62;\5"+
		"\2\13\f\17\17\"\"\2\u010b\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2"+
		"\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2"+
		"\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3"+
		"\2\2\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2"+
		"\2\2\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67"+
		"\3\2\2\2\29\3\2\2\2\3;\3\2\2\2\5B\3\2\2\2\7D\3\2\2\2\tH\3\2\2\2\13N\3"+
		"\2\2\2\rS\3\2\2\2\17Y\3\2\2\2\21b\3\2\2\2\23g\3\2\2\2\25n\3\2\2\2\27s"+
		"\3\2\2\2\31u\3\2\2\2\33w\3\2\2\2\35\177\3\2\2\2\37\u0081\3\2\2\2!\u0085"+
		"\3\2\2\2#\u008c\3\2\2\2%\u0092\3\2\2\2\'\u0099\3\2\2\2)\u009e\3\2\2\2"+
		"+\u00a3\3\2\2\2-\u00bb\3\2\2\2/\u00c2\3\2\2\2\61\u00cc\3\2\2\2\63\u00d4"+
		"\3\2\2\2\65\u00e3\3\2\2\2\67\u00f1\3\2\2\29\u00fc\3\2\2\2;<\7f\2\2<=\7"+
		"g\2\2=>\7h\2\2>?\7k\2\2?@\7p\2\2@A\7g\2\2A\4\3\2\2\2BC\7<\2\2C\6\3\2\2"+
		"\2DE\7g\2\2EF\7p\2\2FG\7f\2\2G\b\3\2\2\2HI\7e\2\2IJ\7c\2\2JK\7n\2\2KL"+
		"\7n\2\2LM\7u\2\2M\n\3\2\2\2NO\7e\2\2OP\7c\2\2PQ\7n\2\2QR\7n\2\2R\f\3\2"+
		"\2\2ST\7c\2\2TU\7r\2\2UV\7r\2\2VW\7n\2\2WX\7{\2\2X\16\3\2\2\2YZ\7e\2\2"+
		"Z[\7t\2\2[\\\7k\2\2\\]\7v\2\2]^\7k\2\2^_\7e\2\2_`\7c\2\2`a\7n\2\2a\20"+
		"\3\2\2\2bc\7k\2\2cd\7p\2\2de\7k\2\2ef\7v\2\2f\22\3\2\2\2gh\7t\2\2hi\7"+
		"g\2\2ij\7v\2\2jk\7w\2\2kl\7t\2\2lm\7p\2\2m\24\3\2\2\2no\7x\2\2op\7c\2"+
		"\2pq\7t\2\2qr\7u\2\2r\26\3\2\2\2st\7]\2\2t\30\3\2\2\2uv\7_\2\2v\32\3\2"+
		"\2\2wx\7o\2\2xy\7g\2\2yz\7v\2\2z{\7j\2\2{|\7q\2\2|}\7f\2\2}~\7u\2\2~\34"+
		"\3\2\2\2\177\u0080\7.\2\2\u0080\36\3\2\2\2\u0081\u0082\7k\2\2\u0082\u0083"+
		"\7p\2\2\u0083\u0084\7v\2\2\u0084 \3\2\2\2\u0085\u0086\7f\2\2\u0086\u0087"+
		"\7q\2\2\u0087\u0088\7w\2\2\u0088\u0089\7d\2\2\u0089\u008a\7n\2\2\u008a"+
		"\u008b\7g\2\2\u008b\"\3\2\2\2\u008c\u008d\7h\2\2\u008d\u008e\7n\2\2\u008e"+
		"\u008f\7q\2\2\u008f\u0090\7c\2\2\u0090\u0091\7v\2\2\u0091$\3\2\2\2\u0092"+
		"\u0093\7u\2\2\u0093\u0094\7v\2\2\u0094\u0095\7t\2\2\u0095\u0096\7k\2\2"+
		"\u0096\u0097\7p\2\2\u0097\u0098\7i\2\2\u0098&\3\2\2\2\u0099\u009a\7x\2"+
		"\2\u009a\u009b\7q\2\2\u009b\u009c\7k\2\2\u009c\u009d\7f\2\2\u009d(\3\2"+
		"\2\2\u009e\u009f\7d\2\2\u009f\u00a0\7q\2\2\u00a0\u00a1\7q\2\2\u00a1\u00a2"+
		"\7n\2\2\u00a2*\3\2\2\2\u00a3\u00a4\7j\2\2\u00a4\u00a5\7g\2\2\u00a5\u00a6"+
		"\7c\2\2\u00a6\u00a7\7f\2\2\u00a7\u00a8\7g\2\2\u00a8\u00a9\7t\2\2\u00a9"+
		"\u00ad\3\2\2\2\u00aa\u00ac\7\"\2\2\u00ab\u00aa\3\2\2\2\u00ac\u00af\3\2"+
		"\2\2\u00ad\u00ae\3\2\2\2\u00ad\u00ab\3\2\2\2\u00ae\u00b0\3\2\2\2\u00af"+
		"\u00ad\3\2\2\2\u00b0\u00b4\7<\2\2\u00b1\u00b3\13\2\2\2\u00b2\u00b1\3\2"+
		"\2\2\u00b3\u00b6\3\2\2\2\u00b4\u00b5\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b5"+
		"\u00b7\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b7\u00b8\7g\2\2\u00b8\u00b9\7p\2"+
		"\2\u00b9\u00ba\7f\2\2\u00ba,\3\2\2\2\u00bb\u00bf\t\2\2\2\u00bc\u00be\t"+
		"\3\2\2\u00bd\u00bc\3\2\2\2\u00be\u00c1\3\2\2\2\u00bf\u00bd\3\2\2\2\u00bf"+
		"\u00c0\3\2\2\2\u00c0.\3\2\2\2\u00c1\u00bf\3\2\2\2\u00c2\u00c6\7$\2\2\u00c3"+
		"\u00c5\n\4\2\2\u00c4\u00c3\3\2\2\2\u00c5\u00c8\3\2\2\2\u00c6\u00c4\3\2"+
		"\2\2\u00c6\u00c7\3\2\2\2\u00c7\u00c9\3\2\2\2\u00c8\u00c6\3\2\2\2\u00c9"+
		"\u00ca\7$\2\2\u00ca\60\3\2\2\2\u00cb\u00cd\7/\2\2\u00cc\u00cb\3\2\2\2"+
		"\u00cc\u00cd\3\2\2\2\u00cd\u00cf\3\2\2\2\u00ce\u00d0\t\5\2\2\u00cf\u00ce"+
		"\3\2\2\2\u00d0\u00d1\3\2\2\2\u00d1\u00cf\3\2\2\2\u00d1\u00d2\3\2\2\2\u00d2"+
		"\62\3\2\2\2\u00d3\u00d5\7/\2\2\u00d4\u00d3\3\2\2\2\u00d4\u00d5\3\2\2\2"+
		"\u00d5\u00d7\3\2\2\2\u00d6\u00d8\t\5\2\2\u00d7\u00d6\3\2\2\2\u00d8\u00d9"+
		"\3\2\2\2\u00d9\u00d7\3\2\2\2\u00d9\u00da\3\2\2\2\u00da\u00e1\3\2\2\2\u00db"+
		"\u00dd\7\60\2\2\u00dc\u00de\t\5\2\2\u00dd\u00dc\3\2\2\2\u00de\u00df\3"+
		"\2\2\2\u00df\u00dd\3\2\2\2\u00df\u00e0\3\2\2\2\u00e0\u00e2\3\2\2\2\u00e1"+
		"\u00db\3\2\2\2\u00e1\u00e2\3\2\2\2\u00e2\64\3\2\2\2\u00e3\u00e4\7%\2\2"+
		"\u00e4\u00e5\7,\2\2\u00e5\u00e9\3\2\2\2\u00e6\u00e8\13\2\2\2\u00e7\u00e6"+
		"\3\2\2\2\u00e8\u00eb\3\2\2\2\u00e9\u00ea\3\2\2\2\u00e9\u00e7\3\2\2\2\u00ea"+
		"\u00ec\3\2\2\2\u00eb\u00e9\3\2\2\2\u00ec\u00ed\7,\2\2\u00ed\u00ee\7%\2"+
		"\2\u00ee\u00ef\3\2\2\2\u00ef\u00f0\b\33\2\2\u00f0\66\3\2\2\2\u00f1\u00f5"+
		"\7%\2\2\u00f2\u00f4\13\2\2\2\u00f3\u00f2\3\2\2\2\u00f4\u00f7\3\2\2\2\u00f5"+
		"\u00f6\3\2\2\2\u00f5\u00f3\3\2\2\2\u00f6\u00f8\3\2\2\2\u00f7\u00f5\3\2"+
		"\2\2\u00f8\u00f9\7\f\2\2\u00f9\u00fa\3\2\2\2\u00fa\u00fb\b\34\2\2\u00fb"+
		"8\3\2\2\2\u00fc\u00fd\t\6\2\2\u00fd\u00fe\3\2\2\2\u00fe\u00ff\b\35\2\2"+
		"\u00ff:\3\2\2\2\17\2\u00ad\u00b4\u00bf\u00c6\u00cc\u00d1\u00d4\u00d9\u00df"+
		"\u00e1\u00e9\u00f5\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}