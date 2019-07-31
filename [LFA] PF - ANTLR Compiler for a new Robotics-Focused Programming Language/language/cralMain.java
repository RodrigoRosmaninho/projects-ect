package language;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.stringtemplate.v4.ST;

import lib.*;
import config.*;

public class cralMain {
   public static void main(String[] args) throws Exception {
      if (args.length<1) {
    	  System.out.println("Usage: java -ea cralMain <source-file>");
    	  System.exit(0);
      }
	   
      	try {
      		// create a CharStream that reads from standard input:
	      CharStream input = CharStreams.fromStream(new FileInputStream(args[0]));
	      // create a lexer that feeds off of input CharStream:
	      cralLexer lexer = new cralLexer(input);
	      // create a buffer of tokens pulled from the lexer:
	      CommonTokenStream tokens = new CommonTokenStream(lexer);
	      // create a parser that feeds off the tokens buffer:
	      cralParser parser = new cralParser(tokens);
	      // replace error listener:
	      parser.removeErrorListeners(); // remove ConsoleErrorListener
	      parser.addErrorListener(new VerboseErrorListener(true));
	      // begin parsing at program rule:
	      ParseTree tree = parser.program();
	      if (parser.getNumberOfSyntaxErrors() == 0) {
	         // print LISP-style tree:
	         // System.out.println(tree.toStringTree(parser));
	    	 SymbolTable symTable=new SymbolTable();

	    	 configMain.main(new FileInputStream(args[1]), symTable);
	    	 if (!configMain.success) {
	    		 System.out.println("Unable to compile due to configurations errors.");
	    		 System.exit(1);
	    	 }
			 cralSemanticAnalysis semantic = new cralSemanticAnalysis(symTable);
	         cralCompiler compiler = new cralCompiler(symTable,"language/cpp.stg");
	         ErrorHandling.reset();
	         semantic.visit(tree);
		     if (!ErrorHandling.error()) {
		         ST code=compiler.visit(tree);
		         
		         String filename="Output.cpp";
		         try {
                     PrintWriter pw = new PrintWriter(new File(filename));
                     pw.print(code.render());
                     pw.close();
                     System.out.println(ErrorHandling.highlight("Compilation Successful",ErrorHandling.B_GREEN));
                  }
                  catch(IOException e)
                  {
                     System.err.println("ERROR: unable to write in file "+filename);
                     System.exit(2);
                  }
		     }
		     else {
		     	ErrorHandling.newLine();
		     	System.out.println(ErrorHandling.highlight("Compilation failed",ErrorHandling.B_RED) + " - " + ErrorHandling.errorCount() + " errors.");
			 }
	      }
      	} catch(IOException e) {
      		System.err.println("ERROR: unable to write in file "+args[0]);
            System.exit(1);
      	}
   }
}
