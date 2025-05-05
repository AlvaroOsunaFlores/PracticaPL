grammar gramaticaG3;

@header {
import java.util.*;
}

@members {
    int nivel = 1;
    String nombreFuncionActual = null;
    String constantes = "";
    String funciones = "";
    String indent() {
        return "    ".repeat(nivel);
    }
}

prg returns [String text]
    : 'program' ID ';' b=blq '.' {
        $text = "#include <stdio.h>\n" + constantes + "\n" + funciones + "void main(void) {\n" + $b.text + "}";
        System.out.println($text);
    }
    | 'unit' ID ';' dcllist '.' {
        $text = "#include <stdio.h>\n\n" + funciones;
        System.out.println($text);
    }
    ;

blq returns [String text]
    : d=dcllist 'begin' s=sentlist 'end' { $text = $d.text + $s.text; }
    ;

dcllist returns [String text]
    : d=dcl r=dcllist { $text = $d.text + $r.text; }
    | { $text = ""; }
    ;

sentlist returns [String text]
    : s=sent r=sentlistP { $text = $s.text + $r.text; }
    ;

sentlistP returns [String text]
    : s=sent r=sentlistP { $text = $s.text + $r.text; }
    | { $text = ""; };


dcl returns [String text]
    : c=defcte { $text = ""; }
    | v=defvar { $text = $v.text; }
    | p=defproc { $text = ""; }
    | f=deffun { $text = ""; }
    ;

defcte returns [String text]
    : 'const' l=ctelist {
        $text = "";
        constantes += $l.text;
    }
    ;

ctelist returns [String text]
    : ID '=' v=simpvalue ';' r=ctelistP { $text = "#define " + $ID.text + " " + $v.text + "\n" + $r.text; }
    ;

ctelistP returns [String text]
    : ID '=' v=simpvalue ';' r=ctelistP { $text = "#define " + $ID.text + " " + $v.text + "\n" + $r.text; }
    | { $text = ""; }
    ;

simpvalue returns [String text]
    : CONSTINT { $text = $CONSTINT.text; }
    | CONSTREAL { $text = $CONSTREAL.text; }
    | CONSTLIT { $text = $CONSTLIT.text; }
    ;

defvar returns [String text]
    : 'var' l=defvarlist ';' { $text = indent() + $l.text; }
    ;

defvarlist returns [String text]
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

varlist returns [String text]
    : ID { $text = $ID.text; }
    | ID ',' r=varlist { $text = $ID.text + ", " + $r.text; }
    ;

defproc returns [String text]
    : 'procedure' ID f=formal_paramlist ';' b=blq ';' {
        funciones += "void " + $ID.text + "(" + $f.text + ") {\n" + $b.text + "}\n\n";
    }
    ;

deffun returns [String text]
    : 'function' ID f=formal_paramlist ':' t=tbas ';' {
        nombreFuncionActual = $ID.text;
    } b=blq ';' {
        funciones += $t.text + " " + $ID.text + "(" + $f.text + ") {\n" + $b.text + "}\n\n";
        nombreFuncionActual = null;
    }
    ;

formal_paramlist returns [String text]
    : '(' f=formal_param ')' { $text = $f.text; }
    | { $text = ""; }
    ;

formal_param returns [String text]
    : v=varlist ':' t=tbas {
        // Dividir variables separadas por coma
        String[] vars = $v.text.split(", ");
        List<String> partes = new ArrayList<>();
        for (String var : vars) {
            partes.add($t.text + " " + var);
        }
        $text = String.join(", ", partes);
    }
    | v=varlist ':' t=tbas ';' r=formal_param {
        String[] vars = $v.text.split(", ");
        List<String> partes = new ArrayList<>();
        for (String var : vars) {
            partes.add($t.text + " " + var);
        }
        $text = String.join(", ", partes) + ", " + $r.text;
    }
    ;

tbas returns [String text]
    : 'INTEGER' { $text = "int"; }
    | 'REAL' { $text = "float"; }
    ;

sent returns [String text]
    : a=asig ';' { $text = indent() + $a.text + ";\n"; }
    | p=proc_call ';' { $text = indent() + $p.text + ";\n"; }
    | 'if' e=expcond 'then' {nivel++;} b=blq {
        nivel--;
        $text = indent() + "if (" + $e.text + ") {\n" + $b.text + indent() + "}\n";
    }
    | 'if' e=expcond 'then' {nivel++;} b1=blq 'else' b2=blq {
        nivel--;
        $text = indent() + "if (" + $e.text + ") {\n" + $b1.text + indent() + "} else {\n" + $b2.text + indent() + "}\n";
    }
    | 'while' e=expcond 'do' {nivel++;} b=blq {
        nivel--;
        $text = indent() + "while (" + $e.text + ") {\n" + $b.text + indent() + "}\n";
    }
    | 'repeat' {nivel++;} b=blq 'until' e=expcond ';' {
        nivel--;
        $text = indent() + "do {\n" + $b.text + indent() + "} while (!(" + $e.text + "));\n";
    }
    | 'for' ID ':=' i=exp inc f=exp 'do' {nivel++;} b=blq {
        nivel--;
        String cmp = $inc.text.equals("to") ? "<=" : ">=";
        String step = $inc.text.equals("to") ? "++" : "--";
        $text = indent() + "for (" + $ID.text + " = " + $i.text + "; " + $ID.text + " " + cmp + " " + $f.text + "; " + $ID.text + step + ") {\n" + $b.text + indent() + "}\n";
    }
    ;

asig returns [String text]
    : ID ':=' e=exp {
        if (nombreFuncionActual != null && $ID.text.equals(nombreFuncionActual)) {
            $text = "return " + $e.text;
        }else {
            $text = $ID.text + " = " + $e.text;
        }
    }
    ;

exp returns [String text]
    : f=factor r=expP { $text = $f.text + $r.text; }
    ;

expP returns [String text]
    : o=op e=exp r=expP { $text = " " + $o.text + " " + $e.text + $r.text; }
    | { $text = ""; }
    ;

op returns [String text]
    : oparit { $text = $oparit.text; }
    ;

oparit returns [String text]
    : '+' { $text = "+"; }
    | '-' { $text = "-"; }
    | '*' { $text = "*"; }
    | 'div' { $text = "/"; }
    | 'mod' { $text = "%"; }
    ;

factor returns [String text]
    : s=simpvalue { $text = $s.text; }
    | '(' e=exp ')' { $text = "(" + $e.text + ")"; }
    | ID sub=subparamlist { $text = $ID.text + $sub.text; }
    ;

subparamlist returns [String text]
    : '(' l=explist ')' { $text = "(" + $l.text + ")"; }
    | { $text = ""; }
    ;

explist returns [String text]
    : e=exp { $text = $e.text; }
    | e=exp ',' r=explist { $text = $e.text + ", " + $r.text; }
    ;

proc_call returns [String text]
    : ID s=subparamlist { $text = $ID.text + $s.text; }
    ;

inc returns [String text]
    : 'to' { $text = "to"; }
    | 'downto' { $text = "downto"; }
    ;

expcond returns [String text]
    : f=factorcond r=expcondP { $text = $f.text + $r.text; }
    ;

expcondP returns [String text]
    : o=oplog f=factorcond r=expcondP { $text = " " + $o.text + " " + $f.text + $r.text; }
    | { $text = ""; }
    ;

oplog returns [String text]
    : 'or' { $text = "||"; }
    | 'and' { $text = "&&"; }
    ;

factorcond returns [String text]
    : e1=exp o=opcomp e2=exp { $text = $e1.text + " " + $o.text + " " + $e2.text; }
    | '(' e=expcond ')' { $text = "(" + $e.text + ")"; }
    | 'not' f=factorcond { $text = "!" + $f.text; }
    | ex=exp { $text = $ex.text; }
    ;

opcomp returns [String text]
    : '<' { $text = "<"; }
    | '>' { $text = ">"; }
    | '<=' { $text = "<="; }
    | '>=' { $text = ">="; }
    | '=' { $text = "=="; }
    ;

// Tokens
ID: [a-zA-Z]([a-zA-Z0-9_])*;
CONSTINT: ('+'|'-')?[0-9]+;
CONSTREAL: CONSTINT(('.'[0-9]+)|(('e'|'E')CONSTINT)|('.'[0-9]+)(('e'|'E')CONSTINT));
CONSTLIT: '\''(~'\''|'\\\'')* '\'';
COMMENT: ('{'~[{}\n]*'}' | '(*' .*? '*)') -> skip;
WS : [ \t\r\n]+ -> skip;
INTERFACE: 'interface' -> skip;
IMPLEMENTATION: 'implementation' -> skip;
ERROR_CHAR: . {
    System.err.println("Carácter inválido: '" + getText() + "' en la línea " + getLine() + ", columna " + getCharPositionInLine());
};