_This project documentation will be written em Brazilian Portuguese only. The codebase, however, is in English with some eventual commentaries in Brazilian Portuguese_

# E-Commerce Mock-up

Usando como base o seguinte tutorial: https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial

Clone da aplicação de comércio eletrônico da Amazon, com vários toques e retoques para fins de estudo e aprendizagem. O código inteiro está em inglês, para ser mais fácil acompanhar o tutorial, com alguns comentários e este README em português.

## Instalando

Clone o repositório:

```
git clone https://github.com/fbatisteti/E-Comm.git
cd e-comm
```

Caso você não tenha, será necessário para o devido funcionamento do código uma conta nos seguintes serviços: [Cloudinary](https://cloudinary.com/); [MongoDB](https://www.mongodb.com/). Caso queira utilizar outros serviços, será necessário, também, alterar no código.

Navegue até o arquivo _./ecomm/lib/constants/private_variables_copy.dart_ e altere com as suas credenciais, depois remova o "\_copy" do nome.

- **ip** caso tenha hospedado o código em algum provedor;
- **cloudinaryName** e **cloudinaryPreset** da sua conta no [Cloudinary](https://cloudinary.com/).
  > **Atenção:** Sua conta no Cloudinary deve ter a opção "unsigned operation" marcada

Faça o mesmo com o arquivo _./server/credential_copy.js_. Não se esqueça de remover o "\_copy" do nome.

- **username**, **password** e nome do banco (**db**) do [MongoDB](https://www.mongodb.com/);
- uma chave para criptografar as senhas (**hashKey**);
- opcionalmente, uma identificação para APIs externas

Instale as dependências:

```
cd server
npm install
cd ../ecomm
flutter pub get
cd ..
```

Para inicializar a aplicação, sugiro ter dois terminais abertos ao mesmo tempo, um para cada bloco de comandos abaixo:

```
cd ecomm
flutter run -d chrome --web-browser-flag "--disable-web-security"
    [para inicializar a aplicação SEM CORS]
```

```
cd server
npm run dev
```

## Dependências

**Dependências FLUTTER ( https://pub.dev/ )**:

- [http](https://pub.dev/packages/http)
- [provider](https://pub.dev/packages/provider)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [badges](https://pub.dev/packages/badges)
- [carousel_slider](https://pub.dev/packages/carousel_slider)
- [dotted_border](https://pub.dev/packages/dotted_border)
- [file_picker](https://pub.dev/packages/file_picker)
- [cloudinary_public](https://pub.dev/packages/cloudinary_public)
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)
- [pay](https://pub.dev/packages/pay)
- [intl](https://pub.dev/packages/intl)
- [charts_flutter_new](https://pub.dev/packages/charts_flutter_new)

**Dependências NODE ( https://www.npmjs.com/ )**:

- [HTTP](https://www.npmjs.com/package/http)
- [Express](https://www.npmjs.com/package/express)
- [Mongoose](https://www.npmjs.com/package/mongoose)
- [Nodemon](https://www.npmjs.com/package/nodemon)
- [JSONWebToken](https://www.npmjs.com/package/jsonwebtoken)

## Sobre o projeto

O E-Comm é uma aplicação de comércio virtual desenvolvida em [Flutter](https://flutter.dev/) e [Node.js](https://nodejs.org/en/). O primeiro foi utilizado na criação fullstack da aplicação, enquanto o segundo foi utilizado para a criação de uma API para os serviços.

O desenvolvimento do projeto inteiro foi feito focado na versão web, uma vez que não havia nenhum emulador Android ou iOS instalados. O tutorial, porém, focou na versão mobile. Alguns ajustes foram feitos durante o código, e outros foram feitos após o término do tutorial para poder melhorar o comportamento em telas maiores (como, por exemplo, nos navegadores).

Não foi feita a parte de pagamentos para iOS e Android. Ao invés disso, criou-se um método genérico que considera que o pagamento ocorreu, para dar sequência nas ativdades. Esta e outras funções que foram necessárias serem alteradas ou que foram feitas a mais, fora do tutorial, estão marcadas no log com um asterisco (\*) antes do registro.

## Erros conhecidos / Falta fazer

- Não é possível realizar o upload de uma imagem pela web quando s\ubindo um novo produto. Isso porque não há "path" quando o assunto é web
- <del>Falta aceitar mais de uma URL de API externa</del> [Adicionado em 10-02-23, olhar o arquivo *./server/routes/admin.js* para mais detalhes]
- Falta auto-refresh quando adiciona novo produto
- <del>Alterar para buscar "on demand" da API, ao invés de salvar em banco</del> [Abandonado em 10-02-23, tem que salvar em banco para ter registro dos IDs]
- <del>Busca não está scrollable na web</del> [Corrigido em 07-02-23, alterado de visualização lista para grid se for web]
- Melhorar barra de busca, não parece estar buscando corretamente
- Quando acessa como admin, tem que atualizar a página para ir para o menu de admin
- <del>Falta colocar tooltip do valor da nota nas estrelas</del> [Alterado em 10-02-23, adicionado o valor e também quanto você deu de nota]
- <del>Falta melhorar a escolha da oferta do dia (atualmente, pega a maior avalição)</del> [Corrigido em 10-02-23, mudança na apresentação, ainda pega o produto que tem mais avaliações em geral]
- <del>Adicionar alternativa aos métodos de pagamento<del> [Corrigido em 09-02-23, adicionado um método genérico]
- <del>Avisar quando um produto é adicionado ao carrinho</del> [Alterado em 10-02-23, junto com uma mensagem falando para comprar mais!]

## Log

- **28-01-23**:\
  Criação do projeto, front será em Flutter
- **29-01-23**:\
  Tela de login criada\
  Criação da API e POST de User
- **30-01-23**:\
  Login e autenticação
- **02-02-23**:\
  Navegação pelo menu inferior\
  Tela de account e pedidos realizados
- **04-02-23**:\
  Tela de home
- **05-02-23**:\
  Início da tela de admin, tela de inclusão de produtos\
  Inclusão de produtos
- **06-02-23**:\
  Tela de produtos apresentando produtos\
  Remoção de produtos
- **07-02-23**:\
  **\*** Inserção de produtos de API externa\
  Navegação pelos produtos por categoria ("filtro")\
  **\*** Criação do filtro "todos"\
  Detalhamento do produto\
  Avaliações (rating)
- **08-02-23**:\
  Oferta do dia\
  Carrinho\
  Apple e Google Pay (não implementados)
- **09-02-23**:\
  **\*** Método "genérico" de venda\
  Pedidos/venda\
  Lista/tela de pedidos realizados\
  Visualização de pedidos pelo admin\
  Estatísticas, logout e toques finais (do tutorial)\
  **\*** Entrada automática após criação de conta\
  **\*** Refatoração e componentização da AppBar\
  **\*** Senha oculta quando digitada\
  **\*** Buscar produtos de todas as APIs listadas
- **10-02-23**:\
  **\*** Correção e melhoria na oferta do dia\
  **\*** Automação do carrossel da página home\
  **\*** Primeiro usuário criado é admin\
  **\*** Melhor visualização dos produtos listados para compra\
  **\*** Ajustes na tela de compra/detalhes dos produtos, e classificação
