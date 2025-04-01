// Generated from C:/Users/jonmh/Downloads/PracticaObligatoriaGrupo3/PracticaObligatoriaGrupo3/src/gramaticaG3.g4 by ANTLR 4.13.2
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link gramaticaG3Parser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface gramaticaG3Visitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#axioma}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAxioma(gramaticaG3Parser.AxiomaContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#prg}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrg(gramaticaG3Parser.PrgContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#blq}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBlq(gramaticaG3Parser.BlqContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#dcllist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDcllist(gramaticaG3Parser.DcllistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#sentlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSentlist(gramaticaG3Parser.SentlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#sentlistP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSentlistP(gramaticaG3Parser.SentlistPContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#dcl}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDcl(gramaticaG3Parser.DclContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#defcte}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefcte(gramaticaG3Parser.DefcteContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#ctelist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCtelist(gramaticaG3Parser.CtelistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#ctelistP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCtelistP(gramaticaG3Parser.CtelistPContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#simpvalue}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSimpvalue(gramaticaG3Parser.SimpvalueContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#defvar}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefvar(gramaticaG3Parser.DefvarContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#defvarlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefvarlist(gramaticaG3Parser.DefvarlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#defvarlistP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefvarlistP(gramaticaG3Parser.DefvarlistPContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#varlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVarlist(gramaticaG3Parser.VarlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#defproc}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefproc(gramaticaG3Parser.DefprocContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#deffun}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDeffun(gramaticaG3Parser.DeffunContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#formal_paramlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFormal_paramlist(gramaticaG3Parser.Formal_paramlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#formal_param}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFormal_param(gramaticaG3Parser.Formal_paramContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#tbas}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTbas(gramaticaG3Parser.TbasContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#sent}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSent(gramaticaG3Parser.SentContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#asig}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAsig(gramaticaG3Parser.AsigContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#exp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExp(gramaticaG3Parser.ExpContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#expP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpP(gramaticaG3Parser.ExpPContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#op}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOp(gramaticaG3Parser.OpContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#oparit}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOparit(gramaticaG3Parser.OparitContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#factor}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFactor(gramaticaG3Parser.FactorContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#subparamlist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSubparamlist(gramaticaG3Parser.SubparamlistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#explist}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExplist(gramaticaG3Parser.ExplistContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#proc_call}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitProc_call(gramaticaG3Parser.Proc_callContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#inc}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInc(gramaticaG3Parser.IncContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#expcond}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpcond(gramaticaG3Parser.ExpcondContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#expcondP}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpcondP(gramaticaG3Parser.ExpcondPContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#oplog}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOplog(gramaticaG3Parser.OplogContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#factorcond}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFactorcond(gramaticaG3Parser.FactorcondContext ctx);
	/**
	 * Visit a parse tree produced by {@link gramaticaG3Parser#opcomp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOpcomp(gramaticaG3Parser.OpcompContext ctx);
}