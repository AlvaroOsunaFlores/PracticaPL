import org.antlr.v4.runtime.*;

public class CustomErrorListener extends BaseErrorListener {
    @Override
    public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol,
                            int line, int charPositionInLine,
                            String msg, RecognitionException e) {
        System.err.println("Error de sintaxis en línea " + line + ", columna " + charPositionInLine + ": " + msg);
        System.err.println("Posible causa: " + getPossibleCause(msg));
    }

    private String getPossibleCause(String msg) {
        if (msg.contains("mismatched input")) {
            return "Entrada inesperada, posiblemente un error de sintaxis.";
        } else if (msg.contains("no viable alternative")) {
            return "Alternativa no viable, probablemente una estructura incompleta.";
        } else {
            return "Error general de sintaxis.";
        }
    }

}
