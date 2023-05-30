# DataSet-Serialize Adapter for RESTRequest4Delphi
<b>This's <a href="https://github.com/viniciussanchez/dataset-serialize">DataSet-Serialize</a> adapter for <a href="https://github.com/viniciussanchez/RESTRequest4Delphi">RESTRequest4Delphi</a>. Allows loading a DataSet with the content of a request.
<br>We created a channel on Telegram for questions and support:<br><br>
<a href="https://t.me/hashload">
  <img src="https://img.shields.io/badge/telegram-join%20channel-7289DA?style=flat-square">
</a>

## ⭕ Prerequisites
* [**DataSet-Serialize**](https://github.com/viniciussanchez/dataset-serialize) - JSON to DataSet and DataSet to JSON converter for Delphi and Lazarus (FPC)
* [**RESTRequest4Delphi**](https://github.com/viniciussanchez/RESTRequest4Delphi) - API to consume REST services written in any programming language with support to Lazarus and Delphi
  
## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command:
``` sh
boss install github.com/viniciussanchez/dataset-serialize-adapter-restrequest4delphi
```
If you choose to install manually, simply add the following folders to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../dataset-serialize-adapter-restrequest4delphi/src
```

## ✔️ Compatibility
This adapter is compatible with projects developed in:
- [X] Delphi
- [X] Lazarus

## ⚡️ Quickstart
```delphi
uses RESTRequest4Delphi, DataSet.Serialize.Adapter.RESTRequest4D;
  
begin
  TRequest.New.BaseURL('http://localhost:8888/users')
    .Adapters(TDataSetSerializeAdapter.New(mtUsers))
    .Accept('application/json')
    .Get;
end;
```

## ⚠️ License
`dataset-serialize-adapter-restrequest4delphi` is free and open-source adapter licensed under the [MIT License](https://github.com/viniciussanchez/dataset-serialize-adapter-restrequest4delphi/blob/main/LICENSE). 
