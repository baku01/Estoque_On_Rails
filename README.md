# Estoque On Rails 🛤️

O projeto "Estoque On Rails" é uma aplicação Ruby on Rails que visa gerenciar o estoque de uma empresa, permitindo o registro de entradas, saídas e requisições de produtos, além de possibilitar o controle de usuários com diferentes níveis de permissão.

## Modelos

### Entrada 📦
- **Associations:** 🔄
    - Pertence a um estoque.
    - `belongs_to :estoque`
  ```ruby
  class Entrada < ApplicationRecord
    belongs_to :estoque
  ```

- **Validations:** ✅
    - Garante a presença de diversos atributos, como data, documento, número, quantidade, preço unitário, preço total e estoque.
  ```ruby
  validates :data, :documento, :numero, :quantidade, :preco_unitario, :preco_total, :estoque, presence: true
  ```

- **Callbacks:** 🎛️
    - Após a criação de uma entrada, atualiza o preço total e realiza cálculos relacionados ao estoque.
  ```ruby
  after_create :after_create_entrada
  ```

- **Métodos Privados:** 🔒
    - Define métodos privados para os callbacks e para definir os atributos ransackáveis.
  ```ruby
  private

  def after_create_entrada
    # Cálculos e atualizações relacionados ao estoque
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[codigo conta_contabil created_at custo_medio custo_total descricao estoque_maximo estoque_minimo estoque_reposicao estoque_saldo grupo_id id id_value localizacao perecivel status tipo unidade updated_at numero]
  end
  ```

### Estoque 📦
- **Associations:** 🔄
    - Pertence a um grupo.
    - Tem muitas entradas e requisições.
  ```ruby
  class Estoque < ApplicationRecord
    belongs_to :grupo
    has_many :entradas
    has_many :requisicao
  ```

- **Validations:** ✅
    - Garante a presença de diversos atributos, como tipo, descrição, unidade, estoque mínimo, estoque máximo, estoque de reposição e grupo.
  ```ruby
  validates :tipo, :descricao, :unidade, :estoque_minimo, :estoque_maximo, :estoque_reposicao, :status, :grupo, presence: true
  ```

- **Callbacks:** 🎛️
    - Não foram definidos callbacks para o modelo Estoque.

- **Métodos Privados:** 🔒
    - Define métodos privados para os atributos ransackáveis.
  ```ruby
  def self.ransackable_attributes(auth_object = nil)
    %w[codigo conta_contabil created_at custo_medio custo_total descricao estoque_maximo estoque_minimo estoque_reposicao estoque_saldo grupo_id id id_value localizacao perecivel status tipo unidade updated_at]
  end
  ```

### Grupo 📦
- **Associations:** 🔄
    - Tem muitos estoques.
  ```ruby
  class Grupo < ApplicationRecord
    has_many :estoques
  ```

- **Validations:** ✅
    - Garante a presença do nome e status do grupo.
  ```ruby
  validates :nome, :status, presence: true
  ```

- **Callbacks:** 🎛️
    - Não foram definidos callbacks para o modelo Grupo.

- **Métodos Privados:** 🔒
    - Define métodos privados para os atributos ransackáveis.
  ```ruby
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id id_value nome status updated_at]
  end
  ```

### Requisicao 📦
- **Associations:** 🔄
    - Pertence a um estoque.
  ```ruby
  class Requisicao < ApplicationRecord
    belongs_to :estoque
  ```

- **Validations:** ✅
    - Garante a presença de diversos atributos, como tipo, data, número, setor e estoque.
  ```ruby
  validates :tipo, :data, :numero, :setor, :estoque, presence: true
  ```

- **Callbacks:** 🎛️
    - Após a criação de uma requisição, atualiza o estoque relacionado conforme o tipo de requisição.
  ```ruby
  after_create :after_create_requisicao
  ```

- **Métodos Privados:** 🔒
    - Define métodos privados para os callbacks e para os atributos ransackáveis.
  ```ruby
  private

  def after_create_requisicao
    # Lógica para atualização do estoque
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at custo_medio custo_total data estoque_id id id_value numero observacoes quantidade setor tipo updated_at]
  end
  ```
## Docker 🐳

O projeto utiliza Docker para facilitar o ambiente de desenvolvimento e garantir a consistência entre diferentes sistemas.

1. Certifique-se de ter o Docker instalado em sua máquina. Você pode encontrar instruções de instalação no [site oficial do Docker](https://docs.docker.com/get-docker/).

2. Clone o repositório do projeto para o seu ambiente local:

   ```bash
   git clone https://github.com/baku01/Estoque_On_Rails
   ```

3. Navegue até o diretório raiz do projeto:

   ```bash
   cd Estoque_On_Rails/service/db
   ```

4. Crie um arquivo `.env` com as variáveis de ambiente necessárias para o projeto. Por exemplo, você pode definir as credenciais do banco de dados neste arquivo.

5. Inicialize os containers do Docker usando o Docker Compose:

   ```bash
   docker-compose up
   ```

Isso irá construir e iniciar os containers necessários para o projeto, incluindo o banco de dados PostgreSQL.

6. Acesse a aplicação em seu navegador web através do endereço `http://localhost:3000`.

Com essas etapas, você terá o projeto "Estoque On Rails" em execução no ambiente Dockerizado.

## Observação

Certifique-se de verificar o arquivo `docker-compose.yml` e ajustar as configurações conforme necessário para o seu ambiente, como as variáveis de ambiente para o banco de dados e outras dependências.

## Gemas 💎

O projeto faz uso das seguintes gemas:

- **devise**: Utilizada para autenticação de usuários.
- **faker**: Utilizada para gerar dados fictícios para testes e desenvolvimento.
- **cancancan**: Utilizada para controle de autorização baseado em papéis.
- **activeadmin**: Utilizada para administração do sistema.
- **sassc-rails**: Utilizada para compilar arquivos Sass para CSS.

## Projeto 🚀

O projeto "Estoque On Rails" visa fornecer uma solução completa para o gerenciamento de estoque, permitindo que empresas controlem suas entradas, saídas e requisições de produtos de forma eficiente. A aplicação oferece uma interface amigável para os usuários realizarem suas operações, além de garantir segurança e controle de acesso através do sistema de autenticação fornecido pelo Devise.

Para executar o projeto localmente, certifique-se de ter o ambiente configurado corretamente e siga as instruções contidas na documentação do Rails para inicializar o servidor.

