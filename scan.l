
D   [0-9]
E   [eE][-+]?{D}+
L   [a-zA-Z_]

%%

{L}({L}|{D})*       { return Parser::ID; }
{D}+\.?{D}*{E}?     { return Parser::NUM; }
\.{D}+{E}?          { return Parser::NUM; }

"+"     { return '+'; }
"-"     { return '-'; }
"*"     { return '*'; }
"/"     { return '/'; }
"="     { return '='; }

"("     { return '('; }
")"     { return ')'; }

\n      { return '\n'; }

[ \t]   {}

.       { std::cerr << "Unexpected character `" << matched() << "`" << std::endl; }
