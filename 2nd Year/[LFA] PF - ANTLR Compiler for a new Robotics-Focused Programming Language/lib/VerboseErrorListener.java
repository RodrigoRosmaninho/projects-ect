package lib;

import org.antlr.v4.runtime.*;
import java.util.List;
import java.util.Collections;

public class VerboseErrorListener extends BaseErrorListener {
	public boolean syntax;
	
	public VerboseErrorListener(boolean syntax) {
		this.syntax=syntax;
	}
	
    @Override public void syntaxError(Recognizer<?, ?> recognizer,
                                      Object offendingSymbol,
                                      int line, int charPositionInLine,
                                      String msg,
                                      RecognitionException e)
    {
        List<String> stack = ((Parser)recognizer).getRuleInvocationStack();
        Collections.reverse(stack);
        if (syntax) ErrorHandling.printSyntaxError(line, msg, charPositionInLine);
        else ErrorHandling.printConfigError(line, msg, charPositionInLine);
    }
}