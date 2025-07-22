# CadenzaFlow Release Parent - Deployment Guide

Bu rehber, CadenzaFlow Release Parent projesini kendi Nexus repository'nize nasıl deploy edeceğinizi açıklar.

## Ön Gereksinimler

1. **Nexus Repository Manager** kurulu ve çalışır durumda
2. **Maven** 3.6+ kurulu
3. **Git** kurulu
4. **GPG** (opsiyonel, Maven Central için gerekli)

## Repository URL'leri

- **Release Repository**: `http://18.157.182.187:32265/repository/cadenzaflow-release/`
- **Snapshot Repository**: `http://18.157.182.187:32265/repository/cadenzaflow-snapshot/`

## Konfigürasyon

### 1. Settings.xml Konfigürasyonu

`/Users/../.m2/settings.xml` dosyasında aşağıdaki server konfigürasyonlarının olduğundan emin olun:

```xml
<servers>
  <server>
    <id>cadenzaflow-nexus</id>
    <username>admin</username>
    <password>admin123</password>
  </server>
</servers>
```

### 2. Nexus Repository Ayarları

Nexus'ta aşağıdaki repository'lerin oluşturulduğundan emin olun:
- `cadenzaflow-release` (Release repository)
- `cadenzaflow-snapshot` (Snapshot repository)

## Deployment Adımları

### Snapshot Deployment (Test)

```bash
mvn clean deploy -DskipTests --settings=/Users/yusufcoskun/.m2/settings.xml
```

### Release Deployment

```bash
# Otomatik script kullanarak
./release.sh

# Manuel olarak
mvn release:prepare release:perform \
    -B -Dresume=false \
    -Dtag=1.0.0 \
    -DreleaseVersion=1.0.0 \
    -DdevelopmentVersion=1.0.1-SNAPSHOT \
    -Darguments="--settings=/Users/.../.m2/settings.xml" \
    --settings=/Users/.../.m2/settings.xml
```

## Proje Kullanımı

Diğer projelerde bu parent POM'u kullanmak için:

```xml
<parent>
  <groupId>com.cadenzaflow</groupId>
  <artifactId>cadenzaflow-release-parent</artifactId>
  <version>1.0.0</version>
  <relativePath />
</parent>
```

## Özelleştirme

### Repository URL'lerini Değiştirme

`pom.xml` dosyasında aşağıdaki property'leri değiştirebilirsiniz:

```xml
<nexus.snapshot.repository>YOUR_SNAPSHOT_URL</nexus.snapshot.repository>
<nexus.release.repository>YOUR_RELEASE_URL</nexus.release.repository>
```

### Maven Central Deployment'ı Atlama

Maven Central'a deploy etmek istemiyorsanız:

```bash
mvn release:prepare release:perform \
    -Darguments="-Dskip.central.release=true" \
    --settings=/Users/.../.m2/settings.xml
```

## Sorun Giderme

### 1. Authentication Hatası

Settings.xml dosyasındaki kullanıcı adı ve şifrenin doğru olduğundan emin olun.

### 2. Repository Erişim Hatası

Nexus repository URL'lerinin doğru olduğundan ve erişilebilir olduğundan emin olun.

### 3. GPG Hatası

Maven Central deployment için GPG anahtarınızın doğru konfigüre edildiğinden emin olun.

## Versiyon Geçmişi

- **1.0.0**: İlk release - CadenzaFlow için uyarlanmış Camunda release parent

## Destek

Sorunlar için GitHub Issues kullanın veya ekibinizle iletişime geçin. 
