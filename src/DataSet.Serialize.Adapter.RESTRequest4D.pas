unit DataSet.Serialize.Adapter.RESTRequest4D;

interface

uses RESTRequest4D.Request.Adapter.Contract, DataSet.Serialize{$IF DEFINED(FPC)}, DB{$ELSE}, Data.DB{$ENDIF};

type
  TDataSetSerializeAdapter = class(TInterfacedObject, IRequestAdapter)
  private
    FRootElement: string;
    FDataSet: TDataSet;
    procedure Execute(const AContent: string);
    {$IFNDEF FPC}
    procedure ActiveCachedUpdates(const ADataSet: TDataSet; const AActive: Boolean);
    {$ENDIF}
    constructor Create(const ADataSet: TDataSet; const ARootElement: string = ''); reintroduce;
  public
    class function New(const ADataSet: TDataSet; const ARootElement: string = ''): IRequestAdapter;
  end;

implementation

{$IFNDEF FPC}
uses System.Generics.Collections, FireDAC.Comp.Client;

procedure TDataSetSerializeAdapter.ActiveCachedUpdates(const ADataSet: TDataSet; const AActive: Boolean);
var
  LDataSet: TDataSet;
  LDataSetDetails: TList<TDataSet>;
begin
  LDataSetDetails := TList<TDataSet>.Create;
  try
    if not AActive then
      FDataSet.Close;
    if ADataSet is TFDMemTable then
      TFDMemTable(ADataSet).CachedUpdates := AActive;
    if AActive and (not ADataSet.Active) and (ADataSet.FieldCount > 0) then
      ADataSet.Open;
    ADataSet.GetDetailDataSets(LDataSetDetails);
    for LDataSet in LDataSetDetails do
      ActiveCachedUpdates(LDataSet, AActive);
  finally
    LDataSetDetails.Free;
  end;
end;
{$ENDIF}

constructor TDataSetSerializeAdapter.Create(const ADataSet: TDataSet; const ARootElement: string = '');
begin
  FDataSet := ADataSet;
  FRootElement := ARootElement;
end;

procedure TDataSetSerializeAdapter.Execute(const AContent: string);
begin
  {$IFNDEF FPC}
  ActiveCachedUpdates(FDataSet, False);
  {$ENDIF}
  FDataSet.LoadFromJSON(AContent, FRootElement);
  {$IFNDEF FPC}
  ActiveCachedUpdates(FDataSet, True);
  {$ENDIF}
end;

class function TDataSetSerializeAdapter.New(const ADataSet: TDataSet; const ARootElement: string = ''): IRequestAdapter;
begin
  Result := TDataSetSerializeAdapter.Create(ADataSet, ARootElement);
end;

end.
