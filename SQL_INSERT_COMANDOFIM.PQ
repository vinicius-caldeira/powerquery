let
  Fonte = ConsultaUnida[Personalizar], // PARA CRIAR ESSA CONSULTA FEZ REFERENCIA DA CONSULTA UNIDA ANTERIOR , E COLOCOU O PERSONALIZAR DENTRO DE COLCHETES PARA SE CRIAR UMA LISTA
  Personalizar1 = 1, // INSERIDO UMA ETAPA MANUALMENTE "MACETE"
  #"Convertido para Tabela" = #table(1, {{Personalizar1}}), //"MACETE ATRAS DE MACETE"
  #"Personalização Adicionada" = Table.AddColumn(
      #"Convertido para Tabela", 
      "Personalizar", 
      each Fonte
    ), // ADICIONADO UMA COLUNA COM A ETAPA FONTE, QUE SERÁ UMA LISTA
  #"Valores Extraídos" = Table.TransformColumns(
      #"Personalização Adicionada", 
      {"Personalizar", each Text.Combine(List.Transform(_, Text.From)), type text}
    ), // COM ESSA LISTA PODEMOS EXTRAIR PARA NOVAS LINHAS, O NORMAL DE FAZERMOS, MAS NESTE CASO IREMOS EXTRAIR VALORES
  Personalizar = #"Valores Extraídos"{0}[Personalizar] // ULTIMO PASSO FOI FAZER DRILLDOWN DA LISTA ESXTRAIDA EM VALORES
in
  Personalizar