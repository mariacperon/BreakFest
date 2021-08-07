<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Mukta:wght@300;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="styles/tipopes.css" rel="stylesheet">
        <link href="styles/util.css" rel="stylesheet">
        <link rel="shortcut icon" href="imagens/cuppa.ico" type="image/x-icon">
        <title>Break Fest</title>
    </head>
    <body>
        <!-- Inicio da NavBar de cima -->
    <header id="navbar">
        <a href="index.html"><img src="imagens/cuppa-inicio.gif" alt="Cuppa"></a>
        <h2> Break Fest </h2>
        <nav>
            <ul id="navbar-list">
                <li><a href="https://projetobreakfest.carrd.co/">Sobre Nós</a></li>
                <li><a href="tipopessoa.jsp">Cadastro</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>
    <!-- Fim da NavBar de cima -->
    <!-- Início dos dois containers iniciais -->
        <main>
        <section id="about-section">
            <!-- Título -->
            <center>
            <h1>Criar uma conta:</h1>     
            </center>
        </section>
        </main>
    <!-- Primeiro container -->
    <section id="tipopess-section">
        <div class="container">
            <div class="tipopess-container">
                <img src="imagens/pessoa.png" alt="Pessoa">
                <h3>Cadastro Físico</h3>
                <p>Para quem deseja consumir produtos dos mais variados estilos e conhecer padarias/lojas novas.</p>
                <br>
                <a href="cadastrofisico.jsp"><button name="conhecer">Cadastrar</button></a>
            </div>
            <hr>
            <!-- Segundo container -->
            <div class="tipopess-container">
                <img src="imagens/cidade.png" alt="Empresa">
                <h3>Cadastro Jurídico</h3>
                <p>Redirecionado para empresas e padarias
                que desejam vender seus produtos.</p>
                <br>
                <a href="cadastrojuridico.jsp"><button name="conhecer">Cadastrar</button></a>
            </div>
        </div>
    </section>
    <!-- Fim dos dois containers iniciais -->
</body>
</html>