# redshift-analysis-environment
Redshiftの分析用クラスタを管理するツール  
メインで用いているクラスタのスナップショットを取得し、スナップショットから分析用クラスタを構築する  
分析用クラスタへの各種操作（削除等）も行う

## 初期設定
```
$ bundle install
```

## 設定ファイルの作成
リネーム
```
$ mv .env.sample .env
```

値の入力
```
AWS_REGION=''
AWS_ACCESS_KEY_ID=''
AWS_SECRET_ACCESS_KEY=''
CLUSTEER_NAME='' # メインのクラスタ名
ANALYSIS_CLUSTER_NAME='' # メインのクラスタのスナップショットから立ち上げたい分析用クラスタ名
```
