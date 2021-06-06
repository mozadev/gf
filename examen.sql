create database BD_TIENDA

USE BD_TIENDA

create table Tb_Producto(
codProd char(5) primary key  not null,
desProd varchar (50) not null,
preProd int  not null,
stockProd int  not null,
unidProd varchar (50) not null,
procedProd varchar (50) not null,
codCate varchar (50) not null

)

--pregunta 2
ALTER TABLE Tb_Producto
ADD CONSTRAINT UC_descripcion UNIQUE (desProd);

INSERT INTO Tb_Producto (codProd,desProd,preProd,stockProd,unidProd,procedProd,codCate)
VALUES ('4', 'fd',2,3,'g','g','f')

INSERT INTO Tb_Producto (codProd,desProd,preProd,stockProd,unidProd,procedProd,codCate)
VALUES ('5', 'fd',2,3,'g','g','f')

select*from Tb_Producto

create table Tb_Factura(
numFactura char(5) primary key  not null,
fechaFacturacin date not null,
codCLiente char(5) not null,
fechaCancelacion date not null,
estadoFact varchar (50) not null,
codVendedor char(5) not null,
igv int not null

)

--pregunta2
ALTER TABLE Tb_Factura
ADD CONSTRAINT  CK_fechaFactura DEFAULT getdate() for fechaFacturacin

INSERT INTO Tb_Factura (numFactura,codCLiente,fechaCancelacion,estadoFact,codVendedor,igv)
VALUES ('4',2,'2019/08/25','g','1',19)

select*from Tb_Factura



create table Tb_Detalle_Factura(
numFactura char(5)  not null,
codProd char(5) not null,

constraint numFactura_codProd PRIMARY KEY (numFactura, codProd),
		constraint FK_numFactura FOREIGN KEY (numFactura) REFERENCES Tb_Factura(numFactura),
		constraint FK_codProd FOREIGN KEY (codProd) REFERENCES Tb_Producto(codProd),

cantidadVend int not null,
precioVenta int not null

)




--pregunta 3

create procedure SPITb_Producto

@codProd char(5) ,
@desProd varchar,
@preProd int ,
@stockProd int ,
@unidProd varchar (50),
@procedProd varchar (50) ,
@codCate varchar (50)
as
begin
	INSERT INTO Tb_Producto (codProd,desProd,preProd,stockProd,unidProd,procedProd,codCate)
	VALUES (@codProd,@desProd,@preProd,@stockProd,@unidProd,@procedProd,@codCate);
END

select*from Tb_Producto

EXECUTE SPITb_Producto '5', 'mermelada',2,10,'und','lima','3'

EXECUTE SPITb_Producto '6', 'pan',1,110,'und','provincia','4'


create procedure SPITb_Factura

@numFactura char(5),

@codCLiente char(5) ,
@fechaCancelacion date,
@estadoFact varchar (50) ,
@codVendedor char(5),
@igv int 
as
begin
	INSERT INTO Tb_Factura (numFactura,codCLiente,fechaCancelacion,estadoFact,codVendedor,igv)
	VALUES (@numFactura,@codCLiente,@fechaCancelacion,@estadoFact,@codVendedor,@igv);
END

select*from Tb_Factura

EXECUTE SPITb_Factura '5',3,'2021/08/25','activo','2',19
EXECUTE SPITb_Factura '6',4,'2022/08/25','activo','3',19



create procedure SPITb_Detalle_Factura

@numFactura char(5)  ,
@codProd char(5),
@cantidadVend int ,
@precioVenta int 



as
begin
	INSERT INTO Tb_Detalle_Factura (numFactura,codProd,cantidadVend,precioVenta)
	VALUES (@numFactura,@codProd,@cantidadVend,@precioVenta);
END

select*from Tb_Detalle_Factura

EXECUTE SPITb_Detalle_Factura '4','5',100,23
EXECUTE SPITb_Detalle_Factura '5','6',200,24


--pregunta 4
select precioVenta from Tb_Detalle_Factura where numFactura like'4%'

select cantidadVend from Tb_Detalle_Factura where codProd like '5%'


-- pregunta 5

CREATE UNIQUE INDEX IX_CODIGO_DESCRIPCION
ON Tb_Producto (codProd, desProd)

