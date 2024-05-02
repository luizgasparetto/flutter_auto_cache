# AutoCacheManager

![GitHub Issues](https://img.shields.io/github/issues/luizgasparetto/auto_cache_manager)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/luizgasparetto/auto_cache_manager)

AutoCacheManager é um gerenciador de cache avançado para Flutter, projetado para otimizar o gerenciamento de cache em aplicações móveis com recursos de alta tecnologia, incluindo criptografia de dados e gestão eficiente do espaço de disco. Utilizando `shared_preferences` e `sqflite`, oferece uma solução abrangente para gerenciamento de dados em cache.

## Características

- **Gerenciamento Automático de Cache:** Processo de cache totalmente automatizado, do armazenamento à recuperação.
- **Criptografia de Dados:** Garante a segurança dos dados armazenados com criptografia avançada.
- **Gerenciamento de Espaço de Disco:** Monitora e otimiza o uso do espaço de armazenamento para evitar sobrecarga.
- **Políticas de Substituição e Invalidação:** Mantém os dados mais relevantes com políticas inteligentes.
- **Alto Desempenho:** Utiliza tecnologias eficientes para um armazenamento de cache rápido.

## Instalação

Instalar o AutoCacheManager no seu projeto Flutter é rápido e fácil. Siga os passos abaixo para adicionar a biblioteca como uma dependência.

### Passo 1: Adicionar a dependência

Você pode adicionar o AutoCacheManager diretamente ao seu projeto Flutter utilizando o comando abaixo no terminal:

```flutter pub add auto_cache_manager```


Este comando irá buscar a versão mais recente do AutoCacheManager e adicioná-la ao seu arquivo `pubspec.yaml` automaticamente.

### Passo 2: Importar a biblioteca

Depois de adicionar a dependência, você precisa importar o AutoCacheManager em seu projeto para começar a utilizá-lo:

```dart
import 'package:auto_cache_manager/auto_cache_manager.dart';
```

### Passo 3: Começar a usar

Agora que você adicionou o AutoCacheManager ao seu projeto, você pode começar a configurá-lo e usá-lo para gerenciar o cache de maneira eficiente. Veja a seção "Exemplo de Uso" para começar.


## Scripts Adicionais

Para facilitar o desenvolvimento e a manutenção do projeto, incluímos alguns scripts úteis que você pode usar para configurar seu ambiente de desenvolvimento e testar alterações localmente antes de enviar para o repositório.

### Script `install.sh` - Instalação do Melos

O `install.sh` é um script projetado para instalar automaticamente o Melos, uma ferramenta de gerenciamento de mono-repositórios que facilita o trabalho com múltiplos pacotes em um único repositório. Para usar esse script, execute o seguinte comando no terminal:

```bash
./scripts/install.sh
```

Este script vai cuidar de todas as configurações necessárias para instalar o Melos e suas dependências, permitindo que você comece a usar a ferramenta imediatamente.

### Script `act.sh` - Testando a CI Localmente

O `act.sh` permite que você execute seus workflows de GitHub Actions localmente, ajudando a identificar e corrigir falhas na CI antes de fazer commits. Isso é especialmente útil para garantir a qualidade do código e a funcionalidade das integrações contínuas. Para executar este script, use o comando:

```bash
./scripts/act.sh
```

Certifique-se de ter o [act](https://github.com/nektos/act) instalado em seu sistema, que é a ferramenta utilizada pelo script para simular os GitHub Actions localmente.

## Contribuições

Contribuições para o AutoCacheManager são muito bem-vindas! Se você está interessado em ajudar a melhorar o projeto, aqui estão algumas maneiras pelas quais você pode contribuir:

### Relatar Bugs

Se você encontrar um bug, por favor, abra uma issue no [GitHub Issues](https://github.com/luizgasparetto/auto_cache_manager/issues) do projeto.

### Sugerir Melhorias

Se você tem ideias para melhorar o AutoCacheManager, seja na forma de novas funcionalidades, melhorias de código ou documentação, não hesite em abrir uma nova issue para discutir suas ideias com a comunidade.

### Enviar Pull Requests

Gostaríamos de receber suas pull requests com correções de bugs, melhorias e outras alterações. Siga estes passos para enviar sua contribuição:
1. Fork o repositório e crie sua branch a partir de `main`.
2. Se você adicionou código que necessita de testes, certifique-se de adicionar os testes necessários.
3. Garanta que seu código segue as convenções de estilo do projeto.
4. Escreva uma mensagem de commit clara que explique as mudanças.
5. Envie o pull request.
