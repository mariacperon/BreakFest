<%-- 
    Documento       : index
    Desenvolvido por: Yan Claus Fructuoso e Ricardo Natal
    Documentado por : Jefferson Teixeira
--%>

<%@page import="dominio.Cartao"%>
<%@page import="dominio.PessoaFisica"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Head igualitário para quase todas as telas -->
<head>
    <!-- Título -->
    <title>Break Fest</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Navbar Usuário -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js'></script>
    <script src="scripts/navbar-usuario.js"></script>
    <link rel="stylesheet" href="styles/navbar-usuario.css"/>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Link da página "inicial" em css -->
    <link href="styles/inicial.css" rel="stylesheet">

    <!-- Link da página "util" em css -->
    <link href="styles/util.css" rel="stylesheet">

    <!-- Imagem do Cuppa -->
    <link rel="shortcut icon" href="imagens/cuppa.ico" type="image/x-icon">

    <!-- Script da confirmacao-de-login -->
    <script src="scripts/confirmacao-de-login.js"></script>

    <!-- Sweet Alerts -->
    <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
    <script src="scripts/alertas-erro.js"></script>
    <script> var resultado = "${sessionScope.resultado}"</script>
    <%request.getSession().setAttribute("resultado", null);%>

    <!-- CSS, JS e BootStrap do cartão de crédito -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="styles/cartaoestilo.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
    <script src="scripts/cartao-de-credito.js"></script>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta.2/css/bootstrap.css'>

    <!-- Modal Cartão de Crédito -->
    <script src="https://kit-pro.fontawesome.com/releases/v5.10.1/js/pro.min.js" data-auto-fetch-svg></script>
    <script src="scripts/alterar-cadastrar-dados.js"></script>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta.2/css/bootstrap.css'>
</head>
<%
    //Instanciar a Pessoa Fisica
    PessoaFisica pf = new PessoaFisica();

    //Pegar o cpf dela
    String fkemail = String.valueOf(request.getSession().getAttribute("usuario"));
    String cpf = pf.procuraCpf(fkemail);

    //Instanciar Cartao e verificar dados
    Cartao cartao = new Cartao();

    //Iniciar variavel do numero
    String numeroCartao;

    //Verificar se há dados cadastrados
    if (cartao.verificaDados(cpf)) {

        cartao = cartao.consultarNumero(cpf);
        //Verificar dados do Cartão
        String numero = cartao.getNumero();
        char[] s = numero.toCharArray();

        if (s.length < 10) {
            numeroCartao = "Sem Dados Cadastrados";
        } else {
            for (int i = 0; i < (s.length - 4); i++) {
                s[i] = '•';
            }
            numeroCartao = "Cartão de Crédito      " + String.valueOf(s);
        }
    } else {
        numeroCartao = "Sem Dados Cadastrados";
    }

%>
<!-- modal de pagamento -->
<div class="modal fade" id="modalPagamento" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <!-- Div de Dados do Cartão de Crédito -->
                <div class="payment-title">
                    <p class="pagamento-titulo">Dados de Pagamento</p>
                </div>
                <div id="dadoscartao">
                    <div class="input-group mb-3 justify-content-center">
                        <div class="input-group-prepend">
                            <span class="input-group-text">
                                <i class="fa fa-credit-card fa-2x" style="border-radius: 5px 0px 0px 5px;color: rgb(240, 62, 61); background-color: #e9ecef !important;"></i>
                            </span>
                        </div>
                        <input type="text" class="form-control col-sm-8" id="dadoscard" readonly style="border-left: none; border-radius: 0px 5px 5px 0px; color:#194a91;" 
                               value="<%out.write(numeroCartao);%>">
                        <input type="hidden" id="verificarNumero" value="<% out.write(numeroCartao); %>">
                        <input type="hidden" id="cpf" name="cpf" value="<% out.write(cpf); %>">
                    </div><br>
                    <button id="btnAdicionar" style="display: none; position: relative; left: 10%" type="submit" class="button" onclick="cartaoCredito()">Adicionar Cartão</button>
                    <button id="btnAlterar" style="position: relative; left: 10%" type="submit" class="button" onclick="cartaoCredito()">Alterar Cartão</button>
                    <br><br>
                </div>
                <!-- Inicio Div Cartão de Crédito-->
                <div id="divcartao">
                    <div class="centrocartao d-flex justify-content-center"  >
                        <div class="container preload">
                            <div class="creditcard">
                                <div class="front" style="margin-left: 20px">
                                    <div id="ccsingle"></div>
                                    <svg version="1.1" id="cardfront" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                         x="0px" y="0px" viewBox="0 0 750 471" style="enable-background:new 0 0 750 471;" xml:space="preserve">
                                    <g id="Front">
                                    <g id="CardBackground">
                                    <g id="Page-1_1_">
                                    <g id="amex_1_">
                                    <path id="Rectangle-1_1_" class="lightcolor grey" d="M40,0h670c22.1,0,40,17.9,40,40v391c0,22.1-17.9,40-40,40H40c-22.1,0-40-17.9-40-40V40
                                          C0,17.9,17.9,0,40,0z" />
                                    </g>
                                    </g>
                                    <path class="darkcolor greydark" d="M750,431V193.2c-217.6-57.5-556.4-13.5-750,24.9V431c0,22.1,17.9,40,40,40h670C732.1,471,750,453.1,750,431z" />
                                    </g>
                                    <text transform="matrix(1 0 0 1 60.106 295.0121)" id="svgnumber" class="st2 st3 st4">0123 4567 8910 1112</text>
                                    <text transform="matrix(1 0 0 1 54.1064 428.1723)" id="svgname" class="st2 st5 st6">CUPPA BREAKFEST</text>
                                    <text transform="matrix(1 0 0 1 54.1074 389.8793)" class="st7 st5 st8">Nome</text>
                                    <text transform="matrix(1 0 0 1 479.7754 388.8793)" class="st7 st5 st8">Expiração</text>
                                    <text transform="matrix(1 0 0 1 65.1054 241.5)" class="st7 st5 st8">Numero do Cartão</text>
                                    <g>
                                    <text transform="matrix(1 0 0 1 574.4219 433.8095)" id="svgexpire" class="st2 st5 st9">01/23</text>
                                    <text transform="matrix(1 0 0 1 479.3848 417.0097)" class="st2 st10 st11">VALIDO</text>
                                    <text transform="matrix(1 0 0 1 479.3848 435.6762)" class="st2 st10 st11">ATÉ</text>
                                    <polygon class="st2" points="554.5,421 540.4,414.2 540.4,427.9 		" />
                                    </g>
                                    <g id="cchip">
                                    <g>
                                    <path class="st2" d="M168.1,143.6H82.9c-10.2,0-18.5-8.3-18.5-18.5V74.9c0-10.2,8.3-18.5,18.5-18.5h85.3
                                          c10.2,0,18.5,8.3,18.5,18.5v50.2C186.6,135.3,178.3,143.6,168.1,143.6z" />
                                    </g>
                                    <g>
                                    <g>
                                    <rect x="82" y="70" class="st12" width="1.5" height="60" />
                                    </g>
                                    <g>
                                    <rect x="167.4" y="70" class="st12" width="1.5" height="60" />
                                    </g>
                                    <g>
                                    <path class="st12" d="M125.5,130.8c-10.2,0-18.5-8.3-18.5-18.5c0-4.6,1.7-8.9,4.7-12.3c-3-3.4-4.7-7.7-4.7-12.3
                                          c0-10.2,8.3-18.5,18.5-18.5s18.5,8.3,18.5,18.5c0,4.6-1.7,8.9-4.7,12.3c3,3.4,4.7,7.7,4.7,12.3
                                          C143.9,122.5,135.7,130.8,125.5,130.8z M125.5,70.8c-9.3,0-16.9,7.6-16.9,16.9c0,4.4,1.7,8.6,4.8,11.8l0.5,0.5l-0.5,0.5
                                          c-3.1,3.2-4.8,7.4-4.8,11.8c0,9.3,7.6,16.9,16.9,16.9s16.9-7.6,16.9-16.9c0-4.4-1.7-8.6-4.8-11.8l-0.5-0.5l0.5-0.5
                                          c3.1-3.2,4.8-7.4,4.8-11.8C142.4,78.4,134.8,70.8,125.5,70.8z" />
                                    </g>
                                    <g>
                                    <rect x="82.8" y="82.1" class="st12" width="25.8" height="1.5" />
                                    </g>
                                    <g>
                                    <rect x="82.8" y="117.9" class="st12" width="26.1" height="1.5" />
                                    </g>
                                    <g>
                                    <rect x="142.4" y="82.1" class="st12" width="25.8" height="1.5" />
                                    </g>
                                    <g>
                                    <rect x="142" y="117.9" class="st12" width="26.2" height="1.5" />
                                    </g>
                                    </g>
                                    </g>
                                    </g>
                                    <g id="Back">
                                    </g>
                                    </svg>
                                </div>
                                <div class="back">
                                    <svg version="1.1" id="cardback" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
                                         x="0px" y="0px" viewBox="0 0 750 471" style="enable-background:new 0 0 750 471;" xml:space="preserve">
                                    <g id="Front">
                                    <line class="st0" x1="35.3" y1="10.4" x2="36.7" y2="11" />
                                    </g>
                                    <g id="Back">
                                    <g id="Page-1_2_">
                                    <g id="amex_2_">
                                    <path id="Rectangle-1_2_" class="darkcolor greydark" d="M40,0h670c22.1,0,40,17.9,40,40v391c0,22.1-17.9,40-40,40H40c-22.1,0-40-17.9-40-40V40
                                          C0,17.9,17.9,0,40,0z" />
                                    </g>
                                    </g>
                                    <rect y="61.6" class="st2" width="750" height="78" />
                                    <g>
                                    <path class="st3" d="M701.1,249.1H48.9c-3.3,0-6-2.7-6-6v-52.5c0-3.3,2.7-6,6-6h652.1c3.3,0,6,2.7,6,6v52.5
                                          C707.1,246.4,704.4,249.1,701.1,249.1z" />
                                    <rect x="42.9" y="198.6" class="st4" width="664.1" height="10.5" />
                                    <rect x="42.9" y="224.5" class="st4" width="664.1" height="10.5" />
                                    <path class="st5" d="M701.1,184.6H618h-8h-10v64.5h10h8h83.1c3.3,0,6-2.7,6-6v-52.5C707.1,187.3,704.4,184.6,701.1,184.6z" />
                                    </g>
                                    <text transform="matrix(1 0 0 1 621.999 227.2734)" id="svgsecurity" class="st6 st7">985</text>
                                    <g class="st8">
                                    <text transform="matrix(1 0 0 1 518.083 280.0879)" class="st9 st6 st10">CVV</text>
                                    </g>
                                    <rect x="58.1" y="378.6" class="st11" width="375.5" height="13.5" />
                                    <rect x="58.1" y="405.6" class="st11" width="421.7" height="13.5" />
                                    <text transform="" id="svgnameback" class="st12 st13">Cuppa BreakFest</text>
                                    </g>
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <!-- Inicio do Formulário do Cartão --->
                        <div class="form-container">
                            <form action="recebecartao.jsp" method="post">
                                <input type="hidden" name="cpf" value="<%out.write(cpf);%>">
                                <div class="field-container">
                                    <br><br>
                                    <label for="name">Nome Impresso no Cartão</label>
                                    <input id="name" name="cardname" minlength="5" maxlength="20" type="text" required>
                                </div>

                                <div class="field-container">
                                    <label for="cardnumber">Número do Cartão</label><span id="generatecard">generate random</span>
                                    <input id="cardnumber" name="cardnumber" type="text"  maxlength="19"  inputmode="numeric" required>
                                    <svg id="ccicon" class="ccicon" width="750" height="471" viewBox="0 0 750 471" version="1.1" xmlns="http://www.w3.org/2000/svg"
                                         xmlns:xlink="http://www.w3.org/1999/xlink">
                                    </svg>         
                                </div>     
                                <div class="field-container">
                                    <label for="expirationdate">Expiração (mm/yy)</label>
                                    <input id="expirationdate" name="expirationdate" type="text"  minlength="5" inputmode="" required>
                                </div>
                                <div class="field-container">
                                    <label for="securitycode">Código de Segurança</label>
                                    <input id="securitycode" name="securitycode" type="text"  minlength="3"  inputmode="numeric" required>
                                </div>
                                <button type="submit" class="button" style="position: relative; left: 5%">Salvar</button>
                            </form>
                        </div>
                        <script src='https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js'></script>
                        <!-- Fim do Formulário do Cartão --->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Fim Modal Pagamento-->    
<!-- Inicio do Body -->
<body>
    <!-- Inicio da NavBar de cima -->
    <header id="navbar">
        <a href="index_1.jsp"><img src="imagens/Break Fest Animated Logo in.gif" alt="Cuppa"></a>
        <h2> Break Fest </h2>
        <nav>
            <ul id="navbar-list">
                <div class="drop-down">
                    <div id="dropDown" class="drop-down__button">
                        <a>Meu Painel</a>
                    </div>
                    <!-- Painel da navbar com as opção de cadastro, pedidos e pagamentos. -->
                    <div class="drop-down__menu-box">
                        <ul class="drop-down__menu">
                            <a href="alterarusuariofisico.jsp"><li data-name="profile" class="drop-down__item">Cadastro</li></a>
                            <a href="consultarpedidofisico.jsp"><li data-name="dashboard" class="drop-down__item">Pedidos</li></a>
                            <a href="#" onclick="resetar()" data-toggle="modal" data-target="#modalPagamento"><li class="drop-down__item">Pagamentos</li></a>
                        </ul>
                    </div>
                </div>

                <!-- Essa opção será para sair da página, será levado para a página de login -->
                <li><a href="login.jsp">Sair</a></li>
            </ul>
        </nav>
    </header>
    <!-- Fim da NavBar de cima -->
    <!-- Início da barra de pesquisa de padarias -->
    <main>
        <div id="divBusca">
            <form action="procurarpadaria_1.jsp" method="post">
                <input type="text" id="txtBusca" placeholder="Pesquisar..."/>
            </form>
        </div>
        <div id="cuppa">
            <img src="imagens/StartScreenLogoOneLoop.gif" alt="Mini-Cuppa" width="300px" height="300px">
        </div>
        <!-- Fim da barra de pesquisa de padarias -->

        <!-- Um pouco da história do trabalho -->
        <section id="about-section">
            <h2>Padarias em destaque:</h2>      
            <p id="destaque">Confira aqui algumas de nossas padarias
                que estão bombando essa semana.
                Clique e confira as ofertas!</p>
            <p id="parag">↓</p>
        </section>
    </main>
    <!-- Fim da história do trabalho e do main -->
    <!-- Inicio das padarias mais badaladas-->
    <section id="padarias-section">
        <div class="container">
            <div class="padarias-container">
                <img src="imagens/pad1.jpg" alt="Padaria Boa">
                <h3>Padaria Pão Bom</h3>
                <p>Localizada na Rua Bahia, 1973</p>
                <p class="subtitle">Especialização:</p>
                <p>Pães e salgados diversos.</p>
                <br>
                <a><input type="button" name="conhecer" class="btn btn-outline-dark" value="Conhecer"></a>
            </div>
            <div class="padarias-container central">
                <img src="imagens/pad2.jpg" alt="Padaria Ótima">
                <h3>Padaria Pães e Doces</h3>
                <p>Localizada na Pedro Zimmerman, 4029</p>
                <p class="subtitle">Especialização:</p>
                <p>Confeitaria em geral e decoração de bolos.</p>
                <br>
                <a><input type="button" name="conhecer" class="btn btn-outline-dark" value="Conhecer"></a>
            </div>
            <div class="padarias-container">
                <img src="imagens/pad3.jpg" alt="Padaria Perfeita">
                <h3>Padaria Pão Duro</h3>
                <p>Localizada na Alfredo Wiiger, 57</p>
                <p class="subtitle">Especialização:</p>
                <p>Refeições e fast foods.</p>
                <br>
                <a><input type="button" name="conhecer" class="btn btn-outline-dark" value="Conhecer"></a>
            </div>
        </div>
    </section>
    <!-- Final das padarias mais badaladas -->

    <!-- Footer iniciado -->
    <footer>
        <img src="imagens/cuppa-inicio.gif" alt="BreakFest">
        <h2>Mande-nos uma mensagem!</h2>
        <p>Caso tenha alguma sujestão de melhora, alguma reclamação ou um elogio :)</p>
        <br>
        <form action="" method="post">
            <input type="text" name="nome" placeholder="Informe seu nome:">
            <input type="email" name="email" placeholder="Informe seu e-mail:">
            <textarea name="mensagem" placeholder="Informe a mensagem aqui:"></textarea>
            <input type="submit" value="Enviar">
            <input type="reset" value="Limpar">
        </form>
        <p><span class="detail">Break Fest - Entra21</span></p>
    </footer>
    <!-- Footer terminado-->
    <!-- JS para Modais -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script src='https://unpkg.com/popper.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/js/bootstrap.min.js'></script>
</body>
</html>