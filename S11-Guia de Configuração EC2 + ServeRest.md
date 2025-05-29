# 📚 Índice

## ☁️ [Guia de Configuração EC2 + ServeRest (AWS)](#%EF%B8%8F-guia-de-configura%C3%A7%C3%A3o-ec2--serverest-aws)

- [📌 Pré-requisitos](#-pr%C3%A9-requisitos)
- [🔐 Etapa 1: Criar Par de Chaves](#-etapa-1-criar-par-de-chaves)
- [🌐 Etapa 2: Configurar VPC e Internet Gateway](#-etapa-2-configurar-vpc-e-internet-gateway)
- [⚙️ Etapa 3: Criar Instância EC2](#%EF%B8%8F-etapa-3-criar-inst%C3%A2ncia-ec2)
- [🔗 Etapa 4: Conectar-se à Instância](#-etapa-4-conectar-se-%C3%A0-inst%C3%A2ncia)
- [🚀 Etapa 5: Subir a API ServeRest](#-etapa-5-subir-a-api-serverest)
- [🔁 Etapa 6: Reinicialização e Rotina de Testes](#-etapa-6-reinicializa%C3%A7%C3%A3o-e-rotina-de-testes)
- [⛔ Encerrando a Instância Após os Testes](#-encerrando-a-inst%C3%A2ncia-ap%C3%B3s-os-testes)

## 📋 [Relatório de Desafios Superados na Configuração EC2 + ServeRest](#-relatório-de-desafios-superados-na-configuração-ec2--serverest)

- [👩‍💻 Alicia](#-alicia)
- [👩‍💻 Brenda](#-brenda)
- [👩‍💻 Maria Eduarda](#-maria-eduarda)
- [👨‍💻 Pedro](#-pedro)
- [👩‍💻 Thais](#-thais)

---

# ☁️ Guia de Configuração EC2 + ServeRest (AWS)

Este guia apresenta o passo-a-passo para criar uma instância EC2 na AWS, configurar a VPC e executar a API [ServeRest](https://serverest.dev/).

---

## 📌 Pré-requisitos

- Ler o documento: **"Orientações para os alunos do Programa de Bolsas Compass.pdf"**  
  ⚠️ Não é necessário executar a seção **"Acessos programáticos"**
- Criar uma pasta local para armazenar a chave `.pem` (ex: `AWS-EC2`)

---

## 🔐 Etapa 1: Criar Par de Chaves

1. Acesse: [academy-compass.awsapps.com/start](https://academy-compass.awsapps.com/start#/)
2. Clique na conta com seu nome > **AdministratorAccess**
3. Pesquise por **EC2** e acesse
4. Menu lateral: **Rede e segurança > Pares de chaves**
5. Crie um par de chaves:
   - Nome: `ec2-pb-aws`
   - Tipo: `RSA`
   - Formato: `.pem`
6. Após o download, mova o arquivo `.pem` para a pasta criada

---

## 🌐 Etapa 2: Configurar VPC e Internet Gateway

1. Vá para **Nuvem privada virtual > Suas VPCs**
   - ⚠️ Certifique-se de ter uma VPC criada (caso contrário, contate o Scrum Master/Suporte Compass UOL)
2. Vá para **Gateways da Internet > Criar**
   - Nome: `ec2-serverest-gateway`
   - Após criar, clique em **Ações > Associar à VPC**
3. Vá para **Tabelas de Rotas**
   - Ignore qualquer rota com nome "-"
   - Para cada rota válida:
     - Clique em **Rotas > Editar rotas**
     - Adicione: `Destino: 0.0.0.0/0` → Alvo: selecione o gateway criado
     - Salve alterações

---

## ⚙️ Etapa 3: Criar Instância EC2

1. Volte ao **EC2 Dashboard**
2. Verifique a região: `Estados Unidos (Norte da Virgínia) - us-east-1`
3. Clique em **Executar Instância**
4. Configure **Nome e Tags**:

| Chave       | Valor               | Recursos                |
|-------------|---------------------|--------------------------|
| Name        | Linux Serverest     | Instâncias, Volumes     |
| Project     | Programa de Bolsas  | Instâncias, Volumes     |
| CostCenter  | Quality Assurance   | Instâncias, Volumes     |

5. Escolha a AMI:
   - Sistema: **Amazon Linux 2023**
   - Arquitetura: **64 bits (x86)**
6. Tipo de instância: `t2.micro`
7. Par de chaves: selecione `ec2-pb-aws`
8. Configuração de rede:
   - VPC: `vpc-XXXXXXXXXXXXXXXXX`
   - Sub-rede: `subnet-XXXXXXXXXXXXXXXXX`
   - IP público: **Habilitar**
   - Grupo de segurança: criar um novo com as seguintes regras:
     - **SSH**, **HTTP**, **HTTPS** → Origem: **Qualquer lugar**
     - **TCP personalizado**, Porta: `3000`, Origem: **Qualquer lugar**
9. Armazenamento: 1 volume de **8 GiB (gp3)**
10. Clique em **Executar Instância**

---

## 🔗 Etapa 4: Conectar-se à Instância

1. Selecione a instância > clique em **Conectar**
2. Copie o **Endereço IP Público**
3. No terminal local:
   ```bash
   cd ~/AWS-EC2
   ls  # Verifique se o arquivo .pem está aqui
   chmod 400 ec2-pb-aws.pem
   ssh -i ec2-pb-aws.pem ec2-user@<IP_PÚBLICO>
   ```
4. Após conectar, execute:
   ```bash
   pwd  # Deve retornar: /home/ec2-user
   ```

---

## 🚀 Etapa 5: Subir a API ServeRest

### Primeira instalação

Execute os comandos **um de cada vez**:

```bash
sudo yum update -y
sudo yum install gcc-c++ make -y
curl --version  # Verifique se está instalado
sudo yum install curl  # Se necessário
mkdir serverestApi
cd serverestApi
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo yum install -y nodejs
npx serverest@latest
```

Acesse via navegador:

```cpp
http://<IP_PÚBLICO>:3000
```

---

## 🔁 Etapa 6: Reinicialização e Rotina de Testes

### Reiniciar a instância

1. No painel da AWS:
   - **EC2 > Instâncias > Estado > Iniciar Instância**
2. Acesse novamente via SSH:
   ```bash
   cd ~/AWS-EC2
   ssh -i ec2-pb-aws.pem ec2-user@<NOVO_IP_PÚBLICO>
   cd serverestApi
   npx serverest@latest
   ```

Acesse via navegador:

```cpp
http://<NOVO_IP_PÚBLICO>:3000
```

---

## ⛔ Encerrando a Instância Após os Testes

Para **evitar cobranças e liberar recursos**, encerre sua instância após os testes.

### Passos:

1. No terminal da instância:
   ```bash
   Ctrl + C
   ```
2. No painel AWS:
   - **EC2 > Instâncias**
   - Marque a instância
   - Clique em **Estado da Instância > Interromper instância**
   - Confirme em **Interromper**

> A instância será pausada (não excluída), mantendo seus arquivos intactos.

---

# 📋 Relatório de Desafios Superados na Configuração EC2 + ServeRest

Este documento complementa o guia principal com os relatos dos participantes do projeto, detalhando os principais desafios enfrentados durante a criação da instância EC2 e a configuração da API ServeRest, além das ações tomadas para superar os obstáculos.

---

## 👩‍💻 Alicia

**Desafio:**  
Erro ao tentar conectar na instância EC2 via SSH: `Connection timed out`, mesmo utilizando o endereço IPv4 correto.

**Ações Realizadas:**  
- Verificou se a chave `.pem` estava na pasta correta.  
- Confirmou as permissões da chave.  
- Reexecutou o comando SSH.

**Resultado:**  
Após ajustar corretamente a permissão da chave `.pem`, a conexão via SSH foi estabelecida com sucesso.

**Conclusão:**  
O problema estava relacionado às permissões da chave `.pem`.

---

## 👩‍💻 Brenda

**Desafio:**  
Erro ao tentar acessar a instância via terminal: `port 22: Connection timed out`.

**Ações Realizadas:**  
- Reassistiu os vídeos da aula para revisar o processo.
- Identificou que o gateway de internet não estava corretamente associado à VPC.

**Resultado:**  
Após ajustar a configuração do gateway, a instância passou a ser acessível normalmente via terminal.

**Conclusão:**  
O problema estava na configuração incompleta do gateway de internet.

---

## 👩‍💻 Maria Eduarda

**Desafio:**  
Não conseguia acessar a aplicação pelo navegador. O endereço IPv4 retornava erro "Não é possível acessar esse site".

**Ações Realizadas:**  
- Reiniciou a instância na AWS.
- Reconectou utilizando o novo IPv4.

**Resultado:**  
O acesso via navegador funcionou corretamente após reinicialização.

**Conclusão:**  
Foi necessário reiniciar a instância para liberar corretamente o endereço IPv4.

---

## 👨‍💻 Pedro

Nenhum desafio ou impedimento relatado.

---

## 👩‍💻 Thais

Nenhum desafio ou impedimento relatado.