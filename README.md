# riflessione-tf
Riflessione AWS環境 - terraform

## 本ドキュメントについて

開発環境の構築手順、また開発時に必要となる各種手順について記載する。

## 開発環境構築

- Macによる開発を前提とする。
- Docker for Macをインストールする。
- リポジトリをクローンする

```bash
git clone git@github.com:mmmcorp/riflessione-tf.git
cd riflessione-tf
```

- `env.sample` ファイルをコピーして、 `.env` を作成し、そこにAWSアクセスキーなど入力する

```bash
cp env.sample .env
```

## terraform コマンド

### terraform init

```
$ make init
```

### terraform plan

```
$ make plan
```

### terraform show

```
$ make show
```

### terraform apply

```
$ make apply
```

### terraform destroy

```
$ make destroy
```

### terraform fmt

```
$ make fmt
```

### terraform console

```
$ make console
```
