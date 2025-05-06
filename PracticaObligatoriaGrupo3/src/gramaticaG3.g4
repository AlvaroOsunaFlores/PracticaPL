grammar gramaticaG3;

@header {
import java.util.*;
}

@members {
    int nivel = 1;  // Controla la indentación en la generación de código.
    String nombreFuncionActual = null;  // Almacena el nombre de la función actualmente procesada.
    String constantes = "";  // Almacena las constantes declaradas en el programa.
    String funciones = "";  // Almacena las definiciones de funciones y procedimientos.
    String indent() {
        return "    ".repeat(nivel);
    }
}

// Regla que define la estructura de un programa principal o una unidad (unit).
prg returns [String text]
    : 'program' ID ';' b=blq '.' {
        // Genera el código principal, incluyendo encabezados, constantes, funciones y el bloque principal.
        $text = constantes + "\n" + funciones + "void main(void) {\n" + $b.text + "}";
        System.out.println($text);
    }
    | 'unit' ID ';' dcllist '.' {
        // Genera código para una unidad sin un bloque principal.
        $text = constantes + "\n" + funciones;
        System.out.println($text);
    }
    ;

// Regla para un bloque de código.
blq returns [String text]
    : d=dcllist 'begin' s=sentlist 'end' {
        // Incluye las declaraciones y sentencias del bloque.
        $text = $d.text + $s.text;
    }
    ;

// Reglas para la lista de declaraciones.
dcllist returns [String text]
    // Combina múltiples declaraciones.
    : d=dcl r=dcllist { $text = $d.text + $r.text; }
    // Sin declaraciones
    | { $text = ""; }
    ;

// Regla para la lista de sentencias.
sentlist returns [String text]
    // Combina múltiples sentencias
    : s=sent r=sentlistP { $text = $s.text + $r.text; }
    ;

sentlistP returns [String text]
    // Combina sentencias adicionales
    : s=sent r=sentlistP { $text = $s.text + $r.text; }
    // Sin sentencias adicionales
    | { $text = ""; };

// Regla para definir declaraciones en el programa.
dcl returns [String text]
    : c=defcte { $text = ""; }  // Declaración de constantes (no devuelve texto, se almacena en "constantes").
    | v=defvar { $text = $v.text; }  // Declaración de variables.
    | p=defproc { $text = ""; }  // Declaración de un procedimiento (no devuelve texto, se almacena en "funciones").
    | f=deffun { $text = ""; }  // Declaración de una función (no devuelve texto, se almacena en "funciones").
    ;

// Regla para definir constantes.
defcte returns [String text]
    : 'const' l=ctelist {
        // Genera la representación de constantes como #define.
        $text = "";
        constantes += $l.text;  // Se agrega a la lista global de constantes.
    }
    ;

// Lista de constantes.
ctelist returns [String text]
    // Define constantes como #define en C.
    : ID '=' v=simpvalue ';' r=ctelistP { $text = "#define " + $ID.text + " " + $v.text + "\n" + $r.text; }
    ;

ctelistP returns [String text]
    // Define constantes adicionales.
    : ID '=' v=simpvalue ';' r=ctelistP { $text = "#define " + $ID.text + " " + $v.text + "\n" + $r.text; }
    // No hay constantes adicionales.
    | { $text = ""; }
    ;

// Representaciones de valores simples para constantes (enteros, reales o cadenas).
simpvalue returns [String text]
    : CONSTINT { $text = $CONSTINT.text; }  // Constante entera
    | CONSTREAL { $text = $CONSTREAL.text; }  // Constante real
    | CONSTLIT { $text = $CONSTLIT.text; }  // Literal de texto
    ;

// Regla para definir variables.
defvar returns [String text]
    // Genera la declaración de variables con su tipo base.
    : 'var' l=defvarlist ';' { $text = indent() + $l.text; }
    ;

// Regla para la lista de variables, especificando su tipo.
defvarlist returns [String text]
    // Declara variables con su tipo de base.
    : v=varlist ':' t=tbas r=defvarlistP {
        $text = $t.text + " " + $v.text + ";\n" + $r.text;
    }
    ;

defvarlistP returns [String text]
    : ';' v=varlist ':' t=tbas r=defvarlistP {
        $text = indent() + $t.text + " " + $v.text + ";\n" + $r.text;
    }
    | { $text = ""; }
    ;

// Regla para nombres de variables separadas por ','
varlist returns [String text]
    : ID { $text = $ID.text; }  // Variable única.
    | ID ',' r=varlist { $text = $ID.text + ", " + $r.text; }  // // Múltiples variables separadas por coma.
    ;

// Regla para definir procedimientos.
defproc returns [String text]
    : 'procedure' ID f=formal_paramlist ';' b=blq ';' {
        // Genera la definición de un procedimiento sin valor de retorno.
        funciones += "void " + $ID.text + "(" + $f.text + ") {\n" + $b.text + "}\n\n";
    }
    ;

// Regla para definir funciones.
deffun returns [String text]
    : 'function' ID f=formal_paramlist ':' t=tbas ';' {
        // Almacena el nombre de la función.
        nombreFuncionActual = $ID.text;
    } b=blq ';' {
        // Genera la cabecera de la función, completa con el bloque y la agrega a las funciones globales.
        funciones += $t.text + " " + $ID.text + "(" + $f.text + ") {\n" + $b.text + "}\n\n";
        nombreFuncionActual = null;
    }
    ;

// Regla para definir parámetros formales.
formal_paramlist returns [String text]
    // Lista de parámetros entre paréntesis.
    : '(' f=formal_param ')' { $text = $f.text; }
    // No hay parametros formales.
    | { $text = ""; }
    ;

// Regla para un parámetro formal con su tipo base.
formal_param returns [String text]
    : v=varlist ':' t=tbas {
        // Dividir variables separadas por coma.
        // Genera la lista de parámetros con tipo.
        String[] vars = $v.text.split(", ");
        List<String> partes = new ArrayList<>();
        for (String var : vars) {
            partes.add($t.text + " " + var);  // Combina el tipo con el nombre de cada variable.
        }
        $text = String.join(", ", partes);
    }
    // permite procesar más de un grupo de parámetros utilizando la recursividad.
    | v=varlist ':' t=tbas ';' r=formal_param {
        String[] vars = $v.text.split(", ");
        List<String> partes = new ArrayList<>();
        for (String var : vars) {
            partes.add($t.text + " " + var);
        }
        $text = String.join(", ", partes) + ", " + $r.text;
    }
    ;

// Regla para especificar tipos de datos básicos.
tbas returns [String text]
    : 'INTEGER' { $text = "int"; }  // Tipo entero.
    | 'REAL' { $text = "float"; }  // Tipo real.
    ;

// Regla para diferentes tipos de sentencias.
sent returns [String text]
    // Sentencia de asignación.
    : a=asig ';' { $text = indent() + $a.text + ";\n"; }
    // Llamada a un procedimiento.
    | p=proc_call ';' { $text = indent() + $p.text + ";\n"; }
    | 'if' e=expcond 'then' {nivel++;} b=blq {
        nivel--;
        $text = indent() + "if (" + $e.text + ") {\n" + $b.text + indent() + "}\n";
    }
    // Sentencia condicional con un bloque
    | 'if' e=expcond 'then' {nivel++;} b1=blq 'else' b2=blq {
        nivel--;
        $text = indent() + "if (" + $e.text + ") {\n" + $b1.text + indent() + "} else {\n" + $b2.text + indent() + "}\n";
    }
    // Sentencia bucle while
    | 'while' e=expcond 'do' {nivel++;} b=blq {
        nivel--;
        $text = indent() + "while (" + $e.text + ") {\n" + $b.text + indent() + "}\n";
    }
    // Sentencia bucle repeat-until
    | 'repeat' {nivel++;} b=blq 'until' e=expcond ';' {
        nivel--;
        $text = indent() + "do {\n" + $b.text + indent() + "} while (!(" + $e.text + "));\n";
    }
    // Sentencia bucle for
    | 'for' ID ':=' i=exp inc f=exp 'do' {nivel++;} b=blq {
        nivel--;
        String cmp = $inc.text.equals("to") ? "<=" : ">=";
        String step = $inc.text.equals("to") ? "++" : "--";
        $text = indent() + "for (" + $ID.text + " = " + $i.text + "; " + $ID.text + " " + cmp + " " + $f.text + "; " + $ID.text + step + ") {\n" + $b.text + indent() + "}\n";
    }
    ;

// Regla para manejar asignaciones.
asig returns [String text]
    : ID ':=' e=exp {
        // Si la asignación corresponde al nombre de la función actual, lo interpreta como una instrucción "return".
        if (nombreFuncionActual != null && $ID.text.equals(nombreFuncionActual)) {
            $text = "return " + $e.text;
        } else {
            // Traducción de una asignación normal.
            $text = $ID.text + " = " + $e.text;
        }
    }
    ;

// Reglas que manejan expresiones.
exp returns [String text]
    // Construye una expresión combinando un factor inicial y sus relaciones adicionales.
    : f=factor r=expP { $text = $f.text + $r.text; }
    ;

expP returns [String text]
    // Expresión recursiva que incluye operadores y subexpresiones.
    : o=op e=exp r=expP { $text = " " + $o.text + " " + $e.text + $r.text; }
    // No hay más operadores.
    | { $text = ""; }
    ;

// Regla que maneja operadores.
op returns [String text]
    // Devuelve un operador aritmético específico.
    : oparit { $text = $oparit.text; }
    ;

oparit returns [String text]
    : '+' { $text = "+"; }  // Operador de suma.
    | '-' { $text = "-"; }  // Operador de resta.
    | '*' { $text = "*"; }  // Operador de multiplicación.
    | 'div' { $text = "/"; }  // Operador de división.
    | 'mod' { $text = "%"; }  // Operador de módulo.
    ;

// Regla que manejan factores.
factor returns [String text]
    // Un factor puede ser un valor simple.
    : s=simpvalue { $text = $s.text; }
    // Un factor puede ser una expresión entre paréntesis.
    | '(' e=exp ')' { $text = "(" + $e.text + ")"; }
    // Un factor puede ser una variable o una llamada a función con parámetros.
    | ID sub=subparamlist { $text = $ID.text + $sub.text; }
    ;

// Regla que maneja lista de parámetros.
subparamlist returns [String text]
    // Lista de parámetros pasados a una función entre paréntesis.
    : '(' l=explist ')' { $text = "(" + $l.text + ")"; }
    // No hay parámetros.
    | { $text = ""; }
    ;

// Regla que maneja lista de expresiones.
explist returns [String text]
    // Lista de expresiones con un elemento.
    : e=exp { $text = $e.text; }
    // Lista de expresiones separadas por coma.
    | e=exp ',' r=explist { $text = $e.text + ", " + $r.text; }
    ;

// Regla que maneja llamadas a funciones.
proc_call returns [String text]
    : ID s=subparamlist { $text = $ID.text + $s.text; }
    ;

inc returns [String text]
    : 'to' { $text = "to"; }  // Incremento en bucle for.
    | 'downto' { $text = "downto"; }  // Decremento en bucle for.
    ;

// Reglas que manejan expresiones condicionales.
expcond returns [String text]
    // Construye una expresión condicional combinando factores condicionales.
    : f=factorcond r=expcondP { $text = $f.text + $r.text; }
    ;

expcondP returns [String text]
    // Expresión condicional recursiva con operadores lógicos.
    : o=oplog f=factorcond r=expcondP { $text = " " + $o.text + " " + $f.text + $r.text; }
    | { $text = ""; }
    ;

oplog returns [String text]
    : 'or' { $text = "||"; }  // Operador lógico OR.
    | 'and' { $text = "&&"; }  // Operador lógico AND.
    ;

// Reglas que manejan factores condicionales.
factorcond returns [String text]
    // Condicional que compara dos expresiones.
    : e1=exp o=opcomp e2=exp { $text = $e1.text + " " + $o.text + " " + $e2.text; }
    // Condicional entre paréntesis.
    | '(' e=expcond ')' { $text = "(" + $e.text + ")"; }
    // Negación lógica de un condicional.
    | 'not' f=factorcond { $text = "!" + $f.text; }
    // Una expresión puede ser un condicional.
    | ex=exp { $text = $ex.text; }
    ;

opcomp returns [String text]
    : '<' { $text = "<"; } // Operador menor que.
    | '>' { $text = ">"; } // Operador mayor que.
    | '<=' { $text = "<="; } // Operador menor o igual.
    | '>=' { $text = ">="; } // Operador mayor o igual.
    | '=' { $text = "=="; } // Operador de igualdad.
    ;

// Tokens
ID: [a-zA-Z]([a-zA-Z0-9_])*;
CONSTINT: ('+'|'-')?[0-9]+;
CONSTREAL: CONSTINT(('.'[0-9]+)|(('e'|'E')CONSTINT)|('.'[0-9]+)(('e'|'E')CONSTINT));
CONSTLIT: '\''(~'\''|'\\\'')* '\'';
COMMENT: ('{'~[{}\n]*'}' | '(*' .*? '*)') -> skip;
WS : [ \t\r\n]+ -> skip;
ERROR_CHAR: . {
    System.err.println("Carácter inválido: '" + getText() + "' en la línea " + getLine() + ", columna " + getCharPositionInLine());
};