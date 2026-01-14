PHP 5.5.38 Docker Image with GD, MySQL, PDO & FPDF

Features:

PHP 5.5.38

GD (GIF, JPEG, PNG)

MySQL (mysql, mysqli)

PDO (pdo_mysql)

FPDF (PDF generation)

Setup

Place your local FPDF files, e.g.:

lib/fpdf/fpdf.php


Dockerfile snippet:

COPY lib/fpdf /usr/local/lib/php/fpdf
RUN echo 'include_path=".:/usr/local/lib/php/fpdf"' > /usr/local/etc/php/conf.d/fpdf.ini


Build & run:

docker build -t php55-gd-mysql-fpdf .
docker run -p 8080:80 php55-gd-mysql-fpdf

Using FPDF in PHP
require 'fpdf.php';

$pdf = new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial','B',16);
$pdf->Cell(40,10,'Hello World!');
$pdf->Output();


include_path ensures PHP finds fpdf.php.

GD supports GIF, JPEG, PNG.
