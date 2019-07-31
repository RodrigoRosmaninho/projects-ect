// Generated from config.g4 by ANTLR 4.7.2

package config;

import lib.*;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link configParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface configVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link configParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(configParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#declare}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeclare(configParser.DeclareContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteral(configParser.LiteralContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#header}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitHeader(configParser.HeaderContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#calls}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCalls(configParser.CallsContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#call}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCall(configParser.CallContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#apply}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitApply(configParser.ApplyContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#critical}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCritical(configParser.CriticalContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#init}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInit(configParser.InitContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#returnType}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturnType(configParser.ReturnTypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#vars}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVars(configParser.VarsContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#var}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar(configParser.VarContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#interval}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInterval(configParser.IntervalContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#message}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMessage(configParser.MessageContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#methods}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMethods(configParser.MethodsContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#method}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitMethod(configParser.MethodContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType(configParser.TypeContext ctx);
	/**
	 * Visit a parse tree produced by {@link configParser#number}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNumber(configParser.NumberContext ctx);
}