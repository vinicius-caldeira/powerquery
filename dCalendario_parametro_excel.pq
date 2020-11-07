let
  Fonte = List.Dates(
      dDatadoexcel_Inicial_VC, 
      Duration.Days(dDatadoexcel_Final_VC - dDatadoexcel_Inicial_VC) + 1, 
      #duration(1, 0, 0, 0)
    ),
  #"Convertido para Tabela" = Table.FromList(
      Fonte, 
      Splitter.SplitByNothing(), 
      null, 
      null, 
      ExtraValues.Error
    ),
  #"Colunas Renomeadas" = Table.RenameColumns(#"Convertido para Tabela", {{"Column1", "Data"}}),
  Datas = Table.TransformColumnTypes(#"Colunas Renomeadas", {{"Data", type date}}),
  Outras = Table.AddColumn(
      Datas, 
      "Outras", 
      each #table(
          {
            "AnoNum", 
            "AnoInicio", 
            "AnoFinal", 
            "MesNum", 
            "MesIni", 
            "MesFim", 
            "MesDias", 
            "TrimestreIni", 
            "TrimestreFim", 
            "TrimestreAno", 
            "SemanaAno", 
            "SemanaMes"
          }, 
          {
            {
              Date.Year([Data]), 
              Date.StartOfYear([Data]), 
              Date.EndOfYear([Data]), 
              Date.Month([Data]), 
              Date.StartOfMonth([Data]), 
              Date.EndOfMonth([Data]), 
              Date.DaysInMonth([Data]), 
              Date.StartOfQuarter([Data]), 
              Date.EndOfQuarter([Data]), 
              Date.QuarterOfYear([Data]), 
              Date.WeekOfYear([Data]), 
              Date.WeekOfMonth([Data])
            }
          }
        )
    ),
  #"Outras Expandido" = Table.ExpandTableColumn(
      Outras, 
      "Outras", 
      {
        "AnoNum", 
        "AnoInicio", 
        "AnoFinal", 
        "MesNum", 
        "MesIni", 
        "MesFim", 
        "MesDias", 
        "TrimestreIni", 
        "TrimestreFim", 
        "TrimestreAno", 
        "SemanaAno", 
        "SemanaMes"
      }, 
      {
        "AnoNum", 
        "AnoInicio", 
        "AnoFinal", 
        "MesNum", 
        "MesIni", 
        "MesFim", 
        "MesDias", 
        "TrimestreIni", 
        "TrimestreFim", 
        "TrimestreAno", 
        "SemanaAno", 
        "SemanaMes"
      }
    ),
    #"Tipo Alterado" = Table.TransformColumnTypes(
      #"Outras Expandido", 
      {
        {"Data", type date}, 
        {"AnoNum", Int64.Type}, 
        {"AnoInicio", type date}, 
        {"AnoFinal", type date}, 
        {"MesNum", Int64.Type}, 
        {"MesIni", type date}, 
        {"MesFim", type date}, 
        {"MesDias", Int64.Type}, 
        {"TrimestreIni", type date}, 
        {"TrimestreFim", type date}, 
        {"TrimestreAno", Int64.Type}, 
        {"SemanaAno", Int64.Type}, 
        {"SemanaMes", Int64.Type}
      }
    )
in
  #"Tipo Alterado"