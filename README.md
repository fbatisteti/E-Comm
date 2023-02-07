*This project will be written em Brazilian Portuguese only.*

# E-Commerce Mock-up

Usando como base o seguinte tutorial: https://github.com/RivaanRanawat/flutter-amazon-clone-tutorial  

Para inicializar a aplicação (SEM CORS)  
```
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

Para inicializar a API  
```
npm run dev
```

**Dependências FRONT**:  
- http  
- provider  
- shared_preferences  
- badges  
- carousel_slider  
- dotted_border  
- file_picker  
- cloudinary_public  

**Dependências BACK**:
- HTTP  
- Express  
- Mongoose  
- Nodemon  
- JSONWebToken  

**Você precisa:**  
- Alterar o arquivo "./ecomm/lib/constants/private_variables_copy.dart" com as suas credenciais (IP, Cloudinary...) e remover o "_copy" do nome  
- Alterar o arquivo "./server/credential_copy.js" com as suas credenciais do MongoDB e remover o "_copy" do nome  

## Erros conhecidos / Falta fazer  
Não é possível realizar o upload de uma imagem pela web quando subindo um novo produto. Isso porque não há "path" quando o assunto é web  
Falta aceitar mais de uma URL de API externa
Falta auto-refresh quando adiciona novo produto
Alterar para buscar "on demand" da API, ao invés de salvar em banco

## Log
- **28-01-23**:  
Criação do projeto, front será em Flutter  
- **29-01-23**:  
Tela de login criada  
Criação da API e POST de User  
- **30-01-23**:  
Login e autenticação  
- **02-02-23**:  
Navegação pelo menu inferior  
Tela de account e pedidos realizados  
- **04-02-23**:  
Tela de home
- **05-02-23**:  
Início da tela de admin, tela de inclusão de produtos  
Inclusão de produtos  
- **06-02-23**:  
Tela de produtos apresentando produtos  
Remoção de produtos  
- **07-02-23**:  
Inserção de produtos de API externa
Navegação pelos produtos por categoria ("filtro")
