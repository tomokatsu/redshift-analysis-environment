# redshift-analysis-environment
Redshiftの分析用クラスタを管理するツール  
メインで用いているクラスタのスナップショットを取得し、スナップショットから分析用クラスタを構築する  
分析用クラスタへの各種操作（削除等）も行う

## 初期設定
```
$ make setup
```

## 設定値の入力
```
$ cat .env
　# AWS Credentials
　AWS_REGION=''
　AWS_ACCESS_KEY_ID=''
　AWS_SECRET_ACCESS_KEY=''

　# Redshift
　CLUSTEER_NAME=''            # メインのクラスタ名
　ANALYSIS_CLUSTER_NAME=''    # メインクラスタのスナップショットから立ち上げたい、分析用クラスタ名

$ vim .env
```
