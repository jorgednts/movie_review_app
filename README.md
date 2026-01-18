# 🎬 Ciné — Flutter Movie & TV Series App

> Uma aplicação *responsiva*, *adaptativa* e *multiplataforma* desenvolvida com Flutter + Clean Architecture, voltada para consulta de filmes e séries, com funcionalidades sociais privadas.

## 🎥 Demonstração

<p align="center">
  <img src="app/assets/demo/cine_demo.gif" alt="Demonstração do Ciné App" height="500" />
</p>

> Uma prévia da navegação pelo app Ciné nas versões mobile e web.

## 📱 Sobre o projeto

**Ciné** é uma aplicação desenvolvida com o objetivo de explorar boas práticas de arquitetura e desenvolvimento com Flutter, destacando-se por:

- ✅ Interface **responsiva**: se ajusta automaticamente a diferentes tamanhos de tela (mobile, tablet, desktop e web)
- ✅ Comportamento **adaptativo**: adapta-se ao tipo de plataforma com UX específica
- ✅ Modularização eficiente
- ✅ Uso mínimo de bibliotecas externas
- ✅ Design limpo e orientação à manutenibilidade

O app permite:

- 🔎 Buscar por filmes e séries de TV via API do [TMDB](https://www.themoviedb.org/)
- 🎞️ Visualizar detalhes completos, como sinopse, elenco e produções similares
- 📝 Adicionar resenhas pessoais e montar uma watchlist
- 🔐 Salvar informações de forma privada com autenticação via **Firebase Auth** e persistência no **Firestore**

---
## 🚀 Como executar

### 💻 Executando localmente

#### Antes de começar, você precisa ter:

- Flutter SDK instalado
- Um editor (VS Code ou Android Studio)
- Uma conta no Firebase
- Uma conta no The Movie Database (TMDB) para obter uma API Key

#### Pré-requisitos:

#### 1. Configure o Firebase:
1. Acesse o Firebase Console e crie um novo projeto;
2. Ative os serviços de autenticação (Firebase Authentication com email e senha) e armazenamento (Firestore);
3. Se for um usuário Android, adicione um app android no Firebase, baixe o arquivo `google-services.json` e coloque-o na pasta app/android/app;
4. Se for um usuário iOS, adicione um app ios no Firebase, baixe o arquivo `GoogleService-Info.plist` e coloque-o na pasta app/ios/Runner;

#### 2. Crie uma API Key e um Token do TMDB:
1. Acesse: https://www.themoviedb.org/;
2. Crie uma conta e obtenha uma API Key e um Token;

#### 3. Instale o Melos:
1. No terminal, realize a ativação do melos:
    ```
    dart pub global activate melos
    ```
2. Na raiz do projeto, execute:
    ```
    melos bootstrap
    ```
3. Caso precise, execute o pub get em todos os módulos:
   ```
   melos pub:get
   ```

#### Passo a passo:

1. Clone o repositório:
    ```
    git clone https://github.com/jorgednts/movie_review_app.git
    ```

2. Entre na pasta App do projeto:
    ```
    cd app
    ```
3. Execute o projeto utilizando o seu TMDB Token:
   ```
   flutter run --dart-define=TMDB_API_TOKEN=SEU_TMDB_API_TOKEN
   ```

### 🤖 Via APK

Você pode baixar instalar o APK num dispositivo Android através do link abaixo:

👉 [https://drive.google.com/file/d/1P3VonKKLkyoGORBMWNmimC_YHqjLe1BV/view?usp=sharing](https://drive.google.com/file/d/1P3VonKKLkyoGORBMWNmimC_YHqjLe1BV/view?usp=sharing)


### 🔗 Acesse online

Você pode testar a versão Web diretamente pelo link:

👉 [https://cine-app-fdadf.web.app](https://cine-app-fdadf.web.app/)

---

## 🧱 Estrutura do Projeto

O projeto é organizado em módulos reutilizáveis e desacoplados:

```text
├── app/                 # Camada de apresentação e lógica específica da aplicação
├── core/                # Modelos, utilitários, contratos e integrações genéricas
├── design_system/       # Componentes visuais reutilizáveis e temas responsivos
├── internationalization/# Suporte a internacionalização e localização
```
---

## 🧠 Tecnologias e Arquitetura

- ✅ **Flutter** (multiplataforma: mobile, web, desktop)
- ✅ **UI responsiva e adaptativa**
- ✅ **Clean Architecture** com **MVVM**
- ✅ **Firebase Auth & Firestore** para autenticação e dados privados
- ✅ **TMDB API** para dados de filmes e séries
- ✅ **Gerenciamento de estado** com `ChangeNotifier` e `setState` (em casos simples)
- ✅ **GoRouter** para navegação
- ✅ **Provider** para injeção de dependência
- ✅ **Padrões Command e Result** para encapsulamento da lógica
  
---

## 📸 Galeria Responsiva

> Abaixo, capturas de tela demonstrando como a interface do app se adapta entre dispositivos **mobile** e **web**.

---

### 🏠 Home

<p float="left">
  <img height="400" src="app/assets/screenshots/mobile/mobile_1.png">
  <img height="400" src="app/assets/screenshots/web/web_1.png">
</p>

---

### 🔍 Search

<p float="left">
  <img height="400" src="app/assets/screenshots/mobile/mobile_2.png">
  <img height="400" src="app/assets/screenshots/web/web_2.png">
</p>

---

### 📝 Reviews

<p float="left">
  <img height="400" src="app/assets/screenshots/mobile/mobile_3.png">
  <img height="400" src="app/assets/screenshots/web/web_3.png">
</p>

---

### 📺 Watchlist

<p float="left">
  <img height="400" src="app/assets/screenshots/mobile/mobile_4.png">
  <img height="400" src="app/assets/screenshots/web/web_4.png">
</p>

---

### 📄 Details

<p float="left">
  <img height="400" src="app/assets/screenshots/mobile/mobile_5.png">
  <img height="400" src="app/assets/screenshots/web/web_5.png">
</p>

---

> 💡 As imagens acima mostram como o app se adapta de forma fluida entre diferentes tamanhos de tela, mantendo uma boa experiência.

---