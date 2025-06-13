
# 🧭 Estratégia de Mapeamento de Elementos

## 🔘 Visão Geral da Estratégia

Durante o mapeamento dos elementos da página **Challenging DOM**, nossa squad adotou uma abordagem baseada em **robustez, manutenção e estabilidade** dos seletores. O objetivo principal foi identificar elementos **fixos e estáveis**, que **não mudem com o tempo** mesmo com atualizações na interface, garantindo que os testes automatizados **não quebrem** com pequenas alterações estruturais.

Para isso, seguimos a **ordem preferencial de mapeamento de elementos**, priorizando seletores mais confiáveis, em detrimento de seletores mais frágeis como `id`, `name` ou seletores por texto.

---

## 🔧 Princípios Aplicados
- **Evitar atributos dinâmicos** (`id`, `name`) que mudam a cada recarregamento da página.
- **Priorizar seletores estruturais e estáticos**, como hierarquias CSS.
- **Utilizar seletores que continuem funcionando mesmo com a adição de novos elementos na tabela.**

---

## 🔘 Mapeamento: Botões

| Tipo de seletor         | Mapeamento                        |
|-------------------------|-----------------------------------|
| ID (se único)           | N/A                               |
| Seletor customizado     | N/A                               |
| Name (se único)         | N/A                               |
| Class name              | `[class='button']`<br>`[class='button alert']`<br>`[class='button success']` |
| CSS combinados          | Não Testado  |
| XPath sem texto         | Não Testado  |
| Links (por atributos)   | Não Testado  |
| XPath com texto/index   | Não Testado  |

---

## 📊 Mapeamento: Tabela

| Tipo de seletor         | Mapeamento                                                                 |
|-------------------------|----------------------------------------------------------------------------|
| ID (se único)           | N/A                                                                        |
| Seletor customizado     | N/A                                                                        |
| Name (se único)         | N/A                                                                        |
| Class name              | N/A                                                                        |
| CSS combinados          | `table tbody tr:nth-child(1)` – Linha<br>`table thead tr th:nth-child(1)` – Cabeçalho<br>`table tbody tr:nth-child(1) td:nth-child(1)` – Célula específica<br>`table tbody tr:nth-child(1) td a:nth-child(1)` – Botão Edit<br>`table tbody tr:nth-child(1) td a:nth-child(2)` – Botão Delete |
| XPath sem texto         | Não Testado                 |
| Links (por atributos)   | Não Testado                                |
| XPath com texto/index   | Não Testado                |

---

## 📌 Considerações Finais
Essa abordagem buscou garantir a **manutenção a longo prazo** dos testes automatizados, usando seletores que resistem a mudanças sutis no HTML. A aplicação da **ordem preferencial de seletores** foi essencial para alcançar esse objetivo com consistência.

Com isso, estabelecemos uma base sólida para automação confiável e evolutiva no contexto da página Challenging DOM.