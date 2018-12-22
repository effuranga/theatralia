<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.User"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Theatralia</title>

    <!-- Bootstrap core CSS -->
    <link href="homeFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="homeFE/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>

    <!-- Plugin CSS -->
    <link href="homeFE/vendor/magnific-popup/magnific-popup.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="homeFE/css/creative.min.css" rel="stylesheet">

  </head>

  <body id="page-top">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">Theatralia</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#about">Sobre nosotros</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#services">Servicios</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#portfolio">Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#contact">Acceso</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <header class="masthead text-center text-white d-flex">
      <div class="container my-auto">
        <div class="row">
          <div class="col-lg-10 mx-auto">
            <h1 class="text-uppercase">
              <strong>Theatralia. Espacio teatral intercultural</strong>
            </h1>
            <hr>
          </div>
          <div class="col-lg-8 mx-auto">
            <p class="text-faded mb-5">Un mismo espacio, múltiples experiencias. Disfruta de nuestra diversa plataforma para destinada a teatros, anfiteatros y cines. Podrás conectarte con gente que comparta tus intereses en la cultura y la diversidad de las artes escénicas</p>
            <a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">Conócenos</a>
          </div>
        </div>
      </div>
    </header>

    <section class="bg-primary" id="about">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto text-center">
            <h2 class="section-heading text-white">¡Lo que hay que saber!</h2>
            <hr class="light my-4">
            <p class="text-faded mb-4">Pasaron por Theatralia® algunos de los grandes nombres de la lírica y una verdadera pléyade de directores, concertistas, y compañías líricas, de zarzuelas y operetas. Entre las célebres personalidades podemos citar a Tita Rufo, Tito Schippa (1913-14), María Barrientos, Enrico Caruso (1915) -quien elogió y comparó su acústica con la del Metropolitan Opera House de New York, también Richard Strauss, Pietro Mascagni, Beniamino Gigli, Arturo Rubinstein, Andrés Segovia, José Iturbi, Igor Stravinsky, Friedrich Gulda, Ralph Votapek, Martha Argerich, Bruno Gelber, los violinistas Zino Francescutti, Jacques Thibaud, Yehudi Menuhin, Ruggiero Ricci, Jaime Laredo, Salvatore Accardo, Uto Ughi. Orquestas: I Musici, Cámara de Munich, Cámara de Estocolmo, Solistas de Zagreb, Cámara de Berlín, Bach de Leipzig, Cámara de Toulouse, Cámara de Praga, Johann Strauss de Viena, Pro Música de New York, Cuarteto de Filadelfia, las sinfónicas New Philarmonia Orchestra, de Londres, Filarmónica de Berlín, Orquesta Filarmónica de Moscú, la National Symphony de Washington bajo la batuta de Mstislav Rostropovich, Orchestra Sinfónica Nazionale de la RAI, Sydney Conservatorium Orchestra, Sinfónica de Milán, Sinfónica de Viena.</p>
            <a class="btn btn-light btn-xl js-scroll-trigger" href="#services">¿Qué ofrecemos?</a>
          </div>
        </div>
      </div>
    </section>

    <section id="services">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Servicios</h2>
            <hr class="my-4">
          </div>
        </div>
      </div>
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-md-6 text-center">
            <div class="service-box mt-5 mx-auto">
              <i class="fas fa-4x fa-gem text-primary mb-3 sr-icon-1"></i>
              <h3 class="mb-3">Punto de venta</h3>
              <p class="text-muted mb-0">Compra desde la plataforma e imprímelo en casa o retira en boletería</p>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 text-center">
            <div class="service-box mt-5 mx-auto">
              <i class="fas fa-4x fa-paper-plane text-primary mb-3 sr-icon-2"></i>
              <h3 class="mb-3">Difusión</h3>
              <p class="text-muted mb-0">Entérate de las últimas novedades del espectáculo</p>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 text-center">
            <div class="service-box mt-5 mx-auto">
              <i class="fas fa-4x fa-code text-primary mb-3 sr-icon-3"></i>
              <h3 class="mb-3">Red social</h3>
              <p class="text-muted mb-0">Opina, comenta, comparte y conoce personas como tú</p>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 text-center">
            <div class="service-box mt-5 mx-auto">
              <i class="fas fa-4x fa-heart text-primary mb-3 sr-icon-4"></i>
              <h3 class="mb-3">Innovación</h3>
              <p class="text-muted mb-0">Te damos la bienvenida al siglo XXI en nuestra plataforma multiproósito</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="p-0" id="portfolio">
      <div class="container-fluid p-0">
        <div class="row no-gutters popup-gallery">
        
        <%
        ArrayList<Play> sp = (ArrayList<Play>) request.getAttribute("starredPlays");
        for(Play p: sp){
        %>
          <div class="col-lg-4 col-sm-6">
            <a class="portfolio-box" href="playPictures/<%=p.getImage() %>">
              <img class="img-fluid" src="playPictures/<%=p.getImage() %>" alt="">
              <div class="portfolio-box-caption">
                <div class="portfolio-box-caption-content">
                  <div class="project-category text-faded">
                    <%=p.getName() %>
                  </div>
                  <div class="project-name">
                    <%=p.getAuthor() %>
                  </div>
                </div>
              </div>
            </a>
          </div>

		<%}
        %>
        </div>
      </div>
    </section>

    <section class="bg-dark text-white">
      <div class="container text-center">
        <h2 class="mb-4">¡Conoce todas nuestras obras!</h2>
        <a class="btn btn-light btn-xl sr-button" href="http://startbootstrap.com/template-overviews/creative/">¡Muéstrame más!</a>
      </div>
    </section>

    <section id="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto text-center">
            <h2 class="section-heading">¡Accede a Theatralia®!</h2>
            <hr class="my-4">
            <p class="mb-5">Formulario de acceso</p>
            <form action="login" method="POST">
              <input type="text" id="userName" name="userName" placeholder="Usuario" /><br/>  
              <input type="password" id="password" name="password" placeholder="Contraseña" /><br/>
              <br/>
              <input type="submit"class="btn btn-primary btn-xl" value="Inicia sesión"/><br/>
              <p> </p>
              <a class="btn btn-secondary btn-xl sr-button" href="signin.jsp">¡Regístrate!</a>
            </form>      
          </div>
        </div>
        <div class="row">
          <div class="col-lg-4 ml-auto text-center">
            <i class="fas fa-phone fa-3x mb-3 sr-contact-1"></i>
            <p>123-456-6789</p>
          </div>
          <div class="col-lg-4 mr-auto text-center">
            <i class="fas fa-envelope fa-3x mb-3 sr-contact-2"></i>
            <p>
              <a href="mailto:your-email@your-domain.com">contato@theatraliaplatform.com</a>
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Bootstrap core JavaScript -->
    <script src="homeFE/vendor/jquery/jquery.min.js"></script>
    <script src="homeFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="homeFE/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="homeFE/vendor/scrollreveal/scrollreveal.min.js"></script>
    <script src="homeFE/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="homeFE/js/creative.min.js"></script>

  </body>

</html>

