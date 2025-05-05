import java.io.*;
import org.antlr.v4.runtime.*;

public class Main {
    public static void main(String[] args) throws IOException {
        try{
            CharStream input = CharStreams.fromFileName(args[0]);
            gramaticaG3Lexer analex = new gramaticaG3Lexer(input);
            CommonTokenStream tokens = new CommonTokenStream(analex);
            gramaticaG3Parser anasint = new gramaticaG3Parser(tokens);
            // Eliminar los listeners por defecto
            anasint.removeErrorListeners();
            analex.removeErrorListeners();
            // Añadir tu listener personalizado
            anasint.addErrorListener(new CustomErrorListener());
            analex.addErrorListener(new CustomErrorListener());
            anasint.prg();
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