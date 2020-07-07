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
p_nombre_usuario    in nombre_usuario.usuario%type,
p_correo            in correo_institucional.usuario%type,
p_nombre_apellido   in nombre_apellido.usuario%type,
p_horas_completadas in cantidad_horas_completadas.usuario%type, 
p_id_tipo_usuario   in ID_tipo_de_usuario.usuario%type,
p_celular           in celular.usuario%type,
p_id_rol            in id_rol.usuario%type,
p_cedula            in cedula.usuario%type,
p_estado_usuario    in estado_usuarios.usuario%type,
p_carrera           in carrera.usuario%type,
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
CREATE SEQUENCE secuencia_proyectos
start with 1
increment by 1
maxvalue 99999
minvalue 1;

/*---------------------------------------------------*/
create or replace procedure crear_proyectos(
p_id_usuario in proyectos.ID_usuario%type,
p_nombre_proyecto in proyectos.nombre_proyecto%type,
p_duracion_proyecto in proyectos.duracion_proyecto%type,
p_prioridad in proyectos.prioridad%type,
p_fecha_inicio in proyectos.fecha_inicio%type,
p_fecha_finalizacion in proyectos.fecha_finalizacion%type,
p_costo_proyecto in proyectos.costo_proyecto%type
)as
v_estado_proyecto:='Inactivo';
begin
insert into proyectos(id_proyecto,
                      id_usuario,
                      nombre_proyecto,
                      duracion_proyecto,
                      descripcion_proyectos,
                      prioridad,
                      fecha_inicio,
                      fecha_finalizacion,
                      costo_proyecto,
                      estado_proyecto) 
                values(secuencia_proyectos.nextval,
                        p_id_usuario,
                        p_nombre_proyecto,
                        p_duracion_proyecto,
                        p_prioridad,
                        p_fecha_inicio,
                        p_fecha_finalizacion,
                        p_costo_proyecto,
                        v_estado_proyecto);
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
v_prioridad varchar(20):='Alta';
v_fecha_inicio to_date:='2020/05/15 8:30:00';
v_fecha_finalizacion to_date:='2020/06/15 8:30:00'; /* agregar el formato */
v_costo_proyecto number(15):=2000;
v_mensaje varchar2(50);
begin 
crear_proyectos(v_id_usuario,v_nombre_proyecto,v_duracion_proyecto,v_prioridad,v_fecha_inicio,v_fecha_finalizacion,v_costo_proyecto);
DBMS_output.put_line(v_mensaje);
end;
/
/*---------------------------------------------------*/
create or replace procedure CambioRol(
p_nombre_usuario  in nombre_usuario.usuario%type,
p_id_rol          in id_rol.usuario%type,
P_mensaje         out varchar2)
as
v_id ID_usuario.usuario%type;
begin
select ID_usuario into v_id from usuario where nombre_usuario=p_nombre_usuario;
update usuario 
set id_rol = p_id_rol;
where ID_usuario=v_id;

EXCEPTION
    WHEN others THEN
        p_mensaje:='No se ha creado el registro...';
end CambioRol;
/

SET serveroutput ON
declare
v_nombre_usuario varchar2(35):='Kadir507';
v_Nid_rol        number(15):=4;

inser_usuarios(v_nombre_usuario,);
DBMS_output.put_line(v_mensaje);
end;
/
/*-------------------------------------------*/
create sequence secuencia_actividades 
start with 1
increment by 1 
maxvalue 99999
minvalue 1;

create or replace procedure crear_actividad(
    p_id_proyectos actividades.id_proyectos%type,
    p_duracion_activa  actividades.duracion_activa%type,
    p_fecha_actividad actividades.fecha_actividad%type,
    p_mensaje out varchar2
) as 
begin 
p_mensaje:='La actividad a sido creada corectamente';

insert into actividades (id_actividad, id_proyectos, duración_activa, fecha_actividad)
values (secuencia_actividades.nextval, p_id_proyectos, p_duracion_activa, to date(p_fecha_actividad));
	exception
		when dup_val_on_index then
			p_mensaje:='Esta actividad ya existe ya existe en la base de datos'; 
		when others then
			p_mensaje:='Error desconocido, no creo el registro';
commit;
END crear_actividades;
/
