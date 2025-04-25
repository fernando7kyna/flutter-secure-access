# Sistema de Portaria

Sistema de gerenciamento de portaria desenvolvido em Flutter para controle de acesso e registro de visitantes.

## Estrutura do Projeto

```
lib/
├── core/              # Configurações e utilitários core do app
│   ├── config/        # Configurações do app
│   ├── theme/         # Temas e estilos
│   └── utils/         # Funções utilitárias
├── data/             
│   ├── models/        # Modelos de dados
│   ├── repositories/  # Repositórios para acesso a dados
│   └── services/      # Serviços de dados
├── features/          # Módulos/Features do app
│   ├── auth/          # Feature de autenticação
│   ├── porteiro/      # Feature de gestão de porteiros
│   └── visitante/     # Feature de gestão de visitantes
├── shared/           
│   ├── components/    # Componentes compartilhados
│   └── widgets/       # Widgets reutilizáveis
└── main.dart          # Ponto de entrada do app
```

## Requisitos

- Flutter 3.0.0 ou superior
- Dart 3.0.0 ou superior

## Como Executar

1. Clone o repositório
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o app

## Funcionalidades

- Login de porteiros
- Cadastro de novos porteiros
- Registro de visitantes
- Histórico de visitas
- Controle de acesso

## Dependências Principais

- shared_preferences: Armazenamento local
- mask_text_input_formatter: Formatação de campos de texto

## Padrões de Código

- Nomenclatura em português para melhor compreensão do domínio
- Documentação inline em português
- Arquitetura baseada em features
- Princípios SOLID e Clean Code
