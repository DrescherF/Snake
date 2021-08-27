object DataModuleSnake: TDataModuleSnake
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 510
  Width = 1088
  object ClientDataSetHighScores: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Score'
        DataType = ftInteger
      end
      item
        Name = 'Date'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 184
  end
  object DataSourceHighScores: TDataSource
    DataSet = ClientDataSetHighScores
    Left = 416
    Top = 200
  end
end
