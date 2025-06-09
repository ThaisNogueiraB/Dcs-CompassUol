# Mapeamento de Elementos HTML

Mapeamento individual de elementos HTML realizado em diferentes páginas web. Os elementos estão organizados por site, com seus respectivos nomes, tipos de seletor e valores utilizados.

Este repositório foi desenvolvido como parte da atividade de mapeamento de elementos HTML, com foco na identificação e categorização de seletores utilizados em páginas reais da web.


---

## 🔵 Livelo - [https://www.livelo.com.br](https://www.livelo.com.br)

| Nome Criado   | Tipo de Seletor | Mapeamento                |
|---------------|------------------|---------------------------|
| BTN_LOGIN     | ID Único         | `#l-header__button_login` |
| BTN_CADASTRO  | ID Único         | `#l-header__button_register` |
| BTN_CARRINHO  | ID Único         | `#l-cart__button`         |

---

## 🍷 Divvino - [https://www.divvino.com.br](https://www.divvino.com.br)

| Nome Criado        | Tipo de Seletor | Mapeamento                                                                 |
|--------------------|------------------|------------------------------------------------------------------------------|
| ARRAY_PRODUTO      | Class Name       | `.vtex-product-summary-2-x-container`                                       |
| ICON_LUPABUSCA     | ID Único         | `#hpa-search`                                                               |
| BTN_CARRINHO       | Class Name       | `.vtex-button.bw1.ba.fw5.v-mid.relative.pa0.lh-solid.br2.min-h-regular.t-action.icon-button.dib.bg-transparent.b--transparent.c-action-primary.hover-b--transparent.hover-bg-action-secondary.hover-b--action-secondary.pointer` |
| ARRAY_BTN_CATEGORIA| Class Name       | `.vtex-menu-2-x-menuContainer.vtex-menu-2-x-menuContainer--headerMenuDesktop.list.flex.pl0.mv0.flex-row` |

---

## 🔍 Google - [https://www.google.com](https://www.google.com)

| Nome Criado   | Tipo de Seletor | Mapeamento     |
|---------------|------------------|----------------|
| BTN_PESQUISA  | Class Name       | `.gNO89b`      |
| ARRAY_LINKS   | Class Name       | `.KxwPGc.SSwjIe` |
| CAMPO_BUSCA   | ID Único         | `#APjFqb`      |

---




## 👗 Renner - [https://www.lojasrenner.com.br](https://www.lojasrenner.com.br) - Pagina escolhida 





| Nome Criado               | Tipo de Seletor     | Mapeamento                                                                 |
|---------------------------|----------------------|----------------------------------------------------------------------------|
| MENU_LOJAPARCEIRA         | Seletor Customizado  | `[data-text="Lojas Parceiras"]`                                           |
| CAMP0_PESQUISA            | Name Único           | `[name='Ntt']`                                                             |
| ICN_SACOLA                | Class Name           | `.ic-sacola`                                                               |
| BTN_NEXTCARROSSEL_LOJAPARCEIRA | ID Único        | `#next-arrow-categoriesCarousel`                                          |
| BENEFICIOS_ITENS          | ID e CSS             | `#renner-beneficios` e `.beneficios:nth-of-type(1)`                        |
| BANNER_REPASSADESK        | XPath (sem texto)    | `//*[@id="repassadesk"]/div/a/img`                                         |
| LINK_VERCONDIÇÕES         | XPath                | `//a[@href='https://www.lojasrenner.com.br/regulamentos']`                 |
| TARGET_VERCONDIÇÕES       | XPath com texto      | `//a[text()='Ver condições']`                                              |

---

### 🧩 Justificativas dos Elementos Mapeados – Renner

| Nome Criado                     | Tipo de Seletor         | Justificativa |
|--------------------------------|--------------------------|---------------|
| MENU_LOJAPARCEIRA              | Seletor Customizado      | O elemento não possuía `id` ou `class` direto. O atributo `data-text="Lojas Parceiras"` foi o mais específico e estável para identificar o item de menu. Ideal para testes que precisam simular cliques em navegação. |
| CAMP0_PESQUISA                 | Name Único               | O campo de busca possui o atributo `name='Ntt'`, permitindo localização rápida e sem ambiguidade, ideal para preenchimento automatizado. |
| ICN_SACOLA                     | Class Name               | O ícone da sacola possui uma classe exclusiva (`.ic-sacola`) que não sofre alteração com conteúdo dinâmico e permite identificação clara. |
| BTN_NEXTCARROSSEL_LOJAPARCEIRA| ID Único                 | O botão de próximo no carrossel tem um `id` único (`#next-arrow-categoriesCarousel`), sendo o melhor seletor possível para ações de navegação por elementos visuais. |
| BENEFICIOS_ITENS              | ID + CSS (com `nth-of-type`) | Foi usado `#renner-beneficios` para localizar a seção e `.beneficios:nth-of-type(1)` para acessar o primeiro item. Essa combinação garante precisão ao acessar um dos múltiplos elementos semelhantes. |
| BANNER_REPASSADESK            | XPath (sem texto)        | Não havia `id` ou `class` identificável na imagem. O uso de XPath estrutural (`//*[@id="repassadesk"]/div/a/img`) foi necessário para capturar o banner de forma precisa. |
| LINK_VERCONDIÇÕES             | XPath                    | O link usava `href`, mas sem `id`. O XPath baseado no atributo `href` (`//a[@href='https://www.lojasrenner.com.br/regulamentos']`) garante que o link correto seja selecionado. |
| TARGET_VERCONDIÇÕES           | XPath com texto          | Quando o objetivo é selecionar um link visível ao usuário com texto conhecido ("Ver condições"), o XPath por texto (`//a[text()='Ver condições']`) é mais intuitivo e seguro, mesmo que outros links apontem para o mesmo destino. |

---



