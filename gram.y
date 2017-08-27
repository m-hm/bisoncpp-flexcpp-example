%scanner                    Scanner.h
%scanner-token-function     d_scanner.lex()

%token ID NUM

%polymorphic
    DOUBLE: double;
    STRING: std::string;

%left '+' '-'
%left '*' '/'
%right NEG

%type<DOUBLE> expr
%type<STRING> ident

%start program

%%

program
    : /*empty*/
    | program stmt
;

stmt
    : '\n'
    | var_assign '\n'
    | print_stmt '\n'
;

print_stmt
    : expr      { std::cout << "\t" << $1 << std::endl; }
;

var_assign
    : ident '=' expr    { vars[$1] = $3; }
;

expr
    : ident     { $$ = vars[$1]; }
    | NUM       { $$ = std::stod(d_scanner.matched()); }
    | '(' expr ')'          { $$ = $1; }
    | '-' expr %prec NEG    { $$ = -$2; }
    | '+' expr %prec NEG    { $$ = $2; }
    | expr '+' expr         { $$ = $1 + $3; }
    | expr '-' expr         { $$ = $1 - $3; }
    | expr '*' expr         { $$ = $1 * $3; }
    | expr '/' expr         { $$ = $1 / $3; }
;


ident
    : ID    { $$ = d_scanner.matched(); }
;