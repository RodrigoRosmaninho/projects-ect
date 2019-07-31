// Generated from cral.g4 by ANTLR 4.7.2

package language;

import lib.*;
import java.util.*;

import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link cralParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface cralVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link cralParser#program}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProgram(cralParser.ProgramContext ctx);
	/**
	 * Visit a parse tree produced by the {@code topAssign}
	 * labeled alternative in {@link cralParser#top}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTopAssign(cralParser.TopAssignContext ctx);
	/**
	 * Visit a parse tree produced by the {@code topDeclare}
	 * labeled alternative in {@link cralParser#top}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTopDeclare(cralParser.TopDeclareContext ctx);
	/**
	 * Visit a parse tree produced by the {@code topBehaviour}
	 * labeled alternative in {@link cralParser#top}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTopBehaviour(cralParser.TopBehaviourContext ctx);
	/**
	 * Visit a parse tree produced by the {@code topFunction}
	 * labeled alternative in {@link cralParser#top}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTopFunction(cralParser.TopFunctionContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#type}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitType(cralParser.TypeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code literalBool}
	 * labeled alternative in {@link cralParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteralBool(cralParser.LiteralBoolContext ctx);
	/**
	 * Visit a parse tree produced by the {@code literalNum}
	 * labeled alternative in {@link cralParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteralNum(cralParser.LiteralNumContext ctx);
	/**
	 * Visit a parse tree produced by the {@code literalString}
	 * labeled alternative in {@link cralParser#literal}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitLiteralString(cralParser.LiteralStringContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#string}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitString(cralParser.StringContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#ref}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRef(cralParser.RefContext ctx);
	/**
	 * Visit a parse tree produced by the {@code atomLiteral}
	 * labeled alternative in {@link cralParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtomLiteral(cralParser.AtomLiteralContext ctx);
	/**
	 * Visit a parse tree produced by the {@code atomCall}
	 * labeled alternative in {@link cralParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtomCall(cralParser.AtomCallContext ctx);
	/**
	 * Visit a parse tree produced by the {@code atomFunction}
	 * labeled alternative in {@link cralParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtomFunction(cralParser.AtomFunctionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code atomID}
	 * labeled alternative in {@link cralParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtomID(cralParser.AtomIDContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#declaration}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeclaration(cralParser.DeclarationContext ctx);
	/**
	 * Visit a parse tree produced by the {@code assignDeclare}
	 * labeled alternative in {@link cralParser#assignment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignDeclare(cralParser.AssignDeclareContext ctx);
	/**
	 * Visit a parse tree produced by the {@code assignID}
	 * labeled alternative in {@link cralParser#assignment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignID(cralParser.AssignIDContext ctx);
	/**
	 * Visit a parse tree produced by the {@code assignOp}
	 * labeled alternative in {@link cralParser#assignment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignOp(cralParser.AssignOpContext ctx);
	/**
	 * Visit a parse tree produced by the {@code assignInc}
	 * labeled alternative in {@link cralParser#assignment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAssignInc(cralParser.AssignIncContext ctx);
	/**
	 * Visit a parse tree produced by the {@code incLeftExpr}
	 * labeled alternative in {@link cralParser#increment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncLeftExpr(cralParser.IncLeftExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code incRightExpr}
	 * labeled alternative in {@link cralParser#increment}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncRightExpr(cralParser.IncRightExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#behaviourSet}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBehaviourSet(cralParser.BehaviourSetContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#behaviourDeclare}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBehaviourDeclare(cralParser.BehaviourDeclareContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#actionCall}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitActionCall(cralParser.ActionCallContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#functionCall}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionCall(cralParser.FunctionCallContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#argumentCall}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArgumentCall(cralParser.ArgumentCallContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#functionDeclare}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFunctionDeclare(cralParser.FunctionDeclareContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#argumentDeclare}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArgumentDeclare(cralParser.ArgumentDeclareContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#returnStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitReturnStat(cralParser.ReturnStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#statement}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStatement(cralParser.StatementContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#block}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlock(cralParser.BlockContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#whenStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhenStat(cralParser.WhenStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#whileStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitWhileStat(cralParser.WhileStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#untilStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUntilStat(cralParser.UntilStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#forStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForStat(cralParser.ForStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#breakStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBreakStat(cralParser.BreakStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#checkStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCheckStat(cralParser.CheckStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#otherStat}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOtherStat(cralParser.OtherStatContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#forRange}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitForRange(cralParser.ForRangeContext ctx);
	/**
	 * Visit a parse tree produced by the {@code parExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParExpr(cralParser.ParExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code unaryExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUnaryExpr(cralParser.UnaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code incExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIncExpr(cralParser.IncExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code ternaryExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTernaryExpr(cralParser.TernaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code atomExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAtomExpr(cralParser.AtomExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code binaryExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBinaryExpr(cralParser.BinaryExprContext ctx);
	/**
	 * Visit a parse tree produced by the {@code intervalExpr}
	 * labeled alternative in {@link cralParser#expr}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitIntervalExpr(cralParser.IntervalExprContext ctx);
	/**
	 * Visit a parse tree produced by {@link cralParser#interval}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInterval(cralParser.IntervalContext ctx);
}