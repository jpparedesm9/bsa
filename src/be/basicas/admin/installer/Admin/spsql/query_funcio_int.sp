/*******************************************************
    ARCHIVO:         b_qryfun.sp
    NOMBRE LOGICO:   sp_query_funcio_int
    PRODUCTO:        cobis
 *******************************************************
                     IMPORTANTE
   Esta aplicacion es parte de los  paquetes bancarios
   propiedad de MACOSA S.A.
   Su uso no autorizado queda  expresamente  prohibido 
   asi como cualquier alteracion o agregado hecho  por 
   alguno de sus usuarios sin el debido consentimiento 
   por escrito de MACOSA. 
   Este programa esta protegido por la ley de derechos
   de autor y por las convenciones  internacionales de
   propiedad intelectual.  Su uso  no  autorizado dara
   derecho a MACOSA para obtener ordenes  de secuestro
   o  retencion  y  para  perseguir  penalmente a  los
   autores de cualquier infraccion.
 *******************************************************
                     PROPOSITO
   Este stored procedure retorna todos los datos de un
   registro de funcionarios incluyendo codigos y su
   repectiva descripcion.
 *******************************************************
                     MODIFICACIONES
   FECHA        AUTOR           RAZON
   11/Nov/98    Myriam Davila   Emision Inicial
   06/Jun/12    Daniel Vera     cambio campo nomina de
                                smallint a int
 *******************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_query_funcio_int')
   drop proc sp_query_funcio_int
go

create proc sp_query_funcio_int(
@t_debug	char(1) = 'N',
@t_file		varchar(14) = null,
@t_from		varchar(32) = null,
@t_trn		smallint = null,
@i_funcionario	smallint = null,
@i_login	login = null,
@i_formato	varchar(10)
)
as


declare
@w_sp_name		varchar(32),
@w_formato		tinyint,
--datos del funcionario
@w_funcionario		smallint,
@w_nombre		descripcion,
@w_sexo			sexo,
@w_sexo_desc		descripcion,
@w_dinero		char (1),
@w_nomina		int, --DVE cambio de smallint a int
@w_departamento		smallint,
@w_departamento_desc	descripcion,
@w_oficina		smallint,
@w_oficina_desc		descripcion,
@w_cargo		tinyint,
@w_cargo_desc		descripcion,
@w_secuencial		tinyint,
@w_jefe			smallint,
@w_jefe_desc		descripcion,
@w_nivel		tinyint,
@w_fecha_ing		datetime,
@w_login		login,
@w_telefono		varchar,
@w_fec_inicio		datetime,
@w_fec_final		datetime,
@w_estado		estado,
@w_estado_desc		descripcion


--nombre del sp
select @w_sp_name = 'sp_query_funcio_int'


--seleccion del formato de fecha
if @i_formato = 'dd/mm/yyy'
   select @w_formato = 103
else if @i_formato = 'mm/dd/yyyy'
   select @w_formato = 101
else if @i_formato = 'yyyy/mm/dd'
   select @w_formato = 111
else
   select @w_formato = 103

--seleccion de los datos del registro
if @i_funcionario is not null
begin
   select
   @w_funcionario	= fu_funcionario,
   @w_nombre		= fu_nombre,
   @w_sexo		= fu_sexo,
   @w_dinero		= fu_dinero,
   @w_nomina		= fu_nomina,
   @w_departamento 	= fu_departamento,
   @w_oficina		= fu_oficina,
   @w_cargo		= fu_cargo,
   @w_secuencial	= fu_secuencial,
   @w_jefe		= fu_jefe,
   @w_nivel		= fu_nivel,
   @w_fecha_ing		= fu_fecha_ing,
   @w_login		= fu_login,
   @w_telefono		= fu_telefono,
   @w_fec_inicio	= fu_fec_inicio,
   @w_fec_final		= fu_fec_final,
   @w_estado		= fu_estado
   from   cl_funcionario
   where  fu_funcionario = @i_funcionario

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = 101001
        return 1
   end
end
else if @i_login is not null
begin

   select
   @w_funcionario	= fu_funcionario,
   @w_nombre		= fu_nombre,
   @w_sexo		= fu_sexo,
   @w_dinero		= fu_dinero,
   @w_nomina		= fu_nomina,
   @w_departamento 	= fu_departamento,
   @w_oficina		= fu_oficina,
   @w_cargo		= fu_cargo,
   @w_secuencial	= fu_secuencial,
   @w_jefe		= fu_jefe,
   @w_nivel		= fu_nivel,
   @w_fecha_ing		= fu_fecha_ing,
   @w_login		= fu_login,
   @w_telefono		= fu_telefono,
   @w_fec_inicio	= fu_fec_inicio,
   @w_fec_final		= fu_fec_final,
   @w_estado		= fu_estado
   from   cl_funcionario
   where  fu_login = @i_login

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
        @t_debug      = @t_debug,
        @t_file       = @t_file,
        @t_from       = @w_sp_name,
        @i_num        = 101001
        return 1
   end
end

--complementar las descripciones de los campos de catalogo
if @w_sexo is not null
   select @w_sexo_desc = a.valor
   from   cl_catalogo a, cl_tabla b
   where  a.codigo = @w_sexo
   and    a.tabla = b.codigo
   and    b.tabla = 'cl_sexo'


if @w_estado is not null
   select @w_estado_desc = a.valor
   from   cl_catalogo a, cl_tabla b
   where  a.codigo = @w_estado
   and    a.tabla = b.codigo
   and    b.tabla = 'cl_estado_ser'

if @w_cargo is not null
   select @w_cargo_desc = a.valor
   from   cl_catalogo a, cl_tabla b
   where  a.codigo = convert(char(10),@w_cargo)
   and    a.tabla = b.codigo
   and    b.tabla = 'cl_cargo'


--complementar otros datos
if @w_oficina is not null
   select @w_oficina_desc = of_nombre
   from   cl_oficina
   where  of_oficina = @w_oficina

if @w_jefe is not null
   select @w_jefe_desc = fu_nombre
   from   cl_funcionario
   where  fu_funcionario = @w_jefe


if @w_oficina is not null AND @w_departamento is not null
   select @w_departamento_desc = de_descripcion
   from   cl_departamento
   where  de_oficina = @w_oficina
   and    de_departamento = @w_departamento

--retornar el registro al front-end
select
   @w_funcionario,				--1
   @w_nombre,					--2
   @w_sexo,					--3
   @w_sexo_desc,				--4
   @w_dinero,					--5
   @w_nomina,					--6
   @w_departamento,				--7
   @w_departamento_desc,			--8
   @w_oficina,					--9
   @w_oficina_desc,				--10
   @w_cargo,					--11
   @w_cargo_desc,				--12
   @w_secuencial,				--13
   @w_jefe,					--14
   @w_jefe_desc,				--15
   @w_nivel,					--16
   convert(char(10),@w_fecha_ing,@w_formato),	--17
   @w_login,					--18
   @w_telefono,					--19
   convert(char(10),@w_fec_inicio,@w_formato),	--20
   convert(char(10),@w_fec_final,@w_formato),	--21
   @w_estado,					--22
   @w_estado_desc				--23


return 0

go



