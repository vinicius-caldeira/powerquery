let
    Fonte = Sql.Database("LOCALHOST", "ADVENTUREWORKSDW2016", [Query="

-- retire os '--' abaixo para fazer inserção dos valores no banco de dados
-- "&ComandoFim&"

-- visualize os dados inseridos (caso tenha banco dados instalado em sua máquina)
SELECT * FROM Z_JOVIANO

"])
in
    Fonte