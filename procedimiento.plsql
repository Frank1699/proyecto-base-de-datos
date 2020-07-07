INSERT INTO roles(ID_rol,Tipo_de_rol)
        (1,'administrador');
INSERT INTO roles(ID_rol,Tipo_de_rol)
        (2,'supervisor');
INSERT INTO roles(ID_rol,Tipo_de_rol)
        (3,'participante');
INSERT INTO roles(ID_rol,Tipo_de_rol)
        (4,'adminisupervisor');

/*-----------------------------------*/

INSERT INTO tipo_usuario(ID_tipo_de_usuario,tipo_de_usuario)
        (1,'Estudiante');
INSERT INTO tipo_usuario(ID_tipo_de_usuario,tipo_de_usuario)
        (2,'Profesor');
INSERT INTO tipo_usuario(ID_tipo_de_usuario,tipo_de_usuario)
        (3,'Externo');

/*-----------------------------------*/

CREATE SEQUENCE secuenciausuario
start with 1
increment by 1
maxvalue 99999
minvalue 1;
/*-----------------------------------*/

create or replace procedure inser_usuarios(
p_nombre_usuario  nombre_usuario.usuario%type;
p_correo          correo_institucional.usuario%type;
p_nombre_apellido nombre_apellido.usuario%type; 
p_horas_completadas cantidad_horas_completadas.usuario%type; 
p_id_tipo_usuario ID_tipo_de_usuario.usuario%type;
p_celular         celular.usuario%type;
p_id_rol          id_rol.usuario%type;
p_cedula          cedula.usuario%type;
p_estado_usuario  estado_usuarios.usuario%type;
p_carrera         carrera.usuario%type;
P_mensaje         out varchar2
) as
v_estado_horas estado_de_horas.usuario%type,
begin
p_mensaje:='Proceso ejecutado con exito';
if p_horas_completadas > 80 THEN
v_estado_de_horas := 'Incompletas';
else 
v_estado_de_horas := 'Completas';
end if;
insert into usuario(ID_usuario,
                    nombre_usuario,
                    correo_institucional,
                    nombre_apellido,
                    cantidad_horas_completadas,
                    estado_de_horas,
                    ID_tipo_de_usuario,
                    celular,
                    id_rol,
                    estado_usuarios,
                    carrera)
             values(secuenciausuario.nextval,
                    p_nombre_usuario,
                    p_correo,
                    p_nombre_apellido,
                    p_horas_completadas,
                    v_estado_de_horas,
                    p_id_tipo_usuario,
                    p_celular,
                    p_id_rol,
                    p_cedula,
                    p_estado_usuario,
                    p_carrera);

EXCEPTION
    WHEN dup_val_on_index THEN
        p_mensaje:='Este valor ya existe';
    WHEN others THEN
        p_mensaje:='No se ha creado el registro...';
end inser_usuarios;
/

SET serveroutput ON
declare
v_nombre_usuario varchar2(35):='Kadir507';
v_correo varchar2(35):'kadircalidad@utp.ac.pa';
v_nombre_apellido varchar2(35):='Kadir Franksasu';
v_horas_completadas number(15):=0;
v_id_tipo_usuario varchar2(35):=1;
v_celular varchar2(35):='65648925';
v_id_rol number(15):=3;
v_cedula varchar2(35):='8-654-3567';
v_estado_usuario varchar2(35):='Activo';
v_carrera varchar2(35):='Ingenieria de Software'; 
v_mensaje varchar2(50);
begin 
inser_usuarios(v_nombre_usuario,v_correo,v_nombre_apellido,v_horas_completadas,v_id_tipo_usuario,v_celular,v_id_rol,v_cedula,v_estado_usuario,v_carrera,v_mensaje);
DBMS_output.put_line(v_mensaje);
end;
/

/*---------------------------------------------------*/

create or replace procedure proponer_proyectos(

)as
begin

EXCEPTION
    WHEN dup_val_on_index THEN
        p_mensaje:='Este valor ya existe';
    WHEN others THEN
        p_mensaje:='No se ha creado el registro...';
end proponer_proyectos;
/
SET serveroutput ON
declare
v_id_usuario number(15):=1;
v_nombre_proyecto varchar(35):='Limpieza de Playa';
v_duracion_proyecto number(15):=240;  
prioridad varchar(20):='Alta';
fecha_inicio date:='2020/05/15 8:30:00';

create or replace procedure ()