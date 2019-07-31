package lib;

import static java.lang.System.*;
import java.io.PrintStream;
import org.antlr.v4.runtime.ParserRuleContext;

/**
 * Error handling module for uniform error handling within ANTLR4
 *
 * @author  Miguel Oliveira e Silva (mos@ua.pt)
 * @version 2.0
 * @since   2013-02-20
 */
public class ErrorHandling
{
    /**
     * Log a new line.
     */
    public static void newLine()
    {
        logFile.println();
        logFile.flush();
    }

    /**
     * Log a new message.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param text message
     */
    public static void printInfo(String text)
    {
        assert text != null && text.length() > 0;

        printMessage(text, 1);
    }

    /**
     * Log a new warning.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param text message
     */
    public static void printWarning(String text)
    {
        assert text != null && text.length() > 0;

        warningCount++;
        printMessage(text, 2);
    }

    /**
     * Log a new error.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param text message
     */
    public static void printError(String text)
    {
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(text, 3);
    }
    
    public static void printSyntaxError(String text)
    {
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(text, 4);
    }
    
    public static void printConfigError(String text)
    {
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(text, 5);
    }

    /**
     * Log a new message.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code line > 0}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param line line number
     * @param text message
     */
    public static void printInfo(int line, String text)
    {
        assert line > 0;
        assert text != null && text.length() > 0;

        printMessage(line, text, 1);
    }

    /**
     * Log a new warning.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code line > 0}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param line line number
     * @param text message
     */
    public static void printWarning(int line, String text)
    {
        assert line > 0;
        assert text != null && text.length() > 0;

        warningCount++;
        printMessage(line, text, 2);
    }

    /**
     * Log a new error.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code line > 0}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param line line number
     * @param text message
     */
    public static void printError(int line, String text)
    {
        assert line > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 3);
    }
    
    public static void printSyntaxError(int line, String text)
    {
        assert line > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 4);
    }
    
    public static void printConfigError(int line, String text)
    {
        assert line > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 5);
    }

    public static void printError(int line, String text, int pos)
    {
        assert line > 0;
        //assert pos > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 3, pos);
    }
    
    public static void printSyntaxError(int line, String text, int pos)
    {
        assert line > 0;
        assert pos > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 4, pos);
    }
    
    public static void printConfigError(int line, String text, int pos)
    {
        assert line > 0;
        assert pos > 0;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(line, text, 5, pos);
    }

    /**
     * Log a new message.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code ctx != null}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param ctx parser tree node reference
     * @param text message
     */
    public static void printInfo(ParserRuleContext ctx, String text)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        printMessage(ctx, text, 1);
    }

    /**
     * Log a new warning.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code ctx != null}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param ctx parser tree node reference
     * @param text message
     */
    public static void printWarning(ParserRuleContext ctx, String text)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        warningCount++;
        printMessage(ctx, text, 2);
    }

    /**
     * Log a new error.
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code ctx != null}</dd>
     *    <dd>{@code text != null && text.length() > 0}</dd>
     * </dl></p>
     *
     * @param ctx parser tree node reference
     * @param text message
     */
    public static void printError(ParserRuleContext ctx, String text)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, 3);
    }
    
    public static void printSyntaxError(ParserRuleContext ctx, String text)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, 4);
    }
    
    public static void printConfigError(ParserRuleContext ctx, String text)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, 5);
    }

    public static void printError(ParserRuleContext ctx, String text, String suggested)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, suggested, 3);
    }
    
    public static void printSyntaxError(ParserRuleContext ctx, String text, String suggested)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, suggested, 4);
    }
    
    public static void printConfigError(ParserRuleContext ctx, String text, String suggested)
    {
        assert ctx != null;
        assert text != null && text.length() > 0;

        errorCount++;
        printMessage(ctx, text, suggested, 5);
    }

    /**
     * Regist a new error.
     *
     */
    public static void registerError() {
        errorCount++;
    }

    /**
     * Exists at least one error?
     *
     * @return {@code boolean} true, in the presence of a registered error
     */
    public static boolean error()
    {
        return errorCount > 0;
    }

    /**
     * Number of registered errors.
     *
     * @return {@code int} number of errors
     */
    public static int errorCount()
    {
        return errorCount;
    }

    /**
     * Number of registered warnings.
     *
     * @return {@code int} number of warnings
     */
    public static int warningCount()
    {
        return warningCount;
    }

    /**
     * Redirect log to a new stream file
     *
     * <p><dl><dt><b>Precondition:</b></dt>
     *    <dd>{@code logFile != null}</dd>
     * </dl></p>
     *
     * @param logFile stream
     */
    public static void redirectLogFile(PrintStream logFile)
    {
        assert logFile != null;

        ErrorHandling.logFile = logFile;
    }

    /**
     * Reset regist of all errors and warnings.
     */
    public static void reset()
    {
        errorCount = 0;
        warningCount = 0;
    }

    public static String bold(String str){
        return BOLD + str + RESET;
    }
    
    public static String highlightVar(String str) {
    	return highlight(str,B_GREEN);
    }
    
    public static String highlightFunc(String str) {
    	return highlight(str,B_CYAN);
    }
    
    public static String highlightBehav(String str) {
    	return highlight(str,B_MAGENTA);
    }
    
    public static String highlightCall(String str) {
    	return highlight(str,B_YELLOW);
    }
    
    public static String highlightLiteral(String str) {
    	return highlight(str,B_WHITE);
    }
    
    public static String colourVar(String str) {
    	return colour(str,GREEN);
    }
    
    public static String colourFunc(String str) {
    	return colour(str,CYAN);
    }
    
    public static String colourBehav(String str) {
    	return colour(str,MAGENTA);
    }
    
    public static String colourCall(String str) {
    	return colour(str,YELLOW);
    }
    
    public static String colourLiteral(String str) {
    	return bold(str);
    }

    public static final String RED="\033[0;31m";
    public static final String BRIGHTRED="\033[31;1m";
    public static final String GREEN="\033[0;32m";
    public static final String YELLOW="\033[0;33m";
    public static final String BLUE="\033[0;34m";
    public static final String MAGENTA="\033[0;35m";
    public static final String CYAN="\033[0;36m";
    public static final String BOLD="\033[1;38m";
    public static final String RESET="\033[0m";
    public static final String BLACK="\033[0;30m";
    public static final String BRIGHTBLACK="\033[30;1m";

    public static final String B_RED=" \033[41m";
    public static final String B_GREEN="\033[42m";
    public static final String B_YELLOW="\033[43m";
    public static final String B_BLUE="\033[44m";
    public static final String B_MAGENTA="\033[45m";
    public static final String B_CYAN="\033[46m";
    public static final String B_WHITE="\033[47m";

    /*
     * 1: info
     * 2: warning
     * 3: error
     */
    protected static final String[] prefixMsg = {"INFO", "WARNING", "SEMANTIC ERROR", "SYNTAX ERROR", "CONFIG ERROR"};
    protected static final String[] prefixFormat = {GREEN, YELLOW, RED, BRIGHTRED, BRIGHTBLACK};

    public static String highlight(String str, String colour) {
    	return BLACK + colour + str + RESET;
    }
    
    public static String colour(String str, String colour) {
    	return colour + str + RESET;
    }
    
    protected static void printMessage(String text, int type)
    {
        logFile.printf("%s%s%s: %s\n", prefixFormat[type-1], prefixMsg[type-1], RESET, text);
        logFile.flush();
    }

    protected static void printMessage(int line, String text, int type)
    {
        logFile.printf("%s%s%s at line %s \n  %s\n\n", prefixFormat[type-1], prefixMsg[type-1], RESET, ErrorHandling.bold(Integer.toString(line)), text);
        logFile.flush();
    }
    protected static void printMessage(int line, String text, String suggested, int type)
    {
        logFile.printf("%s%s%s at line %s \n  %s\n  %s%s%s: %s\n\n", prefixFormat[type-1], prefixMsg[type-1], RESET, ErrorHandling.bold(Integer.toString(line)), text, BLUE, "Suggested Actions", RESET, suggested);
        logFile.flush();
    }
    protected static void printMessage(ParserRuleContext ctx, String text, int type)
    {
        printMessage(ctx.getStart().getLine(), text, type);
    }

    protected static void printMessage(ParserRuleContext ctx, String text, String suggested, int type)
    {
        printMessage(ctx.getStart().getLine(), text, suggested, type);
    }

    protected static void printMessage(int line, String text, int type, int pos){
        logFile.printf("%s%s%s at line %s, position %s\n\t %s\n\n", prefixFormat[type-1], prefixMsg[type-1], RESET, ErrorHandling.bold(Integer.toString(line)), ErrorHandling.bold(Integer.toString(pos)), text);
        logFile.flush();
    }

    protected static PrintStream logFile = out; // default
    protected static int errorCount = 0;
    protected static int warningCount = 0;
}
