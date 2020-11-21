let
  Fonte = Table.Buffer(fVendas),
  #"Consultas Mescladas" = Table.NestedJoin(
      Fonte, 
      {"PRODUTO"}, 
      dProdutos, 
      {"COD"}, 
      "dProdutos", 
      JoinKind.LeftOuter
    ),
  #"dProdutos Expandido" = Table.ExpandTableColumn(
      #"Consultas Mescladas", 
      "dProdutos", 
      {" NOME", " MARCA"}, 
      {" NOME", " MARCA"}
    ),
  #"Consultas Mescladas1" = Table.NestedJoin(
      #"dProdutos Expandido", 
      {" MARCA"}, 
      dRepresentantes, 
      {"MARCA"}, 
      "dRepresentantes", 
      JoinKind.LeftOuter
    ),
  #"dRepresentantes Expandido" = Table.ExpandTableColumn(
      #"Consultas Mescladas1", 
      "dRepresentantes", 
      {" REPRESENTANTE"}, 
      {" REPRESENTANTE"}
    ),
  #"Linhas Filtradas" = Table.SelectRows(
      #"dRepresentantes Expandido", 
      each Date.IsInCurrentYear([DATA])
    ),
  #"Linhas Classificadas" = Table.Sort(#"Linhas Filtradas", {{"DATA", Order.Ascending}}),
  #"Colunas Reordenadas" = Table.ReorderColumns(
      #"Linhas Classificadas", 
      {"PRODUTO", " NOME", " MARCA", " REPRESENTANTE", "DATA", "QTD", "VALOR"}
    ),
  #"Outras Colunas Removidas" = Table.SelectColumns(
      #"Colunas Reordenadas", 
      {"PRODUTO", " NOME", " MARCA", " REPRESENTANTE", "DATA", "QTD", "VALOR"}
    ),
  #"Colunas Renomeadas" = Table.RenameColumns(#"Outras Colunas Removidas", {{"DATA", "DataVenda"}}),
  #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas Renomeadas", {{"VALOR", type text}}),
  #"Valor Substituído" = Table.ReplaceValue(
// para inserir no banco de dados não pode ter virgula (,) e sim ponto (.)     
 #"Tipo Alterado", 
      ",", 
      ".", 
      Replacer.ReplaceText, 
      {"VALOR"}
    ),
  #"Colunas Mescladas" = Table.CombineColumns(Table.TransformColumnTypes(#"Valor Substituído", {{"PRODUTO", type text}, {"DataVenda", type text}, {"QTD", type text}, {"VALOR", type text}}, "pt-BR"),{"PRODUTO", " NOME", " MARCA", " REPRESENTANTE", "DataVenda", "QTD", "VALOR"},Combiner.CombineTextByDelimiter("' , '", QuoteStyle.None),"Mesclado"),
  #"Personalização Adicionada" = Table.AddColumn(
      #"Colunas Mescladas", 
// inseririndo o comando no PQ para inserir os dados no SQL     
 "Personalizar", 
      each "INSERT INTO Z_VINICIUS VALUES ('" & [Mesclado] & "');"
    ),
  #"Outras Colunas Removidas1" = Table.SelectColumns(#"Personalização Adicionada", {"Personalizar"})
in
  #"Outras Colunas Removidas1"