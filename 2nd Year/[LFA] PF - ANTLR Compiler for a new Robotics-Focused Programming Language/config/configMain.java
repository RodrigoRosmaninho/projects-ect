package config;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

import lib.*;
import java.io.*;
import java.util.*;



public class configMain {
	public static boolean success;
   public static void main(FileInputStream configFile, SymbolTable symTable) throws Exception {

      // create a CharStream that reads from standard input:
      CharStream input = CharStreams.fromStream(configFile);
      // create a lexer that feeds off of input CharStream:
      configLexer lexer = new configLexer(input);
      // create a buffer of tokens pulled from the lexer:
      CommonTokenStream tokens = new CommonTokenStream(lexer);
      // create a parser that feeds off the tokens buffer:
      configParser parser = new configParser(tokens);
      // replace error listener:
      parser.removeErrorListeners(); // remove ConsoleErrorListener
      parser.addErrorListener(new VerboseErrorListener(false));
      // begin parsing at program rule:
      ParseTree tree = parser.program();
      if (parser.getNumberOfSyntaxErrors() == 0) {
         // print LISP-style tree:
         // System.out.println(tree.toStringTree(parser));
         configInterp visitor0 = new configInterp(symTable);
         visitor0.visit(tree);
         if (ErrorHandling.error()) {
        	 ErrorHandling.newLine();
		     System.out.println(ErrorHandling.highlight("Configuration file invalid",ErrorHandling.B_WHITE) + " - " + ErrorHandling.errorCount() + " errors.");
		     success=false;
         }
         else success=true;
      }
   }
}
