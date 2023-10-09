--set replication off
--go
/*************************************************************************/
/*   Archivo:            sp_info_cliente_buro.sp                         */
/*   Stored procedure:   sp_info_cliente_buro                            */
/*   Base de datos:      cobis                                           */
/*   Producto:           Cliente                                         */
/*   Disenado por:       MBA                                             */
/*   Fecha de escritura: 27-01-2011                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP"                                                         */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa recupera la información del cliente solicitada por    */
/*   el Buró de Crédito                                                  */
/*                                                                       */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*   FECHA         AUTOR      RAZON                                      */
/*   21-06-2017    MBA       Recupera la información del cliente         */
/*                           solicitada por el Buró de Crédito           */
/*   06-07-2017    NTR       Add subtipo para evitar doble consulta      */
/*************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_info_cliente_buro')
   drop proc sp_info_cliente_buro
go


create proc sp_info_cliente_buro (
   @s_ssn                         int           = null,
   @s_user                        login         = null,
   @s_sesn                        int           = null,
   @s_term                        varchar(30)   = null,
   @s_date                        datetime      = null,
   @s_srv                         varchar(30)   = null,
   @s_lsrv                        varchar(30)   = null,
   @s_rol                         smallint      = null,
   @s_ofi                         smallint      = null,
   @s_org                         char(1)       = null,
   @t_debug                       char(1)       = 'N',
   @t_file                        varchar(14)   = null,
   @t_from                        varchar(32)   = null,
   @t_trn                         int           = null,
   @i_operacion                   char(1)       = null,
   @i_transaccion                 char(1)       = 'S',   -- Transaccion que se va a aplicar
   @i_sub_tipo                    char(1)       = null,  -- Consulta un tipo de consulta por el codigo actual
   -----------------------------------------
   --Variables de la info del cliente
   -----------------------------------------
   @i_codigo_cliente              int           = null  -- Codigo para identificar al cliente
)
as
declare
   -----------------------------------------
   --Variables de info del cliente
   -----------------------------------------
   @w_codigo                        int,                  -- Codigo de la info del cliente
   @w_sp_name                       varchar(32),          -- Nombre del store procedure de la info del cliente
   @w_datetime                      datetime,             -- Variable para insertar la fecha
   @w_num_error                     int                   -- Numero de error que se envia al store procedure sp_cerror
   
   
-----------------------------------------
--Inicializacion de Variables
-----------------------------------------
select @w_sp_name               = 'sp_info_cliente_buro',
       @w_datetime              = convert(varchar,@s_date,101) + ' ' + convert(varchar,getdate(),108)


-----------------------------------------
--ControlTransacciones vs. Operaciones
-----------------------------------------

if @i_operacion = 'Q'
begin

   if @i_sub_tipo = '0'  --ENCABEZADO
   begin
      select DISTINCT 'Versión' = 13,
              'NumeroReferenciaOperador' =tg_prestamo,
              'ProductoRequerido' = 509, 
              'ClavePais' = 'MX',
              'ClaveUsuario' = 'XXXXXXXXX',
              'Password' = 'XXXXXXX',
              'Tipoconsulta' = 'I',
              'Tipocontrato' = 'PA',
              'ClaveUnidadMonetaria'  = 'MX',
              'ImporteContrato' = isnull(tg_monto, op_monto), op_cliente,
              'Idioma' = 'SP',
              'TipoSalida' = '01'
      from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
      where op_estado not in ( 0,99,3)
      and op_cliente = @i_codigo_cliente
      and tg_prestamo = op_banco
      AND tg_cliente = op_cliente
   end
   
      if @i_sub_tipo = '1' OR  @i_sub_tipo = '4'   --NOMBRE
	  begin
             select 'ApellidoPaterno' = convert(varchar(26), p_p_apellido), 
             'ApellidoMaterno' = convert(varchar(26), p_s_apellido), 
              'PrimerNombre'   = convert(varchar(26), en_nombre),
             'FechaNacimiento' = convert(varchar(26), p_fecha_nac),
             'FechaNacimiento' = convert(varchar(10), p_fecha_nac,101),           
                         'RFC' = isnull(convert(varchar(13), en_nit),''),
                'Nacionalidad' = 'MX',
                 'EstadoCivil' =  convert(varchar(1),p_estado_civil),
                 'Sexo'        =  convert(varchar(1),p_sexo),
              'FechaNacimientoDate' = p_fecha_nac
      from cobis..cl_ente
      where en_ente = @i_codigo_cliente
   end
   
   if @i_sub_tipo = '2' OR  @i_sub_tipo = '4'   --DOMICILIO
   begin
      select 'Direccion' = case isnull(di_tipo,'')
  when 'RE' then isnull(convert(varchar(40),di_descripcion),'')
                            when 'AE' then isnull(convert(varchar(40),di_descripcion),'')
                            end,
            'Estado-Provincia' = d.di_provincia,
            'Municipio-Ciudad' = isnull((select convert(varchar(40),ci_descripcion) from cobis..cl_ciudad c where c.ci_ciudad = d.di_ciudad),''), 
           'Colonia-Parroquia' = isnull((select convert(varchar(40),pq_descripcion) from cobis..cl_parroquia p where p.pq_parroquia = d.di_parroquia
                                              and p.pq_parroquia = d.di_parroquia),''),
                          'CP' = isnull(convert(varchar(5),di_codpostal),''),                                     
                     'CodPais' = 'MX'                     
          from cobis..cl_direccion d, cobis..cl_ente e
          where d.di_tipo in ('RE','AE')
          and d.di_ente = e.en_ente
          and en_ente = @i_codigo_cliente
   end
   
    if @i_sub_tipo = '3'    --CUENTA
   begin
      select      'NumeroCuenta' = op_banco, 
                'ClaveOtorgante' = 'XXXXXXXXXX',
               'NombreOtorgante' = 'SOFOME'
      from cob_cartera..ca_operacion, cob_credito..cr_tramite_grupal
      where op_estado not in ( 0,99,3)
      and op_cliente = @i_codigo_cliente
      and tg_prestamo = op_banco
   end
   
   return 0
end --@i_operacion = 'Q'

--Control errores
errores:
-------------------------
   -- Utilizando transaccion
   if @i_transaccion = 'S'
   begin
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   end
   return @w_num_error
GO

