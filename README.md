🔐 Sistema de Segurança - Gerenciamento de Cadastro
Aplicativo mobile desenvolvido com Flutter, voltado ao controle de acesso e registro de visitantes em ambientes corporativos e residenciais. O sistema visa modernizar a recepção, garantindo segurança, agilidade e rastreabilidade das entradas e saídas.

📱 Visão Geral
Este app foi desenvolvido com o objetivo de automatizar processos de portaria, otimizando o registro de visitantes através de uma interface moderna, autenticação segura e navegação fluida.
É ideal para condomínios, empresas e instituições que buscam digitalizar e centralizar a gestão de acesso.

🧠 Funcionalidades
🔐 Login com autenticação segura

👥 Cadastro de usuários (porteiros)

🧾 Registro detalhado de visitantes

💡 Interface responsiva e intuitiva

🧭 Navegação modular

🧾 Geração de relatórios em PDF

📁 Estrutura do Projeto
lib/
├── core/            # Configurações e utilitários centrais
│   ├── config/      # Definições globais
│   ├── theme/       # Estilos do app
│   └── utils/       # Funções auxiliares
│
├── data/            # Camada de dados
│   ├── models/      # Modelos de dados
│   ├── repositories/# Regras de acesso aos dados
│   └── services/    # Integrações e lógicas de negócio
│
├── features/        # Funcionalidades divididas por domínio
│   ├── auth/        # Autenticação
│   ├── porteiro/    # Gestão de usuários
│   └── visitante/   # Gestão de visitantes
│
├── shared/          # Componentes reutilizáveis
│   ├── components/  # Elementos visuais
│   └── widgets/     # Widgets personalizados
│
└── main.dart        # Ponto de entrada da aplicação

🧰 Tecnologias Utilizadas
Flutter 3.0.0+

Dart

Firebase Authentication (se aplicável)

Arquitetura modular baseada em boas práticas de Clean Code

🚀 Como Executar o Projeto
# Clone o repositório
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo

# Instale as dependências
flutter pub get

# Execute no emulador ou dispositivo
flutter run

🎯 Objetivo do Projeto
Projeto desenvolvido com foco em:

Aplicação prática de conceitos modernos de desenvolvimento mobile

Demonstração de domínio com arquitetura limpa

Criação de um sistema seguro e escalável para controle de acesso

Composição de portfólio profissional

👨‍💻 Autor
Fernando Lima
Estudante de Análise e Desenvolvimento de Sistemas
Desenvolvedor Full-Stack | Foco em Flutter, Node.js, e segurança digital
