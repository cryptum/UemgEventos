<?php 

  date_default_timezone_set('America/Sao_Paulo');
  $date = date('Y-m-d H:i');
  $date_emissao = date('d-m-Y');
  $hore_emissao = date('H:i');

  $servidor = "localhost";
  $usuario = "root";
  $senha = "";
  $dbname = "uemg_eventos";
  

  //Criar a conexão
  $conn = mysqli_connect($servidor, $usuario, $senha, $dbname);
  $html = '<style>

    table {
    border-collapse: collapse;
    width: 100%;

    }
    th{
        padding-top: 6px;
        padding-bottom: 6px;
    }

    tr:nth-child(even){background-color:  #f9f9f9}
    </style>

    <head>
    <link rel="stylesheet" type="text/css" href="estilo.css">
    <span class="font-face">Dia: '.$date_emissao.'</span><span style="float:right" class="font-face"> Hora: '.$hore_emissao.'</span>
    </head>

  <table style="font-size: 14px; border: 1px solid; border-radius: 3px; padding: -1px;" class="font-face">
  <thead>
      <tr style="background-color: #dcdcdc; text-align: center;">
      <th>ID</th>
      <th>Título</th>
      <th>Data Início</th>
      <th>Data Fim</th>
      <th>Organizador</th>
      <th>Valor</th>
      <th>Pagar Para</th>
      </tr>
  </thead>
<tbody style="border-top: 1px groove; margin-top: -2px;" class="font-face">';
  
  $result_evento = "SELECT * FROM eventos WHERE data_fim < '{$date}'"; /*Where data_fim < $date*/
  $resultado_evento = mysqli_query($conn, $result_evento);
  while($row_evento = mysqli_fetch_assoc($resultado_evento)){
    $html .= '<tr  style="text-align: center; padding: -1px;">';
    $html .=' <td style="padding: 8px;">'.utf8_encode($row_evento['id']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['titulo']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['data_inicio']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['data_fim']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['organizador']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['valor']) . "</td>";
    $html .= '<td style="padding: 8px;">'.utf8_encode($row_evento['pagar_para']) . "</td>";  
  }

  $html .= '</tr>';
  $html .= '</tbody>';
  $html .= '</table>';

  
  //referenciar o DomPDF com namespace
  use Dompdf\Dompdf;
  use Dompdf\Options;

  // include autoloader
  require_once("../dompdf/autoload.inc.php");

  //Criando a Instancia
  $dompdf = new DOMPDF();
  
  // Carrega seu HTML
  $dompdf->load_html('
      <img style="float:right; width:20%; height: 20%; top:-20px;" src="../imagens/uemg-frutal.png" /><br>
      <h1 style="margin-top:50px;font-size: 20px; text-align: center;" class="font-face">Relatório Eventos </h1>
      '. $html .'
    ');


  $dompdf->setPaper('A4', 'portrait');

  //Renderizar o html
  $dompdf->render();

  //Exibibir a pÃ¡gina
  $dompdf->stream(
    "relatorio.pdf", 
    array(
      "Attachment" => false //Para realizar o download somente alterar para true
    )
  );
?>