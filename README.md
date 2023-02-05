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

## Erros conhecidos  
Não é possível realizar o upload de uma imagem pela web quando subindo um novo produto. Isso porque não há "path" quando o assunto é web  

## Log
- **01-28-23**:  
Criação do projeto, front será em Flutter  
- **01-29-23**:  
Tela de login criada  
Criação da API e POST de User  
- **01-30-23**:  
Login e autenticação  
- **02-02-23**:  
Navegação pelo menu inferior  
Tela de account e pedidos realizados  
- **02-04-23**:  
Tela de home
- **02-05-23**:  
Início da tela de admin, tela de inclusão de produtos
Inclusão de produtos
