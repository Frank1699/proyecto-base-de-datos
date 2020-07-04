/*secuencias*/


/*tablas*/

create table tipo_usuario(
ID_tipo_de_usuario number(15),
tipo_de_usuario varchar(20),
constraint pk_ID_tipo_de_usuario
primary key (ID_tipo_de_usuario)
);

CREATE TABLE roles(
    ID_rol number(15) ,
    Tipo_de_rol varchar(15),
constraint pk_ID_rol
primary key (id_rol)
)

Create table usuario(
ID_usuario number(10), 
nombre_usuario varchar(15),
correo_institucional varchar(25),
nombre_apellido varchar(25),
cantidad_horas_completadas number(15),
estado_de_horas varchar(15),
ID_tipo_de_usuario number(15), 
celular number(15),
id_rol number(15), 
cedula number(15),
estado_usuarios varchar(10),
carrera varchar(10),
Constraint pk_ID_usuario
Primary key (ID_usuario),
constraint fk_ID_tipo_de_usuario 
foreign key(ID_tipo_de_usuario)
references tipo_usuario(ID_tipo_de_usuario),
constraint fk_id_rol 
foreign key(id_rol)
references Roles(id_rol)
);

create table proyectos(
ID_proyectos number(15),
ID_usuario number(10),
nombre_proyecto varchar(20),
duracion_proyecto number(15),
prioridad varchar(20),
fecha_inicio date,
fecha_finalizacion date,
costo_proyecto number(15),
estado_proyecto varchar(15),
Constraint pk_ID_proyectos
primary key (ID_proyectos),
constraint fk_ID_usuario 
foreign key(ID_usuario)
references usuario (ID_usuario)
);

create table Propone(
  ID_usuario number(10),
  id_rol number(15), 
  nombre_apellido varchar(25),
  ID_proyectos number(15),
  Constraint pk_id_usuario_rol
Primary key (ID_usuario,Id_proyecto)
constraint fk_usuario_rol
foreign key(ID_rol)
references Roles (ID_rol)
  
);

create table actividades(
ID_actividades number(10),
ID_proyectos number(15),
duracion_actividad number(15),
fecha_actividad date,
Constraint pk_ID_actividades
primary key (ID_actividades),
constraint fk_ID_proyectos
foreign key(ID_proyectos)
references proyectos (ID_proyectos)
);

Create table participa_de(
    ID_actividades number(10),
    ID_usuario number(10),
    ID_proyectos number(15),
    horas_participadas number(15),
    Constraint pk_participa_de
    Primary key (ID_actividades,ID_usuario),
    constraint fk_participa_Id_proyecto
    foreign key(ID_proyectos)
    references proyectos (ID_proyectos)
);


