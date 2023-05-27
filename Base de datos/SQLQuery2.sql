create table usuarios(
id_usuario int identity(1,1),
documento_usuario int not null,
nombre varchar(25) not null,
apellido varchar(25) not null,
tipo_usu varchar(10)not null,
telefono int not null,
correo varchar(80),
contrasena varbinary(max) not null,
primary key (id_usuario, documento_usuario)
);

create table vehiculos(
id_vehiculo int identity(1,1)not null,
placa_vehiculo varchar(6)not null,
primary key (id_vehiculo, placa_vehiculo)
);

create table plazas(
id_plaza varchar(3)primary key,
nombre_tipo_plaza varchar(15)not null,
nombre_tipo_vehiculo varchar(15)not null
);

create table plazas_ocupadas(
id_plaza_ocupada int identity(1,1)primary key,
id_vehiculo int,
placa_vehiculo varchar(6)not null,
id_plaza varchar(3),
constraint fk_vehiculo foreign key(id_vehiculo, placa_vehiculo) references vehiculos(id_vehiculo, placa_vehiculo),
constraint fk_plaza foreign key(id_plaza) references plazas(id_plaza)
);

create table invitados(
id_usuario int,
id_invitado int,
documento_usuario int,
documento_invitado int,
primary key (id_usuario, id_invitado),
constraint fk_usuario foreign key(id_usuario, documento_usuario) references usuarios(id_usuario, documento_usuario),
constraint fk_invitado foreign key(id_invitado, documento_invitado) references usuarios(id_usuario, documento_usuario)
);

create table tipo_membresia(
id_tmembresia int identity(1,1)primary key,
nombre_tmembresia varchar(10)not null,
duracion int,
);

create table membresias_activas(
id_membresia int identity(1,1)primary key,
id_usuario int,
documento_usuario int,
id_tmembresia int,
fecha_inicio datetime not null,
constraint fk_usuario_membresia foreign key(id_usuario, documento_usuario) references usuarios(id_usuario, documento_usuario),
constraint fk_membresia foreign key(id_tmembresia) references tipo_membresia(id_tmembresia)
);

create table movimientos_ingreso(
id_movingreso int identity(1,1)primary key,
id_usuario int,
documento_usuario int,
id_plaza varchar(3)not null,
id_vehiculo int,
placa_vehiculo varchar(6)not null,
fecha_ingreso datetime,
constraint fk_usuingreso foreign key(id_usuario, documento_usuario) references usuarios(id_usuario, documento_usuario),
constraint fk_vehiculoingreso foreign key(id_vehiculo, placa_vehiculo) references vehiculos(id_vehiculo, placa_vehiculo),
constraint fk_plazaingreso foreign key(id_plaza) references plazas(id_plaza)
);

create table tarifas(
id_tarifa int identity(1,1)primary key,
nombre_ttarifa varchar(10)not null,
nombre_categoria varchar(15)not null,
nombre_tdia varchar(15)not null,
valor float,
);

create table movimiento_salida(
id_movsalida int primary key,
id_usuario int,
documento_usuario int,
fehca_salida datetime,
id_tarifa int,
constraint fk_tarifamov foreign key(id_tarifa) references tarifas(id_tarifa),
constraint fk_mov foreign key(id_movsalida) references movimientos_ingreso(id_movingreso),
constraint fk_ususalida foreign key(id_usuario, documento_usuario) references usuarios(id_usuario, documento_usuario)
);

create table factura(
id_factura int identity(1,1)primary key,
id_movsalida int,
valor float,
constraint fk_factura foreign key(id_movsalida) references movimiento_salida(id_movsalida)
);

create table dias_festivos(
id_diafestivo int identity(1,1)primary key,
fecha_festiva date
);
