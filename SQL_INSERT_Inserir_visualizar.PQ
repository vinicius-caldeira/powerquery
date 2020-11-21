let
/* 
para criar essa estrutura, usamos um nova consulta e buscando do SQL SERVER, dando nome do servidor(localHost), 
nome do banco de dados(ADVENTUREWORKSDW2016), e  em opções avançadas usamos uma instrução de SELECT A=1, 
para que possa ser criado a estrutura 
*/
// nesta query estamos fazendo dois comandos, um de inserir(ComandoFim) e outro de Visualizar(SELECT * FROM Z_JOVIANO)
Fonte = Sql.Database(
      "LOCALHOST", 
      "ADVENTUREWORKSDW2016",[Query = "  
         
-- retire os '--' abaixo para fazer inserção dos valores no banco de dados
-- "&ComandoFim&" // inserir os dados no SQL
     
-- visualize os dados inseridos (caso tenha banco dados instalado em sua máquina)
SELECT * FROM Z_VINICIUS " // visualiza os dados inserido no SQL
      ]
    )
// APOS DAR ENTER NO COMANDO ACIMA, DEVE SER APRESENTADO EMBAIXO A TABELA INSERIDA QUE ESTAVA NA LISTA
in
  Fonte

/* ARQUIVO ORIGINAL JOVIANO
let
    Fonte = Sql.Database("LOCALHOST", "ADVENTUREWORKSDW2016", [Query="

-- retire os '--' abaixo para fazer inserção dos valores no banco de dados
-- "&ComandoFim&"

-- visualize os dados inseridos (caso tenha banco dados instalado em sua máquina)
SELECT * FROM Z_JOVIANO

"])
in
    Fonte
*/