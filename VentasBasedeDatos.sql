DROP DATABASE  ParcialI;
CREATE DATABASE ParcialI;
USE ParcialI;
CREATE TABLE bodegas
(
	codigo_bodega VARCHAR(5) PRIMARY KEY,
    nombre_bodega VARCHAR(60),
    estatus_bodega VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

insert into bodegas values("A1","Bodega 1","1");
insert into bodegas values("A2","Bodega 2","1");
insert into bodegas values("A3","Bodega 3","1");

CREATE TABLE lineas
(
	codigo_linea VARCHAR(5) PRIMARY KEY,
    nombre_linea VARCHAR(60),
    estatus_linea VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
insert into lineas values("L1","B320","1");
insert into lineas values("L2","B321","1");
insert into lineas values("L3","B322","1");


CREATE TABLE marcas
(
	codigo_marca VARCHAR(5) PRIMARY KEY,
    nombre_marca VARCHAR(60),
    estatus_marca VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
insert into marcas values("M1","Kellogs","1");
insert into marcas values("M2","ABONITO","1");
insert into marcas values("M3","PLANTITA S.A","1");
CREATE TABLE productos
(
	codigo_producto VARCHAR(18) PRIMARY KEY,
    nombre_producto VARCHAR(60),
    codigo_linea VARCHAR(5),
    codigo_marca VARCHAR(5),
    existencia_producto FLOAT(10,2),
    estatus_producto VARCHAR(1),
    FOREIGN KEY (codigo_linea) REFERENCES lineas(codigo_linea),
    FOREIGN KEY (codigo_marca) REFERENCES marcas(codigo_marca)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
insert into productos values("C1","Semillas","L1","M1","20.00","1");
insert into productos values("C2","Abono","L2","M3","12.00","1");
insert into productos values("C3","Girasoles","L3","M2","14.00","1");
CREATE TABLE existencias
(
	codigo_bodega VARCHAR(5),
    codigo_producto VARCHAR(18),
    saldo_existencia FLOAT(10,2),
    PRIMARY KEY (codigo_bodega, codigo_producto),
	FOREIGN KEY (codigo_bodega) REFERENCES bodegas(codigo_bodega),
    FOREIGN KEY (codigo_producto) REFERENCES productos(codigo_producto)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE vendedores
(
	codigo_vendedor VARCHAR(5) PRIMARY KEY,
    nombre_vendedor VARCHAR(60),
    direccion_vendedor VARCHAR(60),
    telefono_vendedor VARCHAR(50),
    nit_vendedor VARCHAR(20),
    estatus_vendedor VARCHAR(1)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
insert into vendedores values("V1","Joshua Barrios","Ciudad Guatemala","8200-0192","0395843-2","1");
insert into vendedores values("V2","Alejandro Ortiz","Ciudad Quetzaltenango","83200-0192","0395953-5","1");
insert into vendedores values("V3","Yordi Perez","Progreso","8420-0192","0393243-8","1");
CREATE TABLE clientes
(
	codigo_cliente VARCHAR(5) PRIMARY KEY,
    nombre_cliente VARCHAR(60),
    direccion_cliente VARCHAR(60),
    nit_cliente VARCHAR(20),
    telefono_cliente VARCHAR(50),
    codigo_vendedor VARCHAR(5),
    estatus_cliente VARCHAR(1),
    FOREIGN KEY (codigo_vendedor) REFERENCES vendedores(codigo_vendedor)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
insert into clientes  values("CL3","Jasiel Perez","Peten","0393243-8","8420-0192","V2","1");
insert into clientes  values("CL2","Rita Sipaque","Ciudad Guatemala","0393243-8","8420-0192","V1","1");
insert into clientes  values("CL1","Nelly Barrios","Antigua Guatemala","0393243-8","8420-0192","V3","1");
CREATE TABLE ventas_encabezado
(
	documento_ventaenca VARCHAR(10) PRIMARY KEY,
    codigo_cliente VARCHAR(5),
    fecha_ventaenca DATE,
    total_ventaenca FLOAT(10,2),
    estatus_ventaenca VARCHAR(1),
    FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo_cliente)
) ENGINE=INNODB DEFAULT CHARSET=latin1;
CREATE TABLE ventas_detalle
(
	documento_ventaenca VARCHAR(10),
    codigo_producto VARCHAR(18),
    cantidad_ventadet FLOAT(10,2),
    costo_ventadet FLOAT(10,2),
    precio_ventadet FLOAT(10,2),
    codigo_bodega VARCHAR(5),
    PRIMARY KEY (documento_ventaenca, codigo_producto),
    FOREIGN KEY (documento_ventaenca) REFERENCES ventas_encabezado(documento_ventaenca),
    FOREIGN KEY (codigo_producto) REFERENCES productos(codigo_producto),
    FOREIGN KEY (codigo_bodega) REFERENCES bodegas(codigo_bodega)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

create table usuarios(
	idU int not null primary key,
    usuario varchar(20),
    contraseña varchar(20)
);
insert into usuarios values(1,"uno","12345");
select * from ventas_encabezado;
select * from ventas_detalle;
select * from ventas_detalle vd INNER JOIN ventas_encabezado ve ON ve.documento_ventaenca = vd.documento_ventaenca INNER JOIN productos pd ON vd.codigo_producto = pd.codigo_producto