import java.io.*;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTree;

public class Main {
    public static void main(String[] args) {
        try{
            CharStream input = CharStreams.fromFileName(args[0]);
            gramaticaG3Lexer analex = new gramaticaG3Lexer(input);
            CommonTokenStream tokens = new CommonTokenStream(analex);
            gramaticaG3Parser anasint = new gramaticaG3Parser(tokens);
            ParseTree parseTree = anasint.prg();
            System.out.println(parseTree.toStringTree(anasint));
        } catch (org.antlr.v4.runtime.RecognitionException e) {
            //Fallo al reconocer la entrada
            System.err.println("REC " + e.getMessage());
        } catch (IOException e) {
            //Fallo de entrada/salida
            System.err.println("IO " + e.getMessage());
        } catch (java.lang.RuntimeException e) {
            //Cualquier otro fallo
            System.err.println("RUN " + e.getMessage());
        }
    }
}